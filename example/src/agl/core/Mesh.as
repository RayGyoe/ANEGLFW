package agl.core
{
	import agl.shader.IndexBuffer;
	import agl.shader.Shader;
	import agl.shader.VertexBuffer;
	import com.vsdevelop.air.extension.glfw.Gl;
	
	/**
	 * ...
	 * @author Ray.lei
	 */
	public class Mesh
	{
		
		private var _vertexBuffer:VertexBuffer;
		private var _indexBuffer:IndexBuffer;
		
<<<<<<< HEAD
		public var shader:Shader;
		
=======
>>>>>>> a06a60f3db15f644b949939c977d4e683c1a161c
		public function Mesh(vertexFormat:VertexFormat)
		{
			_vertexBuffer = new VertexBuffer(vertexFormat);
		}
		
		public function setVertexData(semantic, data):void
		{
			this._vertexBuffer.setData(semantic, data);
		}
		
		public function setTriangles(data):void
		{
			if (this._indexBuffer == null)
			{
				this._indexBuffer = new IndexBuffer();
			}
			this._indexBuffer.setData(data);
		}
		
		public function destroy():void
		{
			this._vertexBuffer.destroy();
		}
		
		public function upload():void
		{
			this._vertexBuffer.upload();
			if (this._indexBuffer)
			{
				this._indexBuffer.upload();
			}
		}
		
<<<<<<< HEAD
		public function render():void
		{
			Gl.glBindBuffer(this._vertexBuffer.vbo,Gl.GL_ARRAY_BUFFER);
=======
		public function render(shader:Shader):void
		{
			Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, this._vertexBuffer.vbo);
>>>>>>> a06a60f3db15f644b949939c977d4e683c1a161c
			
			this._vertexBuffer.bindAttrib(shader);
			
			if (this._indexBuffer)
			{
<<<<<<< HEAD
				Gl.glBindBuffer(this._indexBuffer.vbo,Gl.GL_ELEMENT_ARRAY_BUFFER);
				//Gl.glDrawElements(this._indexBuffer.mode, this._indexBuffer.indexCount, this._indexBuffer.type, 0);
				Gl.glDrawArrays(Gl.GL_TRIANGLES, 0, this._indexBuffer.indexCount);
				
				Gl.glBindBuffer(0, Gl.GL_ELEMENT_ARRAY_BUFFER);
=======
				Gl.glBindBuffer(Gl.GL_ELEMENT_ARRAY_BUFFER, this._indexBuffer.vbo);
				Gl.glDrawElements(this._indexBuffer.mode, this._indexBuffer.indexCount, this._indexBuffer.type, 0);
				Gl.glBindBuffer(Gl.GL_ELEMENT_ARRAY_BUFFER, null);
>>>>>>> a06a60f3db15f644b949939c977d4e683c1a161c
			}
			else
			{
				Gl.glDrawArrays(Gl.GL_TRIANGLES, 0, this._vertexBuffer.vertexCount);
			}
			
			this._vertexBuffer.unbindAttrib(shader);
			
<<<<<<< HEAD
			Gl.glBindBuffer(0,Gl.GL_ARRAY_BUFFER);
=======
			Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, null);
>>>>>>> a06a60f3db15f644b949939c977d4e683c1a161c
		}
	}

}