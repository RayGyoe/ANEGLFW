package com.vsdevelop.display3D.textures
{
    import com.vsdevelop.display3D.Context3D;
    import flash.display.BitmapData;
    import flash.events.EventDispatcher;
    import flash.utils.ByteArray;
    import com.vsdevelop.air.extension.glfw.Gl;
    
    public class Texture extends EventDispatcher
    {
        public static const BGRA:String = "bgra";
        public static const BGRA_PACKED:String = "bgraPacked4444";
        public static const BGR_PACKED:String = "bgrPacked565";
        public static const COMPRESSED:String = "compressed";
        public static const COMPRESSED_ALPHA:String = "compressedAlpha";
        
        private var _context:Context3D;
        private var _width:int;
        private var _height:int;
        private var _format:String;
        private var _textureId:uint;
        private var _optimizeForRenderToTexture:Boolean;
        
        public function Texture(context:Context3D, width:int, height:int, format:String = BGRA, optimizeForRenderToTexture:Boolean = false)
        {
            _context = context;
            _width = width;
            _height = height;
            _format = format;
            _optimizeForRenderToTexture = optimizeForRenderToTexture;
            
            // 创建OpenGL纹理 - 修复API调用方式
            var textureIds:Vector.<uint> = new Vector.<uint>(1);
            if (Gl.glGenTextures != null)
            {
                Gl.glGenTextures(1, textureIds);
                _textureId = textureIds[0];
            }
        }
        
        public function uploadFromBitmapData(source:BitmapData, miplevel:uint = 0):void
        {
            if (source == null) {
                throw new Error("Texture.uploadFromBitmapData: source cannot be null");
            }
            if (source.width != _width || source.height != _height) {
                throw new Error("Texture.uploadFromBitmapData: source dimensions must match texture dimensions");
            }
                
            var pixels:ByteArray = source.getPixels(source.rect);
            pixels.position = 0;
            
            Gl.glBindTexture(Gl.GL_TEXTURE_2D, _textureId);
            Gl.glTexImage2D(
                Gl.GL_TEXTURE_2D,
                miplevel,
                Gl.GL_RGBA,
                _width,
                _height,
                0,
                Gl.GL_BGRA,
                Gl.GL_UNSIGNED_BYTE,
                pixels
            );
            
            // 设置纹理参数
            Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_MIN_FILTER, Gl.GL_LINEAR);
            Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_MAG_FILTER, Gl.GL_LINEAR);
            Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_WRAP_S, Gl.GL_CLAMP_TO_EDGE);
            Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_WRAP_T, Gl.GL_CLAMP_TO_EDGE);
        }
        
        public function uploadFromByteArray(data:ByteArray, byteArrayOffset:uint, miplevel:uint = 0):void
        {
            if (data == null) {
                throw new Error("Texture.uploadFromByteArray: data cannot be null");
            }
            if (byteArrayOffset >= data.length) {
                throw new Error("Texture.uploadFromByteArray: byteArrayOffset exceeds data length");
            }
                
            data.position = byteArrayOffset;
            
            Gl.glBindTexture(Gl.GL_TEXTURE_2D, _textureId);
            Gl.glTexImage2D(
                Gl.GL_TEXTURE_2D,
                miplevel,
                Gl.GL_RGBA,
                _width,
                _height,
                0,
                Gl.GL_BGRA,
                Gl.GL_UNSIGNED_BYTE,
                data
            );
            
            // 设置纹理参数
            Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_MIN_FILTER, Gl.GL_LINEAR);
            Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_MAG_FILTER, Gl.GL_LINEAR);
            Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_WRAP_S, Gl.GL_CLAMP_TO_EDGE);
            Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_WRAP_T, Gl.GL_CLAMP_TO_EDGE);
        }
        
        public function uploadCompressedTextureFromByteArray(data:ByteArray, byteArrayOffset:uint, async:Boolean = false):void
        {
            // 压缩纹理支持需要扩展实现
            trace("uploadCompressedTextureFromByteArray not implemented yet");
        }
        
        public function dispose():void
        {
            if (_textureId != 0)
            {
                // 修复OpenGL纹理删除 - 使用正确的API调用方式
                var textureIds:Vector.<uint> = new Vector.<uint>(1);
                textureIds[0] = _textureId;
                Gl.glDeleteTextures(1, textureIds);
                _textureId = 0;
            }
        }
        
        public function get width():int
        {
            return _width;
        }
        
        public function get height():int
        {
            return _height;
        }
        
        public function get format():String
        {
            return _format;
        }
        
        public function get textureId():uint
        {
            return _textureId;
        }
    }
}