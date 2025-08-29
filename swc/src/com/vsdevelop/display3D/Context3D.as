package com.vsdevelop.display3D
{
	import com.vsdevelop.air.extension.glfw.Gl;
	import com.vsdevelop.air.extension.glfw.Glfw;
	
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	public class Context3D
	{
		public function Context3D()
		{
		}
		
		public function clear(red:Number = 0.0, green:Number = 0.0, blue:Number = 0.0, alpha:Number = 1.0, depth:Number = 1.0, stencil:uint = 0, mask:uint = 0xffffffff):void
		{
			Gl.glClearColor(red, green, blue, alpha);
			Gl.glClear(Gl.GL_COLOR_BUFFER_BIT | Gl.GL_DEPTH_BUFFER_BIT);
		}
		
		public function configureBackBuffer(width:int, height:int, antiAlias:int, enableDepthAndStencil:Boolean = true):void
		{
			Glfw.glfwSetWindowSize(Glfw.activeWindow, width, height);
		}
		
		public function createVertexBuffer(numVertices:int, data32PerVertex:int):VertexBuffer3D
		{
			return new VertexBuffer3D(numVertices, data32PerVertex);
		}
		
		public function createIndexBuffer(numIndices:int):IndexBuffer3D
		{
			return new IndexBuffer3D(numIndices);
		}
		
		public function createProgram():Program3D
		{
			return new Program3D();
		}
		
		public function drawTriangles(indexBuffer:IndexBuffer3D, firstIndex:int = 0, numTriangles:int = -1):void
		{
			var count:int = (numTriangles == -1) ? indexBuffer.numIndices : numTriangles * 3;
			Gl.glDrawElements(Gl.GL_TRIANGLES, count, Gl.GL_UNSIGNED_SHORT, firstIndex);
		}
		
		public function present():void
		{
			Glfw.glfwSwapBuffers(Glfw.activeWindow);
		}
		
		public function setProgram(program:Program3D):void
		{
			program.use();
		}
		
		public function setVertexBufferAt(index:int, buffer:VertexBuffer3D, bufferOffset:int = 0, format:String = "float4"):void
		{
			buffer.bind();
			var size:int = 0;
			switch(format)
			{
				case "float1": size = 1; break;
				case "float2": size = 2; break;
				case "float3": size = 3; break;
				case "float4": size = 4; break;
			}
			Gl.glVertexAttribPointer(index, size, Gl.GL_FLOAT, Gl.GL_FALSE, buffer.data32PerVertex * 4, bufferOffset * 4);
			Gl.glEnableVertexAttribArray(index);
		}
		
		public function dispose():void
		{
			
		}
	}
}