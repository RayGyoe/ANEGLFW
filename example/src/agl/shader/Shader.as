package agl.shader
{
	import com.vsdevelop.air.extension.glfw.Gl;
	
	/**
	 * ...
	 * @author Ray.lei
	 */
	public class Shader
	{
		
		private var program:int;
		private var _semanticToAttribName:Object = {}; // {[semantic:string]:string}
		private var _attributes:Object = {}; // {[name:string]:number}
		private var _uniforms:Object = {};  // {[name:string]:WebGLUniformLocation}
		
		public function Shader()
		{
			
		}
		
		public function mapAttributeSemantic(semantic:String, attribName:String):void
		{
			this._semanticToAttribName[semantic] = attribName;
			
			this._attributes[attribName] = Gl.glGetUniformLocation(program, attribName);
		}
		
		public function create(vshader:String, fshader:String):Boolean
		{
			var vertexShader:int = this.loadShader(Gl.GL_VERTEX_SHADER, vshader);
			var fragmentShader:int = this.loadShader(Gl.GL_FRAGMENT_SHADER, fshader);
			if (!vertexShader || !fragmentShader)
			{
				return false;
			}
			
			// Create a program object
			this.program = Gl.glCreateProgram();
			if (!this.program)
			{
				return false;
			}
			
			// Attach the shader objects
			Gl.glAttachShader(this.program, vertexShader);
			Gl.glAttachShader(this.program, fragmentShader);
			
			// Link the program object
			Gl.glLinkProgram(this.program);
			
			// Check the result of linking
			
			
			return true;
		}
		
		public function loadShader(type:int, source:String):int
		{
			var shader:int = Gl.glCreateShader(type);
			if (!shader)
			{
				trace('unable to create shader');
				return null;
			}
			
			// Set the shader program
			Gl.glShaderSource(shader,1, source);
			// Compile the shader
			Gl.glCompileShader(shader);
			
			return shader;
		}
		
		public function setUniform(type:String, name:String, value:Number):void
		{
			var location:int = getAttributeLocation(name);
			if (!location){
				trace(name, location);
				return;
			}
			switch (type)
			{
			case Gl.GL_FLOAT: 
			{
				Gl.glUniform1f(location, value);
				break;
			}
			/*
			case Gl.GL_FLOAT_VEC2: 
			{
				Gl.glUniform2fv(location, value);
				break;
			}
			case Gl.GL_FLOAT_VEC3: 
			{
				Gl.glUniform3fv(location, value);
				break;
			}
			case Gl.GL_FLOAT_VEC4: 
			{
				Gl.glUniform4fv(location, value);
				break;
			}
			case Gl.GL_FLOAT_MAT4: 
			{
				Gl.glUniformMatrix4fv(location, false, value);
				break;
			}*/
			default: 
			{
				trace('uniform type not support', type);
				break;
			}
			}
		}
		
		public function getAttributeLocation(semantic:String):int
		{
			var name:String = this._semanticToAttribName[semantic];
			if (name)
			{
				var location:int = this._attributes[name];
				return location;
			}
			
			trace('Shader: can not find attribute for semantic ' + semantic);
			return -1;
		
		}
		
		public function useProgram():void
		{
			if (this.program)
			{
				Gl.glUseProgram(this.program);
			}
		}
	
	}

}