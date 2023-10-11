package agl.core
{
	
	/**
	 * ...
	 * @author Ray.lei
	 */
	public class VertexFormat
	{
		
		private var attribs:Array = [];
		private var attribSizeMap:Object = {};
		private var _vertexSize:int = 0;
		
		public function VertexFormat()
		{
			
		}
		
		public function addAttrib(attribSemantic:String, size:int):void
		{
			this.attribs.push(attribSemantic);
			this.attribSizeMap[attribSemantic] = size;
		}
		
		public function getVertexSize():int
		{
			if (this._vertexSize === 0)
			{
				for (var i:int = 0; i < this.attribs.length; ++i)
				{
					var semantic:String = this.attribs[i];
					this._vertexSize += this.attribSizeMap[semantic];
				}
			}
			return this._vertexSize;
		}
	}

}