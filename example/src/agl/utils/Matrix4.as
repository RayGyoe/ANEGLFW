package agl.utils 
{
	import flash.geom.Matrix3D;
	
	/**
	 * ...
	 * @author Ray.lei
	 */
	public class Matrix4 extends Matrix3D 
	{
		
		public function Matrix4(v:Vector.<Number>=null) 
		{
			super(v);
			
		}
		
		
		public function setLookAt(eyeX:Number, eyeY:Number, eyeZ:Number, targetX:Number, targetY:Number, targetZ:Number, upX:Number, upY:Number, upZ:Number) : void{
           // N = eye - target
           var nx:Number, ny:Number, nz:Number;
           nx = eyeX - targetX;
           ny = eyeY - targetY;
           nz = eyeZ - targetZ;
           var rl:Number = 1/Math.sqrt(nx*nx+ny*ny+nz*nz);
           nx *= rl;
           ny *= rl;
           nz *= rl;
           // U = UP cross N
           var ux:Number, uy:Number, uz:Number;
           ux = upY * nz - upZ * ny;
           uy = upZ * nx - upX * nz;
           uz = upX * ny - upY * nx;
           rl = 1/Math.sqrt(ux*ux+uy*uy+uz*uz);
           ux *= rl;
           uy *= rl;
           uz *= rl;
           // V = N cross U
           var vx:Number, vy:Number, vz:Number;
           vx = ny * uz - nz * uy;
           vy = nz * ux - nx * uz;
           vz = nx * uy - ny * ux;
           rl = 1/Math.sqrt(vx*vx+vy*vy+vz*vz);
           vx *= rl;
           vy *= rl;
           vz *= rl;
       
           var e:Vector.<Number> = this.rawData;
           e[0] = ux;
           e[1] = vx;
           e[2] = nx;
           e[3] = 0;
       
           e[4] = uy;
           e[5] = vy;
           e[6] = ny;
           e[7] = 0;
       
           e[8] = uz;
           e[9] = vz;
           e[10] = nz;
           e[11] = 0;
       
           e[12] = 0;
           e[13] = 0;
           e[14] = 0;
           e[15] = 1;
		   
		   this.rawData = e;
       
           this.translate(-eyeX, -eyeY, -eyeZ);
       }
	   
	   
	   public function translate(x:Number, y:Number, z:Number):void {
           var e:Vector.<Number>  = this.rawData;
           e[12] += e[0] * x + e[4] * y + e[8]  * z;
           e[13] += e[1] * x + e[5] * y + e[9]  * z;
           e[14] += e[2] * x + e[6] * y + e[10] * z;
           e[15] += e[3] * x + e[7] * y + e[11] * z;
		   
		   this.rawData = e;
       };
	   
	   
	   
	   public function setPerspective(fovy:Number, aspect:Number, near:Number, far:Number):void
	   {
           if(near === far || aspect === 0 || near <= 0 || far <= 0){
               trace("wrong param");
               return;
           }

           var radius:Number = fovy * Math.PI / 180 / 2;
           var sin:Number = Math.sin(radius);
           if(sin === 0){
               trace("wrong param");
               return;
           }
           var cot:Number = Math.cos(radius) / sin;
           var rd:Number = 1 / (far - near);
          
		   /*
		   rawData : Vector.<Number> {
				0 : 1 
				1 : 0 
				2 : 0 
				3 : 0 
				4 : 0 
				5 : 1 
				6 : 0 
				7 : 0 
				8 : 0 
				9 : 0 
				10 : 1 
				11 : 0 
				12 : 0 
				13 : 0 
				14 : 0 
				15 : 1 
				fixed : false 
				length : 16 [0x10] 
			}
*/
		   
           var e:Vector.<Number>  =  this.rawData;
           e[0] = cot / aspect;
           e[1] = 0;
           e[2] = 0;
           e[3] = 0;

           e[4] = 0;
           e[5] = cot;
           e[6] = 0;
           e[7] = 0;

           e[8] = 0;
           e[9] = 0;
           e[10] = -(far + near) * rd;
           e[11] = -1;

           e[12] = 0;
           e[13] = 0;
           e[14] = -2 * near * far * rd;
           e[15] = 0;
		   
		   this.rawData = e;
       }
	   
	   public function multiply(other:Matrix4):void
		{
			//this.append(other);
			
           var  e:Vector.<Number> , a:Vector.<Number> , b:Vector.<Number> , ai0:Number, ai1:Number, ai2:Number, ai3:Number;
     
           // Calculate e = a * b
           e = this.rawData;
           a = this.rawData;
		   
           b = other.rawData;
           var i:int
           // If e equals b, copy b to temporary matrix.
           if (e === b) {
               for (i = 0; i < 16; ++i) {
                   other.rawData[i] = this.rawData[i];
               }
           }
           
           for (i = 0; i < 4; i++) {
               ai0=a[i];  ai1=a[i+4];  ai2=a[i+8];  ai3=a[i+12];
               e[i]    = ai0 * b[0]  + ai1 * b[1]  + ai2 * b[2]  + ai3 * b[3];
               e[i+4]  = ai0 * b[4]  + ai1 * b[5]  + ai2 * b[6]  + ai3 * b[7];
               e[i+8]  = ai0 * b[8]  + ai1 * b[9]  + ai2 * b[10] + ai3 * b[11];
               e[i+12] = ai0 * b[12] + ai1 * b[13] + ai2 * b[14] + ai3 * b[15];
           }
		   this.rawData = e;
           
		}
		
		
		
		
        public function setRotate(angle:Number, x:Number, y:Number, z:Number):void{
           var e:Vector.<Number> , s:Number, c:Number, len:Number, rlen:Number, nc:Number, xy:Number, yz:Number, zx:Number, xs:Number, ys:Number, zs:Number;

           angle = Math.PI * angle / 180;
           e = this.rawData;

           s = Math.sin(angle);
           c = Math.cos(angle);

           if (0 !== x && 0 === y && 0 === z) {
               // Rotation around X axis
               if (x < 0) {
               s = -s;
               }
               e[0] = 1;  e[4] = 0;  e[ 8] = 0;  e[12] = 0;
               e[1] = 0;  e[5] = c;  e[ 9] =-s;  e[13] = 0;
               e[2] = 0;  e[6] = s;  e[10] = c;  e[14] = 0;
               e[3] = 0;  e[7] = 0;  e[11] = 0;  e[15] = 1;
           } else if (0 === x && 0 !== y && 0 === z) {
               // Rotation around Y axis
               if (y < 0) {
               s = -s;
               }
               e[0] = c;  e[4] = 0;  e[ 8] = s;  e[12] = 0;
               e[1] = 0;  e[5] = 1;  e[ 9] = 0;  e[13] = 0;
               e[2] =-s;  e[6] = 0;  e[10] = c;  e[14] = 0;
               e[3] = 0;  e[7] = 0;  e[11] = 0;  e[15] = 1;
           } else if (0 === x && 0 === y && 0 !== z) {
               // Rotation around Z axis
               if (z < 0) {
               s = -s;
               }
               e[0] = c;  e[4] =-s;  e[ 8] = 0;  e[12] = 0;
               e[1] = s;  e[5] = c;  e[ 9] = 0;  e[13] = 0;
               e[2] = 0;  e[6] = 0;  e[10] = 1;  e[14] = 0;
               e[3] = 0;  e[7] = 0;  e[11] = 0;  e[15] = 1;
           } else {
               // Rotation around another axis
               len = Math.sqrt(x*x + y*y + z*z);
               if (len !== 1) {
				   rlen = 1 / len;
				   x *= rlen;
				   y *= rlen;
				   z *= rlen;
               }
               nc = 1 - c;
               xy = x * y;
               yz = y * z;
               zx = z * x;
               xs = x * s;
               ys = y * s;
               zs = z * s;

               e[ 0] = x*x*nc +  c;
               e[ 1] = xy *nc + zs;
               e[ 2] = zx *nc - ys;
               e[ 3] = 0;

               e[ 4] = xy *nc - zs;
               e[ 5] = y*y*nc +  c;
               e[ 6] = yz *nc + xs;
               e[ 7] = 0;

               e[ 8] = zx *nc + ys;
               e[ 9] = yz *nc - xs;
               e[10] = z*z*nc +  c;
               e[11] = 0;

               e[12] = 0;
               e[13] = 0;
               e[14] = 0;
               e[15] = 1;
           }
		   
		   this.rawData = e;
       }
	   
	   
       public function rotate(angle:Number, x:Number, y:Number, z:Number):void{
		   var m4:Matrix4 = new Matrix4()
		   m4.setRotate(angle, x, y, z);
           return this.multiply(m4);
       }
	   
	   public function cloneMatrix4():Matrix4
	   {
		   return  new Matrix4(this.rawData);
	   }
	}
}