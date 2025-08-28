package agl.shader
{
	import com.vsdevelop.air.extension.glfw.Gl;
	import flash.geom.Matrix3D;
	
	/**
	 * ...
	 * @author Ray.lei
	 */
	public class Shader
	{
		
		public function get program():int 
		{
			return _program;
		}
		
		private var _program:int;
		
		private var _uniformLocations:Object = {};
		
		public function Shader(vshader:String, fshader:String)
		{
			var vertexShader:int = this.loadShader(Gl.GL_VERTEX_SHADER, vshader);
			var fragmentShader:int = this.loadShader(Gl.GL_FRAGMENT_SHADER, fshader);
			if (!vertexShader || !fragmentShader)
			{
				return;
			}
			
			// Create a program object
			this._program = Gl.glCreateProgram();
			if (!this._program)
			{
				return;
			}
			
			with (Gl) 
			{
				// Attach the shader objects
				glAttachShader(this._program, vertexShader);
				glAttachShader(this._program, fragmentShader);
				
				// Link the program object
				glLinkProgram(this._program);
				
				// Check the result of linking			
				glDeleteShader(vertexShader);
				glDeleteShader(fragmentShader);
			}
		}
		
		private function loadShader(type:int, shaderString:String):int 
		{
			var shader:int = Gl.glCreateShader(type);
			Gl.glShaderSource(shader, 1, shaderString);
			Gl.glCompileShader(shader);
			return shader;
		}
		
		public function useProgram():void
		{
			if (this._program)Gl.glUseProgram(this._program);
		}
		
		
		public function setMatrix4fv(name:String, nat4:flash.geom.Matrix3D):void 
		{
			Gl.glUniformMatrix4fv(getUniformLocation(name), 1, Gl.GL_FALSE, nat4);
		}
		
		private function getUniformLocation(name:String):int
		{
			if (!_uniformLocations[name])_uniformLocations[name] = Gl.glGetUniformLocation(this._program, name);
			return _uniformLocations[name];
		}
	}

}