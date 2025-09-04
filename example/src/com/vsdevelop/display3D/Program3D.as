package com.vsdevelop.display3D
{
	import com.vsdevelop.air.extension.glfw.Gl;
	import flash.utils.ByteArray;
	
	/**
	 * 着色器程序，用于在GPU上执行渲染逻辑
	 * @author Ray.eDoctor
	 */
	public class Program3D
	{
		private var _context:Context3D;
		private var _program:int;
		
		/**
		 * 创建一个Program3D实例
		 * @param context
		 */
		public function Program3D(context:Context3D)
		{
			_context = context;
			_program = Gl.glCreateProgram();
		}
		
		/**
		 * 上传着色器代码
		 * @param vertexProgram
		 * @param fragmentProgram
		 */
		public function upload(vertexProgram:String, fragmentProgram:String):void
		{
			var vertexShader:int = loadShader(Gl.GL_VERTEX_SHADER, vertexProgram);
			var fragmentShader:int = loadShader(Gl.GL_FRAGMENT_SHADER, fragmentProgram);
			
			Gl.glAttachShader(_program, vertexShader);
			Gl.glAttachShader(_program, fragmentShader);
			Gl.glLinkProgram(_program);
			
			// 检查链接状态
			var linkStatus:int = Gl.glGetProgramiv(_program, Gl.GL_LINK_STATUS);
			if (linkStatus == Gl.GL_FALSE)
			{
				var infoLog:String = Gl.glGetProgramInfoLog(_program);
				trace("Could not link program. \n" + infoLog);
			}
			
			Gl.glDeleteShader(vertexShader);
			Gl.glDeleteShader(fragmentShader);
		}
		
		/**
		 * 加载着色器
		 * @param type
		 * @param source
		 * @return
		 */
		private function loadShader(type:int, source:String):int
		{
			var shader:int = Gl.glCreateShader(type);
			Gl.glShaderSource(shader, source);
			Gl.glCompileShader(shader);
			
			// 检查编译状态
			var compiled:int = Gl.glGetShaderiv(shader, Gl.GL_COMPILE_STATUS);
			if (compiled == Gl.GL_FALSE)
			{
				var infoLog:String = Gl.glGetShaderInfoLog(shader);
				trace("Could not compile shader " + type + ".\n" + infoLog);
				Gl.glDeleteShader(shader);
				return 0;
			}
			
			return shader;
		}
		
		/**
		 * 获取程序ID
		 */
		public function get program():int
		{
			return _program;
		}
		
		/**
		 * 释放程序
		 */
		public function dispose():void
		{
			Gl.glDeleteProgram(_program);
		}
	}
}