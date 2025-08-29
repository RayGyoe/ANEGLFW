package com.vsdevelop.display3D.textures
{
    import flash.events.EventDispatcher;
    
    /**
     * TextureBase 是所有纹理类的抽象基类
     */
    public class TextureBase extends EventDispatcher
    {
        public function TextureBase()
        {
            super();
        }
        
        /**
         * 释放纹理资源
         */
        public function dispose():void
        {
            // 子类实现
        }
        
        /**
         * 纹理宽度
         */
        public function get width():int
        {
            return 0;
        }
        
        /**
         * 纹理高度
         */
        public function get height():int
        {
            return 0;
        }
        
        /**
         * 纹理格式
         */
        public function get format():String
        {
            return "";
        }
    }
}