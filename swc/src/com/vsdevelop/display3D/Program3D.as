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
			
			Gl.glShaderSource(_vertexShaderID, vertexShaderAGAL.length, vertexShaderAGAL, 0);
			Gl.glCompileShader(_vertexShaderID);
			
			Gl.glShaderSource(_fragmentShaderID, fragmentShaderAGAL.length, fragmentShaderAGAL, 0);
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
			Gl.glShaderSource(_vertexShaderID, vSource.length, vSource, 0);
			Gl.glCompileShader(_vertexShaderID);
			
			_fragmentShaderID = Gl.glCreateShader(Gl.GL_FRAGMENT_SHADER);
			var fSource:ByteArray = new ByteArray();
			fSource.writeUTFBytes(fragmentSource);
			fSource.position = 0;
			Gl.glShaderSource(_fragmentShaderID, fSource.length, fSource, 0);
			Gl.glCompileShader(_fragmentShaderID);
			
			Gl.glAttachShader(_programID, _vertexShaderID);
			Gl.glAttachShader(_programID, _fragmentShaderID);
			Gl.glLinkProgram(_programID);
		}
		
		public function use():void
		{
			Gl.glUseProgram(_programID);
		}
		
		public function dispose():void
		{
			Gl.glDeleteProgram(_programID);
			Gl.glDeleteShader(_vertexShaderID);
			Gl.glDeleteShader(_fragmentShaderID);
		}
	}
}