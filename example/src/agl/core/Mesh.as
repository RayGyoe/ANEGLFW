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
		
		public function render(shader:Shader):void
		{
			Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, this._vertexBuffer.vbo);
			
			this._vertexBuffer.bindAttrib(shader);
			
			if (this._indexBuffer)
			{
				Gl.glBindBuffer(Gl.GL_ELEMENT_ARRAY_BUFFER, this._indexBuffer.vbo);
				Gl.glDrawElements(this._indexBuffer.mode, this._indexBuffer.indexCount, this._indexBuffer.type, 0);
				Gl.glBindBuffer(Gl.GL_ELEMENT_ARRAY_BUFFER, null);
			}
			else
			{
				Gl.glDrawArrays(Gl.GL_TRIANGLES, 0, this._vertexBuffer.vertexCount);
			}
			
			this._vertexBuffer.unbindAttrib(shader);
			
			Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, null);
		}
	}

}