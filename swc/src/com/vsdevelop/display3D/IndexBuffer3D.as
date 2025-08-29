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
			var buffers:ByteArray = new ByteArray();
			Gl.glGenBuffers(1, buffers);
			_bufferID = buffers.readUnsignedInt();
		}
		
		public function uploadFromByteArray(data:ByteArray, byteArrayOffset:int, startIndex:int, numIndices:int):void
		{
			bind();
			Gl.glBufferData(Gl.GL_ELEMENT_ARRAY_BUFFER, data.length, data, Gl.GL_STATIC_DRAW);
		}
		
		public function bind():void
		{
			Gl.glBindBuffer(Gl.GL_ELEMENT_ARRAY_BUFFER, _bufferID);
		}
		
		public function dispose():void
		{
			var buffers:ByteArray = new ByteArray();
			buffers.writeUnsignedInt(_bufferID);
			buffers.position = 0;
			Gl.glDeleteBuffers(1, buffers);
		}
		
		public function get numIndices():int
		{
			return _numIndices;
		}
	}
}