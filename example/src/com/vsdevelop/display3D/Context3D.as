package com.vsdevelop.display3D
{
	import com.vsdevelop.air.extension.glfw.Gl;
	import com.vsdevelop.display.Stage3D;
	
	/**
	 * 3D渲染上下文，封装了底层的OpenGL操作
	 * @author Ray.eDoctor
	 */
	public class Context3D
	{
		private var _stage3D:Stage3D;
		
		/**
		 * 创建一个Context3D实例
		 * @param stage3D
		 */
		public function Context3D(stage3D:Stage3D)
		{
			_stage3D = stage3D;
		}
		
		/**
		 * 清除颜色、深度和模板缓冲区
		 * @param red
		 * @param green
		 * @param blue
		 * @param alpha
		 * @param depth
		 * @param stencil
		 * @param mask
		 */
		public function clear(red:Number = 0.0, green:Number = 0.0, blue:Number = 0.0, alpha:Number = 1.0, depth:Number = 1.0, stencil:uint = 0, mask:uint = 0xFFFFFFFF):void
		{
			Gl.glClearColor(red, green, blue, alpha);
			Gl.glClearDepth(depth);
			Gl.glClearStencil(stencil);
			Gl.glClear(mask);
		}
		
		/**
		 * 配置后台缓冲区
		 * @param width
		 * @param height
		 * @param antiAlias
		 * @param enableDepthAndStencil
		 */
		public function configureBackBuffer(width:int, height:int, antiAlias:int, enableDepthAndStencil:Boolean = true):void
		{
			// 在OpenGL中，后台缓冲区的配置通常在创建窗口时完成
			// 这里可以添加一些相关的设置，例如视口
			Gl.glViewport(0, 0, width, height);
		}
		
		/**
		 * 呈现后台缓冲区
		 */
		public function present():void
		{
			// 在ANE中，这个操作可能由本地代码处理
		}
		
		/**
		 * 创建顶点缓冲区
		 * @param numVertices
		 * @param data32PerVertex
		 * @return
		 */
		public function createVertexBuffer(numVertices:int, data32PerVertex:int):VertexBuffer3D
		{
			return new VertexBuffer3D(this, numVertices, data32PerVertex);
		}
		
		/**
		 * 创建索引缓冲区
		 * @param numIndices
		 * @return
		 */
		public function createIndexBuffer(numIndices:int):IndexBuffer3D
		{
			return new IndexBuffer3D(this, numIndices);
		}
		
		/**
		 * 创建着色器程序
		 * @return
		 */
		public function createProgram():Program3D
		{
			return new Program3D(this);
		}
		
		/**
		 * 绘制三角形
		 * @param indexBuffer
		 * @param firstIndex
		 * @param numTriangles
		 */
		public function drawTriangles(indexBuffer:IndexBuffer3D, firstIndex:int = 0, numTriangles:int = -1):void
		{
			var numIndices:int = numTriangles == -1 ? indexBuffer.numIndices : numTriangles * 3;
			Gl.glBindBuffer(Gl.GL_ELEMENT_ARRAY_BUFFER, indexBuffer.buffer);
			Gl.glDrawElements(Gl.GL_TRIANGLES, numIndices, Gl.GL_UNSIGNED_SHORT, firstIndex * 2);
		}
		
		/**
		 * 设置顶点缓冲区
		 * @param index
		 * @param buffer
		 * @param bufferOffset
		 * @param format
		 */
		public function setVertexBufferAt(index:int, buffer:VertexBuffer3D, bufferOffset:int = 0, format:String = "float3"):void
		{
			Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, buffer.buffer);
			var size:int;
			var type:int;
			var normalized:Boolean = false;
			var stride:int = buffer.data32PerVertex * 4;
			var pointer:int = bufferOffset * 4;
			
			switch (format)
			{
				case "float3":
					size = 3;
					type = Gl.GL_FLOAT;
					break;
				// Add other formats as needed
			}
			
			Gl.glVertexAttribPointer(index, size, type, normalized, stride, pointer);
			Gl.glEnableVertexAttribArray(index);
		}
		
		/**
		 * 设置着色器程序
		 * @param program
		 */
		public function setProgram(program:Program3D):void
		{
			Gl.glUseProgram(program.program);
		}
	}
}