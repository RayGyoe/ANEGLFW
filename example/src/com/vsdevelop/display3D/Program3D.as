package com.vsdevelop.display3D
{
	import com.vsdevelop.air.extension.glfw.Gl;
	import flash.utils.ByteArray;
	
	public class Program3D
	{
		internal var _programID:uint;
		internal var _vertexShaderID:uint;
		internal var _fragmentShaderID:uint;
		
		public function Program3D()
		{
			_programID = Gl.glCreateProgram();
		}
		
		public function upload(vertexShaderAGAL:ByteArray, fragmentShaderAGAL:ByteArray):void
		{
			_vertexShaderID = Gl.glCreateShader(Gl.GL_VERTEX_SHADER);
			_fragmentShaderID = Gl.glCreateShader(Gl.GL_FRAGMENT_SHADER);
			
			Gl.glShaderSource(_vertexShaderID, 1, vertexShaderAGAL.toString());
			Gl.glCompileShader(_vertexShaderID);
			
			Gl.glShaderSource(_fragmentShaderID, 1, fragmentShaderAGAL.toString());
			Gl.glCompileShader(_fragmentShaderID);
			
			Gl.glAttachShader(_programID, _vertexShaderID);
			Gl.glAttachShader(_programID, _fragmentShaderID);
			Gl.glLinkProgram(_programID);
		}
		
		public function uploadFromGLSL(vertexSource:String, fragmentSource:String):void
	{
		// 编译顶点着色器
		_vertexShaderID = Gl.glCreateShader(Gl.GL_VERTEX_SHADER);
		Gl.glShaderSource(_vertexShaderID, 1, vertexSource);
		Gl.glCompileShader(_vertexShaderID);
		
		// 检查顶点着色器编译状态
		var vertexCompileStatus:int = Gl.glGetShaderiv(_vertexShaderID, Gl.GL_COMPILE_STATUS);
		if (vertexCompileStatus == 0) {
			var vertexLog:String = Gl.glGetShaderInfoLog(_vertexShaderID,255);
			trace("Vertex shader compilation failed:", vertexLog);
			throw new Error("Vertex shader compilation failed: " + vertexLog);
		}
		
		// 编译片段着色器
		_fragmentShaderID = Gl.glCreateShader(Gl.GL_FRAGMENT_SHADER);
		Gl.glShaderSource(_fragmentShaderID, 1, fragmentSource);
		Gl.glCompileShader(_fragmentShaderID);
		
		// 检查片段着色器编译状态
		var fragmentCompileStatus:int = Gl.glGetShaderiv(_fragmentShaderID, Gl.GL_COMPILE_STATUS);
		if (fragmentCompileStatus == 0) {
			var fragmentLog:String = Gl.glGetShaderInfoLog(_fragmentShaderID,255);
			trace("Fragment shader compilation failed:", fragmentLog);
			throw new Error("Fragment shader compilation failed: " + fragmentLog);
		}
		
		// 绑定attribute位置（在链接之前）
		Gl.glBindAttribLocation(_programID, 0, "aPosition");
		Gl.glBindAttribLocation(_programID, 1, "aTexCoord");
		Gl.glBindAttribLocation(_programID, 1, "aColor"); // 为颜色属性绑定位置1（根据着色器使用情况）
		
		// 链接程序
		Gl.glAttachShader(_programID, _vertexShaderID);
		Gl.glAttachShader(_programID, _fragmentShaderID);
		Gl.glLinkProgram(_programID);
		
		// 检查程序链接状态
		var linkStatus:int = Gl.glGetProgramiv(_programID, Gl.GL_LINK_STATUS);
		if (linkStatus == 0) {
			var programLog:String = Gl.glGetProgramInfoLog(_programID,255);
			trace("Program linking failed:", programLog);
			throw new Error("Program linking failed: " + programLog);
		}
		
		trace("Shader program compiled and linked successfully");
	}
		
		public function activate():void
		{
			Gl.glUseProgram(_programID);
		}
		
		public function dispose():void
		{
			Gl.glDeleteProgram(_programID);
			Gl.glDeleteShader(_vertexShaderID);
			Gl.glDeleteShader(_fragmentShaderID);
		}
		
		/**
		 * 设置uniform整数值
		 */
		public function setUniform1i(name:String, value:int):void
		{
			var location:int = Gl.glGetUniformLocation(_programID, name);
			if (location != -1)
			{
				Gl.glUniform1i(location, value);
			}
		}
		
		/**
		 * 设置uniform浮点值
		 */
		public function setUniform1f(name:String, value:Number):void
		{
			var location:int = Gl.glGetUniformLocation(_programID, name);
			if (location != -1)
			{
				Gl.glUniform1f(location, value);
			}
		}
		
		/**
		 * 获取程序ID
		 */
		public function get programID():uint
		{
			return _programID;
		}
	}
}