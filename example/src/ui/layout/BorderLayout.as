package ui.layout
{
    import ui.core.UIComponent;
    import flash.geom.Rectangle;
    
    /**
     * 边界布局管理器
     * 支持五区域布局：North(北), South(南), East(东), West(西), Center(中)
     * 
     * 特性：
     * - 边界区域(North/South/East/West)保持首选尺寸
     * - 中心区域(Center)自适应填充剩余空间
     * - 支持区域的显示/隐藏
     * - 支持最小尺寸约束
     * - 布局顺序：North -> South -> West -> East -> Center
     * 
     * @author UI Framework Team
     * @version 1.0
     */
    public class BorderLayout extends LayoutManager
    {
        // 区域常量
        public static const NORTH:String = "north";
        public static const SOUTH:String = "south";
        public static const EAST:String = "east";
        public static const WEST:String = "west";
        public static const CENTER:String = "center";
        
        // 区域组件映射
        private var _regions:Object;
        
        // 区域尺寸设置
        private var _northHeight:Number;    // 北区域高度
        private var _southHeight:Number;    // 南区域高度
        private var _eastWidth:Number;      // 东区域宽度
        private var _westWidth:Number;      // 西区域宽度
        
        // 尺寸模式
        private var _autoSize:Boolean;      // 是否自动计算区域尺寸
        
        /**
         * 构造函数
         */
        public function BorderLayout()
        {
            super();
            _regions = {};
            _northHeight = -1;  // -1表示自动计算
            _southHeight = -1;
            _eastWidth = -1;
            _westWidth = -1;
            _autoSize = true;
        }
        
        /**
         * 执行边界布局
         * 
         * @param container 需要布局的容器组件
         */
        public override function layout(container:UIComponent):void
        {
            if (!_enabled)
                return;
                
            var children:Vector.<UIComponent> = getVisibleChildren(container);
            if (children.length == 0)
                return;
                
            // 更新区域组件映射
            updateRegionMapping(children);
            
            var contentBounds:Rectangle = getContentBounds(container);
            
            // 计算各区域的边界
            var regionBounds:Object = calculateRegionBounds(contentBounds);
            
            // 应用布局
            applyRegionLayout(regionBounds);
        }
        
        /**
         * 更新区域组件映射
         * 
         * @param children 子组件列表
         */
        private function updateRegionMapping(children:Vector.<UIComponent>):void
        {
            // 清空现有映射
            _regions = {};
            
            // 遍历子组件，根据区域属性进行映射
            for (var i:int = 0; i < children.length; i++)
            {
                var child:UIComponent = children[i];
                var region:String = getChildRegion(child, i);
                
                if (region && isValidRegion(region))
                {
                    _regions[region] = child;
                }
            }
        }
        
        /**
         * 获取子组件的区域设置
         * 
         * @param child 子组件
         * @param index 组件索引
         * @return 区域名称
         */
        private function getChildRegion(child:UIComponent, index:int):String
        {
            // 尝试从组件的自定义属性中获取区域
            if (child.hasOwnProperty("borderRegion"))
            {
                return String(child["borderRegion"]).toLowerCase();
            }
            
            // 如果没有设置区域，根据索引自动分配
            switch (index)
            {
                case 0: return NORTH;
                case 1: return SOUTH;
                case 2: return WEST;
                case 3: return EAST;
                case 4: return CENTER;
                default: return CENTER;
            }
        }
        
        /**
         * 检查区域名称是否有效
         * 
         * @param region 区域名称
         * @return 是否有效
         */
        private function isValidRegion(region:String):Boolean
        {
            return region == NORTH || region == SOUTH || region == EAST || 
                   region == WEST || region == CENTER;
        }
        
        /**
         * 计算各区域的边界
         * 
         * @param contentBounds 内容区域
         * @return 区域边界对象
         */
        private function calculateRegionBounds(contentBounds:Rectangle):Object
        {
            var bounds:Object = {};
            
            // 可用区域（逐步缩减）
            var availableArea:Rectangle = contentBounds.clone();
            
            // 1. 计算北区域
            if (_regions[NORTH])
            {
                var northComponent:UIComponent = _regions[NORTH] as UIComponent;
                var northHeight:Number = _autoSize ? northComponent.height : 
                                       (_northHeight > 0 ? _northHeight : northComponent.height);
                
                bounds[NORTH] = new Rectangle(
                    availableArea.x,
                    availableArea.y,
                    availableArea.width,
                    Math.min(northHeight, availableArea.height)
                );
                
                // 缩减可用区域
                availableArea.y += bounds[NORTH].height;
                availableArea.height -= bounds[NORTH].height;
            }
            
            // 2. 计算南区域
            if (_regions[SOUTH])
            {
                var southComponent:UIComponent = _regions[SOUTH] as UIComponent;
                var southHeight:Number = _autoSize ? southComponent.height : 
                                       (_southHeight > 0 ? _southHeight : southComponent.height);
                
                southHeight = Math.min(southHeight, availableArea.height);
                
                bounds[SOUTH] = new Rectangle(
                    availableArea.x,
                    availableArea.y + availableArea.height - southHeight,
                    availableArea.width,
                    southHeight
                );
                
                // 缩减可用区域
                availableArea.height -= southHeight;
            }
            
            // 3. 计算西区域
            if (_regions[WEST])
            {
                var westComponent:UIComponent = _regions[WEST] as UIComponent;
                var westWidth:Number = _autoSize ? westComponent.width : 
                                     (_westWidth > 0 ? _westWidth : westComponent.width);
                
                bounds[WEST] = new Rectangle(
                    availableArea.x,
                    availableArea.y,
                    Math.min(westWidth, availableArea.width),
                    availableArea.height
                );
                
                // 缩减可用区域
                availableArea.x += bounds[WEST].width;
                availableArea.width -= bounds[WEST].width;
            }
            
            // 4. 计算东区域
            if (_regions[EAST])
            {
                var eastComponent:UIComponent = _regions[EAST] as UIComponent;
                var eastWidth:Number = _autoSize ? eastComponent.width : 
                                     (_eastWidth > 0 ? _eastWidth : eastComponent.width);
                
                eastWidth = Math.min(eastWidth, availableArea.width);
                
                bounds[EAST] = new Rectangle(
                    availableArea.x + availableArea.width - eastWidth,
                    availableArea.y,
                    eastWidth,
                    availableArea.height
                );
                
                // 缩减可用区域
                availableArea.width -= eastWidth;
            }
            
            // 5. 计算中心区域（剩余空间）
            if (_regions[CENTER])
            {
                bounds[CENTER] = availableArea.clone();
                
                // 确保尺寸不为负数
                bounds[CENTER].width = Math.max(0, bounds[CENTER].width);
                bounds[CENTER].height = Math.max(0, bounds[CENTER].height);
            }
            
            return bounds;
        }
        
        /**
         * 应用区域布局
         * 
         * @param regionBounds 区域边界对象
         */
        private function applyRegionLayout(regionBounds:Object):void
        {
            // 应用各区域的布局
            for (var region:String in regionBounds)
            {
                if (_regions[region])
                {
                    var component:UIComponent = _regions[region] as UIComponent;
                    var bounds:Rectangle = regionBounds[region] as Rectangle;
                    
                    applyBounds(component, bounds.x, bounds.y, bounds.width, bounds.height);
                }
            }
        }
        
        /**
         * 计算容器的首选尺寸
         * 
         * @param container 容器组件
         * @return 首选尺寸矩形
         */
        public override function getPreferredSize(container:UIComponent):Rectangle
        {
            var children:Vector.<UIComponent> = getVisibleChildren(container);
            if (children.length == 0)
            {
                return new Rectangle(0, 0, _padding.x + _padding.width, _padding.y + _padding.height);
            }
            
            // 更新区域映射
            updateRegionMapping(children);
            
            var totalWidth:Number = 0;
            var totalHeight:Number = 0;
            
            // 计算宽度：West + Center + East
            var westWidth:Number = 0;
            var centerWidth:Number = 0;
            var eastWidth:Number = 0;
            
            if (_regions[WEST])
            {
                westWidth = (_regions[WEST] as UIComponent).width;
            }
            
            if (_regions[CENTER])
            {
                centerWidth = (_regions[CENTER] as UIComponent).width;
            }
            
            if (_regions[EAST])
            {
                eastWidth = (_regions[EAST] as UIComponent).width;
            }
            
            totalWidth = westWidth + centerWidth + eastWidth;
            
            // 确保北区域和南区域的宽度需求
            if (_regions[NORTH])
            {
                totalWidth = Math.max(totalWidth, (_regions[NORTH] as UIComponent).width);
            }
            
            if (_regions[SOUTH])
            {
                totalWidth = Math.max(totalWidth, (_regions[SOUTH] as UIComponent).width);
            }
            
            // 计算高度：North + Center + South
            var northHeight:Number = 0;
            var centerHeight:Number = 0;
            var southHeight:Number = 0;
            
            if (_regions[NORTH])
            {
                northHeight = (_regions[NORTH] as UIComponent).height;
            }
            
            if (_regions[CENTER])
            {
                centerHeight = (_regions[CENTER] as UIComponent).height;
            }
            
            if (_regions[SOUTH])
            {
                southHeight = (_regions[SOUTH] as UIComponent).height;
            }
            
            totalHeight = northHeight + centerHeight + southHeight;
            
            // 确保西区域和东区域的高度需求
            if (_regions[WEST])
            {
                totalHeight = Math.max(totalHeight, (_regions[WEST] as UIComponent).height);
            }
            
            if (_regions[EAST])
            {
                totalHeight = Math.max(totalHeight, (_regions[EAST] as UIComponent).height);
            }
            
            // 加上内边距
            totalWidth += _padding.x + _padding.width;
            totalHeight += _padding.y + _padding.height;
            
            return new Rectangle(0, 0, totalWidth, totalHeight);
        }
        
        /**
         * 添加组件到指定区域
         * 重写基类方法以支持边界布局的区域约束
         * 
         * @param component 组件
         * @param constraints 布局约束参数，对于BorderLayout应传入区域名称字符串
         */
        public override function addComponent(component:UIComponent, constraints:Object = null):void
        {
            var region:String = constraints as String;
            if (region != null && isValidRegion(region))
            {
                // 设置组件的区域属性
                component["borderRegion"] = region;
                _regions[region] = component;
            }
        }
        
        /**
         * 添加组件到指定区域（保持向后兼容的便捷方法）
         * 
         * @param component 组件
         * @param region 区域名称
         */
        public function addComponentToRegion(component:UIComponent, region:String):void
        {
            addComponent(component, region);
        }
        
        /**
         * 从指定区域移除组件
         * 
         * @param region 区域名称
         */
        public function removeComponent(region:String):void
        {
            if (_regions[region])
            {
                var component:UIComponent = _regions[region] as UIComponent;
                if (component.hasOwnProperty("borderRegion"))
                {
                    delete component["borderRegion"];
                }
                delete _regions[region];
            }
        }
        
        /**
         * 获取指定区域的组件
         * 
         * @param region 区域名称
         * @return 组件实例
         */
        public function getComponent(region:String):UIComponent
        {
            return _regions[region] as UIComponent;
        }
        
        // 属性访问器
        
        /**
         * 设置北区域高度
         * 
         * @param value 高度值，-1表示自动计算
         */
        public function set northHeight(value:Number):void
        {
            _northHeight = value;
        }
        
        /**
         * 获取北区域高度
         * 
         * @return 高度值
         */
        public function get northHeight():Number
        {
            return _northHeight;
        }
        
        /**
         * 设置南区域高度
         * 
         * @param value 高度值，-1表示自动计算
         */
        public function set southHeight(value:Number):void
        {
            _southHeight = value;
        }
        
        /**
         * 获取南区域高度
         * 
         * @return 高度值
         */
        public function get southHeight():Number
        {
            return _southHeight;
        }
        
        /**
         * 设置东区域宽度
         * 
         * @param value 宽度值，-1表示自动计算
         */
        public function set eastWidth(value:Number):void
        {
            _eastWidth = value;
        }
        
        /**
         * 获取东区域宽度
         * 
         * @return 宽度值
         */
        public function get eastWidth():Number
        {
            return _eastWidth;
        }
        
        /**
         * 设置西区域宽度
         * 
         * @param value 宽度值，-1表示自动计算
         */
        public function set westWidth(value:Number):void
        {
            _westWidth = value;
        }
        
        /**
         * 获取西区域宽度
         * 
         * @return 宽度值
         */
        public function get westWidth():Number
        {
            return _westWidth;
        }
        
        /**
         * 设置是否自动计算区域尺寸
         * 
         * @param value 是否自动计算
         */
        public function set autoSize(value:Boolean):void
        {
            _autoSize = value;
        }
        
        /**
         * 获取是否自动计算区域尺寸
         * 
         * @return 是否自动计算
         */
        public function get autoSize():Boolean
        {
            return _autoSize;
        }
        
        /**
         * 设置北区域高度
         * 
         * @param height 高度值，-1表示自动计算
         */
        public function setNorthHeight(height:Number):void
        {
            _northHeight = height;
        }
        
        /**
         * 释放资源
         */
        public override function dispose():void
        {
            _regions = null;
            super.dispose();
        }
    }
}