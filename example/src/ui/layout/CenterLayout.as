package ui.layout
{
    import ui.core.UIComponent;
    import flash.geom.Rectangle;
    
    /**
     * 居中布局管理器
     * 将所有子组件在容器中完全居中（水平和垂直都居中）
     * 
     * 特性：
     * - 支持水平和垂直方向的完全居中
     * - 适用于单个子组件的居中显示
     * - 多个子组件会重叠在中心位置
     * - 主要用于Button等需要内容居中的组件
     * 
     * @author UI Framework Team
     * @version 1.0
     */
    public class CenterLayout extends LayoutManager
    {
        /**
         * 构造函数
         */
        public function CenterLayout()
        {
            super();
        }
        
        /**
         * 执行居中布局
         * 将所有子组件在容器中心位置居中
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
            
            // 将每个子组件都居中放置
            for (var i:int = 0; i < children.length; i++)
            {
                var child:UIComponent = children[i];
                
                // 计算居中位置
                var centerX:Number = contentBounds.x + (contentBounds.width - child.width) / 2;
                var centerY:Number = contentBounds.y + (contentBounds.height - child.height) / 2;
                
                // 设置子组件位置
                child.x = centerX;
                child.y = centerY;
            }
        }
        
        /**
         * 计算首选尺寸
         * 返回最大子组件的尺寸加上内边距
         * 
         * @param container 容器组件
         * @return 首选尺寸矩形
         */
        public override function getPreferredSize(container:UIComponent):Rectangle
        {
            var children:Vector.<UIComponent> = getVisibleChildren(container);
            if (children.length == 0)
            {
                return new Rectangle(0, 0, _padding.left + _padding.right, _padding.top + _padding.bottom);
            }
            
            var maxWidth:Number = 0;
            var maxHeight:Number = 0;
            
            // 找到最大的子组件尺寸
            for (var i:int = 0; i < children.length; i++)
            {
                var child:UIComponent = children[i];
                maxWidth = Math.max(maxWidth, child.width);
                maxHeight = Math.max(maxHeight, child.height);
            }
            
            return new Rectangle(0, 0, 
                maxWidth + _padding.left + _padding.right,
                maxHeight + _padding.top + _padding.bottom);
        }
    }
}