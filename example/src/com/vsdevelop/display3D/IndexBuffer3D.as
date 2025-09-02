package com.vsdevelop.display3D
{
	import com.vsdevelop.air.extension.glfw.Gl;
	import flash.utils.ByteArray;
	
	public class IndexBuffer3D
	{
		private var _bufferID:uint;
		private var _numIndices:int;
		
		public function IndexBuffer3D(numIndices:int)
		{
			_numIndices = numIndices;
			
			// 修复OpenGL缓冲区创建 - 使用正确的API调用方式
			_bufferID = Gl.glGenBuffers(1);
		}
		
		public function uploadFromByteArray(data:ByteArray, byteArrayOffset:int, startIndex:int, numIndices:int):void
		{
			bind();
			// 添加错误检查
			if (data == null || data.length == 0) {
				throw new Error("IndexBuffer3D.uploadFromByteArray: data cannot be null or empty");
			}
			// 将ByteArray转换为Vector.<Number>
			var dataVector:Vector.<Number> = new Vector.<Number>();
			data.position = 0;
			while (data.bytesAvailable >= 4) {
				dataVector.push(data.readFloat());
			}
			Gl.glBufferData(Gl.GL_ELEMENT_ARRAY_BUFFER, data.length, dataVector, Gl.GL_STATIC_DRAW);
		}
		
		/**
		 * 从Vector上传索引数据
		 * @param data 索引数据向量
		 * @param startIndex 起始索引
		 * @param numIndices 索引数量
		 */
		public function uploadFromVector(data:Vector.<uint>, startIndex:int, numIndices:int):void
		{
			bind();
			// 添加错误检查
			if (data == null || data.length == 0) {
				throw new Error("IndexBuffer3D.uploadFromVector: data cannot be null or empty");
			}
			if (startIndex < 0 || numIndices <= 0) {
				throw new Error("IndexBuffer3D.uploadFromVector: invalid index range");
			}
			if (startIndex + numIndices > _numIndices) {
				throw new Error("IndexBuffer3D.uploadFromVector: index range exceeds buffer capacity");
			}
			
			// 创建16位无符号整数数组，与GL_UNSIGNED_SHORT匹配
			var indexVector:Vector.<Number> = new Vector.<Number>();
			
			var endIndex:int = startIndex + numIndices;
			for (var i:int = startIndex; i < endIndex && i < data.length; i++) {
				// 确保索引值在16位无符号整数范围内
				if (data[i] > 65535) {
					throw new Error("IndexBuffer3D.uploadFromVector: index value exceeds 16-bit limit: " + data[i]);
				}
				indexVector.push(data[i]);
			}
			
			trace("IndexBuffer3D: Uploading", indexVector.length, "indices:", indexVector);
			
			// 使用正确的数据类型上传索引数据
			Gl.glBufferData(Gl.GL_ELEMENT_ARRAY_BUFFER, indexVector.length * 2, indexVector, Gl.GL_STATIC_DRAW);
			
			// 验证上传是否成功
			var error:int = Gl.glGetError();
			if (error != Gl.GL_NO_ERROR) {
				trace("IndexBuffer3D upload error:", error.toString(16));
			}
		}
		
		public function bind():void
		{
			Gl.glBindBuffer(Gl.GL_ELEMENT_ARRAY_BUFFER, _bufferID);
		}
		
		public function dispose():void
		{
			if (_bufferID != 0) {
				// 修复OpenGL缓冲区删除 - 使用正确的API调用方式
				Gl.glDeleteBuffers(1, _bufferID);
				_bufferID = 0;
			}
		}
		
		public function get bufferID():uint 
		{
			return _bufferID;
		}
		
		public function get numIndices():int
		{
			return _numIndices;
		}
	}
}