package ui.utils {
    import flash.utils.Dictionary;
    
    /**
     * 通用对象池类
     * 用于减少频繁的对象创建和销毁开销，提高内存使用效率
     * 支持多种对象类型的池化管理
     */
    public class ObjectPool {
        private static var _instance:ObjectPool;
        private var _pools:Dictionary; // 存储不同类型的对象池
        private var _maxPoolSizes:Dictionary; // 每种类型的最大池大小
        private var _statistics:Dictionary; // 统计信息
        
        /**
         * 构造函数
         */
        public function ObjectPool() {
            if (_instance) {
                throw new Error("ObjectPool is a singleton class. Use getInstance() instead.");
            }
            _pools = new Dictionary();
            _maxPoolSizes = new Dictionary();
            _statistics = new Dictionary();
        }
        
        /**
         * 获取单例实例
         * @return ObjectPool实例
         */
        public static function getInstance():ObjectPool {
            if (!_instance) {
                _instance = new ObjectPool();
            }
            return _instance;
        }
        
        /**
         * 设置指定类型的最大池大小
         * @param type 对象类型
         * @param maxSize 最大池大小
         */
        public function setMaxPoolSize(type:Class, maxSize:int):void {
            _maxPoolSizes[type] = maxSize;
        }
        
        /**
         * 从池中获取对象
         * @param type 对象类型
         * @param constructorArgs 构造函数参数
         * @return 对象实例
         */
        public function getObject(type:Class, ...constructorArgs):* {
            var pool:Vector.<Object> = _pools[type];
            if (!pool) {
                pool = new Vector.<Object>();
                _pools[type] = pool;
                _statistics[type] = {
                    created: 0,
                    reused: 0,
                    pooled: 0,
                    maxPoolSize: 0
                };
            }
            
            var obj:*;
            if (pool.length > 0) {
                // 从池中重用对象
                obj = pool.pop();
                _statistics[type].reused++;
                
                // 如果对象有reset方法，调用它来重置状态
                if (obj.hasOwnProperty('reset') && obj.reset is Function) {
                    obj.reset.apply(obj, constructorArgs);
                }
            } else {
                // 创建新对象
                switch (constructorArgs.length) {
                    case 0:
                        obj = new type();
                        break;
                    case 1:
                        obj = new type(constructorArgs[0]);
                        break;
                    case 2:
                        obj = new type(constructorArgs[0], constructorArgs[1]);
                        break;
                    case 3:
                        obj = new type(constructorArgs[0], constructorArgs[1], constructorArgs[2]);
                        break;
                    case 4:
                        obj = new type(constructorArgs[0], constructorArgs[1], constructorArgs[2], constructorArgs[3]);
                        break;
                    default:
                        // 对于更多参数的情况，使用反射
                        obj = createObjectWithArgs(type, constructorArgs);
                        break;
                }
                _statistics[type].created++;
            }
            
            return obj;
        }
        
        /**
         * 将对象返回到池中
         * @param obj 要返回的对象
         */
        public function returnObject(obj:*):void {
            if (!obj) return;
            
            var type:Class = Object(obj).constructor as Class;
            var pool:Vector.<Object> = _pools[type];
            if (!pool) {
                pool = new Vector.<Object>();
                _pools[type] = pool;
                _statistics[type] = {
                    created: 0,
                    reused: 0,
                    pooled: 0,
                    maxPoolSize: 0
                };
            }
            
            var maxSize:int = _maxPoolSizes[type] || 50; // 默认最大池大小
            if (pool.length < maxSize) {
                // 如果对象有cleanup方法，调用它来清理状态
                if (obj.hasOwnProperty('cleanup') && obj.cleanup is Function) {
                    obj.cleanup();
                }
                
                pool.push(obj);
                _statistics[type].pooled++;
                
                // 更新最大池大小统计
                if (pool.length > _statistics[type].maxPoolSize) {
                    _statistics[type].maxPoolSize = pool.length;
                }
            }
        }
        
        /**
         * 清空指定类型的对象池
         * @param type 对象类型，如果为null则清空所有池
         */
        public function clearPool(type:Class = null):void {
            if (type) {
                var pool:Vector.<Object> = _pools[type];
                if (pool) {
                    // 清理池中的对象
                    for each (var obj:* in pool) {
                        if (obj.hasOwnProperty('dispose') && obj.dispose is Function) {
                            obj.dispose();
                        }
                    }
                    pool.length = 0;
                }
            } else {
                // 清空所有池
                for (var poolType:* in _pools) {
                    clearPool(poolType as Class);
                }
            }
        }
        
        /**
         * 获取指定类型的统计信息
         * @param type 对象类型
         * @return 统计信息对象
         */
        public function getStatistics(type:Class):Object {
            return _statistics[type] || {
                created: 0,
                reused: 0,
                pooled: 0,
                maxPoolSize: 0
            };
        }
        
        /**
         * 获取所有类型的统计信息
         * @return 包含所有统计信息的对象
         */
        public function getAllStatistics():Object {
            var result:Object = {};
            for (var type:* in _statistics) {
                var typeName:String = getQualifiedClassName(type);
                result[typeName] = _statistics[type];
            }
            return result;
        }
        
        /**
         * 获取当前池的状态信息
         * @return 池状态信息
         */
        public function getPoolStatus():Object {
            var status:Object = {};
            for (var type:* in _pools) {
                var typeName:String = getQualifiedClassName(type);
                var pool:Vector.<Object> = _pools[type];
                var maxSize:int = _maxPoolSizes[type] || 50;
                status[typeName] = {
                    currentSize: pool.length,
                    maxSize: maxSize,
                    utilization: (pool.length / maxSize * 100).toFixed(1) + "%"
                };
            }
            return status;
        }
        
        /**
         * 使用反射创建带参数的对象
         * @param type 对象类型
         * @param args 构造函数参数
         * @return 创建的对象
         */
        private function createObjectWithArgs(type:Class, args:Array):* {
            // 这里使用一个简化的实现，实际项目中可能需要更复杂的反射机制
            try {
                // 尝试使用apply方法
                var obj:* = Object(type).constructor.apply(null, args);
                return obj;
            } catch (e:Error) {
                // 如果失败，创建无参对象
                return new type();
            }
        }
        
        /**
         * 获取类的完全限定名
         * @param type 类型
         * @return 类名字符串
         */
        private function getQualifiedClassName(type:*):String {
            var className:String = String(type);
            // 简化的类名提取
            if (className.indexOf("class ") == 0) {
                className = className.substring(6);
            }
            if (className.indexOf("[class ") == 0) {
                className = className.substring(7, className.length - 1);
            }
            return className;
        }
        
        /**
         * 释放对象池资源
         */
        public function dispose():void {
            clearPool();
            _pools = null;
            _maxPoolSizes = null;
            _statistics = null;
            _instance = null;
        }
    }
}