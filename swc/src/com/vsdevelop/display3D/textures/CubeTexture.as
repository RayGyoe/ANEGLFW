package com.vsdevelop.display3D.textures
{
    import com.vsdevelop.display3D.Context3D;
    import flash.display.BitmapData;
    import flash.events.EventDispatcher;
    import flash.utils.ByteArray;
    import com.vsdevelop.air.extension.glfw.Gl;
    
    public class CubeTexture extends EventDispatcher
    {
        private var _context:Context3D;
        private var _size:int;
        private var _format:String;
        private var _textureId:uint;
        
        public function CubeTexture(context:Context3D, size:int, format:String = "bgra")
        {
            _context = context;
            _size = size;
            _format = format;
            
            // 创建OpenGL立方体贴图 - 修复API调用方式
            var textureIds:Vector.<uint> = new Vector.<uint>(1);
            if (Gl.glGenTextures != null)
            {
                Gl.glGenTextures(1, textureIds);
                _textureId = textureIds[0];
            }
        }
        
        public function uploadFromBitmapData(source:BitmapData, side:int, miplevel:uint = 0):void
        {
            if (source == null) {
                throw new Error("CubeTexture.uploadFromBitmapData: source cannot be null");
            }
            if (source.width != _size || source.height != _size) {
                throw new Error("CubeTexture.uploadFromBitmapData: source dimensions must match cube size");
            }
            if (side < 0 || side > 5) {
                throw new Error("CubeTexture.uploadFromBitmapData: side must be between 0 and 5");
            }
                
            var pixels:ByteArray = source.getPixels(source.rect);
            pixels.position = 0;
            
            Gl.glBindTexture(Gl.GL_TEXTURE_CUBE_MAP, _textureId);
            
            var target:int = getCubeMapTarget(side);
            Gl.glTexImage2D(
                target,
                miplevel,
                Gl.GL_RGBA,
                _size,
                _size,
                0,
                Gl.GL_BGRA,
                Gl.GL_UNSIGNED_BYTE,
                pixels
            );
            
            // 设置纹理参数
            Gl.glTexParameteri(Gl.GL_TEXTURE_CUBE_MAP, Gl.GL_TEXTURE_MIN_FILTER, Gl.GL_LINEAR);
            Gl.glTexParameteri(Gl.GL_TEXTURE_CUBE_MAP, Gl.GL_TEXTURE_MAG_FILTER, Gl.GL_LINEAR);
            Gl.glTexParameteri(Gl.GL_TEXTURE_CUBE_MAP, Gl.GL_TEXTURE_WRAP_S, Gl.GL_CLAMP_TO_EDGE);
            Gl.glTexParameteri(Gl.GL_TEXTURE_CUBE_MAP, Gl.GL_TEXTURE_WRAP_T, Gl.GL_CLAMP_TO_EDGE);
            Gl.glTexParameteri(Gl.GL_TEXTURE_CUBE_MAP, Gl.GL_TEXTURE_WRAP_R, Gl.GL_CLAMP_TO_EDGE);
        }
        
        public function uploadFromByteArray(data:ByteArray, byteArrayOffset:uint, side:int, miplevel:uint = 0):void
        {
            if (data == null) {
                throw new Error("CubeTexture.uploadFromByteArray: data cannot be null");
            }
            if (byteArrayOffset >= data.length) {
                throw new Error("CubeTexture.uploadFromByteArray: byteArrayOffset exceeds data length");
            }
            if (side < 0 || side > 5) {
                throw new Error("CubeTexture.uploadFromByteArray: side must be between 0 and 5");
            }
                
            data.position = byteArrayOffset;
            
            Gl.glBindTexture(Gl.GL_TEXTURE_CUBE_MAP, _textureId);
            
            var target:int = getCubeMapTarget(side);
            Gl.glTexImage2D(
                target,
                miplevel,
                Gl.GL_RGBA,
                _size,
                _size,
                0,
                Gl.GL_BGRA,
                Gl.GL_UNSIGNED_BYTE,
                data
            );
            
            // 设置纹理参数
            Gl.glTexParameteri(Gl.GL_TEXTURE_CUBE_MAP, Gl.GL_TEXTURE_MIN_FILTER, Gl.GL_LINEAR);
            Gl.glTexParameteri(Gl.GL_TEXTURE_CUBE_MAP, Gl.GL_TEXTURE_MAG_FILTER, Gl.GL_LINEAR);
            Gl.glTexParameteri(Gl.GL_TEXTURE_CUBE_MAP, Gl.GL_TEXTURE_WRAP_S, Gl.GL_CLAMP_TO_EDGE);
            Gl.glTexParameteri(Gl.GL_TEXTURE_CUBE_MAP, Gl.GL_TEXTURE_WRAP_T, Gl.GL_CLAMP_TO_EDGE);
            Gl.glTexParameteri(Gl.GL_TEXTURE_CUBE_MAP, Gl.GL_TEXTURE_WRAP_R, Gl.GL_CLAMP_TO_EDGE);
        }
        
        public function uploadCompressedTextureFromByteArray(data:ByteArray, byteArrayOffset:uint, async:Boolean = false):void
        {
            // 压缩立方体贴图支持需要扩展实现
            trace("uploadCompressedTextureFromByteArray for CubeTexture not implemented yet");
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
        
        private function getCubeMapTarget(side:int):int
        {
            switch (side)
            {
                case 0: return Gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X;
                case 1: return Gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_X;
                case 2: return Gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Y;
                case 3: return Gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Y;
                case 4: return Gl.GL_TEXTURE_CUBE_MAP_POSITIVE_Z;
                case 5: return Gl.GL_TEXTURE_CUBE_MAP_NEGATIVE_Z;
                default: return Gl.GL_TEXTURE_CUBE_MAP_POSITIVE_X;
            }
        }
        
        public function get size():int
        {
            return _size;
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