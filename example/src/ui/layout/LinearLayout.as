package ui.layout
{
    import ui.core.UIComponent;
    import flash.geom.Rectangle;
    
    /**
     * 线性布局管理器
     * 支持水平或垂直方向的线性排列组件
     * 
     * 特性：
     * - 支持水平(HORIZONTAL)和垂直(VERTICAL)两种方向
     * - 支持组件权重分配，实现弹性布局
     * - 支持多种对齐方式
     * - 支持自动换行(可选)
     * 
     * @author UI Framework Team
     * @version 1.0
     */
    public class LinearLayout extends LayoutManager
    {
        // 布局方向常量
        public static const HORIZONTAL:String = "horizontal";
        public static const VERTICAL:String = "vertical";
        
        // 对齐方式常量
        public static const ALIGN_START:String = "start";      // 起始对齐
        public static const ALIGN_CENTER:String = "center";    // 居中对齐
        public static const ALIGN_END:String = "end";          // 结束对齐
        public static const ALIGN_STRETCH:String = "stretch";  // 拉伸填充
        
        // 布局属性
        private var _orientation:String;        // 布局方向
        private var _alignment:String;          // 对齐方式
        private var _wrap:Boolean;              // 是否自动换行
        private var _distributeEvenly:Boolean;  // 是否平均分配空间
        
        /**
         * 构造函数
         * 
         * @param orientation 布局方向 (HORIZONTAL 或 VERTICAL)
         * @param alignment 对齐方式
         */
        public function LinearLayout(orientation:String = HORIZONTAL, alignment:String = ALIGN_START)
        {
            super();
            _orientation = orientation;
            _alignment = alignment;
            _wrap = false;
            _distributeEvenly = false;
        }
        
        /**
         * 执行线性布局
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
                
            var contentBounds:Rectangle = getContentBounds(container);
            
            if (_orientation == HORIZONTAL)
            {
                layoutHorizontal(children, contentBounds);
            }
            else
            {
                layoutVertical(children, contentBounds);
            }
        }
        
        /**
         * 水平布局
         * 
         * @param children 子组件列表
         * @param contentBounds 内容区域
         */
        private function layoutHorizontal(children:Vector.<UIComponent>, contentBounds:Rectangle):void
        {
            var totalWidth:Number = 0;
            var maxHeight:Number = 0;
            var totalWeight:Number = 0;
            
            // 第一遍：计算固定尺寸和权重
            for (var i:int = 0; i < children.length; i++)
            {
                var child:UIComponent = children[i];
                var weight:Number = getChildWeight(child);
                
                if (weight > 0)
                {
                    totalWeight += weight;
                }
                else
                {
                    totalWidth += child.width;
                }
                
                maxHeight = Math.max(maxHeight, child.height);
                
                if (i > 0)
                    totalWidth += _spacing;
            }
            
            // 计算可用于权重分配的空间
            var availableWidth:Number = contentBounds.width - totalWidth;
            var weightUnit:Number = totalWeight > 0 ? availableWidth / totalWeight : 0;
            
            // 第二遍：设置位置和尺寸
            var currentX:Number = contentBounds.x;
            
            for (i = 0; i < children.length; i++)
            {
                child = children[i];
                weight = getChildWeight(child);
                
                var childWidth:Number;
                var childHeight:Number;
                var childY:Number;
                
                // 计算宽度
                if (weight > 0)
                {
                    childWidth = weight * weightUnit;
                }
                else if (_distributeEvenly)
                {
                    childWidth = (contentBounds.width - (children.length - 1) * _spacing) / children.length;
                }
                else
                {
                    childWidth = child.width;
                }
                
                // 计算高度和Y坐标
                switch (_alignment)
                {
                    case ALIGN_START:
                        childHeight = child.height;
                        childY = contentBounds.y;
                        break;
                        
                    case ALIGN_CENTER:
                        childHeight = child.height;
                        childY = contentBounds.y + (contentBounds.height - childHeight) / 2;
                        break;
                        
                    case ALIGN_END:
                        childHeight = child.height;
                        childY = contentBounds.y + contentBounds.height - childHeight;
                        break;
                        
                    case ALIGN_STRETCH:
                        childHeight = contentBounds.height;
                        childY = contentBounds.y;
                        break;
                        
                    default:
                        childHeight = child.height;
                        childY = contentBounds.y;
                        break;
                }
                
                // 应用位置和尺寸
                applyBounds(child, currentX, childY, childWidth, childHeight);
                
                currentX += childWidth + _spacing;
            }
        }
        
        /**
         * 垂直布局
         * 
         * @param children 子组件列表
         * @param contentBounds 内容区域
         */
        private function layoutVertical(children:Vector.<UIComponent>, contentBounds:Rectangle):void
        {
            var totalHeight:Number = 0;
            var maxWidth:Number = 0;
            var totalWeight:Number = 0;
            
            // 第一遍：计算固定尺寸和权重
            for (var i:int = 0; i < children.length; i++)
            {
                var child:UIComponent = children[i];
                var weight:Number = getChildWeight(child);
                
                if (weight > 0)
                {
                    totalWeight += weight;
                }
                else
                {
                    totalHeight += child.height;
                }
                
                maxWidth = Math.max(maxWidth, child.width);
                
                if (i > 0)
                    totalHeight += _spacing;
            }
            
            // 计算可用于权重分配的空间
            var availableHeight:Number = contentBounds.height - totalHeight;
            var weightUnit:Number = totalWeight > 0 ? availableHeight / totalWeight : 0;
            
            // 第二遍：设置位置和尺寸
            var currentY:Number = contentBounds.y;
            
            for (i = 0; i < children.length; i++)
            {
                child = children[i];
                weight = getChildWeight(child);
                
                var childWidth:Number;
                var childHeight:Number;
                var childX:Number;
                
                // 计算高度
                if (weight > 0)
                {
                    childHeight = weight * weightUnit;
                }
                else if (_distributeEvenly)
                {
                    childHeight = (contentBounds.height - (children.length - 1) * _spacing) / children.length;
                }
                else
                {
                    childHeight = child.height;
                }
                
                // 计算宽度和X坐标
                switch (_alignment)
                {
                    case ALIGN_START:
                        childWidth = child.width;
                        childX = contentBounds.x;
                        break;
                        
                    case ALIGN_CENTER:
                        childWidth = child.width;
                        childX = contentBounds.x + (contentBounds.width - childWidth) / 2;
                        break;
                        
                    case ALIGN_END:
                        childWidth = child.width;
                        childX = contentBounds.x + contentBounds.width - childWidth;
                        break;
                        
                    case ALIGN_STRETCH:
                        childWidth = contentBounds.width;
                        childX = contentBounds.x;
                        break;
                        
                    default:
                        childWidth = child.width;
                        childX = contentBounds.x;
                        break;
                }
                
                // 应用位置和尺寸
                applyBounds(child, childX, currentY, childWidth, childHeight);
                
                currentY += childHeight + _spacing;
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
            
            var totalWidth:Number = 0;
            var totalHeight:Number = 0;
            var maxWidth:Number = 0;
            var maxHeight:Number = 0;
            
            for (var i:int = 0; i < children.length; i++)
            {
                var child:UIComponent = children[i];
                
                if (_orientation == HORIZONTAL)
                {
                    totalWidth += child.width;
                    maxHeight = Math.max(maxHeight, child.height);
                    
                    if (i > 0)
                        totalWidth += _spacing;
                }
                else
                {
                    totalHeight += child.height;
                    maxWidth = Math.max(maxWidth, child.width);
                    
                    if (i > 0)
                        totalHeight += _spacing;
                }
            }
            
            var preferredWidth:Number = _orientation == HORIZONTAL ? totalWidth : maxWidth;
            var preferredHeight:Number = _orientation == HORIZONTAL ? maxHeight : totalHeight;
            
            // 加上内边距
            preferredWidth += _padding.x + _padding.width;
            preferredHeight += _padding.y + _padding.height;
            
            return new Rectangle(0, 0, preferredWidth, preferredHeight);
        }
        
        /**
         * 获取子组件的权重
         * 从组件的自定义属性中获取权重值
         * 
         * @param child 子组件
         * @return 权重值，默认为0
         */
        private function getChildWeight(child:UIComponent):Number
        {
            // 尝试从组件的自定义属性中获取权重
            if (child.hasOwnProperty("layoutWeight"))
            {
                return Number(child["layoutWeight"]);
            }
            return 0;
        }
        
        // 属性访问器
        
        /**
         * 设置布局方向
         * 
         * @param value 方向值 (HORIZONTAL 或 VERTICAL)
         */
        public function set orientation(value:String):void
        {
            _orientation = value;
        }
        
        /**
         * 获取布局方向
         * 
         * @return 方向值
         */
        public function get orientation():String
        {
            return _orientation;
        }
        
        /**
         * 设置对齐方式
         * 
         * @param value 对齐方式
         */
        public function set alignment(value:String):void
        {
            _alignment = value;
        }
        
        /**
         * 获取对齐方式
         * 
         * @return 对齐方式
         */
        public function get alignment():String
        {
            return _alignment;
        }
        
        /**
         * 设置是否自动换行
         * 
         * @param value 是否换行
         */
        public function set wrap(value:Boolean):void
        {
            _wrap = value;
        }
        
        /**
         * 获取是否自动换行
         * 
         * @return 是否换行
         */
        public function get wrap():Boolean
        {
            return _wrap;
        }
        
        /**
         * 设置是否平均分配空间
         * 
         * @param value 是否平均分配
         */
        public function set distributeEvenly(value:Boolean):void
        {
            _distributeEvenly = value;
        }
        
        /**
         * 获取是否平均分配空间
         * 
         * @return 是否平均分配
         */
        public function get distributeEvenly():Boolean
        {
            return _distributeEvenly;
        }
        
        /**
         * 设置对齐方式
         * 
         * @param alignment 对齐方式
         */
        public function setAlignment(alignment:String):void
        {
            _alignment = alignment;
        }
        
        /**
         * 添加组件到线性布局
         * 重写基类方法以支持线性布局的权重约束
         * 
         * @param component 要添加的组件
         * @param constraints 布局约束参数，可以是权重数值或包含权重的对象
         */
        public override function addComponent(component:UIComponent, constraints:Object = null):void
        {
            // 处理权重约束
            if (constraints != null)
            {
                var weight:Number = 1.0; // 默认权重
                
                if (constraints is Number)
                {
                    // 直接传入权重数值
                    weight = constraints as Number;
                }
                else if (constraints.hasOwnProperty("weight"))
                {
                    // 传入包含权重的对象
                    weight = constraints.weight;
                }
                
                // 设置组件的权重属性（用于布局计算）
                component["layoutWeight"] = weight;
            }
            else
            {
                // 默认权重为1.0
                component["layoutWeight"] = 1.0;
            }
        }
    }
}