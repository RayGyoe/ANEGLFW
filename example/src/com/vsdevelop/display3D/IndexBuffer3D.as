package com.vsdevelop.display3D
{
	import com.vsdevelop.air.extension.glfw.Gl;
	import flash.utils.ByteArray;
	
	/**
	 * 索引缓冲区，用于存储顶点索引数据
	 * @author Ray.eDoctor
	 */
	public class IndexBuffer3D
	{
		private var _context:Context3D;
		public var numIndices:int;
		private var _buffer:int;
		
		/**
		 * 创建一个IndexBuffer3D实例
		 * @param context
		 * @param numIndices
		 */
		public function IndexBuffer3D(context:Context3D, numIndices:int)
		{
			_context = context;
			this.numIndices = numIndices;
			_buffer = Gl.glGenBuffers(1)[0];
		}
		
		/**
		 * 上传索引数据
		 * @param data
		 * @param startIndex
		 * @param numIndices
		 */
		public function uploadFromVector(data:Vector.<uint>, startIndex:int, numIndices:int):void
		{
			Gl.glBindBuffer(Gl.GL_ELEMENT_ARRAY_BUFFER, _buffer);
			var byteData:ByteArray = new ByteArray();
			byteData.length = data.length * 2; // Use 2 for unsigned short
			for (var i:int = 0; i < data.length; i++)
			{
				byteData.writeShort(data[i]);
			}
			byteData.position = 0;
			Gl.glBufferData(Gl.GL_ELEMENT_ARRAY_BUFFER, byteData, Gl.GL_STATIC_DRAW);
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