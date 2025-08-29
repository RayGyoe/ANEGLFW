package com.vsdevelop.air.extension.glfw
{
	import flash.geom.Matrix3D;
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Ray.eDoctor
	 */
	public final class Gl
	{
		
		public static const GL_DEPTH_BUFFER_BIT:int = 0x00000100;
		public static const GL_STENCIL_BUFFER_BIT:int = 0x00000400;
		public static const GL_COLOR_BUFFER_BIT:int = 0x00004000;
		public static const GL_FALSE:int = 0;
		public static const GL_TRUE:int = 1;
		public static const GL_POINTS:int = 0x0000;
		public static const GL_LINES:int = 0x0001;
		public static const GL_LINE_LOOP:int = 0x0002;
		public static const GL_LINE_STRIP:int = 0x0003;
		public static const GL_TRIANGLES:int = 0x0004;
		public static const GL_TRIANGLE_STRIP:int = 0x0005;
		public static const GL_TRIANGLE_FAN:int = 0x0006;
		public static const GL_NEVER:int = 0x0200;
		public static const GL_LESS:int = 0x0201;
		public static const GL_EQUAL:int = 0x0202;
		public static const GL_LEQUAL:int = 0x0203;
		public static const GL_GREATER:int = 0x0204;
		public static const GL_NOTEQUAL:int = 0x0205;
		public static const GL_GEQUAL:int = 0x0206;
		public static const GL_ALWAYS:int = 0x0207;
		public static const GL_ZERO:int = 0;
		public static const GL_ONE:int = 1;
		public static const GL_SRC_COLOR:int = 0x0300;
		public static const GL_ONE_MINUS_SRC_COLOR:int = 0x0301;
		public static const GL_SRC_ALPHA:int = 0x0302;
		public static const GL_ONE_MINUS_SRC_ALPHA:int = 0x0303;
		public static const GL_DST_ALPHA:int = 0x0304;
		public static const GL_ONE_MINUS_DST_ALPHA:int = 0x0305;
		public static const GL_DST_COLOR:int = 0x0306;
		public static const GL_ONE_MINUS_DST_COLOR:int = 0x0307;
		public static const GL_SRC_ALPHA_SATURATE:int = 0x0308;
		public static const GL_NONE:int = 0;
		public static const GL_FRONT_LEFT:int = 0x0400;
		public static const GL_FRONT_RIGHT:int = 0x0401;
		public static const GL_BACK_LEFT:int = 0x0402;
		public static const GL_BACK_RIGHT:int = 0x0403;
		public static const GL_FRONT:int = 0x0404;
		public static const GL_BACK:int = 0x0405;
		public static const GL_LEFT:int = 0x0406;
		public static const GL_RIGHT:int = 0x0407;
		public static const GL_FRONT_AND_BACK:int = 0x0408;
		public static const GL_NO_ERROR:int = 0;
		public static const GL_INVALID_ENUM:int = 0x0500;
		public static const GL_INVALID_VALUE:int = 0x0501;
		public static const GL_INVALID_OPERATION:int = 0x0502;
		public static const GL_OUT_OF_MEMORY:int = 0x0505;
		public static const GL_CW:int = 0x0900;
		public static const GL_CCW:int = 0x0901;
		public static const GL_POINT_SIZE:int = 0x0B11;
		public static const GL_POINT_SIZE_RANGE:int = 0x0B12;
		public static const GL_POINT_SIZE_GRANULARITY:int = 0x0B13;
		public static const GL_LINE_SMOOTH:int = 0x0B20;
		public static const GL_LINE_WIDTH:int = 0x0B21;
		public static const GL_LINE_WIDTH_RANGE:int = 0x0B22;
		public static const GL_LINE_WIDTH_GRANULARITY:int = 0x0B23;
		public static const GL_POLYGON_MODE:int = 0x0B40;
		public static const GL_POLYGON_SMOOTH:int = 0x0B41;
		public static const GL_CULL_FACE:int = 0x0B44;
		public static const GL_CULL_FACE_MODE:int = 0x0B45;
		public static const GL_FRONT_FACE:int = 0x0B46;
		public static const GL_DEPTH_RANGE:int = 0x0B70;
		public static const GL_DEPTH_TEST:int = 0x0B71;
		public static const GL_DEPTH_WRITEMASK:int = 0x0B72;
		public static const GL_DEPTH_CLEAR_VALUE:int = 0x0B73;
		public static const GL_DEPTH_FUNC:int = 0x0B74;
		public static const GL_STENCIL_TEST:int = 0x0B90;
		public static const GL_STENCIL_CLEAR_VALUE:int = 0x0B91;
		public static const GL_STENCIL_FUNC:int = 0x0B92;
		public static const GL_STENCIL_VALUE_MASK:int = 0x0B93;
		public static const GL_STENCIL_FAIL:int = 0x0B94;
		public static const GL_STENCIL_PASS_DEPTH_FAIL:int = 0x0B95;
		public static const GL_STENCIL_PASS_DEPTH_PASS:int = 0x0B96;
		public static const GL_STENCIL_REF:int = 0x0B97;
		public static const GL_STENCIL_WRITEMASK:int = 0x0B98;
		public static const GL_VIEWPORT:int = 0x0BA2;
		public static const GL_DITHER:int = 0x0BD0;
		public static const GL_BLEND_DST:int = 0x0BE0;
		public static const GL_BLEND_SRC:int = 0x0BE1;
		public static const GL_BLEND:int = 0x0BE2;
		public static const GL_LOGIC_OP_MODE:int = 0x0BF0;
		public static const GL_DRAW_BUFFER:int = 0x0C01;
		public static const GL_READ_BUFFER:int = 0x0C02;
		public static const GL_SCISSOR_BOX:int = 0x0C10;
		public static const GL_SCISSOR_TEST:int = 0x0C11;
		public static const GL_COLOR_CLEAR_VALUE:int = 0x0C22;
		public static const GL_COLOR_WRITEMASK:int = 0x0C23;
		public static const GL_DOUBLEBUFFER:int = 0x0C32;
		public static const GL_STEREO:int = 0x0C33;
		public static const GL_LINE_SMOOTH_HINT:int = 0x0C52;
		public static const GL_POLYGON_SMOOTH_HINT:int = 0x0C53;
		public static const GL_UNPACK_SWAP_BYTES:int = 0x0CF0;
		public static const GL_UNPACK_LSB_FIRST:int = 0x0CF1;
		public static const GL_UNPACK_ROW_LENGTH:int = 0x0CF2;
		public static const GL_UNPACK_SKIP_ROWS:int = 0x0CF3;
		public static const GL_UNPACK_SKIP_PIXELS:int = 0x0CF4;
		public static const GL_UNPACK_ALIGNMENT:int = 0x0CF5;
		public static const GL_PACK_SWAP_BYTES:int = 0x0D00;
		public static const GL_PACK_LSB_FIRST:int = 0x0D01;
		public static const GL_PACK_ROW_LENGTH:int = 0x0D02;
		public static const GL_PACK_SKIP_ROWS:int = 0x0D03;
		public static const GL_PACK_SKIP_PIXELS:int = 0x0D04;
		public static const GL_PACK_ALIGNMENT:int = 0x0D05;
		public static const GL_MAX_TEXTURE_SIZE:int = 0x0D33;
		public static const GL_MAX_VIEWPORT_DIMS:int = 0x0D3A;
		public static const GL_SUBPIXEL_BITS:int = 0x0D50;
		public static const GL_TEXTURE_1D:int = 0x0DE0;
		public static const GL_TEXTURE_2D:int = 0x0DE1;
		public static const GL_TEXTURE_WIDTH:int = 0x1000;
		public static const GL_TEXTURE_HEIGHT:int = 0x1001;
		public static const GL_TEXTURE_BORDER_COLOR:int = 0x1004;
		public static const GL_DONT_CARE:int = 0x1100;
		public static const GL_FASTEST:int = 0x1101;
		public static const GL_NICEST:int = 0x1102;
		public static const GL_BYTE:int = 0x1400;
		public static const GL_UNSIGNED_BYTE:int = 0x1401;
		public static const GL_SHORT:int = 0x1402;
		public static const GL_UNSIGNED_SHORT:int = 0x1403;
		public static const GL_INT:int = 0x1404;
		public static const GL_UNSIGNED_INT:int = 0x1405;
		public static const GL_FLOAT:int = 0x1406;
		public static const GL_CLEAR:int = 0x1500;
		public static const GL_AND:int = 0x1501;
		public static const GL_AND_REVERSE:int = 0x1502;
		public static const GL_COPY:int = 0x1503;
		public static const GL_AND_INVERTED:int = 0x1504;
		public static const GL_NOOP:int = 0x1505;
		public static const GL_XOR:int = 0x1506;
		public static const GL_OR:int = 0x1507;
		public static const GL_NOR:int = 0x1508;
		public static const GL_EQUIV:int = 0x1509;
		public static const GL_INVERT:int = 0x150A;
		public static const GL_OR_REVERSE:int = 0x150B;
		public static const GL_COPY_INVERTED:int = 0x150C;
		public static const GL_OR_INVERTED:int = 0x150D;
		public static const GL_NAND:int = 0x150E;
		public static const GL_SET:int = 0x150F;
		public static const GL_TEXTURE:int = 0x1702;
		public static const GL_COLOR:int = 0x1800;
		public static const GL_DEPTH:int = 0x1801;
		public static const GL_STENCIL:int = 0x1802;
		public static const GL_STENCIL_INDEX:int = 0x1901;
		public static const GL_DEPTH_COMPONENT:int = 0x1902;
		public static const GL_RED:int = 0x1903;
		public static const GL_GREEN:int = 0x1904;
		public static const GL_BLUE:int = 0x1905;
		public static const GL_ALPHA:int = 0x1906;
		public static const GL_RGB:int = 0x1907;
		public static const GL_RGBA:int = 0x1908;
		public static const GL_POINT:int = 0x1B00;
		public static const GL_LINE:int = 0x1B01;
		public static const GL_FILL:int = 0x1B02;
		public static const GL_KEEP:int = 0x1E00;
		public static const GL_REPLACE:int = 0x1E01;
		public static const GL_INCR:int = 0x1E02;
		public static const GL_DECR:int = 0x1E03;
		public static const GL_VENDOR:int = 0x1F00;
		public static const GL_RENDERER:int = 0x1F01;
		public static const GL_VERSION:int = 0x1F02;
		public static const GL_EXTENSIONS:int = 0x1F03;
		public static const GL_NEAREST:int = 0x2600;
		public static const GL_LINEAR:int = 0x2601;
		public static const GL_NEAREST_MIPMAP_NEAREST:int = 0x2700;
		public static const GL_LINEAR_MIPMAP_NEAREST:int = 0x2701;
		public static const GL_NEAREST_MIPMAP_LINEAR:int = 0x2702;
		public static const GL_LINEAR_MIPMAP_LINEAR:int = 0x2703;
		public static const GL_TEXTURE_MAG_FILTER:int = 0x2800;
		public static const GL_TEXTURE_MIN_FILTER:int = 0x2801;
		public static const GL_TEXTURE_WRAP_S:int = 0x2802;
		public static const GL_TEXTURE_WRAP_T:int = 0x2803;
		public static const GL_REPEAT:int = 0x2901;
		public static const GL_COLOR_LOGIC_OP:int = 0x0BF2;
		public static const GL_POLYGON_OFFSET_UNITS:int = 0x2A00;
		public static const GL_POLYGON_OFFSET_POINT:int = 0x2A01;
		public static const GL_POLYGON_OFFSET_LINE:int = 0x2A02;
		public static const GL_POLYGON_OFFSET_FILL:int = 0x8037;
		public static const GL_POLYGON_OFFSET_FACTOR:int = 0x8038;
		public static const GL_TEXTURE_BINDING_1D:int = 0x8068;
		public static const GL_TEXTURE_BINDING_2D:int = 0x8069;
		public static const GL_TEXTURE_INTERNAL_FORMAT:int = 0x1003;
		public static const GL_TEXTURE_RED_SIZE:int = 0x805C;
		public static const GL_TEXTURE_GREEN_SIZE:int = 0x805D;
		public static const GL_TEXTURE_BLUE_SIZE:int = 0x805E;
		public static const GL_TEXTURE_ALPHA_SIZE:int = 0x805F;
		public static const GL_DOUBLE:int = 0x140A;
		public static const GL_PROXY_TEXTURE_1D:int = 0x8063;
		public static const GL_PROXY_TEXTURE_2D:int = 0x8064;
		public static const GL_R3_G3_B2:int = 0x2A10;
		public static const GL_RGB4:int = 0x804F;
		public static const GL_RGB5:int = 0x8050;
		public static const GL_RGB8:int = 0x8051;
		public static const GL_RGB10:int = 0x8052;
		public static const GL_RGB12:int = 0x8053;
		public static const GL_RGB16:int = 0x8054;
		public static const GL_RGBA2:int = 0x8055;
		public static const GL_RGBA4:int = 0x8056;
		public static const GL_RGB5_A1:int = 0x8057;
		public static const GL_RGBA8:int = 0x8058;
		public static const GL_RGB10_A2:int = 0x8059;
		public static const GL_RGBA12:int = 0x805A;
		public static const GL_RGBA16:int = 0x805B;
		public static const GL_UNSIGNED_BYTE_3_3_2:int = 0x8032;
		public static const GL_UNSIGNED_SHORT_4_4_4_4:int = 0x8033;
		public static const GL_UNSIGNED_SHORT_5_5_5_1:int = 0x8034;
		public static const GL_UNSIGNED_INT_8_8_8_8:int = 0x8035;
		public static const GL_UNSIGNED_INT_10_10_10_2:int = 0x8036;
		public static const GL_TEXTURE_BINDING_3D:int = 0x806A;
		public static const GL_PACK_SKIP_IMAGES:int = 0x806B;
		public static const GL_PACK_IMAGE_HEIGHT:int = 0x806C;
		public static const GL_UNPACK_SKIP_IMAGES:int = 0x806D;
		public static const GL_UNPACK_IMAGE_HEIGHT:int = 0x806E;
		public static const GL_TEXTURE_3D:int = 0x806F;
		public static const GL_PROXY_TEXTURE_3D:int = 0x8070;
		public static const GL_TEXTURE_DEPTH:int = 0x8071;
		public static const GL_TEXTURE_WRAP_R:int = 0x8072;
		public static const GL_MAX_3D_TEXTURE_SIZE:int = 0x8073;
		public static const GL_UNSIGNED_BYTE_2_3_3_REV:int = 0x8362;
		public static const GL_UNSIGNED_SHORT_5_6_5:int = 0x8363;
		public static const GL_UNSIGNED_SHORT_5_6_5_REV:int = 0x8364;
		public static const GL_UNSIGNED_SHORT_4_4_4_4_REV:int = 0x8365;
		public static const GL_UNSIGNED_SHORT_1_5_5_5_REV:int = 0x8366;
		public static const GL_UNSIGNED_INT_8_8_8_8_REV:int = 0x8367;
		public static const GL_UNSIGNED_INT_2_10_10_10_REV:int = 0x8368;
		public static const GL_BGR:int = 0x80E0;
		public static const GL_BGRA:int = 0x80E1;
		public static const GL_MAX_ELEMENTS_VERTICES:int = 0x80E8;
		public static const GL_MAX_ELEMENTS_INDICES:int = 0x80E9;
		public static const GL_CLAMP_TO_EDGE:int = 0x812F;
		public static const GL_TEXTURE_MIN_LOD:int = 0x813A;
		public static const GL_TEXTURE_MAX_LOD:int = 0x813B;
		public static const GL_TEXTURE_BASE_LEVEL:int = 0x813C;
		public static const GL_TEXTURE_MAX_LEVEL:int = 0x813D;
		public static const GL_SMOOTH_POINT_SIZE_RANGE:int = 0x0B12;
		public static const GL_SMOOTH_POINT_SIZE_GRANULARITY:int = 0x0B13;
		public static const GL_SMOOTH_LINE_WIDTH_RANGE:int = 0x0B22;
		public static const GL_SMOOTH_LINE_WIDTH_GRANULARITY:int = 0x0B23;
		public static const GL_ALIASED_LINE_WIDTH_RANGE:int = 0x846E;
		public static const GL_TEXTURE0:int = 0x84C0;
		public static const GL_TEXTURE1:int = 0x84C1;
		public static const GL_TEXTURE2:int = 0x84C2;
		public static const GL_TEXTURE3:int = 0x84C3;
		public static const GL_TEXTURE4:int = 0x84C4;
		public static const GL_TEXTURE5:int = 0x84C5;
		public static const GL_TEXTURE6:int = 0x84C6;
		public static const GL_TEXTURE7:int = 0x84C7;
		public static const GL_TEXTURE8:int = 0x84C8;
		public static const GL_TEXTURE9:int = 0x84C9;
		public static const GL_TEXTURE10:int = 0x84CA;
		public static const GL_TEXTURE11:int = 0x84CB;
		public static const GL_TEXTURE12:int = 0x84CC;
		public static const GL_TEXTURE13:int = 0x84CD;
		public static const GL_TEXTURE14:int = 0x84CE;
		public static const GL_TEXTURE15:int = 0x84CF;
		public static const GL_TEXTURE16:int = 0x84D0;
		public static const GL_TEXTURE17:int = 0x84D1;
		public static const GL_TEXTURE18:int = 0x84D2;
		public static const GL_TEXTURE19:int = 0x84D3;
		public static const GL_TEXTURE20:int = 0x84D4;
		public static const GL_TEXTURE21:int = 0x84D5;
		public static const GL_TEXTURE22:int = 0x84D6;
		public static const GL_TEXTURE23:int = 0x84D7;
		public static const GL_TEXTURE24:int = 0x84D8;
		public static const GL_TEXTURE25:int = 0x84D9;
		public static const GL_TEXTURE26:int = 0x84DA;
		public static const GL_TEXTURE27:int = 0x84DB;
		public static const GL_TEXTURE28:int = 0x84DC;
		public static const GL_TEXTURE29:int = 0x84DD;
		public static const GL_TEXTURE30:int = 0x84DE;
		public static const GL_TEXTURE31:int = 0x84DF;
		public static const GL_ACTIVE_TEXTURE:int = 0x84E0;
		public static const GL_MULTISAMPLE:int = 0x809D;
		public static const GL_SAMPLE_ALPHA_TO_COVERAGE:int = 0x809E;
		public static const GL_SAMPLE_ALPHA_TO_ONE:int = 0x809F;
		public static const GL_SAMPLE_COVERAGE:int = 0x80A0;
		public static const GL_SAMPLE_BUFFERS:int = 0x80A8;
		public static const GL_SAMPLES:int = 0x80A9;
		public static const GL_SAMPLE_COVERAGE_VALUE:int = 0x80AA;
		public static const GL_SAMPLE_COVERAGE_INVERT:int = 0x80AB;
		public static const GL_TEXTURE_CUBE_MAP:int = 0x8513;
		public static const GL_TEXTURE_BINDING_CUBE_MAP:int = 0x8514;
		public static const GL_TEXTURE_CUBE_MAP_POSITIVE_X:int = 0x8515;
		public static const GL_TEXTURE_CUBE_MAP_NEGATIVE_X:int = 0x8516;
		public static const GL_TEXTURE_CUBE_MAP_POSITIVE_Y:int = 0x8517;
		public static const GL_TEXTURE_CUBE_MAP_NEGATIVE_Y:int = 0x8518;
		public static const GL_TEXTURE_CUBE_MAP_POSITIVE_Z:int = 0x8519;
		public static const GL_TEXTURE_CUBE_MAP_NEGATIVE_Z:int = 0x851A;
		public static const GL_PROXY_TEXTURE_CUBE_MAP:int = 0x851B;
		public static const GL_MAX_CUBE_MAP_TEXTURE_SIZE:int = 0x851C;
		public static const GL_COMPRESSED_RGB:int = 0x84ED;
		public static const GL_COMPRESSED_RGBA:int = 0x84EE;
		public static const GL_TEXTURE_COMPRESSION_HINT:int = 0x84EF;
		public static const GL_TEXTURE_COMPRESSED_IMAGE_SIZE:int = 0x86A0;
		public static const GL_TEXTURE_COMPRESSED:int = 0x86A1;
		public static const GL_NUM_COMPRESSED_TEXTURE_FORMATS:int = 0x86A2;
		public static const GL_COMPRESSED_TEXTURE_FORMATS:int = 0x86A3;
		public static const GL_CLAMP_TO_BORDER:int = 0x812D;
		public static const GL_BLEND_DST_RGB:int = 0x80C8;
		public static const GL_BLEND_SRC_RGB:int = 0x80C9;
		public static const GL_BLEND_DST_ALPHA:int = 0x80CA;
		public static const GL_BLEND_SRC_ALPHA:int = 0x80CB;
		public static const GL_POINT_FADE_THRESHOLD_SIZE:int = 0x8128;
		public static const GL_DEPTH_COMPONENT16:int = 0x81A5;
		public static const GL_DEPTH_COMPONENT24:int = 0x81A6;
		public static const GL_DEPTH_COMPONENT32:int = 0x81A7;
		public static const GL_MIRRORED_REPEAT:int = 0x8370;
		public static const GL_MAX_TEXTURE_LOD_BIAS:int = 0x84FD;
		public static const GL_TEXTURE_LOD_BIAS:int = 0x8501;
		public static const GL_INCR_WRAP:int = 0x8507;
		public static const GL_DECR_WRAP:int = 0x8508;
		public static const GL_TEXTURE_DEPTH_SIZE:int = 0x884A;
		public static const GL_TEXTURE_COMPARE_MODE:int = 0x884C;
		public static const GL_TEXTURE_COMPARE_FUNC:int = 0x884D;
		public static const GL_BLEND_COLOR:int = 0x8005;
		public static const GL_BLEND_EQUATION:int = 0x8009;
		public static const GL_CONSTANT_COLOR:int = 0x8001;
		public static const GL_ONE_MINUS_CONSTANT_COLOR:int = 0x8002;
		public static const GL_CONSTANT_ALPHA:int = 0x8003;
		public static const GL_ONE_MINUS_CONSTANT_ALPHA:int = 0x8004;
		public static const GL_FUNC_ADD:int = 0x8006;
		public static const GL_FUNC_REVERSE_SUBTRACT:int = 0x800B;
		public static const GL_FUNC_SUBTRACT:int = 0x800A;
		public static const GL_MIN:int = 0x8007;
		public static const GL_MAX:int = 0x8008;
		public static const GL_BUFFER_SIZE:int = 0x8764;
		public static const GL_BUFFER_USAGE:int = 0x8765;
		public static const GL_QUERY_COUNTER_BITS:int = 0x8864;
		public static const GL_CURRENT_QUERY:int = 0x8865;
		public static const GL_QUERY_RESULT:int = 0x8866;
		public static const GL_QUERY_RESULT_AVAILABLE:int = 0x8867;
		public static const GL_ARRAY_BUFFER:int = 0x8892;
		public static const GL_ELEMENT_ARRAY_BUFFER:int = 0x8893;
		public static const GL_ARRAY_BUFFER_BINDING:int = 0x8894;
		public static const GL_ELEMENT_ARRAY_BUFFER_BINDING:int = 0x8895;
		public static const GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING:int = 0x889F;
		public static const GL_READ_ONLY:int = 0x88B8;
		public static const GL_WRITE_ONLY:int = 0x88B9;
		public static const GL_READ_WRITE:int = 0x88BA;
		public static const GL_BUFFER_ACCESS:int = 0x88BB;
		public static const GL_BUFFER_MAPPED:int = 0x88BC;
		public static const GL_BUFFER_MAP_POINTER:int = 0x88BD;
		public static const GL_STREAM_DRAW:int = 0x88E0;
		public static const GL_STREAM_READ:int = 0x88E1;
		public static const GL_STREAM_COPY:int = 0x88E2;
		public static const GL_STATIC_DRAW:int = 0x88E4;
		public static const GL_STATIC_READ:int = 0x88E5;
		public static const GL_STATIC_COPY:int = 0x88E6;
		public static const GL_DYNAMIC_DRAW:int = 0x88E8;
		public static const GL_DYNAMIC_READ:int = 0x88E9;
		public static const GL_DYNAMIC_COPY:int = 0x88EA;
		public static const GL_SAMPLES_PASSED:int = 0x8914;
		public static const GL_SRC1_ALPHA:int = 0x8589;
		public static const GL_BLEND_EQUATION_RGB:int = 0x8009;
		public static const GL_VERTEX_ATTRIB_ARRAY_ENABLED:int = 0x8622;
		public static const GL_VERTEX_ATTRIB_ARRAY_SIZE:int = 0x8623;
		public static const GL_VERTEX_ATTRIB_ARRAY_STRIDE:int = 0x8624;
		public static const GL_VERTEX_ATTRIB_ARRAY_TYPE:int = 0x8625;
		public static const GL_CURRENT_VERTEX_ATTRIB:int = 0x8626;
		public static const GL_VERTEX_PROGRAM_POINT_SIZE:int = 0x8642;
		public static const GL_VERTEX_ATTRIB_ARRAY_POINTER:int = 0x8645;
		public static const GL_STENCIL_BACK_FUNC:int = 0x8800;
		public static const GL_STENCIL_BACK_FAIL:int = 0x8801;
		public static const GL_STENCIL_BACK_PASS_DEPTH_FAIL:int = 0x8802;
		public static const GL_STENCIL_BACK_PASS_DEPTH_PASS:int = 0x8803;
		public static const GL_MAX_DRAW_BUFFERS:int = 0x8824;
		public static const GL_DRAW_BUFFER0:int = 0x8825;
		public static const GL_DRAW_BUFFER1:int = 0x8826;
		public static const GL_DRAW_BUFFER2:int = 0x8827;
		public static const GL_DRAW_BUFFER3:int = 0x8828;
		public static const GL_DRAW_BUFFER4:int = 0x8829;
		public static const GL_DRAW_BUFFER5:int = 0x882A;
		public static const GL_DRAW_BUFFER6:int = 0x882B;
		public static const GL_DRAW_BUFFER7:int = 0x882C;
		public static const GL_DRAW_BUFFER8:int = 0x882D;
		public static const GL_DRAW_BUFFER9:int = 0x882E;
		public static const GL_DRAW_BUFFER10:int = 0x882F;
		public static const GL_DRAW_BUFFER11:int = 0x8830;
		public static const GL_DRAW_BUFFER12:int = 0x8831;
		public static const GL_DRAW_BUFFER13:int = 0x8832;
		public static const GL_DRAW_BUFFER14:int = 0x8833;
		public static const GL_DRAW_BUFFER15:int = 0x8834;
		public static const GL_BLEND_EQUATION_ALPHA:int = 0x883D;
		public static const GL_MAX_VERTEX_ATTRIBS:int = 0x8869;
		public static const GL_VERTEX_ATTRIB_ARRAY_NORMALIZED:int = 0x886A;
		public static const GL_MAX_TEXTURE_IMAGE_UNITS:int = 0x8872;
		public static const GL_FRAGMENT_SHADER:int = 0x8B30;
		public static const GL_VERTEX_SHADER:int = 0x8B31;
		public static const GL_MAX_FRAGMENT_UNIFORM_COMPONENTS:int = 0x8B49;
		public static const GL_MAX_VERTEX_UNIFORM_COMPONENTS:int = 0x8B4A;
		public static const GL_MAX_VARYING_FLOATS:int = 0x8B4B;
		public static const GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS:int = 0x8B4C;
		public static const GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS:int = 0x8B4D;
		public static const GL_SHADER_TYPE:int = 0x8B4F;
		public static const GL_FLOAT_VEC2:int = 0x8B50;
		public static const GL_FLOAT_VEC3:int = 0x8B51;
		public static const GL_FLOAT_VEC4:int = 0x8B52;
		public static const GL_INT_VEC2:int = 0x8B53;
		public static const GL_INT_VEC3:int = 0x8B54;
		public static const GL_INT_VEC4:int = 0x8B55;
		public static const GL_BOOL:int = 0x8B56;
		public static const GL_BOOL_VEC2:int = 0x8B57;
		public static const GL_BOOL_VEC3:int = 0x8B58;
		public static const GL_BOOL_VEC4:int = 0x8B59;
		public static const GL_FLOAT_MAT2:int = 0x8B5A;
		public static const GL_FLOAT_MAT3:int = 0x8B5B;
		public static const GL_FLOAT_MAT4:int = 0x8B5C;
		public static const GL_SAMPLER_1D:int = 0x8B5D;
		public static const GL_SAMPLER_2D:int = 0x8B5E;
		public static const GL_SAMPLER_3D:int = 0x8B5F;
		public static const GL_SAMPLER_CUBE:int = 0x8B60;
		public static const GL_SAMPLER_1D_SHADOW:int = 0x8B61;
		public static const GL_SAMPLER_2D_SHADOW:int = 0x8B62;
		public static const GL_DELETE_STATUS:int = 0x8B80;
		public static const GL_COMPILE_STATUS:int = 0x8B81;
		public static const GL_LINK_STATUS:int = 0x8B82;
		public static const GL_VALIDATE_STATUS:int = 0x8B83;
		public static const GL_INFO_LOG_LENGTH:int = 0x8B84;
		public static const GL_ATTACHED_SHADERS:int = 0x8B85;
		public static const GL_ACTIVE_UNIFORMS:int = 0x8B86;
		public static const GL_ACTIVE_UNIFORM_MAX_LENGTH:int = 0x8B87;
		public static const GL_SHADER_SOURCE_LENGTH:int = 0x8B88;
		public static const GL_ACTIVE_ATTRIBUTES:int = 0x8B89;
		public static const GL_ACTIVE_ATTRIBUTE_MAX_LENGTH:int = 0x8B8A;
		public static const GL_FRAGMENT_SHADER_DERIVATIVE_HINT:int = 0x8B8B;
		public static const GL_SHADING_LANGUAGE_VERSION:int = 0x8B8C;
		public static const GL_CURRENT_PROGRAM:int = 0x8B8D;
		public static const GL_POINT_SPRITE_COORD_ORIGIN:int = 0x8CA0;
		public static const GL_LOWER_LEFT:int = 0x8CA1;
		public static const GL_UPPER_LEFT:int = 0x8CA2;
		public static const GL_STENCIL_BACK_REF:int = 0x8CA3;
		public static const GL_STENCIL_BACK_VALUE_MASK:int = 0x8CA4;
		public static const GL_STENCIL_BACK_WRITEMASK:int = 0x8CA5;
		public static const GL_PIXEL_PACK_BUFFER:int = 0x88EB;
		public static const GL_PIXEL_UNPACK_BUFFER:int = 0x88EC;
		public static const GL_PIXEL_PACK_BUFFER_BINDING:int = 0x88ED;
		public static const GL_PIXEL_UNPACK_BUFFER_BINDING:int = 0x88EF;
		public static const GL_FLOAT_MAT2x3:int = 0x8B65;
		public static const GL_FLOAT_MAT2x4:int = 0x8B66;
		public static const GL_FLOAT_MAT3x2:int = 0x8B67;
		public static const GL_FLOAT_MAT3x4:int = 0x8B68;
		public static const GL_FLOAT_MAT4x2:int = 0x8B69;
		public static const GL_FLOAT_MAT4x3:int = 0x8B6A;
		public static const GL_SRGB:int = 0x8C40;
		public static const GL_SRGB8:int = 0x8C41;
		public static const GL_SRGB_ALPHA:int = 0x8C42;
		public static const GL_SRGB8_ALPHA8:int = 0x8C43;
		public static const GL_COMPRESSED_SRGB:int = 0x8C48;
		public static const GL_COMPRESSED_SRGB_ALPHA:int = 0x8C49;
		public static const GL_COMPARE_REF_TO_TEXTURE:int = 0x884E;
		public static const GL_CLIP_DISTANCE0:int = 0x3000;
		public static const GL_CLIP_DISTANCE1:int = 0x3001;
		public static const GL_CLIP_DISTANCE2:int = 0x3002;
		public static const GL_CLIP_DISTANCE3:int = 0x3003;
		public static const GL_CLIP_DISTANCE4:int = 0x3004;
		public static const GL_CLIP_DISTANCE5:int = 0x3005;
		public static const GL_CLIP_DISTANCE6:int = 0x3006;
		public static const GL_CLIP_DISTANCE7:int = 0x3007;
		public static const GL_MAX_CLIP_DISTANCES:int = 0x0D32;
		public static const GL_MAJOR_VERSION:int = 0x821B;
		public static const GL_MINOR_VERSION:int = 0x821C;
		public static const GL_NUM_EXTENSIONS:int = 0x821D;
		public static const GL_CONTEXT_FLAGS:int = 0x821E;
		public static const GL_COMPRESSED_RED:int = 0x8225;
		public static const GL_COMPRESSED_RG:int = 0x8226;
		public static const GL_CONTEXT_FLAG_FORWARD_COMPATIBLE_BIT:int = 0x00000001;
		public static const GL_RGBA32F:int = 0x8814;
		public static const GL_RGB32F:int = 0x8815;
		public static const GL_RGBA16F:int = 0x881A;
		public static const GL_RGB16F:int = 0x881B;
		public static const GL_VERTEX_ATTRIB_ARRAY_INTEGER:int = 0x88FD;
		public static const GL_MAX_ARRAY_TEXTURE_LAYERS:int = 0x88FF;
		public static const GL_MIN_PROGRAM_TEXEL_OFFSET:int = 0x8904;
		public static const GL_MAX_PROGRAM_TEXEL_OFFSET:int = 0x8905;
		public static const GL_CLAMP_READ_COLOR:int = 0x891C;
		public static const GL_FIXED_ONLY:int = 0x891D;
		public static const GL_MAX_VARYING_COMPONENTS:int = 0x8B4B;
		public static const GL_TEXTURE_1D_ARRAY:int = 0x8C18;
		public static const GL_PROXY_TEXTURE_1D_ARRAY:int = 0x8C19;
		public static const GL_TEXTURE_2D_ARRAY:int = 0x8C1A;
		public static const GL_PROXY_TEXTURE_2D_ARRAY:int = 0x8C1B;
		public static const GL_TEXTURE_BINDING_1D_ARRAY:int = 0x8C1C;
		public static const GL_TEXTURE_BINDING_2D_ARRAY:int = 0x8C1D;
		public static const GL_R11F_G11F_B10F:int = 0x8C3A;
		public static const GL_UNSIGNED_INT_10F_11F_11F_REV:int = 0x8C3B;
		public static const GL_RGB9_E5:int = 0x8C3D;
		public static const GL_UNSIGNED_INT_5_9_9_9_REV:int = 0x8C3E;
		public static const GL_TEXTURE_SHARED_SIZE:int = 0x8C3F;
		public static const GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH:int = 0x8C76;
		public static const GL_TRANSFORM_FEEDBACK_BUFFER_MODE:int = 0x8C7F;
		public static const GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS:int = 0x8C80;
		public static const GL_TRANSFORM_FEEDBACK_VARYINGS:int = 0x8C83;
		public static const GL_TRANSFORM_FEEDBACK_BUFFER_START:int = 0x8C84;
		public static const GL_TRANSFORM_FEEDBACK_BUFFER_SIZE:int = 0x8C85;
		public static const GL_PRIMITIVES_GENERATED:int = 0x8C87;
		public static const GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN:int = 0x8C88;
		public static const GL_RASTERIZER_DISCARD:int = 0x8C89;
		public static const GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS:int = 0x8C8A;
		public static const GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS:int = 0x8C8B;
		public static const GL_INTERLEAVED_ATTRIBS:int = 0x8C8C;
		public static const GL_SEPARATE_ATTRIBS:int = 0x8C8D;
		public static const GL_TRANSFORM_FEEDBACK_BUFFER:int = 0x8C8E;
		public static const GL_TRANSFORM_FEEDBACK_BUFFER_BINDING:int = 0x8C8F;
		public static const GL_RGBA32UI:int = 0x8D70;
		public static const GL_RGB32UI:int = 0x8D71;
		public static const GL_RGBA16UI:int = 0x8D76;
		public static const GL_RGB16UI:int = 0x8D77;
		public static const GL_RGBA8UI:int = 0x8D7C;
		public static const GL_RGB8UI:int = 0x8D7D;
		public static const GL_RGBA32I:int = 0x8D82;
		public static const GL_RGB32I:int = 0x8D83;
		public static const GL_RGBA16I:int = 0x8D88;
		public static const GL_RGB16I:int = 0x8D89;
		public static const GL_RGBA8I:int = 0x8D8E;
		public static const GL_RGB8I:int = 0x8D8F;
		public static const GL_RED_INTEGER:int = 0x8D94;
		public static const GL_GREEN_INTEGER:int = 0x8D95;
		public static const GL_BLUE_INTEGER:int = 0x8D96;
		public static const GL_RGB_INTEGER:int = 0x8D98;
		public static const GL_RGBA_INTEGER:int = 0x8D99;
		public static const GL_BGR_INTEGER:int = 0x8D9A;
		public static const GL_BGRA_INTEGER:int = 0x8D9B;
		public static const GL_SAMPLER_1D_ARRAY:int = 0x8DC0;
		public static const GL_SAMPLER_2D_ARRAY:int = 0x8DC1;
		public static const GL_SAMPLER_1D_ARRAY_SHADOW:int = 0x8DC3;
		public static const GL_SAMPLER_2D_ARRAY_SHADOW:int = 0x8DC4;
		public static const GL_SAMPLER_CUBE_SHADOW:int = 0x8DC5;
		public static const GL_UNSIGNED_INT_VEC2:int = 0x8DC6;
		public static const GL_UNSIGNED_INT_VEC3:int = 0x8DC7;
		public static const GL_UNSIGNED_INT_VEC4:int = 0x8DC8;
		public static const GL_INT_SAMPLER_1D:int = 0x8DC9;
		public static const GL_INT_SAMPLER_2D:int = 0x8DCA;
		public static const GL_INT_SAMPLER_3D:int = 0x8DCB;
		public static const GL_INT_SAMPLER_CUBE:int = 0x8DCC;
		public static const GL_INT_SAMPLER_1D_ARRAY:int = 0x8DCE;
		public static const GL_INT_SAMPLER_2D_ARRAY:int = 0x8DCF;
		public static const GL_UNSIGNED_INT_SAMPLER_1D:int = 0x8DD1;
		public static const GL_UNSIGNED_INT_SAMPLER_2D:int = 0x8DD2;
		public static const GL_UNSIGNED_INT_SAMPLER_3D:int = 0x8DD3;
		public static const GL_UNSIGNED_INT_SAMPLER_CUBE:int = 0x8DD4;
		public static const GL_UNSIGNED_INT_SAMPLER_1D_ARRAY:int = 0x8DD6;
		public static const GL_UNSIGNED_INT_SAMPLER_2D_ARRAY:int = 0x8DD7;
		public static const GL_QUERY_WAIT:int = 0x8E13;
		public static const GL_QUERY_NO_WAIT:int = 0x8E14;
		public static const GL_QUERY_BY_REGION_WAIT:int = 0x8E15;
		public static const GL_QUERY_BY_REGION_NO_WAIT:int = 0x8E16;
		public static const GL_BUFFER_ACCESS_FLAGS:int = 0x911F;
		public static const GL_BUFFER_MAP_LENGTH:int = 0x9120;
		public static const GL_BUFFER_MAP_OFFSET:int = 0x9121;
		public static const GL_DEPTH_COMPONENT32F:int = 0x8CAC;
		public static const GL_DEPTH32F_STENCIL8:int = 0x8CAD;
		public static const GL_FLOAT_32_UNSIGNED_INT_24_8_REV:int = 0x8DAD;
		public static const GL_INVALID_FRAMEBUFFER_OPERATION:int = 0x0506;
		public static const GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING:int = 0x8210;
		public static const GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE:int = 0x8211;
		public static const GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE:int = 0x8212;
		public static const GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE:int = 0x8213;
		public static const GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE:int = 0x8214;
		public static const GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE:int = 0x8215;
		public static const GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE:int = 0x8216;
		public static const GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE:int = 0x8217;
		public static const GL_FRAMEBUFFER_DEFAULT:int = 0x8218;
		public static const GL_FRAMEBUFFER_UNDEFINED:int = 0x8219;
		public static const GL_DEPTH_STENCIL_ATTACHMENT:int = 0x821A;
		public static const GL_MAX_RENDERBUFFER_SIZE:int = 0x84E8;
		public static const GL_DEPTH_STENCIL:int = 0x84F9;
		public static const GL_UNSIGNED_INT_24_8:int = 0x84FA;
		public static const GL_DEPTH24_STENCIL8:int = 0x88F0;
		public static const GL_TEXTURE_STENCIL_SIZE:int = 0x88F1;
		public static const GL_TEXTURE_RED_TYPE:int = 0x8C10;
		public static const GL_TEXTURE_GREEN_TYPE:int = 0x8C11;
		public static const GL_TEXTURE_BLUE_TYPE:int = 0x8C12;
		public static const GL_TEXTURE_ALPHA_TYPE:int = 0x8C13;
		public static const GL_TEXTURE_DEPTH_TYPE:int = 0x8C16;
		public static const GL_UNSIGNED_NORMALIZED:int = 0x8C17;
		public static const GL_FRAMEBUFFER_BINDING:int = 0x8CA6;
		public static const GL_DRAW_FRAMEBUFFER_BINDING:int = 0x8CA6;
		public static const GL_RENDERBUFFER_BINDING:int = 0x8CA7;
		public static const GL_READ_FRAMEBUFFER:int = 0x8CA8;
		public static const GL_DRAW_FRAMEBUFFER:int = 0x8CA9;
		public static const GL_READ_FRAMEBUFFER_BINDING:int = 0x8CAA;
		public static const GL_RENDERBUFFER_SAMPLES:int = 0x8CAB;
		public static const GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE:int = 0x8CD0;
		public static const GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME:int = 0x8CD1;
		public static const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL:int = 0x8CD2;
		public static const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE:int = 0x8CD3;
		public static const GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER:int = 0x8CD4;
		public static const GL_FRAMEBUFFER_COMPLETE:int = 0x8CD5;
		public static const GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT:int = 0x8CD6;
		public static const GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT:int = 0x8CD7;
		public static const GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER:int = 0x8CDB;
		public static const GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER:int = 0x8CDC;
		public static const GL_FRAMEBUFFER_UNSUPPORTED:int = 0x8CDD;
		public static const GL_MAX_COLOR_ATTACHMENTS:int = 0x8CDF;
		public static const GL_COLOR_ATTACHMENT0:int = 0x8CE0;
		public static const GL_COLOR_ATTACHMENT1:int = 0x8CE1;
		public static const GL_COLOR_ATTACHMENT2:int = 0x8CE2;
		public static const GL_COLOR_ATTACHMENT3:int = 0x8CE3;
		public static const GL_COLOR_ATTACHMENT4:int = 0x8CE4;
		public static const GL_COLOR_ATTACHMENT5:int = 0x8CE5;
		public static const GL_COLOR_ATTACHMENT6:int = 0x8CE6;
		public static const GL_COLOR_ATTACHMENT7:int = 0x8CE7;
		public static const GL_COLOR_ATTACHMENT8:int = 0x8CE8;
		public static const GL_COLOR_ATTACHMENT9:int = 0x8CE9;
		public static const GL_COLOR_ATTACHMENT10:int = 0x8CEA;
		public static const GL_COLOR_ATTACHMENT11:int = 0x8CEB;
		public static const GL_COLOR_ATTACHMENT12:int = 0x8CEC;
		public static const GL_COLOR_ATTACHMENT13:int = 0x8CED;
		public static const GL_COLOR_ATTACHMENT14:int = 0x8CEE;
		public static const GL_COLOR_ATTACHMENT15:int = 0x8CEF;
		public static const GL_COLOR_ATTACHMENT16:int = 0x8CF0;
		public static const GL_COLOR_ATTACHMENT17:int = 0x8CF1;
		public static const GL_COLOR_ATTACHMENT18:int = 0x8CF2;
		public static const GL_COLOR_ATTACHMENT19:int = 0x8CF3;
		public static const GL_COLOR_ATTACHMENT20:int = 0x8CF4;
		public static const GL_COLOR_ATTACHMENT21:int = 0x8CF5;
		public static const GL_COLOR_ATTACHMENT22:int = 0x8CF6;
		public static const GL_COLOR_ATTACHMENT23:int = 0x8CF7;
		public static const GL_COLOR_ATTACHMENT24:int = 0x8CF8;
		public static const GL_COLOR_ATTACHMENT25:int = 0x8CF9;
		public static const GL_COLOR_ATTACHMENT26:int = 0x8CFA;
		public static const GL_COLOR_ATTACHMENT27:int = 0x8CFB;
		public static const GL_COLOR_ATTACHMENT28:int = 0x8CFC;
		public static const GL_COLOR_ATTACHMENT29:int = 0x8CFD;
		public static const GL_COLOR_ATTACHMENT30:int = 0x8CFE;
		public static const GL_COLOR_ATTACHMENT31:int = 0x8CFF;
		public static const GL_DEPTH_ATTACHMENT:int = 0x8D00;
		public static const GL_STENCIL_ATTACHMENT:int = 0x8D20;
		public static const GL_FRAMEBUFFER:int = 0x8D40;
		public static const GL_RENDERBUFFER:int = 0x8D41;
		public static const GL_RENDERBUFFER_WIDTH:int = 0x8D42;
		public static const GL_RENDERBUFFER_HEIGHT:int = 0x8D43;
		public static const GL_RENDERBUFFER_INTERNAL_FORMAT:int = 0x8D44;
		public static const GL_STENCIL_INDEX1:int = 0x8D46;
		public static const GL_STENCIL_INDEX4:int = 0x8D47;
		public static const GL_STENCIL_INDEX8:int = 0x8D48;
		public static const GL_STENCIL_INDEX16:int = 0x8D49;
		public static const GL_RENDERBUFFER_RED_SIZE:int = 0x8D50;
		public static const GL_RENDERBUFFER_GREEN_SIZE:int = 0x8D51;
		public static const GL_RENDERBUFFER_BLUE_SIZE:int = 0x8D52;
		public static const GL_RENDERBUFFER_ALPHA_SIZE:int = 0x8D53;
		public static const GL_RENDERBUFFER_DEPTH_SIZE:int = 0x8D54;
		public static const GL_RENDERBUFFER_STENCIL_SIZE:int = 0x8D55;
		public static const GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE:int = 0x8D56;
		public static const GL_MAX_SAMPLES:int = 0x8D57;
		public static const GL_FRAMEBUFFER_SRGB:int = 0x8DB9;
		public static const GL_HALF_FLOAT:int = 0x140B;
		public static const GL_MAP_READ_BIT:int = 0x0001;
		public static const GL_MAP_WRITE_BIT:int = 0x0002;
		public static const GL_MAP_INVALIDATE_RANGE_BIT:int = 0x0004;
		public static const GL_MAP_INVALIDATE_BUFFER_BIT:int = 0x0008;
		public static const GL_MAP_FLUSH_EXPLICIT_BIT:int = 0x0010;
		public static const GL_MAP_UNSYNCHRONIZED_BIT:int = 0x0020;
		public static const GL_COMPRESSED_RED_RGTC1:int = 0x8DBB;
		public static const GL_COMPRESSED_SIGNED_RED_RGTC1:int = 0x8DBC;
		public static const GL_COMPRESSED_RG_RGTC2:int = 0x8DBD;
		public static const GL_COMPRESSED_SIGNED_RG_RGTC2:int = 0x8DBE;
		public static const GL_RG:int = 0x8227;
		public static const GL_RG_INTEGER:int = 0x8228;
		public static const GL_R8:int = 0x8229;
		public static const GL_R16:int = 0x822A;
		public static const GL_RG8:int = 0x822B;
		public static const GL_RG16:int = 0x822C;
		public static const GL_R16F:int = 0x822D;
		public static const GL_R32F:int = 0x822E;
		public static const GL_RG16F:int = 0x822F;
		public static const GL_RG32F:int = 0x8230;
		public static const GL_R8I:int = 0x8231;
		public static const GL_R8UI:int = 0x8232;
		public static const GL_R16I:int = 0x8233;
		public static const GL_R16UI:int = 0x8234;
		public static const GL_R32I:int = 0x8235;
		public static const GL_R32UI:int = 0x8236;
		public static const GL_RG8I:int = 0x8237;
		public static const GL_RG8UI:int = 0x8238;
		public static const GL_RG16I:int = 0x8239;
		public static const GL_RG16UI:int = 0x823A;
		public static const GL_RG32I:int = 0x823B;
		public static const GL_RG32UI:int = 0x823C;
		public static const GL_VERTEX_ARRAY_BINDING:int = 0x85B5;
		public static const GL_SAMPLER_2D_RECT:int = 0x8B63;
		public static const GL_SAMPLER_2D_RECT_SHADOW:int = 0x8B64;
		public static const GL_SAMPLER_BUFFER:int = 0x8DC2;
		public static const GL_INT_SAMPLER_2D_RECT:int = 0x8DCD;
		public static const GL_INT_SAMPLER_BUFFER:int = 0x8DD0;
		public static const GL_UNSIGNED_INT_SAMPLER_2D_RECT:int = 0x8DD5;
		public static const GL_UNSIGNED_INT_SAMPLER_BUFFER:int = 0x8DD8;
		public static const GL_TEXTURE_BUFFER:int = 0x8C2A;
		public static const GL_MAX_TEXTURE_BUFFER_SIZE:int = 0x8C2B;
		public static const GL_TEXTURE_BINDING_BUFFER:int = 0x8C2C;
		public static const GL_TEXTURE_BUFFER_DATA_STORE_BINDING:int = 0x8C2D;
		public static const GL_TEXTURE_RECTANGLE:int = 0x84F5;
		public static const GL_TEXTURE_BINDING_RECTANGLE:int = 0x84F6;
		public static const GL_PROXY_TEXTURE_RECTANGLE:int = 0x84F7;
		public static const GL_MAX_RECTANGLE_TEXTURE_SIZE:int = 0x84F8;
		public static const GL_R8_SNORM:int = 0x8F94;
		public static const GL_RG8_SNORM:int = 0x8F95;
		public static const GL_RGB8_SNORM:int = 0x8F96;
		public static const GL_RGBA8_SNORM:int = 0x8F97;
		public static const GL_R16_SNORM:int = 0x8F98;
		public static const GL_RG16_SNORM:int = 0x8F99;
		public static const GL_RGB16_SNORM:int = 0x8F9A;
		public static const GL_RGBA16_SNORM:int = 0x8F9B;
		public static const GL_SIGNED_NORMALIZED:int = 0x8F9C;
		public static const GL_PRIMITIVE_RESTART:int = 0x8F9D;
		public static const GL_PRIMITIVE_RESTART_INDEX:int = 0x8F9E;
		public static const GL_COPY_READ_BUFFER:int = 0x8F36;
		public static const GL_COPY_WRITE_BUFFER:int = 0x8F37;
		public static const GL_UNIFORM_BUFFER:int = 0x8A11;
		public static const GL_UNIFORM_BUFFER_BINDING:int = 0x8A28;
		public static const GL_UNIFORM_BUFFER_START:int = 0x8A29;
		public static const GL_UNIFORM_BUFFER_SIZE:int = 0x8A2A;
		public static const GL_MAX_VERTEX_UNIFORM_BLOCKS:int = 0x8A2B;
		public static const GL_MAX_GEOMETRY_UNIFORM_BLOCKS:int = 0x8A2C;
		public static const GL_MAX_FRAGMENT_UNIFORM_BLOCKS:int = 0x8A2D;
		public static const GL_MAX_COMBINED_UNIFORM_BLOCKS:int = 0x8A2E;
		public static const GL_MAX_UNIFORM_BUFFER_BINDINGS:int = 0x8A2F;
		public static const GL_MAX_UNIFORM_BLOCK_SIZE:int = 0x8A30;
		public static const GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS:int = 0x8A31;
		public static const GL_MAX_COMBINED_GEOMETRY_UNIFORM_COMPONENTS:int = 0x8A32;
		public static const GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS:int = 0x8A33;
		public static const GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT:int = 0x8A34;
		public static const GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH:int = 0x8A35;
		public static const GL_ACTIVE_UNIFORM_BLOCKS:int = 0x8A36;
		public static const GL_UNIFORM_TYPE:int = 0x8A37;
		public static const GL_UNIFORM_SIZE:int = 0x8A38;
		public static const GL_UNIFORM_NAME_LENGTH:int = 0x8A39;
		public static const GL_UNIFORM_BLOCK_INDEX:int = 0x8A3A;
		public static const GL_UNIFORM_OFFSET:int = 0x8A3B;
		public static const GL_UNIFORM_ARRAY_STRIDE:int = 0x8A3C;
		public static const GL_UNIFORM_MATRIX_STRIDE:int = 0x8A3D;
		public static const GL_UNIFORM_IS_ROW_MAJOR:int = 0x8A3E;
		public static const GL_UNIFORM_BLOCK_BINDING:int = 0x8A3F;
		public static const GL_UNIFORM_BLOCK_DATA_SIZE:int = 0x8A40;
		public static const GL_UNIFORM_BLOCK_NAME_LENGTH:int = 0x8A41;
		public static const GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS:int = 0x8A42;
		public static const GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES:int = 0x8A43;
		public static const GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER:int = 0x8A44;
		public static const GL_UNIFORM_BLOCK_REFERENCED_BY_GEOMETRY_SHADER:int = 0x8A45;
		public static const GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER:int = 0x8A46;
		public static const GL_INVALID_INDEX:uint = 0xFFFFFFFF;
		public static const GL_CONTEXT_CORE_PROFILE_BIT:int = 0x00000001;
		public static const GL_CONTEXT_COMPATIBILITY_PROFILE_BIT:int = 0x00000002;
		public static const GL_LINES_ADJACENCY:int = 0x000A;
		public static const GL_LINE_STRIP_ADJACENCY:int = 0x000B;
		public static const GL_TRIANGLES_ADJACENCY:int = 0x000C;
		public static const GL_TRIANGLE_STRIP_ADJACENCY:int = 0x000D;
		public static const GL_PROGRAM_POINT_SIZE:int = 0x8642;
		public static const GL_MAX_GEOMETRY_TEXTURE_IMAGE_UNITS:int = 0x8C29;
		public static const GL_FRAMEBUFFER_ATTACHMENT_LAYERED:int = 0x8DA7;
		public static const GL_FRAMEBUFFER_INCOMPLETE_LAYER_TARGETS:int = 0x8DA8;
		public static const GL_GEOMETRY_SHADER:int = 0x8DD9;
		public static const GL_GEOMETRY_VERTICES_OUT:int = 0x8916;
		public static const GL_GEOMETRY_INPUT_TYPE:int = 0x8917;
		public static const GL_GEOMETRY_OUTPUT_TYPE:int = 0x8918;
		public static const GL_MAX_GEOMETRY_UNIFORM_COMPONENTS:int = 0x8DDF;
		public static const GL_MAX_GEOMETRY_OUTPUT_VERTICES:int = 0x8DE0;
		public static const GL_MAX_GEOMETRY_TOTAL_OUTPUT_COMPONENTS:int = 0x8DE1;
		public static const GL_MAX_VERTEX_OUTPUT_COMPONENTS:int = 0x9122;
		public static const GL_MAX_GEOMETRY_INPUT_COMPONENTS:int = 0x9123;
		public static const GL_MAX_GEOMETRY_OUTPUT_COMPONENTS:int = 0x9124;
		public static const GL_MAX_FRAGMENT_INPUT_COMPONENTS:int = 0x9125;
		public static const GL_CONTEXT_PROFILE_MASK:int = 0x9126;
		public static const GL_DEPTH_CLAMP:int = 0x864F;
		public static const GL_QUADS_FOLLOW_PROVOKING_VERTEX_CONVENTION:int = 0x8E4C;
		public static const GL_FIRST_VERTEX_CONVENTION:int = 0x8E4D;
		public static const GL_LAST_VERTEX_CONVENTION:int = 0x8E4E;
		public static const GL_PROVOKING_VERTEX:int = 0x8E4F;
		public static const GL_TEXTURE_CUBE_MAP_SEAMLESS:int = 0x884F;
		public static const GL_MAX_SERVER_WAIT_TIMEOUT:int = 0x9111;
		public static const GL_OBJECT_TYPE:int = 0x9112;
		public static const GL_SYNC_CONDITION:int = 0x9113;
		public static const GL_SYNC_STATUS:int = 0x9114;
		public static const GL_SYNC_FLAGS:int = 0x9115;
		public static const GL_SYNC_FENCE:int = 0x9116;
		public static const GL_SYNC_GPU_COMMANDS_COMPLETE:int = 0x9117;
		public static const GL_UNSIGNALED:int = 0x9118;
		public static const GL_SIGNALED:int = 0x9119;
		public static const GL_ALREADY_SIGNALED:int = 0x911A;
		public static const GL_TIMEOUT_EXPIRED:int = 0x911B;
		public static const GL_CONDITION_SATISFIED:int = 0x911C;
		public static const GL_WAIT_FAILED:int = 0x911D;
		public static const GL_TIMEOUT_IGNORED:uint = 0xFFFFFFFF;
		public static const GL_SYNC_FLUSH_COMMANDS_BIT:int = 0x00000001;
		public static const GL_SAMPLE_POSITION:int = 0x8E50;
		public static const GL_SAMPLE_MASK:int = 0x8E51;
		public static const GL_SAMPLE_MASK_VALUE:int = 0x8E52;
		public static const GL_MAX_SAMPLE_MASK_WORDS:int = 0x8E59;
		public static const GL_TEXTURE_2D_MULTISAMPLE:int = 0x9100;
		public static const GL_PROXY_TEXTURE_2D_MULTISAMPLE:int = 0x9101;
		public static const GL_TEXTURE_2D_MULTISAMPLE_ARRAY:int = 0x9102;
		public static const GL_PROXY_TEXTURE_2D_MULTISAMPLE_ARRAY:int = 0x9103;
		public static const GL_TEXTURE_BINDING_2D_MULTISAMPLE:int = 0x9104;
		public static const GL_TEXTURE_BINDING_2D_MULTISAMPLE_ARRAY:int = 0x9105;
		public static const GL_TEXTURE_SAMPLES:int = 0x9106;
		public static const GL_TEXTURE_FIXED_SAMPLE_LOCATIONS:int = 0x9107;
		public static const GL_SAMPLER_2D_MULTISAMPLE:int = 0x9108;
		public static const GL_INT_SAMPLER_2D_MULTISAMPLE:int = 0x9109;
		public static const GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE:int = 0x910A;
		public static const GL_SAMPLER_2D_MULTISAMPLE_ARRAY:int = 0x910B;
		public static const GL_INT_SAMPLER_2D_MULTISAMPLE_ARRAY:int = 0x910C;
		public static const GL_UNSIGNED_INT_SAMPLER_2D_MULTISAMPLE_ARRAY:int = 0x910D;
		public static const GL_MAX_COLOR_TEXTURE_SAMPLES:int = 0x910E;
		public static const GL_MAX_DEPTH_TEXTURE_SAMPLES:int = 0x910F;
		public static const GL_MAX_INTEGER_SAMPLES:int = 0x9110;
		public static const GL_VERTEX_ATTRIB_ARRAY_DIVISOR:int = 0x88FE;
		public static const GL_SRC1_COLOR:int = 0x88F9;
		public static const GL_ONE_MINUS_SRC1_COLOR:int = 0x88FA;
		public static const GL_ONE_MINUS_SRC1_ALPHA:int = 0x88FB;
		public static const GL_MAX_DUAL_SOURCE_DRAW_BUFFERS:int = 0x88FC;
		public static const GL_ANY_SAMPLES_PASSED:int = 0x8C2F;
		public static const GL_SAMPLER_BINDING:int = 0x8919;
		public static const GL_RGB10_A2UI:int = 0x906F;
		public static const GL_TEXTURE_SWIZZLE_R:int = 0x8E42;
		public static const GL_TEXTURE_SWIZZLE_G:int = 0x8E43;
		public static const GL_TEXTURE_SWIZZLE_B:int = 0x8E44;
		public static const GL_TEXTURE_SWIZZLE_A:int = 0x8E45;
		public static const GL_TEXTURE_SWIZZLE_RGBA:int = 0x8E46;
		public static const GL_TIME_ELAPSED:int = 0x88BF;
		public static const GL_TIMESTAMP:int = 0x8E28;
		public static const GL_INT_2_10_10_10_REV:int = 0x8D9F;
		public static const GL_SAMPLE_SHADING:int = 0x8C36;
		public static const GL_MIN_SAMPLE_SHADING_VALUE:int = 0x8C37;
		public static const GL_MIN_PROGRAM_TEXTURE_GATHER_OFFSET:int = 0x8E5E;
		public static const GL_MAX_PROGRAM_TEXTURE_GATHER_OFFSET:int = 0x8E5F;
		public static const GL_TEXTURE_CUBE_MAP_ARRAY:int = 0x9009;
		public static const GL_TEXTURE_BINDING_CUBE_MAP_ARRAY:int = 0x900A;
		public static const GL_PROXY_TEXTURE_CUBE_MAP_ARRAY:int = 0x900B;
		public static const GL_SAMPLER_CUBE_MAP_ARRAY:int = 0x900C;
		public static const GL_SAMPLER_CUBE_MAP_ARRAY_SHADOW:int = 0x900D;
		public static const GL_INT_SAMPLER_CUBE_MAP_ARRAY:int = 0x900E;
		public static const GL_UNSIGNED_INT_SAMPLER_CUBE_MAP_ARRAY:int = 0x900F;
		public static const GL_DRAW_INDIRECT_BUFFER:int = 0x8F3F;
		public static const GL_DRAW_INDIRECT_BUFFER_BINDING:int = 0x8F43;
		public static const GL_GEOMETRY_SHADER_INVOCATIONS:int = 0x887F;
		public static const GL_MAX_GEOMETRY_SHADER_INVOCATIONS:int = 0x8E5A;
		public static const GL_MIN_FRAGMENT_INTERPOLATION_OFFSET:int = 0x8E5B;
		public static const GL_MAX_FRAGMENT_INTERPOLATION_OFFSET:int = 0x8E5C;
		public static const GL_FRAGMENT_INTERPOLATION_OFFSET_BITS:int = 0x8E5D;
		public static const GL_MAX_VERTEX_STREAMS:int = 0x8E71;
		public static const GL_DOUBLE_VEC2:int = 0x8FFC;
		public static const GL_DOUBLE_VEC3:int = 0x8FFD;
		public static const GL_DOUBLE_VEC4:int = 0x8FFE;
		public static const GL_DOUBLE_MAT2:int = 0x8F46;
		public static const GL_DOUBLE_MAT3:int = 0x8F47;
		public static const GL_DOUBLE_MAT4:int = 0x8F48;
		public static const GL_DOUBLE_MAT2x3:int = 0x8F49;
		public static const GL_DOUBLE_MAT2x4:int = 0x8F4A;
		public static const GL_DOUBLE_MAT3x2:int = 0x8F4B;
		public static const GL_DOUBLE_MAT3x4:int = 0x8F4C;
		public static const GL_DOUBLE_MAT4x2:int = 0x8F4D;
		public static const GL_DOUBLE_MAT4x3:int = 0x8F4E;
		public static const GL_ACTIVE_SUBROUTINES:int = 0x8DE5;
		public static const GL_ACTIVE_SUBROUTINE_UNIFORMS:int = 0x8DE6;
		public static const GL_ACTIVE_SUBROUTINE_UNIFORM_LOCATIONS:int = 0x8E47;
		public static const GL_ACTIVE_SUBROUTINE_MAX_LENGTH:int = 0x8E48;
		public static const GL_ACTIVE_SUBROUTINE_UNIFORM_MAX_LENGTH:int = 0x8E49;
		public static const GL_MAX_SUBROUTINES:int = 0x8DE7;
		public static const GL_MAX_SUBROUTINE_UNIFORM_LOCATIONS:int = 0x8DE8;
		public static const GL_NUM_COMPATIBLE_SUBROUTINES:int = 0x8E4A;
		public static const GL_COMPATIBLE_SUBROUTINES:int = 0x8E4B;
		public static const GL_PATCHES:int = 0x000E;
		public static const GL_PATCH_VERTICES:int = 0x8E72;
		public static const GL_PATCH_DEFAULT_INNER_LEVEL:int = 0x8E73;
		public static const GL_PATCH_DEFAULT_OUTER_LEVEL:int = 0x8E74;
		public static const GL_TESS_CONTROL_OUTPUT_VERTICES:int = 0x8E75;
		public static const GL_TESS_GEN_MODE:int = 0x8E76;
		public static const GL_TESS_GEN_SPACING:int = 0x8E77;
		public static const GL_TESS_GEN_VERTEX_ORDER:int = 0x8E78;
		public static const GL_TESS_GEN_POINT_MODE:int = 0x8E79;
		public static const GL_ISOLINES:int = 0x8E7A;
		public static const GL_QUADS:int = 0x0007;
		public static const GL_FRACTIONAL_ODD:int = 0x8E7B;
		public static const GL_FRACTIONAL_EVEN:int = 0x8E7C;
		public static const GL_MAX_PATCH_VERTICES:int = 0x8E7D;
		public static const GL_MAX_TESS_GEN_LEVEL:int = 0x8E7E;
		public static const GL_MAX_TESS_CONTROL_UNIFORM_COMPONENTS:int = 0x8E7F;
		public static const GL_MAX_TESS_EVALUATION_UNIFORM_COMPONENTS:int = 0x8E80;
		public static const GL_MAX_TESS_CONTROL_TEXTURE_IMAGE_UNITS:int = 0x8E81;
		public static const GL_MAX_TESS_EVALUATION_TEXTURE_IMAGE_UNITS:int = 0x8E82;
		public static const GL_MAX_TESS_CONTROL_OUTPUT_COMPONENTS:int = 0x8E83;
		public static const GL_MAX_TESS_PATCH_COMPONENTS:int = 0x8E84;
		public static const GL_MAX_TESS_CONTROL_TOTAL_OUTPUT_COMPONENTS:int = 0x8E85;
		public static const GL_MAX_TESS_EVALUATION_OUTPUT_COMPONENTS:int = 0x8E86;
		public static const GL_MAX_TESS_CONTROL_UNIFORM_BLOCKS:int = 0x8E89;
		public static const GL_MAX_TESS_EVALUATION_UNIFORM_BLOCKS:int = 0x8E8A;
		public static const GL_MAX_TESS_CONTROL_INPUT_COMPONENTS:int = 0x886C;
		public static const GL_MAX_TESS_EVALUATION_INPUT_COMPONENTS:int = 0x886D;
		public static const GL_MAX_COMBINED_TESS_CONTROL_UNIFORM_COMPONENTS:int = 0x8E1E;
		public static const GL_MAX_COMBINED_TESS_EVALUATION_UNIFORM_COMPONENTS:int = 0x8E1F;
		public static const GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_CONTROL_SHADER:int = 0x84F0;
		public static const GL_UNIFORM_BLOCK_REFERENCED_BY_TESS_EVALUATION_SHADER:int = 0x84F1;
		public static const GL_TESS_EVALUATION_SHADER:int = 0x8E87;
		public static const GL_TESS_CONTROL_SHADER:int = 0x8E88;
		public static const GL_TRANSFORM_FEEDBACK:int = 0x8E22;
		public static const GL_TRANSFORM_FEEDBACK_BUFFER_PAUSED:int = 0x8E23;
		public static const GL_TRANSFORM_FEEDBACK_BUFFER_ACTIVE:int = 0x8E24;
		public static const GL_TRANSFORM_FEEDBACK_BINDING:int = 0x8E25;
		public static const GL_MAX_TRANSFORM_FEEDBACK_BUFFERS:int = 0x8E70;
		public static const GL_FIXED:int = 0x140C;
		public static const GL_IMPLEMENTATION_COLOR_READ_TYPE:int = 0x8B9A;
		public static const GL_IMPLEMENTATION_COLOR_READ_FORMAT:int = 0x8B9B;
		public static const GL_LOW_FLOAT:int = 0x8DF0;
		public static const GL_MEDIUM_FLOAT:int = 0x8DF1;
		public static const GL_HIGH_FLOAT:int = 0x8DF2;
		public static const GL_LOW_INT:int = 0x8DF3;
		public static const GL_MEDIUM_INT:int = 0x8DF4;
		public static const GL_HIGH_INT:int = 0x8DF5;
		public static const GL_SHADER_COMPILER:int = 0x8DFA;
		public static const GL_SHADER_BINARY_FORMATS:int = 0x8DF8;
		public static const GL_NUM_SHADER_BINARY_FORMATS:int = 0x8DF9;
		public static const GL_MAX_VERTEX_UNIFORM_VECTORS:int = 0x8DFB;
		public static const GL_MAX_VARYING_VECTORS:int = 0x8DFC;
		public static const GL_MAX_FRAGMENT_UNIFORM_VECTORS:int = 0x8DFD;
		public static const GL_RGB565:int = 0x8D62;
		public static const GL_PROGRAM_BINARY_RETRIEVABLE_HINT:int = 0x8257;
		public static const GL_PROGRAM_BINARY_LENGTH:int = 0x8741;
		public static const GL_NUM_PROGRAM_BINARY_FORMATS:int = 0x87FE;
		public static const GL_PROGRAM_BINARY_FORMATS:int = 0x87FF;
		public static const GL_VERTEX_SHADER_BIT:int = 0x00000001;
		public static const GL_FRAGMENT_SHADER_BIT:int = 0x00000002;
		public static const GL_GEOMETRY_SHADER_BIT:int = 0x00000004;
		public static const GL_TESS_CONTROL_SHADER_BIT:int = 0x00000008;
		public static const GL_TESS_EVALUATION_SHADER_BIT:int = 0x00000010;
		public static const GL_ALL_SHADER_BITS:uint = 0xFFFFFFFF;
		public static const GL_PROGRAM_SEPARABLE:int = 0x8258;
		public static const GL_ACTIVE_PROGRAM:int = 0x8259;
		public static const GL_PROGRAM_PIPELINE_BINDING:int = 0x825A;
		public static const GL_MAX_VIEWPORTS:int = 0x825B;
		public static const GL_VIEWPORT_SUBPIXEL_BITS:int = 0x825C;
		public static const GL_VIEWPORT_BOUNDS_RANGE:int = 0x825D;
		public static const GL_LAYER_PROVOKING_VERTEX:int = 0x825E;
		public static const GL_VIEWPORT_INDEX_PROVOKING_VERTEX:int = 0x825F;
		public static const GL_UNDEFINED_VERTEX:int = 0x8260;
		public static const GL_COPY_READ_BUFFER_BINDING:int = 0x8F36;
		public static const GL_COPY_WRITE_BUFFER_BINDING:int = 0x8F37;
		public static const GL_TRANSFORM_FEEDBACK_ACTIVE:int = 0x8E24;
		public static const GL_TRANSFORM_FEEDBACK_PAUSED:int = 0x8E23;
		public static const GL_UNPACK_COMPRESSED_BLOCK_WIDTH:int = 0x9127;
		public static const GL_UNPACK_COMPRESSED_BLOCK_HEIGHT:int = 0x9128;
		public static const GL_UNPACK_COMPRESSED_BLOCK_DEPTH:int = 0x9129;
		public static const GL_UNPACK_COMPRESSED_BLOCK_SIZE:int = 0x912A;
		public static const GL_PACK_COMPRESSED_BLOCK_WIDTH:int = 0x912B;
		public static const GL_PACK_COMPRESSED_BLOCK_HEIGHT:int = 0x912C;
		public static const GL_PACK_COMPRESSED_BLOCK_DEPTH:int = 0x912D;
		public static const GL_PACK_COMPRESSED_BLOCK_SIZE:int = 0x912E;
		public static const GL_NUM_SAMPLE_COUNTS:int = 0x9380;
		public static const GL_MIN_MAP_BUFFER_ALIGNMENT:int = 0x90BC;
		public static const GL_ATOMIC_COUNTER_BUFFER:int = 0x92C0;
		public static const GL_ATOMIC_COUNTER_BUFFER_BINDING:int = 0x92C1;
		public static const GL_ATOMIC_COUNTER_BUFFER_START:int = 0x92C2;
		public static const GL_ATOMIC_COUNTER_BUFFER_SIZE:int = 0x92C3;
		public static const GL_ATOMIC_COUNTER_BUFFER_DATA_SIZE:int = 0x92C4;
		public static const GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTERS:int = 0x92C5;
		public static const GL_ATOMIC_COUNTER_BUFFER_ACTIVE_ATOMIC_COUNTER_INDICES:int = 0x92C6;
		public static const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_VERTEX_SHADER:int = 0x92C7;
		public static const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_CONTROL_SHADER:int = 0x92C8;
		public static const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_TESS_EVALUATION_SHADER:int = 0x92C9;
		public static const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_GEOMETRY_SHADER:int = 0x92CA;
		public static const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_FRAGMENT_SHADER:int = 0x92CB;
		public static const GL_MAX_VERTEX_ATOMIC_COUNTER_BUFFERS:int = 0x92CC;
		public static const GL_MAX_TESS_CONTROL_ATOMIC_COUNTER_BUFFERS:int = 0x92CD;
		public static const GL_MAX_TESS_EVALUATION_ATOMIC_COUNTER_BUFFERS:int = 0x92CE;
		public static const GL_MAX_GEOMETRY_ATOMIC_COUNTER_BUFFERS:int = 0x92CF;
		public static const GL_MAX_FRAGMENT_ATOMIC_COUNTER_BUFFERS:int = 0x92D0;
		public static const GL_MAX_COMBINED_ATOMIC_COUNTER_BUFFERS:int = 0x92D1;
		public static const GL_MAX_VERTEX_ATOMIC_COUNTERS:int = 0x92D2;
		public static const GL_MAX_TESS_CONTROL_ATOMIC_COUNTERS:int = 0x92D3;
		public static const GL_MAX_TESS_EVALUATION_ATOMIC_COUNTERS:int = 0x92D4;
		public static const GL_MAX_GEOMETRY_ATOMIC_COUNTERS:int = 0x92D5;
		public static const GL_MAX_FRAGMENT_ATOMIC_COUNTERS:int = 0x92D6;
		public static const GL_MAX_COMBINED_ATOMIC_COUNTERS:int = 0x92D7;
		public static const GL_MAX_ATOMIC_COUNTER_BUFFER_SIZE:int = 0x92D8;
		public static const GL_MAX_ATOMIC_COUNTER_BUFFER_BINDINGS:int = 0x92DC;
		public static const GL_ACTIVE_ATOMIC_COUNTER_BUFFERS:int = 0x92D9;
		public static const GL_UNIFORM_ATOMIC_COUNTER_BUFFER_INDEX:int = 0x92DA;
		public static const GL_UNSIGNED_INT_ATOMIC_COUNTER:int = 0x92DB;
		public static const GL_VERTEX_ATTRIB_ARRAY_BARRIER_BIT:int = 0x00000001;
		public static const GL_ELEMENT_ARRAY_BARRIER_BIT:int = 0x00000002;
		public static const GL_UNIFORM_BARRIER_BIT:int = 0x00000004;
		public static const GL_TEXTURE_FETCH_BARRIER_BIT:int = 0x00000008;
		public static const GL_SHADER_IMAGE_ACCESS_BARRIER_BIT:int = 0x00000020;
		public static const GL_COMMAND_BARRIER_BIT:int = 0x00000040;
		public static const GL_PIXEL_BUFFER_BARRIER_BIT:int = 0x00000080;
		public static const GL_TEXTURE_UPDATE_BARRIER_BIT:int = 0x00000100;
		public static const GL_BUFFER_UPDATE_BARRIER_BIT:int = 0x00000200;
		public static const GL_FRAMEBUFFER_BARRIER_BIT:int = 0x00000400;
		public static const GL_TRANSFORM_FEEDBACK_BARRIER_BIT:int = 0x00000800;
		public static const GL_ATOMIC_COUNTER_BARRIER_BIT:int = 0x00001000;
		public static const GL_ALL_BARRIER_BITS:uint = 0xFFFFFFFF;
		public static const GL_MAX_IMAGE_UNITS:int = 0x8F38;
		public static const GL_MAX_COMBINED_IMAGE_UNITS_AND_FRAGMENT_OUTPUTS:int = 0x8F39;
		public static const GL_IMAGE_BINDING_NAME:int = 0x8F3A;
		public static const GL_IMAGE_BINDING_LEVEL:int = 0x8F3B;
		public static const GL_IMAGE_BINDING_LAYERED:int = 0x8F3C;
		public static const GL_IMAGE_BINDING_LAYER:int = 0x8F3D;
		public static const GL_IMAGE_BINDING_ACCESS:int = 0x8F3E;
		public static const GL_IMAGE_1D:int = 0x904C;
		public static const GL_IMAGE_2D:int = 0x904D;
		public static const GL_IMAGE_3D:int = 0x904E;
		public static const GL_IMAGE_2D_RECT:int = 0x904F;
		public static const GL_IMAGE_CUBE:int = 0x9050;
		public static const GL_IMAGE_BUFFER:int = 0x9051;
		public static const GL_IMAGE_1D_ARRAY:int = 0x9052;
		public static const GL_IMAGE_2D_ARRAY:int = 0x9053;
		public static const GL_IMAGE_CUBE_MAP_ARRAY:int = 0x9054;
		public static const GL_IMAGE_2D_MULTISAMPLE:int = 0x9055;
		public static const GL_IMAGE_2D_MULTISAMPLE_ARRAY:int = 0x9056;
		public static const GL_INT_IMAGE_1D:int = 0x9057;
		public static const GL_INT_IMAGE_2D:int = 0x9058;
		public static const GL_INT_IMAGE_3D:int = 0x9059;
		public static const GL_INT_IMAGE_2D_RECT:int = 0x905A;
		public static const GL_INT_IMAGE_CUBE:int = 0x905B;
		public static const GL_INT_IMAGE_BUFFER:int = 0x905C;
		public static const GL_INT_IMAGE_1D_ARRAY:int = 0x905D;
		public static const GL_INT_IMAGE_2D_ARRAY:int = 0x905E;
		public static const GL_INT_IMAGE_CUBE_MAP_ARRAY:int = 0x905F;
		public static const GL_INT_IMAGE_2D_MULTISAMPLE:int = 0x9060;
		public static const GL_INT_IMAGE_2D_MULTISAMPLE_ARRAY:int = 0x9061;
		public static const GL_UNSIGNED_INT_IMAGE_1D:int = 0x9062;
		public static const GL_UNSIGNED_INT_IMAGE_2D:int = 0x9063;
		public static const GL_UNSIGNED_INT_IMAGE_3D:int = 0x9064;
		public static const GL_UNSIGNED_INT_IMAGE_2D_RECT:int = 0x9065;
		public static const GL_UNSIGNED_INT_IMAGE_CUBE:int = 0x9066;
		public static const GL_UNSIGNED_INT_IMAGE_BUFFER:int = 0x9067;
		public static const GL_UNSIGNED_INT_IMAGE_1D_ARRAY:int = 0x9068;
		public static const GL_UNSIGNED_INT_IMAGE_2D_ARRAY:int = 0x9069;
		public static const GL_UNSIGNED_INT_IMAGE_CUBE_MAP_ARRAY:int = 0x906A;
		public static const GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE:int = 0x906B;
		public static const GL_UNSIGNED_INT_IMAGE_2D_MULTISAMPLE_ARRAY:int = 0x906C;
		public static const GL_MAX_IMAGE_SAMPLES:int = 0x906D;
		public static const GL_IMAGE_BINDING_FORMAT:int = 0x906E;
		public static const GL_IMAGE_FORMAT_COMPATIBILITY_TYPE:int = 0x90C7;
		public static const GL_IMAGE_FORMAT_COMPATIBILITY_BY_SIZE:int = 0x90C8;
		public static const GL_IMAGE_FORMAT_COMPATIBILITY_BY_CLASS:int = 0x90C9;
		public static const GL_MAX_VERTEX_IMAGE_UNIFORMS:int = 0x90CA;
		public static const GL_MAX_TESS_CONTROL_IMAGE_UNIFORMS:int = 0x90CB;
		public static const GL_MAX_TESS_EVALUATION_IMAGE_UNIFORMS:int = 0x90CC;
		public static const GL_MAX_GEOMETRY_IMAGE_UNIFORMS:int = 0x90CD;
		public static const GL_MAX_FRAGMENT_IMAGE_UNIFORMS:int = 0x90CE;
		public static const GL_MAX_COMBINED_IMAGE_UNIFORMS:int = 0x90CF;
		public static const GL_COMPRESSED_RGBA_BPTC_UNORM:int = 0x8E8C;
		public static const GL_COMPRESSED_SRGB_ALPHA_BPTC_UNORM:int = 0x8E8D;
		public static const GL_COMPRESSED_RGB_BPTC_SIGNED_FLOAT:int = 0x8E8E;
		public static const GL_COMPRESSED_RGB_BPTC_UNSIGNED_FLOAT:int = 0x8E8F;
		public static const GL_TEXTURE_IMMUTABLE_FORMAT:int = 0x912F;
		public static const GL_NUM_SHADING_LANGUAGE_VERSIONS:int = 0x82E9;
		public static const GL_VERTEX_ATTRIB_ARRAY_LONG:int = 0x874E;
		public static const GL_COMPRESSED_RGB8_ETC2:int = 0x9274;
		public static const GL_COMPRESSED_SRGB8_ETC2:int = 0x9275;
		public static const GL_COMPRESSED_RGB8_PUNCHTHROUGH_ALPHA1_ETC2:int = 0x9276;
		public static const GL_COMPRESSED_SRGB8_PUNCHTHROUGH_ALPHA1_ETC2:int = 0x9277;
		public static const GL_COMPRESSED_RGBA8_ETC2_EAC:int = 0x9278;
		public static const GL_COMPRESSED_SRGB8_ALPHA8_ETC2_EAC:int = 0x9279;
		public static const GL_COMPRESSED_R11_EAC:int = 0x9270;
		public static const GL_COMPRESSED_SIGNED_R11_EAC:int = 0x9271;
		public static const GL_COMPRESSED_RG11_EAC:int = 0x9272;
		public static const GL_COMPRESSED_SIGNED_RG11_EAC:int = 0x9273;
		public static const GL_PRIMITIVE_RESTART_FIXED_INDEX:int = 0x8D69;
		public static const GL_ANY_SAMPLES_PASSED_CONSERVATIVE:int = 0x8D6A;
		public static const GL_MAX_ELEMENT_INDEX:int = 0x8D6B;
		public static const GL_COMPUTE_SHADER:int = 0x91B9;
		public static const GL_MAX_COMPUTE_UNIFORM_BLOCKS:int = 0x91BB;
		public static const GL_MAX_COMPUTE_TEXTURE_IMAGE_UNITS:int = 0x91BC;
		public static const GL_MAX_COMPUTE_IMAGE_UNIFORMS:int = 0x91BD;
		public static const GL_MAX_COMPUTE_SHARED_MEMORY_SIZE:int = 0x8262;
		public static const GL_MAX_COMPUTE_UNIFORM_COMPONENTS:int = 0x8263;
		public static const GL_MAX_COMPUTE_ATOMIC_COUNTER_BUFFERS:int = 0x8264;
		public static const GL_MAX_COMPUTE_ATOMIC_COUNTERS:int = 0x8265;
		public static const GL_MAX_COMBINED_COMPUTE_UNIFORM_COMPONENTS:int = 0x8266;
		public static const GL_MAX_COMPUTE_WORK_GROUP_INVOCATIONS:int = 0x90EB;
		public static const GL_MAX_COMPUTE_WORK_GROUP_COUNT:int = 0x91BE;
		public static const GL_MAX_COMPUTE_WORK_GROUP_SIZE:int = 0x91BF;
		public static const GL_COMPUTE_WORK_GROUP_SIZE:int = 0x8267;
		public static const GL_UNIFORM_BLOCK_REFERENCED_BY_COMPUTE_SHADER:int = 0x90EC;
		public static const GL_ATOMIC_COUNTER_BUFFER_REFERENCED_BY_COMPUTE_SHADER:int = 0x90ED;
		public static const GL_DISPATCH_INDIRECT_BUFFER:int = 0x90EE;
		public static const GL_DISPATCH_INDIRECT_BUFFER_BINDING:int = 0x90EF;
		public static const GL_COMPUTE_SHADER_BIT:int = 0x00000020;
		public static const GL_DEBUG_OUTPUT_SYNCHRONOUS:int = 0x8242;
		public static const GL_DEBUG_NEXT_LOGGED_MESSAGE_LENGTH:int = 0x8243;
		public static const GL_DEBUG_CALLBACK_FUNCTION:int = 0x8244;
		public static const GL_DEBUG_CALLBACK_USER_PARAM:int = 0x8245;
		public static const GL_DEBUG_SOURCE_API:int = 0x8246;
		public static const GL_DEBUG_SOURCE_WINDOW_SYSTEM:int = 0x8247;
		public static const GL_DEBUG_SOURCE_SHADER_COMPILER:int = 0x8248;
		public static const GL_DEBUG_SOURCE_THIRD_PARTY:int = 0x8249;
		public static const GL_DEBUG_SOURCE_APPLICATION:int = 0x824A;
		public static const GL_DEBUG_SOURCE_OTHER:int = 0x824B;
		public static const GL_DEBUG_TYPE_ERROR:int = 0x824C;
		public static const GL_DEBUG_TYPE_DEPRECATED_BEHAVIOR:int = 0x824D;
		public static const GL_DEBUG_TYPE_UNDEFINED_BEHAVIOR:int = 0x824E;
		public static const GL_DEBUG_TYPE_PORTABILITY:int = 0x824F;
		public static const GL_DEBUG_TYPE_PERFORMANCE:int = 0x8250;
		public static const GL_DEBUG_TYPE_OTHER:int = 0x8251;
		public static const GL_MAX_DEBUG_MESSAGE_LENGTH:int = 0x9143;
		public static const GL_MAX_DEBUG_LOGGED_MESSAGES:int = 0x9144;
		public static const GL_DEBUG_LOGGED_MESSAGES:int = 0x9145;
		public static const GL_DEBUG_SEVERITY_HIGH:int = 0x9146;
		public static const GL_DEBUG_SEVERITY_MEDIUM:int = 0x9147;
		public static const GL_DEBUG_SEVERITY_LOW:int = 0x9148;
		public static const GL_DEBUG_TYPE_MARKER:int = 0x8268;
		public static const GL_DEBUG_TYPE_PUSH_GROUP:int = 0x8269;
		public static const GL_DEBUG_TYPE_POP_GROUP:int = 0x826A;
		public static const GL_DEBUG_SEVERITY_NOTIFICATION:int = 0x826B;
		public static const GL_MAX_DEBUG_GROUP_STACK_DEPTH:int = 0x826C;
		public static const GL_DEBUG_GROUP_STACK_DEPTH:int = 0x826D;
		public static const GL_BUFFER:int = 0x82E0;
		public static const GL_SHADER:int = 0x82E1;
		public static const GL_PROGRAM:int = 0x82E2;
		public static const GL_VERTEX_ARRAY:int = 0x8074;
		public static const GL_QUERY:int = 0x82E3;
		public static const GL_PROGRAM_PIPELINE:int = 0x82E4;
		public static const GL_SAMPLER:int = 0x82E6;
		public static const GL_MAX_LABEL_LENGTH:int = 0x82E8;
		public static const GL_DEBUG_OUTPUT:int = 0x92E0;
		public static const GL_CONTEXT_FLAG_DEBUG_BIT:int = 0x00000002;
		public static const GL_MAX_UNIFORM_LOCATIONS:int = 0x826E;
		public static const GL_FRAMEBUFFER_DEFAULT_WIDTH:int = 0x9310;
		public static const GL_FRAMEBUFFER_DEFAULT_HEIGHT:int = 0x9311;
		public static const GL_FRAMEBUFFER_DEFAULT_LAYERS:int = 0x9312;
		public static const GL_FRAMEBUFFER_DEFAULT_SAMPLES:int = 0x9313;
		public static const GL_FRAMEBUFFER_DEFAULT_FIXED_SAMPLE_LOCATIONS:int = 0x9314;
		public static const GL_MAX_FRAMEBUFFER_WIDTH:int = 0x9315;
		public static const GL_MAX_FRAMEBUFFER_HEIGHT:int = 0x9316;
		public static const GL_MAX_FRAMEBUFFER_LAYERS:int = 0x9317;
		public static const GL_MAX_FRAMEBUFFER_SAMPLES:int = 0x9318;
		public static const GL_INTERNALFORMAT_SUPPORTED:int = 0x826F;
		public static const GL_INTERNALFORMAT_PREFERRED:int = 0x8270;
		public static const GL_INTERNALFORMAT_RED_SIZE:int = 0x8271;
		public static const GL_INTERNALFORMAT_GREEN_SIZE:int = 0x8272;
		public static const GL_INTERNALFORMAT_BLUE_SIZE:int = 0x8273;
		public static const GL_INTERNALFORMAT_ALPHA_SIZE:int = 0x8274;
		public static const GL_INTERNALFORMAT_DEPTH_SIZE:int = 0x8275;
		public static const GL_INTERNALFORMAT_STENCIL_SIZE:int = 0x8276;
		public static const GL_INTERNALFORMAT_SHARED_SIZE:int = 0x8277;
		public static const GL_INTERNALFORMAT_RED_TYPE:int = 0x8278;
		public static const GL_INTERNALFORMAT_GREEN_TYPE:int = 0x8279;
		public static const GL_INTERNALFORMAT_BLUE_TYPE:int = 0x827A;
		public static const GL_INTERNALFORMAT_ALPHA_TYPE:int = 0x827B;
		public static const GL_INTERNALFORMAT_DEPTH_TYPE:int = 0x827C;
		public static const GL_INTERNALFORMAT_STENCIL_TYPE:int = 0x827D;
		public static const GL_MAX_WIDTH:int = 0x827E;
		public static const GL_MAX_HEIGHT:int = 0x827F;
		public static const GL_MAX_DEPTH:int = 0x8280;
		public static const GL_MAX_LAYERS:int = 0x8281;
		public static const GL_MAX_COMBINED_DIMENSIONS:int = 0x8282;
		public static const GL_COLOR_COMPONENTS:int = 0x8283;
		public static const GL_DEPTH_COMPONENTS:int = 0x8284;
		public static const GL_STENCIL_COMPONENTS:int = 0x8285;
		public static const GL_COLOR_RENDERABLE:int = 0x8286;
		public static const GL_DEPTH_RENDERABLE:int = 0x8287;
		public static const GL_STENCIL_RENDERABLE:int = 0x8288;
		public static const GL_FRAMEBUFFER_RENDERABLE:int = 0x8289;
		public static const GL_FRAMEBUFFER_RENDERABLE_LAYERED:int = 0x828A;
		public static const GL_FRAMEBUFFER_BLEND:int = 0x828B;
		public static const GL_READ_PIXELS:int = 0x828C;
		public static const GL_READ_PIXELS_FORMAT:int = 0x828D;
		public static const GL_READ_PIXELS_TYPE:int = 0x828E;
		public static const GL_TEXTURE_IMAGE_FORMAT:int = 0x828F;
		public static const GL_TEXTURE_IMAGE_TYPE:int = 0x8290;
		public static const GL_GET_TEXTURE_IMAGE_FORMAT:int = 0x8291;
		public static const GL_GET_TEXTURE_IMAGE_TYPE:int = 0x8292;
		public static const GL_MIPMAP:int = 0x8293;
		public static const GL_MANUAL_GENERATE_MIPMAP:int = 0x8294;
		public static const GL_AUTO_GENERATE_MIPMAP:int = 0x8295;
		public static const GL_COLOR_ENCODING:int = 0x8296;
		public static const GL_SRGB_READ:int = 0x8297;
		public static const GL_SRGB_WRITE:int = 0x8298;
		public static const GL_FILTER:int = 0x829A;
		public static const GL_VERTEX_TEXTURE:int = 0x829B;
		public static const GL_TESS_CONTROL_TEXTURE:int = 0x829C;
		public static const GL_TESS_EVALUATION_TEXTURE:int = 0x829D;
		public static const GL_GEOMETRY_TEXTURE:int = 0x829E;
		public static const GL_FRAGMENT_TEXTURE:int = 0x829F;
		public static const GL_COMPUTE_TEXTURE:int = 0x82A0;
		public static const GL_TEXTURE_SHADOW:int = 0x82A1;
		public static const GL_TEXTURE_GATHER:int = 0x82A2;
		public static const GL_TEXTURE_GATHER_SHADOW:int = 0x82A3;
		public static const GL_SHADER_IMAGE_LOAD:int = 0x82A4;
		public static const GL_SHADER_IMAGE_STORE:int = 0x82A5;
		public static const GL_SHADER_IMAGE_ATOMIC:int = 0x82A6;
		public static const GL_IMAGE_TEXEL_SIZE:int = 0x82A7;
		public static const GL_IMAGE_COMPATIBILITY_CLASS:int = 0x82A8;
		public static const GL_IMAGE_PIXEL_FORMAT:int = 0x82A9;
		public static const GL_IMAGE_PIXEL_TYPE:int = 0x82AA;
		public static const GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_TEST:int = 0x82AC;
		public static const GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_TEST:int = 0x82AD;
		public static const GL_SIMULTANEOUS_TEXTURE_AND_DEPTH_WRITE:int = 0x82AE;
		public static const GL_SIMULTANEOUS_TEXTURE_AND_STENCIL_WRITE:int = 0x82AF;
		public static const GL_TEXTURE_COMPRESSED_BLOCK_WIDTH:int = 0x82B1;
		public static const GL_TEXTURE_COMPRESSED_BLOCK_HEIGHT:int = 0x82B2;
		public static const GL_TEXTURE_COMPRESSED_BLOCK_SIZE:int = 0x82B3;
		public static const GL_CLEAR_BUFFER:int = 0x82B4;
		public static const GL_TEXTURE_VIEW:int = 0x82B5;
		public static const GL_VIEW_COMPATIBILITY_CLASS:int = 0x82B6;
		public static const GL_FULL_SUPPORT:int = 0x82B7;
		public static const GL_CAVEAT_SUPPORT:int = 0x82B8;
		public static const GL_IMAGE_CLASS_4_X_32:int = 0x82B9;
		public static const GL_IMAGE_CLASS_2_X_32:int = 0x82BA;
		public static const GL_IMAGE_CLASS_1_X_32:int = 0x82BB;
		public static const GL_IMAGE_CLASS_4_X_16:int = 0x82BC;
		public static const GL_IMAGE_CLASS_2_X_16:int = 0x82BD;
		public static const GL_IMAGE_CLASS_1_X_16:int = 0x82BE;
		public static const GL_IMAGE_CLASS_4_X_8:int = 0x82BF;
		public static const GL_IMAGE_CLASS_2_X_8:int = 0x82C0;
		public static const GL_IMAGE_CLASS_1_X_8:int = 0x82C1;
		public static const GL_IMAGE_CLASS_11_11_10:int = 0x82C2;
		public static const GL_IMAGE_CLASS_10_10_10_2:int = 0x82C3;
		public static const GL_VIEW_CLASS_128_BITS:int = 0x82C4;
		public static const GL_VIEW_CLASS_96_BITS:int = 0x82C5;
		public static const GL_VIEW_CLASS_64_BITS:int = 0x82C6;
		public static const GL_VIEW_CLASS_48_BITS:int = 0x82C7;
		public static const GL_VIEW_CLASS_32_BITS:int = 0x82C8;
		public static const GL_VIEW_CLASS_24_BITS:int = 0x82C9;
		public static const GL_VIEW_CLASS_16_BITS:int = 0x82CA;
		public static const GL_VIEW_CLASS_8_BITS:int = 0x82CB;
		public static const GL_VIEW_CLASS_S3TC_DXT1_RGB:int = 0x82CC;
		public static const GL_VIEW_CLASS_S3TC_DXT1_RGBA:int = 0x82CD;
		public static const GL_VIEW_CLASS_S3TC_DXT3_RGBA:int = 0x82CE;
		public static const GL_VIEW_CLASS_S3TC_DXT5_RGBA:int = 0x82CF;
		public static const GL_VIEW_CLASS_RGTC1_RED:int = 0x82D0;
		public static const GL_VIEW_CLASS_RGTC2_RG:int = 0x82D1;
		public static const GL_VIEW_CLASS_BPTC_UNORM:int = 0x82D2;
		public static const GL_VIEW_CLASS_BPTC_FLOAT:int = 0x82D3;
		public static const GL_UNIFORM:int = 0x92E1;
		public static const GL_UNIFORM_BLOCK:int = 0x92E2;
		public static const GL_PROGRAM_INPUT:int = 0x92E3;
		public static const GL_PROGRAM_OUTPUT:int = 0x92E4;
		public static const GL_BUFFER_VARIABLE:int = 0x92E5;
		public static const GL_SHADER_STORAGE_BLOCK:int = 0x92E6;
		public static const GL_VERTEX_SUBROUTINE:int = 0x92E8;
		public static const GL_TESS_CONTROL_SUBROUTINE:int = 0x92E9;
		public static const GL_TESS_EVALUATION_SUBROUTINE:int = 0x92EA;
		public static const GL_GEOMETRY_SUBROUTINE:int = 0x92EB;
		public static const GL_FRAGMENT_SUBROUTINE:int = 0x92EC;
		public static const GL_COMPUTE_SUBROUTINE:int = 0x92ED;
		public static const GL_VERTEX_SUBROUTINE_UNIFORM:int = 0x92EE;
		public static const GL_TESS_CONTROL_SUBROUTINE_UNIFORM:int = 0x92EF;
		public static const GL_TESS_EVALUATION_SUBROUTINE_UNIFORM:int = 0x92F0;
		public static const GL_GEOMETRY_SUBROUTINE_UNIFORM:int = 0x92F1;
		public static const GL_FRAGMENT_SUBROUTINE_UNIFORM:int = 0x92F2;
		public static const GL_COMPUTE_SUBROUTINE_UNIFORM:int = 0x92F3;
		public static const GL_TRANSFORM_FEEDBACK_VARYING:int = 0x92F4;
		public static const GL_ACTIVE_RESOURCES:int = 0x92F5;
		public static const GL_MAX_NAME_LENGTH:int = 0x92F6;
		public static const GL_MAX_NUM_ACTIVE_VARIABLES:int = 0x92F7;
		public static const GL_MAX_NUM_COMPATIBLE_SUBROUTINES:int = 0x92F8;
		public static const GL_NAME_LENGTH:int = 0x92F9;
		public static const GL_TYPE:int = 0x92FA;
		public static const GL_ARRAY_SIZE:int = 0x92FB;
		public static const GL_OFFSET:int = 0x92FC;
		public static const GL_BLOCK_INDEX:int = 0x92FD;
		public static const GL_ARRAY_STRIDE:int = 0x92FE;
		public static const GL_MATRIX_STRIDE:int = 0x92FF;
		public static const GL_IS_ROW_MAJOR:int = 0x9300;
		public static const GL_ATOMIC_COUNTER_BUFFER_INDEX:int = 0x9301;
		public static const GL_BUFFER_BINDING:int = 0x9302;
		public static const GL_BUFFER_DATA_SIZE:int = 0x9303;
		public static const GL_NUM_ACTIVE_VARIABLES:int = 0x9304;
		public static const GL_ACTIVE_VARIABLES:int = 0x9305;
		public static const GL_REFERENCED_BY_VERTEX_SHADER:int = 0x9306;
		public static const GL_REFERENCED_BY_TESS_CONTROL_SHADER:int = 0x9307;
		public static const GL_REFERENCED_BY_TESS_EVALUATION_SHADER:int = 0x9308;
		public static const GL_REFERENCED_BY_GEOMETRY_SHADER:int = 0x9309;
		public static const GL_REFERENCED_BY_FRAGMENT_SHADER:int = 0x930A;
		public static const GL_REFERENCED_BY_COMPUTE_SHADER:int = 0x930B;
		public static const GL_TOP_LEVEL_ARRAY_SIZE:int = 0x930C;
		public static const GL_TOP_LEVEL_ARRAY_STRIDE:int = 0x930D;
		public static const GL_LOCATION:int = 0x930E;
		public static const GL_LOCATION_INDEX:int = 0x930F;
		public static const GL_IS_PER_PATCH:int = 0x92E7;
		public static const GL_SHADER_STORAGE_BUFFER:int = 0x90D2;
		public static const GL_SHADER_STORAGE_BUFFER_BINDING:int = 0x90D3;
		public static const GL_SHADER_STORAGE_BUFFER_START:int = 0x90D4;
		public static const GL_SHADER_STORAGE_BUFFER_SIZE:int = 0x90D5;
		public static const GL_MAX_VERTEX_SHADER_STORAGE_BLOCKS:int = 0x90D6;
		public static const GL_MAX_GEOMETRY_SHADER_STORAGE_BLOCKS:int = 0x90D7;
		public static const GL_MAX_TESS_CONTROL_SHADER_STORAGE_BLOCKS:int = 0x90D8;
		public static const GL_MAX_TESS_EVALUATION_SHADER_STORAGE_BLOCKS:int = 0x90D9;
		public static const GL_MAX_FRAGMENT_SHADER_STORAGE_BLOCKS:int = 0x90DA;
		public static const GL_MAX_COMPUTE_SHADER_STORAGE_BLOCKS:int = 0x90DB;
		public static const GL_MAX_COMBINED_SHADER_STORAGE_BLOCKS:int = 0x90DC;
		public static const GL_MAX_SHADER_STORAGE_BUFFER_BINDINGS:int = 0x90DD;
		public static const GL_MAX_SHADER_STORAGE_BLOCK_SIZE:int = 0x90DE;
		public static const GL_SHADER_STORAGE_BUFFER_OFFSET_ALIGNMENT:int = 0x90DF;
		public static const GL_SHADER_STORAGE_BARRIER_BIT:int = 0x00002000;
		public static const GL_MAX_COMBINED_SHADER_OUTPUT_RESOURCES:int = 0x8F39;
		public static const GL_DEPTH_STENCIL_TEXTURE_MODE:int = 0x90EA;
		public static const GL_TEXTURE_BUFFER_OFFSET:int = 0x919D;
		public static const GL_TEXTURE_BUFFER_SIZE:int = 0x919E;
		public static const GL_TEXTURE_BUFFER_OFFSET_ALIGNMENT:int = 0x919F;
		public static const GL_TEXTURE_VIEW_MIN_LEVEL:int = 0x82DB;
		public static const GL_TEXTURE_VIEW_NUM_LEVELS:int = 0x82DC;
		public static const GL_TEXTURE_VIEW_MIN_LAYER:int = 0x82DD;
		public static const GL_TEXTURE_VIEW_NUM_LAYERS:int = 0x82DE;
		public static const GL_TEXTURE_IMMUTABLE_LEVELS:int = 0x82DF;
		public static const GL_VERTEX_ATTRIB_BINDING:int = 0x82D4;
		public static const GL_VERTEX_ATTRIB_RELATIVE_OFFSET:int = 0x82D5;
		public static const GL_VERTEX_BINDING_DIVISOR:int = 0x82D6;
		public static const GL_VERTEX_BINDING_OFFSET:int = 0x82D7;
		public static const GL_VERTEX_BINDING_STRIDE:int = 0x82D8;
		public static const GL_MAX_VERTEX_ATTRIB_RELATIVE_OFFSET:int = 0x82D9;
		public static const GL_MAX_VERTEX_ATTRIB_BINDINGS:int = 0x82DA;
		public static const GL_VERTEX_BINDING_BUFFER:int = 0x8F4F;
		public static const GL_DISPLAY_LIST:int = 0x82E7;
		public static const GL_STACK_UNDERFLOW:int = 0x0504;
		public static const GL_STACK_OVERFLOW:int = 0x0503;
		public static const GL_MAX_VERTEX_ATTRIB_STRIDE:int = 0x82E5;
		public static const GL_PRIMITIVE_RESTART_FOR_PATCHES_SUPPORTED:int = 0x8221;
		public static const GL_TEXTURE_BUFFER_BINDING:int = 0x8C2A;
		public static const GL_MAP_PERSISTENT_BIT:int = 0x0040;
		public static const GL_MAP_COHERENT_BIT:int = 0x0080;
		public static const GL_DYNAMIC_STORAGE_BIT:int = 0x0100;
		public static const GL_CLIENT_STORAGE_BIT:int = 0x0200;
		public static const GL_CLIENT_MAPPED_BUFFER_BARRIER_BIT:int = 0x00004000;
		public static const GL_BUFFER_IMMUTABLE_STORAGE:int = 0x821F;
		public static const GL_BUFFER_STORAGE_FLAGS:int = 0x8220;
		public static const GL_CLEAR_TEXTURE:int = 0x9365;
		public static const GL_LOCATION_COMPONENT:int = 0x934A;
		public static const GL_TRANSFORM_FEEDBACK_BUFFER_INDEX:int = 0x934B;
		public static const GL_TRANSFORM_FEEDBACK_BUFFER_STRIDE:int = 0x934C;
		public static const GL_QUERY_BUFFER:int = 0x9192;
		public static const GL_QUERY_BUFFER_BARRIER_BIT:int = 0x00008000;
		public static const GL_QUERY_BUFFER_BINDING:int = 0x9193;
		public static const GL_QUERY_RESULT_NO_WAIT:int = 0x9194;
		public static const GL_MIRROR_CLAMP_TO_EDGE:int = 0x8743;
		public static const GL_CONTEXT_LOST:int = 0x0507;
		public static const GL_NEGATIVE_ONE_TO_ONE:int = 0x935E;
		public static const GL_ZERO_TO_ONE:int = 0x935F;
		public static const GL_CLIP_ORIGIN:int = 0x935C;
		public static const GL_CLIP_DEPTH_MODE:int = 0x935D;
		public static const GL_QUERY_WAIT_INVERTED:int = 0x8E17;
		public static const GL_QUERY_NO_WAIT_INVERTED:int = 0x8E18;
		public static const GL_QUERY_BY_REGION_WAIT_INVERTED:int = 0x8E19;
		public static const GL_QUERY_BY_REGION_NO_WAIT_INVERTED:int = 0x8E1A;
		public static const GL_MAX_CULL_DISTANCES:int = 0x82F9;
		public static const GL_MAX_COMBINED_CLIP_AND_CULL_DISTANCES:int = 0x82FA;
		public static const GL_TEXTURE_TARGET:int = 0x1006;
		public static const GL_QUERY_TARGET:int = 0x82EA;
		public static const GL_GUILTY_CONTEXT_RESET:int = 0x8253;
		public static const GL_INNOCENT_CONTEXT_RESET:int = 0x8254;
		public static const GL_UNKNOWN_CONTEXT_RESET:int = 0x8255;
		public static const GL_RESET_NOTIFICATION_STRATEGY:int = 0x8256;
		public static const GL_LOSE_CONTEXT_ON_RESET:int = 0x8252;
		public static const GL_NO_RESET_NOTIFICATION:int = 0x8261;
		public static const GL_CONTEXT_FLAG_ROBUST_ACCESS_BIT:int = 0x00000004;
		public static const GL_COLOR_TABLE:int = 0x80D0;
		public static const GL_POST_CONVOLUTION_COLOR_TABLE:int = 0x80D1;
		public static const GL_POST_COLOR_MATRIX_COLOR_TABLE:int = 0x80D2;
		public static const GL_PROXY_COLOR_TABLE:int = 0x80D3;
		public static const GL_PROXY_POST_CONVOLUTION_COLOR_TABLE:int = 0x80D4;
		public static const GL_PROXY_POST_COLOR_MATRIX_COLOR_TABLE:int = 0x80D5;
		public static const GL_CONVOLUTION_1D:int = 0x8010;
		public static const GL_CONVOLUTION_2D:int = 0x8011;
		public static const GL_SEPARABLE_2D:int = 0x8012;
		public static const GL_HISTOGRAM:int = 0x8024;
		public static const GL_PROXY_HISTOGRAM:int = 0x8025;
		public static const GL_MINMAX:int = 0x802E;
		public static const GL_CONTEXT_RELEASE_BEHAVIOR:int = 0x82FB;
		public static const GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH:int = 0x82FC;
		public static const GL_SHADER_BINARY_FORMAT_SPIR_V:int = 0x9551;
		public static const GL_SPIR_V_BINARY:int = 0x9552;
		public static const GL_PARAMETER_BUFFER:int = 0x80EE;
		public static const GL_PARAMETER_BUFFER_BINDING:int = 0x80EF;
		public static const GL_CONTEXT_FLAG_NO_ERROR_BIT:int = 0x00000008;
		public static const GL_VERTICES_SUBMITTED:int = 0x82EE;
		public static const GL_PRIMITIVES_SUBMITTED:int = 0x82EF;
		public static const GL_VERTEX_SHADER_INVOCATIONS:int = 0x82F0;
		public static const GL_TESS_CONTROL_SHADER_PATCHES:int = 0x82F1;
		public static const GL_TESS_EVALUATION_SHADER_INVOCATIONS:int = 0x82F2;
		public static const GL_GEOMETRY_SHADER_PRIMITIVES_EMITTED:int = 0x82F3;
		public static const GL_FRAGMENT_SHADER_INVOCATIONS:int = 0x82F4;
		public static const GL_COMPUTE_SHADER_INVOCATIONS:int = 0x82F5;
		public static const GL_CLIPPING_INPUT_PRIMITIVES:int = 0x82F6;
		public static const GL_CLIPPING_OUTPUT_PRIMITIVES:int = 0x82F7;
		public static const GL_POLYGON_OFFSET_CLAMP:int = 0x8E1B;
		public static const GL_SPIR_V_EXTENSIONS:int = 0x9553;
		public static const GL_NUM_SPIR_V_EXTENSIONS:int = 0x9554;
		public static const GL_TEXTURE_MAX_ANISOTROPY:int = 0x84FE;
		public static const GL_MAX_TEXTURE_MAX_ANISOTROPY:int = 0x84FF;
		public static const GL_TRANSFORM_FEEDBACK_OVERFLOW:int = 0x82EC;
		
		static private function checkSupported():void
		{
			if (!ANEGLFW.getInstance().isSupported)
			{
				throw Error('ANEGLFW Not Supported');
			}
		}
		
		
		public static function gladLoadGLLoader(procname:String = ""):int
		{
			checkSupported();
			return int(ANEGLFW.getInstance().context.call("gladLoadGLLoader", procname));
		}
		
		public static function glViewport(x:int, y:int, width:int, height:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glViewport", x, y, width, height);
		}
		
		public static function glGenVertexArrays(n:int):int
		{
			checkSupported();
			return int(ANEGLFW.getInstance().context.call("glGenVertexArrays", n));
		}
		
		public static function glBindVertexArray(array:int):int
		{
			checkSupported();
			return int(ANEGLFW.getInstance().context.call("glBindVertexArray", array));
		}
		
		public static function glCreateBuffers(GLsizei:int):int
		{
			checkSupported();
			return int(ANEGLFW.getInstance().context.call("glCreateBuffers", GLsizei));
		}
		
		public static function glDeleteBuffers(GLsizei:int, buffer:uint):int
		{
			checkSupported();
			return int(ANEGLFW.getInstance().context.call("glDeleteBuffers", GLsizei, buffer));
		}
		
		public static function glGenBuffers(GLsizei:int):int
		{
			checkSupported();
			return int(ANEGLFW.getInstance().context.call("glGenBuffers", GLsizei));
		}
		
		public static function glBindBuffer(target:int, buffer:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glBindBuffer", target, buffer);
		}
		
		public static function glBufferData(target:int, dataSize:int, data:Vector.<Number>, buffer:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glBufferData", target, dataSize, data, buffer);
		}
		
		public static function glVertexAttribPointer(index:uint, size:int, type:uint, normalized:Boolean, stride:int, pointer_IntPtr:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glVertexAttribPointer", index, size, type, normalized, stride, pointer_IntPtr);
		}
		
		public static function glEnableVertexAttribArray(index:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glEnableVertexAttribArray", index);
		}
		
		public static function glDisableVertexAttribArray(index:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glDisableVertexAttribArray", index);
		}
		
		public static function glDeleteVertexArrays(n:int, arrays:Vector.<uint>):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glDeleteVertexArrays", n, arrays);
		}
		
		public static function glCreateShader(shader:int):int
		{
			checkSupported();
			return int(ANEGLFW.getInstance().context.call("glCreateShader", shader));
		}
		
		public static function glShaderSource(shader:int, count:int, shaderString:String):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glShaderSource", shader, count, shaderString);
		}
		
		public static function glCompileShader(shader:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glCompileShader", shader);
		}
		
		public static function glDeleteShader(shader:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glDeleteShader", shader);
		}
		
		public static function glCreateProgram():int
		{
			checkSupported();
			return int(ANEGLFW.getInstance().context.call("glCreateProgram"));
		}
		
		public static function glAttachShader(program:int, shader:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glAttachShader", program, shader);
		}
		
		public static function glLinkProgram(program:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glLinkProgram", program);
		}
		
		public static function glUseProgram(program:int):void
	{
		checkSupported();
		ANEGLFW.getInstance().context.call("glUseProgram", program);
	}
	
	public static function glDeleteProgram(program:int):void
	{
		checkSupported();
		ANEGLFW.getInstance().context.call("glDeleteProgram", program);
	}
	
	
	public static function glGenTextures(size:int):int
		{
			checkSupported();
			return int(ANEGLFW.getInstance().context.call("glGenTextures", size));
		}
		public static function glBindTexture(target:int, texture:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glBindTexture", target, texture);
		}
		public static function glTexParameteri(target:int,pname:int,param:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glTexParameteri", target, pname,param);
		}
		
		public static function glTexImage2D(target:int,  level:int,internalformat:int,width:int,height:int,border:int,format:int,type:int,bitmapdataByte:ByteArray):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glTexImage2D", target, level, internalformat, width, height, border, format, type, bitmapdataByte);
		}
		public static function glGenerateMipmap(target:int):int
		{
			checkSupported();
			return int(ANEGLFW.getInstance().context.call("glGenerateMipmap", target));
		}
		
		public static function glActiveTexture(texture:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glActiveTexture", texture);
		}
		
		public static function glDeleteTextures(n:int, textures:uint):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glDeleteTextures", n, textures);
		}
		
		
		
		public static function glGetUniformLocation(program:int, name:String):int
		{
			checkSupported();
			return int(ANEGLFW.getInstance().context.call("glGetUniformLocation", program, name));
		}
		
		public static function glUniform1f(location:int, v0:Number):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glUniform1f", location, v0);
		}
		
		public static function glUniform2f(location:int, v0:Number, v1:Number):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glUniform2f", location, v0, v1);
		}
		
		public static function glUniform3f(location:int, v0:Number, v1:Number, v2:Number):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glUniform3f", location, v0, v1, v2);
		}
		
		public static function glUniform4f(location:int, v0:Number, v1:Number, v2:Number, v3:Number):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glUniform4f", location, v0, v1, v2, v3);
		}
		
		public static function glUniform1i(location:int, v0:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glUniform1i", location, v0);
		}
		
		public static function glUniformMatrix4fv(location:int, count:Number, transpose:int, matrix3D:Matrix3D = null):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glUniformMatrix4fv", location, count, transpose, matrix3D);
		}
		
		public static function glfwGetTime():Number
		{
			checkSupported();
			return Number(ANEGLFW.getInstance().context.call("glfwGetTime"));
		}
		
		public static function glDrawArrays(mode:int, first:int, count:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glDrawArrays", mode, first, count);
		}
		
		public static function glDrawElements(mode:int, count:int, type:int, indicesPtr:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glDrawElements", mode, count, type, indicesPtr);
		}
		
		public static function glClearColor(red:Number, green:Number, blue:Number, alpha:Number = 1):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glClearColor", red, green, blue, alpha);
		}
		
		public static function glClear(mask:uint):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glClear", mask);
		}
		
		public static function glPolygonMode(face:int, mode:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glPolygonMode", face, mode);
		}
		
		public static function glPointSize(size:Number):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glPointSize", size);
		}
		public static function glCullFace(mode:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glCullFace", mode);
		}
		public static function glEnable(cap:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glEnable", cap);
		}
		
		public static function glDisable(cap:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glDisable", cap);
		}
		
		public static function glBlendFunc(sfactor:int, dfactor:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glBlendFunc", sfactor, dfactor);
		}
		
		public static function glClearDepth(depth:Number):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glClearDepth", depth);
		}
		
		public static function glDepthFunc(func:int):void
		{
			checkSupported();
			ANEGLFW.getInstance().context.call("glDepthFunc", func);
		}
	}

}