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
			_vertexShaderID = Gl.glCreateShader(Gl.GL_VERTEX_SHADER);
			var vSource:ByteArray = new ByteArray();
			vSource.writeUTFBytes(vertexSource);
			vSource.position = 0;
			Gl.glShaderSource(_vertexShaderID, 1, vertexSource);
			Gl.glCompileShader(_vertexShaderID);
			
			_fragmentShaderID = Gl.glCreateShader(Gl.GL_FRAGMENT_SHADER);
			var fSource:ByteArray = new ByteArray();
			fSource.writeUTFBytes(fragmentSource);
			fSource.position = 0;
			Gl.glShaderSource(_fragmentShaderID, 1, fragmentSource);
			Gl.glCompileShader(_fragmentShaderID);
			
			Gl.glAttachShader(_programID, _vertexShaderID);
			Gl.glAttachShader(_programID, _fragmentShaderID);
			Gl.glLinkProgram(_programID);
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