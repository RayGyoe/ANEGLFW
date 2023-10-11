package agl.shader
{
	import agl.core.VertexFormat;
	import agl.utils.VertexSemantic;
	import com.vsdevelop.air.extension.glfw.Gl;
	
	/**
	 * ...
	 * @author Ray.lei
	 */
	public class VertexBuffer
	{
		
		private var _vertexCount:int = 0;
		private var _vertexStride:int = 0; // vertex data size in byte
		private var _vertexFormat:VertexFormat;
		private var _attribsInfo:Object = {};
		private var _bufferData = null;
		
		private var BYTES_PER_ELEMENT:int = 4; // for Float32Array
		
		private var _vbo:int;
		
		public function VertexBuffer(vertexFormat:VertexFormat)
		{
			this._vertexFormat = vertexFormat;
			
			var attribNum:int = this._vertexFormat.attribs.length;
			for (var i = 0; i < attribNum; ++i)
			{
				var semantic:String = this._vertexFormat.attribs[i];
				var size:int = this._vertexFormat.attribSizeMap[semantic];
				if (size == null)
				{
					trace('VertexBuffer: bad semantic');
				}
				else
				{
					var info = new VertexAttribInfo(semantic, size);
					this._attribsInfo[semantic] = info;
				}
			}
			
			this._vbo = Gl.glCreateBuffer();
		}
		
		public function setData(semantic, data):void
		{
			this._attribsInfo[semantic].data = data;
		}
		
		public function get vbo():int
		{
			return this._vbo;
		}
		
		public function get vertexCount():int
		{
			return this._vertexCount;
		}
		
		public function get vertexStride():int
		{
			return this._vertexStride;
		}
		
		public function destroy():void
		{
			Gl.glDeleteBuffer(this._vbo);
			this._vbo = 0;
		}
		
		//combine vertex attribute datas to a data array
		private function _compile():void
		{
			var positionInfo = this._attribsInfo[VertexSemantic.POSITION];
			if (positionInfo == null)
			{
				trace('VertexBuffer: no attrib position');
				return;
			}
			if (positionInfo.data == null || positionInfo.data.length === 0)
			{
				trace('VertexBuffer: position data is empty');
				return;
			}
			
			this._vertexCount = positionInfo.data.length / positionInfo.size;
			this._vertexStride = this._vertexFormat.getVertexSize() * this.BYTES_PER_ELEMENT;
			
			this._bufferData = [];
			for (var i = 0; i < this._vertexCount; ++i)
			{
				for (var semantic in this._vertexFormat.attribs)
				{
					var info = this._attribsInfo[semantic];
					if (info == null || info.data == null)
					{
						trace('VertexBuffer: bad semantic ' + semantic);
						continue;
					}
					for (var k = 0; k < info.size; ++k)
					{
						var value = info.data[i * info.size + k];
						if (value === undefined)
						{
							trace('VertexBuffer: missing value for ' + semantic);
						}
						this._bufferData.push(value);
					}
				}
			}
			
			//compute offset for attrib info, and free info.data
			var offset = 0;
			for (var semantic in this._vertexFormat.attribs)
			{
				var info = this._attribsInfo[semantic];
				info.offset = offset;
				info.data = null;
				offset += info.size * this.BYTES_PER_ELEMENT;
			}
		}
		
		//upload data to webGL, add free buffer data
		public function upload():void
		{
			this._compile();
			
			var buffer = [this._bufferData];
			
			Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, this._vbo);
			Gl.glBufferData(Gl.GL_ARRAY_BUFFER, buffer, Gl.GL_STATIC_DRAW);
			Gl.glBindBuffer(Gl.GL_ARRAY_BUFFER, null);
			
			this._bufferData = null;
		}
		
		public function bindAttrib(shader):void
		{
			for (var semantic in this._vertexFormat.attribs)
			{
				var info = this._attribsInfo[semantic];
				
				var location:int = shader.getAttributeLocation(semantic);
				if (location >= 0)
				{
					Gl.glVertexAttribPointer(location, info.size, Gl.GL_FLOAT, //type 
					false, //normalized, 
					this._vertexStride, info.offset);
					Gl.glEnableVertexAttribArray(location);
				}
			}
		}
		
		public function unbindAttrib(shader):void
		{
			for (var semantic in this._vertexFormat.attribs)
			{
				var location = shader.getAttributeLocation(semantic);
				if (location >= 0)
				{
					Gl.glDisableVertexAttribArray(location);
				}
			}
		}
	}

}