package com.vsdevelop.display3D
{
	import com.vsdevelop.air.extension.glfw.Gl;
	import flash.utils.ByteArray;
	
	/**
	 * 顶点缓冲区，用于存储顶点数据
	 * @author Ray.eDoctor
	 */
	public class VertexBuffer3D
	{
		private var _context:Context3D;
		public var data32PerVertex:int;
		private var _numVertices:int;
		private var _data32PerVertex:int;
		private var _buffer:int;
		
		/**
		 * 创建一个VertexBuffer3D实例
		 * @param context
		 * @param numVertices
		 * @param data32PerVertex
		 */
		public function VertexBuffer3D(context:Context3D, numVertices:int, data32PerVertex:int)
		{
			_context = context;
			_numVertices = numVertices;
			this.data32PerVertex = data32PerVertex;
			var buffers:Vector.<uint> = Gl.glGenBuffers(1);
			_buffer = buffers[0];
		}		/**
		 * 上传顶点数据
		 * @param data
		 * @param startVertex
		 * @param numVertices
		 */
		public function uploadFromVector(data:Vector.<Number>, startVertex:int, numVertices:int):void
		{
			Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, _buffer);
			var byteData:ByteArray = new ByteArray();
			byteData.length = data.length * 4;
			for (var i:int = 0; i < data.length; i++)
			{
				byteData.writeFloat(data[i]);
			}
			byteData.position = 0;
			Gl.glBufferData(Gl.GL_ARRAY_BUFFER, byteData.length, byteData, Gl.GL_STATIC_DRAW);
		}
		
		/**
		 * 释放缓冲区
		 */
		public function dispose():void
		{
			Gl.glDeleteBuffers(1, _buffer);
		}
		
		/**
		 * 获取缓冲区ID
		 */
		public function get buffer():int
		{
			return _buffer;
		}
	}
}