package com.vsdevelop.display3D
{
	import com.vsdevelop.air.extension.glfw.Gl;
	import flash.utils.ByteArray;
	
	public class IndexBuffer3D
	{
		internal var _bufferID:uint;
		internal var _numIndices:int;
		
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
			
			// 将Vector数据转换为ByteArray
			var byteArray:ByteArray = new ByteArray();
			byteArray.endian = "littleEndian";
			
			var endIndex:int = startIndex + numIndices;
			for (var i:int = startIndex; i < endIndex && i < data.length; i++) {
				byteArray.writeShort(data[i]); // 使用16位无符号整数
			}
			
			byteArray.position = 0;
			// 将ByteArray转换为Vector.<Number>
			var dataVector:Vector.<Number> = new Vector.<Number>();
			byteArray.position = 0;
			while (byteArray.bytesAvailable >= 2) {
				dataVector.push(byteArray.readUnsignedShort());
			}
			Gl.glBufferData(Gl.GL_ELEMENT_ARRAY_BUFFER, byteArray.length, dataVector, Gl.GL_STATIC_DRAW);
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
		
		public function get numIndices():int
		{
			return _numIndices;
		}
	}
}