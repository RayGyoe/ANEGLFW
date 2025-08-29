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
			var buffers:ByteArray = new ByteArray();
			Gl.glGenBuffers(1, buffers);
			_bufferID = buffers.readUnsignedInt();
		}
		
		public function uploadFromByteArray(data:ByteArray, byteArrayOffset:int, startVertex:int, numVertices:int):void
		{
			bind();
			Gl.glBufferData(Gl.GL_ARRAY_BUFFER, data.length, data, Gl.GL_STATIC_DRAW);
		}
		
		public function bind():void
		{
			Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, _bufferID);
		}
		
		public function dispose():void
		{
			var buffers:ByteArray = new ByteArray();
			buffers.writeUnsignedInt(_bufferID);
			buffers.position = 0;
			Gl.glDeleteBuffers(1, buffers);
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