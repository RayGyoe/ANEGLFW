package ui.layout
{
    import ui.core.UIComponent;
    import flash.geom.Rectangle;
    
    /**
     * 网格布局管理器
     * 支持行列网格式排列组件
     * 
     * 特性：
     * - 支持固定行数和列数的网格布局
     * - 支持跨行跨列的组件
     * - 支持单元格内的对齐方式
     * - 支持行高和列宽的自动计算或手动设置
     * - 支持网格间距设置
     * 
     * @author UI Framework Team
     * @version 1.0
     */
    public class GridLayout extends LayoutManager
    {
        // 对齐方式常量
        public static const ALIGN_START:String = "start";
        public static const ALIGN_CENTER:String = "center";
        public static const ALIGN_END:String = "end";
        public static const ALIGN_STRETCH:String = "stretch";
        
        // 尺寸模式常量
        public static const SIZE_AUTO:String = "auto";        // 自动计算尺寸
        public static const SIZE_FIXED:String = "fixed";      // 固定尺寸
        public static const SIZE_PERCENT:String = "percent";  // 百分比尺寸
        
        // 网格属性
        private var _rows:int;                    // 行数
        private var _columns:int;                 // 列数
        private var _cellAlignment:String;        // 单元格内对齐方式
        private var _uniformCellSize:Boolean;     // 是否使用统一的单元格尺寸
        
        // 间距设置
        private var _horizontalSpacing:Number;   // 水平间距
        private var _verticalSpacing:Number;     // 垂直间距
        
        // 行列尺寸设置
        private var _rowHeights:Vector.<Number>;  // 行高数组
        private var _columnWidths:Vector.<Number>; // 列宽数组
        
        /**
         * 构造函数
         * 
         * @param rows 行数
         * @param columns 列数
         * @param cellAlignment 单元格内对齐方式
         */
        public function GridLayout(rows:int = 1, columns:int = 1, cellAlignment:String = ALIGN_STRETCH)
        {
            super();
            _rows = Math.max(1, rows);
            _columns = Math.max(1, columns);
            _cellAlignment = cellAlignment;
            _uniformCellSize = true;
            _horizontalSpacing = 0;
            _verticalSpacing = 0;
            
            _rowHeights = new Vector.<Number>();
            _columnWidths = new Vector.<Number>();
        }
        
        /**
         * 执行网格布局
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
            
            // 计算网格尺寸
            var gridInfo:GridInfo = calculateGridSize(children, contentBounds);
            
            // 布局子组件
            layoutChildren(children, gridInfo, contentBounds);
        }
        
        /**
         * 计算网格尺寸信息
         * 
         * @param children 子组件列表
         * @param contentBounds 内容区域
         * @return 网格信息对象
         */
        private function calculateGridSize(children:Vector.<UIComponent>, contentBounds:Rectangle):GridInfo
        {
            var gridInfo:GridInfo = new GridInfo();
            gridInfo.rows = _rows;
            gridInfo.columns = _columns;
            gridInfo.rowHeights = new Vector.<Number>(_rows);
            gridInfo.columnWidths = new Vector.<Number>(_columns);
            
            // 计算可用空间
            var availableWidth:Number = contentBounds.width - (_columns - 1) * _horizontalSpacing;
            var availableHeight:Number = contentBounds.height - (_rows - 1) * _verticalSpacing;
            
            if (_uniformCellSize)
            {
                // 统一单元格尺寸
                var cellWidth:Number = availableWidth / _columns;
                var cellHeight:Number = availableHeight / _rows;
                
                for (var i:int = 0; i < _columns; i++)
                {
                    gridInfo.columnWidths[i] = cellWidth;
                }
                
                for (i = 0; i < _rows; i++)
                {
                    gridInfo.rowHeights[i] = cellHeight;
                }
            }
            else
            {
                // 根据内容计算尺寸
                calculateDynamicSizes(children, gridInfo, availableWidth, availableHeight);
            }
            
            return gridInfo;
        }
        
        /**
         * 动态计算行列尺寸
         * 
         * @param children 子组件列表
         * @param gridInfo 网格信息
         * @param availableWidth 可用宽度
         * @param availableHeight 可用高度
         */
        private function calculateDynamicSizes(children:Vector.<UIComponent>, gridInfo:GridInfo, 
                                             availableWidth:Number, availableHeight:Number):void
        {
            // 初始化为0
            for (var i:int = 0; i < _columns; i++)
            {
                gridInfo.columnWidths[i] = 0;
            }
            
            for (i = 0; i < _rows; i++)
            {
                gridInfo.rowHeights[i] = 0;
            }
            
            // 遍历子组件，计算每个单元格的最大尺寸需求
            for (i = 0; i < children.length; i++)
            {
                var child:UIComponent = children[i];
                var gridPos:GridPosition = getChildGridPosition(child, i);
                
                if (gridPos.column < _columns && gridPos.row < _rows)
                {
                    // 更新列宽（考虑跨列）
                    var childWidthPerColumn:Number = child.width / gridPos.columnSpan;
                    for (var col:int = gridPos.column; col < gridPos.column + gridPos.columnSpan && col < _columns; col++)
                    {
                        gridInfo.columnWidths[col] = Math.max(gridInfo.columnWidths[col], childWidthPerColumn);
                    }
                    
                    // 更新行高（考虑跨行）
                    var childHeightPerRow:Number = child.height / gridPos.rowSpan;
                    for (var row:int = gridPos.row; row < gridPos.row + gridPos.rowSpan && row < _rows; row++)
                    {
                        gridInfo.rowHeights[row] = Math.max(gridInfo.rowHeights[row], childHeightPerRow);
                    }
                }
            }
            
            // 调整尺寸以适应可用空间
            adjustSizesToFitSpace(gridInfo, availableWidth, availableHeight);
        }
        
        /**
         * 调整网格尺寸以适应可用空间
         * 
         * @param gridInfo 网格信息
         * @param availableWidth 可用宽度
         * @param availableHeight 可用高度
         */
        private function adjustSizesToFitSpace(gridInfo:GridInfo, availableWidth:Number, availableHeight:Number):void
        {
            // 计算当前总宽度和总高度
            var totalWidth:Number = 0;
            var totalHeight:Number = 0;
            
            for (var i:int = 0; i < _columns; i++)
            {
                totalWidth += gridInfo.columnWidths[i];
            }
            
            for (i = 0; i < _rows; i++)
            {
                totalHeight += gridInfo.rowHeights[i];
            }
            
            // 按比例调整列宽
            if (totalWidth > 0 && totalWidth != availableWidth)
            {
                var widthScale:Number = availableWidth / totalWidth;
                for (i = 0; i < _columns; i++)
                {
                    gridInfo.columnWidths[i] *= widthScale;
                }
            }
            
            // 按比例调整行高
            if (totalHeight > 0 && totalHeight != availableHeight)
            {
                var heightScale:Number = availableHeight / totalHeight;
                for (i = 0; i < _rows; i++)
                {
                    gridInfo.rowHeights[i] *= heightScale;
                }
            }
        }
        
        /**
         * 布局子组件
         * 
         * @param children 子组件列表
         * @param gridInfo 网格信息
         * @param contentBounds 内容区域
         */
        private function layoutChildren(children:Vector.<UIComponent>, gridInfo:GridInfo, contentBounds:Rectangle):void
        {
            for (var i:int = 0; i < children.length; i++)
            {
                var child:UIComponent = children[i];
                var gridPos:GridPosition = getChildGridPosition(child, i);
                
                if (gridPos.column < _columns && gridPos.row < _rows)
                {
                    var cellBounds:Rectangle = calculateCellBounds(gridPos, gridInfo, contentBounds);
                    positionChildInCell(child, cellBounds);
                }
            }
        }
        
        /**
         * 计算单元格边界
         * 
         * @param gridPos 网格位置
         * @param gridInfo 网格信息
         * @param contentBounds 内容区域
         * @return 单元格边界矩形
         */
        private function calculateCellBounds(gridPos:GridPosition, gridInfo:GridInfo, contentBounds:Rectangle):Rectangle
        {
            var cellX:Number = contentBounds.x;
            var cellY:Number = contentBounds.y;
            var cellWidth:Number = 0;
            var cellHeight:Number = 0;
            
            // 计算X坐标和宽度
            for (var col:int = 0; col < gridPos.column; col++)
            {
                cellX += gridInfo.columnWidths[col] + _horizontalSpacing;
            }
            
            for (col = gridPos.column; col < gridPos.column + gridPos.columnSpan && col < _columns; col++)
            {
                cellWidth += gridInfo.columnWidths[col];
                if (col > gridPos.column)
                    cellWidth += _horizontalSpacing;
            }
            
            // 计算Y坐标和高度
            for (var row:int = 0; row < gridPos.row; row++)
            {
                cellY += gridInfo.rowHeights[row] + _verticalSpacing;
            }
            
            for (row = gridPos.row; row < gridPos.row + gridPos.rowSpan && row < _rows; row++)
            {
                cellHeight += gridInfo.rowHeights[row];
                if (row > gridPos.row)
                    cellHeight += _verticalSpacing;
            }
            
            return new Rectangle(cellX, cellY, cellWidth, cellHeight);
        }
        
        /**
         * 在单元格内定位子组件
         * 
         * @param child 子组件
         * @param cellBounds 单元格边界
         */
        private function positionChildInCell(child:UIComponent, cellBounds:Rectangle):void
        {
            var childX:Number;
            var childY:Number;
            var childWidth:Number;
            var childHeight:Number;
            
            // 根据对齐方式计算位置和尺寸
            switch (_cellAlignment)
            {
                case ALIGN_START:
                    childX = cellBounds.x;
                    childY = cellBounds.y;
                    childWidth = child.width;
                    childHeight = child.height;
                    break;
                    
                case ALIGN_CENTER:
                    childWidth = child.width;
                    childHeight = child.height;
                    childX = cellBounds.x + (cellBounds.width - childWidth) / 2;
                    childY = cellBounds.y + (cellBounds.height - childHeight) / 2;
                    break;
                    
                case ALIGN_END:
                    childWidth = child.width;
                    childHeight = child.height;
                    childX = cellBounds.x + cellBounds.width - childWidth;
                    childY = cellBounds.y + cellBounds.height - childHeight;
                    break;
                    
                case ALIGN_STRETCH:
                    childX = cellBounds.x;
                    childY = cellBounds.y;
                    childWidth = cellBounds.width;
                    childHeight = cellBounds.height;
                    break;
                    
                default:
                    childX = cellBounds.x;
                    childY = cellBounds.y;
                    childWidth = child.width;
                    childHeight = child.height;
                    break;
            }
            
            // 应用位置和尺寸
            applyBounds(child, childX, childY, childWidth, childHeight);
        }
        
        /**
         * 获取子组件的网格位置
         * 
         * @param child 子组件
         * @param index 组件索引
         * @return 网格位置对象
         */
        private function getChildGridPosition(child:UIComponent, index:int):GridPosition
        {
            var gridPos:GridPosition = new GridPosition();
            
            // 尝试从组件的自定义属性中获取网格位置
            if (child.hasOwnProperty("gridRow") && child.hasOwnProperty("gridColumn"))
            {
                gridPos.row = int(child["gridRow"]);
                gridPos.column = int(child["gridColumn"]);
                gridPos.rowSpan = child.hasOwnProperty("gridRowSpan") ? int(child["gridRowSpan"]) : 1;
                gridPos.columnSpan = child.hasOwnProperty("gridColumnSpan") ? int(child["gridColumnSpan"]) : 1;
            }
            else
            {
                // 根据索引自动计算位置
                gridPos.row = Math.floor(index / _columns);
                gridPos.column = index % _columns;
                gridPos.rowSpan = 1;
                gridPos.columnSpan = 1;
            }
            
            return gridPos;
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
            
            // 简化计算：假设统一单元格尺寸
            var maxChildWidth:Number = 0;
            var maxChildHeight:Number = 0;
            
            for (var i:int = 0; i < children.length; i++)
            {
                var child:UIComponent = children[i];
                maxChildWidth = Math.max(maxChildWidth, child.width);
                maxChildHeight = Math.max(maxChildHeight, child.height);
            }
            
            var totalWidth:Number = maxChildWidth * _columns + _horizontalSpacing * (_columns - 1);
            var totalHeight:Number = maxChildHeight * _rows + _verticalSpacing * (_rows - 1);
            
            // 加上内边距
            totalWidth += _padding.x + _padding.width;
            totalHeight += _padding.y + _padding.height;
            
            return new Rectangle(0, 0, totalWidth, totalHeight);
        }
        
        // 属性访问器
        
        /**
         * 设置行数
         * 
         * @param value 行数
         */
        public function set rows(value:int):void
        {
            _rows = Math.max(1, value);
        }
        
        /**
         * 获取行数
         * 
         * @return 行数
         */
        public function get rows():int
        {
            return _rows;
        }
        
        /**
         * 设置列数
         * 
         * @param value 列数
         */
        public function set columns(value:int):void
        {
            _columns = Math.max(1, value);
        }
        
        /**
         * 获取列数
         * 
         * @return 列数
         */
        public function get columns():int
        {
            return _columns;
        }
        
        /**
         * 设置单元格对齐方式
         * 
         * @param value 对齐方式
         */
        public function set cellAlignment(value:String):void
        {
            _cellAlignment = value;
        }
        
        /**
         * 获取单元格对齐方式
         * 
         * @return 对齐方式
         */
        public function get cellAlignment():String
        {
            return _cellAlignment;
        }
        
        /**
         * 设置是否使用统一单元格尺寸
         * 
         * @param value 是否统一
         */
        public function set uniformCellSize(value:Boolean):void
        {
            _uniformCellSize = value;
        }
        
        /**
         * 获取是否使用统一单元格尺寸
         * 
         * @return 是否统一
         */
        public function get uniformCellSize():Boolean
        {
            return _uniformCellSize;
        }
        
        /**
         * 设置水平间距
         * 
         * @param value 间距值
         */
        public function set horizontalSpacing(value:Number):void
        {
            _horizontalSpacing = value;
        }
        
        /**
         * 获取水平间距
         * 
         * @return 间距值
         */
        public function get horizontalSpacing():Number
        {
            return _horizontalSpacing;
        }
        
        /**
         * 设置垂直间距
         * 
         * @param value 间距值
         */
        public function set verticalSpacing(value:Number):void
        {
            _verticalSpacing = value;
        }
        
        /**
         * 获取垂直间距
         * 
         * @return 间距值
         */
        public function get verticalSpacing():Number
        {
            return _verticalSpacing;
        }
        
        /**
         * 设置单元格对齐方式
         * 
         * @param alignment 对齐方式
         */
        public function setCellAlignment(alignment:String):void
        {
            _cellAlignment = alignment;
        }
        
        /**
         * 添加组件到网格布局
         * 重写基类方法以支持网格布局的位置和跨度约束
         * 
         * @param component 要添加的组件
         * @param constraints 布局约束参数，可以包含row、column、rowSpan、columnSpan等属性
         */
        public override function addComponent(component:UIComponent, constraints:Object = null):void
        {
            // 设置默认网格位置
            var gridPos:GridPosition = new GridPosition();
            
            if (constraints != null)
            {
                // 解析网格约束参数
                if (constraints.hasOwnProperty("row"))
                    gridPos.row = constraints.row;
                if (constraints.hasOwnProperty("column"))
                    gridPos.column = constraints.column;
                if (constraints.hasOwnProperty("rowSpan"))
                    gridPos.rowSpan = constraints.rowSpan;
                if (constraints.hasOwnProperty("columnSpan"))
                    gridPos.columnSpan = constraints.columnSpan;
            }
            
            // 设置组件的网格位置属性（用于布局计算）
            component["gridPosition"] = gridPos;
        }
    }
}

/**
 * 网格信息类
 * 存储网格布局的计算结果
 */
class GridInfo
{
    public var rows:int;
    public var columns:int;
    public var rowHeights:Vector.<Number>;
    public var columnWidths:Vector.<Number>;
}

/**
 * 网格位置类
 * 存储组件在网格中的位置和跨度信息
 */
class GridPosition
{
    public var row:int = 0;
    public var column:int = 0;
    public var rowSpan:int = 1;
    public var columnSpan:int = 1;
}