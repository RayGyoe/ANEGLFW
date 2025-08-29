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
		// 验证颜色值范围
		red = Math.max(0.0, Math.min(1.0, red));
		green = Math.max(0.0, Math.min(1.0, green));
		blue = Math.max(0.0, Math.min(1.0, blue));
		alpha = Math.max(0.0, Math.min(1.0, alpha));
		depth = Math.max(0.0, Math.min(1.0, depth));
		
		Gl.glClearColor(red, green, blue, alpha);
		Gl.glClearDepth(depth);
		Gl.glClear(Gl.GL_COLOR_BUFFER_BIT | Gl.GL_DEPTH_BUFFER_BIT);
	}
		
		public function configureBackBuffer(width:int, height:int, antiAlias:int, enableDepthAndStencil:Boolean = true):void
	{
		// 添加参数验证
		if (width <= 0 || height <= 0) {
			throw new Error("Context3D.configureBackBuffer: width and height must be positive");
		}
		if (antiAlias < 0) {
			throw new Error("Context3D.configureBackBuffer: antiAlias cannot be negative");
		}
		
		Glfw.glfwSetWindowSize(Glfw.activeWindow, width, height);
		Gl.glViewport(0, 0, width, height);
		
		// 启用深度测试（如果需要）
		if (enableDepthAndStencil) {
			Gl.glEnable(Gl.GL_DEPTH_TEST);
			Gl.glDepthFunc(Gl.GL_LEQUAL);
		} else {
			Gl.glDisable(Gl.GL_DEPTH_TEST);
		}
	}
		
		public function createVertexBuffer(numVertices:int, data32PerVertex:int):VertexBuffer3D
	{
		// 添加参数验证
		if (numVertices <= 0) {
			throw new Error("Context3D.createVertexBuffer: numVertices must be positive");
		}
		if (data32PerVertex <= 0) {
			throw new Error("Context3D.createVertexBuffer: data32PerVertex must be positive");
		}
		return new VertexBuffer3D(numVertices, data32PerVertex);
	}
		
		public function createIndexBuffer(numIndices:int):IndexBuffer3D
	{
		// 添加参数验证
		if (numIndices <= 0) {
			throw new Error("Context3D.createIndexBuffer: numIndices must be positive");
		}
		return new IndexBuffer3D(numIndices);
	}
		
		public function createProgram():Program3D
		{
			return new Program3D();
		}
		
		public function drawTriangles(indexBuffer:IndexBuffer3D, firstIndex:int = 0, numTriangles:int = -1):void
	{
		// 添加错误检查
		if (indexBuffer == null) {
			throw new Error("Context3D.drawTriangles: indexBuffer cannot be null");
		}
		if (firstIndex < 0) {
			throw new Error("Context3D.drawTriangles: firstIndex cannot be negative");
		}
		
		// 确保正确绑定索引缓冲区
		indexBuffer.bind();
		
		var count:int = (numTriangles == -1) ? indexBuffer.numIndices : numTriangles * 3;
		
		// 验证绘制范围
		if (firstIndex + count > indexBuffer.numIndices) {
			throw new Error("Context3D.drawTriangles: draw range exceeds index buffer capacity");
		}
		
		// 计算字节偏移量（每个索引2字节）
		var byteOffset:int = firstIndex * 2;
		Gl.glDrawElements(Gl.GL_TRIANGLES, count, Gl.GL_UNSIGNED_SHORT, byteOffset);
	}
		
		public function present():void
		{
			Glfw.glfwSwapBuffers(Glfw.activeWindow);
		}
		
		public function setProgram(program:Program3D):void
	{
		// 添加错误检查
		if (program == null) {
			throw new Error("Context3D.setProgram: program cannot be null");
		}
		program.use();
	}
		
		public function setVertexBufferAt(index:int, buffer:VertexBuffer3D, bufferOffset:int = 0, format:String = "float4"):void
	{
		// 添加错误检查
		if (buffer == null) {
			throw new Error("Context3D.setVertexBufferAt: buffer cannot be null");
		}
		if (index < 0) {
			throw new Error("Context3D.setVertexBufferAt: index cannot be negative");
		}
		if (bufferOffset < 0) {
			throw new Error("Context3D.setVertexBufferAt: bufferOffset cannot be negative");
		}
		
		buffer.bind();
		var size:int = 0;
		switch(format)
		{
			case "float1": size = 1; break;
			case "float2": size = 2; break;
			case "float3": size = 3; break;
			case "float4": size = 4; break;
			default: 
				throw new Error("Context3D.setVertexBufferAt: unsupported format '" + format + "'");
		}
		
		// 验证缓冲区偏移量
		var stride:int = buffer.data32PerVertex * 4;
		var offset:int = bufferOffset * 4;
		if (offset >= stride * buffer.numVertices) {
			throw new Error("Context3D.setVertexBufferAt: bufferOffset exceeds vertex buffer capacity");
		}
		
		Gl.glVertexAttribPointer(index, size, Gl.GL_FLOAT, Gl.GL_FALSE, stride, offset);
		Gl.glEnableVertexAttribArray(index);
	}
		
		public function dispose():void
	{
		// 清理OpenGL状态
		Gl.glUseProgram(0);
		Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, 0);
		Gl.glBindBuffer(Gl.GL_ELEMENT_ARRAY_BUFFER, 0);
		Gl.glBindTexture(Gl.GL_TEXTURE_2D, 0);
		Gl.glBindTexture(Gl.GL_TEXTURE_CUBE_MAP, 0);
	}
		
		/**
	 * 创建2D纹理
	 */
	public function createTexture(width:int, height:int, format:String = "bgra", optimizeForRenderToTexture:Boolean = false, streamingLevels:int = 0):com.vsdevelop.display3D.textures.Texture
	{
		// 添加参数验证
		if (width <= 0 || height <= 0) {
			throw new Error("Context3D.createTexture: width and height must be positive");
		}
		if (format == null || format.length == 0) {
			throw new Error("Context3D.createTexture: format cannot be null or empty");
		}
		return new com.vsdevelop.display3D.textures.Texture(this, width, height, format, optimizeForRenderToTexture);
	}
		
		/**
	 * 创建立方体贴图
	 */
	public function createCubeTexture(size:int, format:String = "bgra", optimizeForRenderToTexture:Boolean = false, streamingLevels:int = 0):com.vsdevelop.display3D.textures.CubeTexture
	{
		// 添加参数验证
		if (size <= 0) {
			throw new Error("Context3D.createCubeTexture: size must be positive");
		}
		if (format == null || format.length == 0) {
			throw new Error("Context3D.createCubeTexture: format cannot be null or empty");
		}
		return new com.vsdevelop.display3D.textures.CubeTexture(this, size, format);
	}
		
		/**
	 * 创建矩形纹理
	 */
	public function createRectangleTexture(width:int, height:int, format:String = "bgra", optimizeForRenderToTexture:Boolean = false):com.vsdevelop.display3D.textures.RectangleTexture
	{
		// 添加参数验证
		if (width <= 0 || height <= 0) {
			throw new Error("Context3D.createRectangleTexture: width and height must be positive");
		}
		if (format == null || format.length == 0) {
			throw new Error("Context3D.createRectangleTexture: format cannot be null or empty");
		}
		return new com.vsdevelop.display3D.textures.RectangleTexture(this, width, height, format);
	}
	}
}