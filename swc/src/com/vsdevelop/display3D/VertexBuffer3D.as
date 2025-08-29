package com.vsdevelop.display3D
{
	import com.vsdevelop.air.extension.glfw.Gl;
	import flash.utils.ByteArray;
	
	public class VertexBuffer3D
	{
		internal var _bufferID:uint;
		internal var _numVertices:int;
		internal var _data32PerVertex:int;
		
		public function VertexBuffer3D(numVertices:int, data32PerVertex:int)
		{
			_numVertices = numVertices;
			_data32PerVertex = data32PerVertex;
			
			// 修复OpenGL缓冲区创建 - 使用正确的API调用方式
			var bufferIds:Vector.<uint> = new Vector.<uint>(1);
			Gl.glGenBuffers(1, bufferIds);
			_bufferID = bufferIds[0];
		}
		
		public function uploadFromByteArray(data:ByteArray, byteArrayOffset:int, startVertex:int, numVertices:int):void
		{
			bind();
			// 添加错误检查
			if (data == null || data.length == 0) {
				throw new Error("VertexBuffer3D.uploadFromByteArray: data cannot be null or empty");
			}
			Gl.glBufferData(Gl.GL_ARRAY_BUFFER, data.length, data, Gl.GL_STATIC_DRAW);
		}
		
		/**
		 * 从Vector上传顶点数据
		 * @param data 顶点数据向量
		 * @param startVertex 起始顶点索引
		 * @param numVertices 顶点数量
		 */
		public function uploadFromVector(data:Vector.<Number>, startVertex:int, numVertices:int):void
		{
			bind();
			// 添加错误检查
			if (data == null || data.length == 0) {
				throw new Error("VertexBuffer3D.uploadFromVector: data cannot be null or empty");
			}
			if (startVertex < 0 || numVertices <= 0) {
				throw new Error("VertexBuffer3D.uploadFromVector: invalid vertex range");
			}
			if (startVertex + numVertices > _numVertices) {
				throw new Error("VertexBuffer3D.uploadFromVector: vertex range exceeds buffer capacity");
			}
			
			// 将Vector数据转换为ByteArray
			var byteArray:ByteArray = new ByteArray();
			byteArray.endian = "littleEndian";
			
			var startIndex:int = startVertex * _data32PerVertex;
			var endIndex:int = startIndex + (numVertices * _data32PerVertex);
			
			for (var i:int = startIndex; i < endIndex && i < data.length; i++) {
				byteArray.writeFloat(data[i]);
			}
			
			byteArray.position = 0;
			Gl.glBufferData(Gl.GL_ARRAY_BUFFER, byteArray.length, byteArray, Gl.GL_STATIC_DRAW);
		}
		
		public function bind():void
		{
			Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, _bufferID);
		}
		
		public function dispose():void
		{
			if (_bufferID != 0) {
				// 修复OpenGL缓冲区删除 - 使用正确的API调用方式
				var bufferIds:Vector.<uint> = new Vector.<uint>(1);
				bufferIds[0] = _bufferID;
				Gl.glDeleteBuffers(1, bufferIds);
				_bufferID = 0;
			}
		}
		
		public function get numVertices():int
		{
			return _numVertices;
		}
		
		public function get data32PerVertex():int
		{
			return _data32PerVertex;
		}
	}
}