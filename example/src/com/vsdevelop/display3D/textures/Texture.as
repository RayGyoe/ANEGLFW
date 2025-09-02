package com.vsdevelop.display3D.textures
{
    import com.vsdevelop.display3D.Context3D;
    import flash.display.BitmapData;
    import flash.events.EventDispatcher;
    import flash.utils.ByteArray;
    import com.vsdevelop.air.extension.glfw.Gl;
	import flash.utils.Endian;
    
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
            if (Gl.glGenTextures != null)
            {
                _textureId = Gl.glGenTextures(1);
            }
        }
        
        public function uploadFromBitmapData(source:BitmapData, miplevel:uint = 0):void
        {
            // 检查纹理对象是否有效
            if (_textureId == 0) {
                throw new Error("Texture.uploadFromBitmapData: texture not created or invalid");
            }
            
            if (source == null) {
                throw new Error("Texture.uploadFromBitmapData: source cannot be null");
            }
            if (source.width != _width || source.height != _height) {
                throw new Error("Texture.uploadFromBitmapData: source dimensions must match texture dimensions");
            }
            
            // 检查纹理尺寸是否为2的幂（某些OpenGL实现要求）
            var isPowerOfTwo:Boolean = isPowerOfTwoValue(_width) && isPowerOfTwoValue(_height);
            if (!isPowerOfTwo) {
                trace("Warning: Texture dimensions are not power of two:", _width, "x", _height);
            }
                
            var pixels:ByteArray = new ByteArray();
			pixels.endian = Endian.LITTLE_ENDIAN;
			source.copyPixelsToByteArray(source.rect, pixels);
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
            
            // 检查OpenGL错误
            var error:int = Gl.glGetError();
            if (error != Gl.GL_NO_ERROR) {
                throw new Error("Texture.uploadFromBitmapData: OpenGL error during texture upload: " + error);
            }
            
            // 设置纹理参数
            if (isPowerOfTwo) {
                // 对于2的幂纹理，可以使用mipmap
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_MIN_FILTER, Gl.GL_LINEAR_MIPMAP_LINEAR);
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_MAG_FILTER, Gl.GL_LINEAR);
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_WRAP_S, Gl.GL_REPEAT);
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_WRAP_T, Gl.GL_REPEAT);
                Gl.glGenerateMipmap(Gl.GL_TEXTURE_2D);
            } else {
                // 对于非2的幂纹理，使用线性过滤和边缘夹紧
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_MIN_FILTER, Gl.GL_LINEAR);
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_MAG_FILTER, Gl.GL_LINEAR);
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_WRAP_S, Gl.GL_CLAMP_TO_EDGE);
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_WRAP_T, Gl.GL_CLAMP_TO_EDGE);
            }
            
            trace("Texture uploaded successfully:", _width, "x", _height, "miplevel:", miplevel);
        }
        
        public function uploadFromByteArray(data:ByteArray, byteArrayOffset:uint, miplevel:uint = 0):void
        {
            // 检查纹理对象是否有效
            if (_textureId == 0) {
                throw new Error("Texture.uploadFromByteArray: texture not created or invalid");
            }
            
            if (data == null) {
                throw new Error("Texture.uploadFromByteArray: data cannot be null");
            }
            if (byteArrayOffset >= data.length) {
                throw new Error("Texture.uploadFromByteArray: byteArrayOffset exceeds data length");
            }
            if (_width <= 0 || _height <= 0) {
                throw new Error("Texture.uploadFromByteArray: invalid texture dimensions");
            }
            
            // 检查纹理尺寸是否为2的幂
            var isPowerOfTwo:Boolean = isPowerOfTwoValue(_width) && isPowerOfTwoValue(_height);
            if (!isPowerOfTwo) {
                trace("Warning: Texture dimensions are not power of two:", _width, "x", _height);
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
            
            // 检查OpenGL错误
            var error:int = Gl.glGetError();
            if (error != Gl.GL_NO_ERROR) {
                throw new Error("Texture.uploadFromByteArray: OpenGL error during texture upload: " + error);
            }
            
            // 设置纹理参数
            if (isPowerOfTwo) {
                // 对于2的幂纹理，可以使用mipmap
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_MIN_FILTER, Gl.GL_LINEAR_MIPMAP_LINEAR);
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_MAG_FILTER, Gl.GL_LINEAR);
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_WRAP_S, Gl.GL_REPEAT);
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_WRAP_T, Gl.GL_REPEAT);
                Gl.glGenerateMipmap(Gl.GL_TEXTURE_2D);
            } else {
                // 对于非2的幂纹理，使用线性过滤和边缘夹紧
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_MIN_FILTER, Gl.GL_LINEAR);
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_MAG_FILTER, Gl.GL_LINEAR);
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_WRAP_S, Gl.GL_CLAMP_TO_EDGE);
                Gl.glTexParameteri(Gl.GL_TEXTURE_2D, Gl.GL_TEXTURE_WRAP_T, Gl.GL_CLAMP_TO_EDGE);
            }
            
            trace("Texture uploaded successfully from ByteArray:", _width, "x", _height, "miplevel:", miplevel);
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
                Gl.glDeleteTextures(1, _textureId);
                _textureId = 0;
                trace("Texture disposed successfully");
            }
        }
        
        // 辅助方法：检查数值是否为2的幂
        private function isPowerOfTwoValue(value:int):Boolean
        {
            return value > 0 && (value & (value - 1)) == 0;
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