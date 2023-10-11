package agl.shader
{
	import com.vsdevelop.air.extension.glfw.Gl;
	
	/**
	 * ...
	 * @author Ray.lei
	 */
	public class IndexBuffer
	{
		
		private var _indexCount:int = 0;
		private var _mode:int = Gl.GL_TRIANGLES;
		private var _type:int = Gl.GL_UNSIGNED_SHORT;
		private var _vbo:int;
		private var _bufferData:Array = null;
		
		public function IndexBuffer()
		{
			this._vbo = Gl.glCreateBuffer();
		}
		
		public function setData(data):void
		{
			this._bufferData = data;
		}
		
		public function get vbo():int
		{
			return this._vbo;
		}
		
		public function get indexCount():int
		{
			return this._indexCount;
		}
		
		public function get mode():int
		{
			return this._mode;
		}
		
		public function get type():int
		{
			return this._type;
		}
		
		public function destroy():void
		{
			Gl.glDeleteBuffer(this._vbo);
			this._vbo = 0;
		}
		
		public function upload():void
		{
			if (this._bufferData == null)
			{
				trace("buffer data is null.");
				return;
			}
			var useByte:Boolean = this._bufferData.length <= 256;
			var buffer:Array = [this._bufferData];
			this._type = useByte ? Gl.GL_UNSIGNED_BYTE : Gl.GL_UNSIGNED_SHORT;
			
			Gl.glBufferData(this._vbo,Gl.GL_ELEMENT_ARRAY_BUFFER, buffer, Gl.GL_STATIC_DRAW);
			
			this._indexCount = buffer.length;
			this._bufferData = null;
		}
	}

}