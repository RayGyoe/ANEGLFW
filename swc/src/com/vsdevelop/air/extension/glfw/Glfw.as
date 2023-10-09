package com.vsdevelop.air.extension.glfw
{
	
	/**
	 * ...
	 * @author Ray.lei
	 */
	public final class Glfw
	{
		public static const GLFW_VERSION_MAJOR:int = 3;
		public static const GLFW_VERSION_MINOR:int = 3;
		public static const GLFW_VERSION_REVISION:int = 4;
		public static const GLFW_TRUE:int = 1;
		public static const GLFW_FALSE:int = 0;
		public static const GLFW_RELEASE:int = 0;
		public static const GLFW_PRESS:int = 1;
		public static const GLFW_REPEAT:int = 2;
		public static const GLFW_HAT_CENTERED:int = 0;
		public static const GLFW_HAT_UP:int = 1;
		public static const GLFW_HAT_RIGHT:int = 2;
		public static const GLFW_HAT_DOWN:int = 4;
		public static const GLFW_HAT_LEFT:int = 8;
		public static const GLFW_HAT_RIGHT_UP:int = (GLFW_HAT_RIGHT | GLFW_HAT_UP);
		public static const GLFW_HAT_RIGHT_DOWN:int = (GLFW_HAT_RIGHT | GLFW_HAT_DOWN);
		public static const GLFW_HAT_LEFT_UP:int = (GLFW_HAT_LEFT | GLFW_HAT_UP);
		public static const GLFW_HAT_LEFT_DOWN:int = (GLFW_HAT_LEFT | GLFW_HAT_DOWN);
		public static const GLFW_KEY_UNKNOWN:int = -1;
		public static const GLFW_KEY_SPACE:int = 32;
		public static const GLFW_KEY_APOSTROPHE:int = 39;
		public static const GLFW_KEY_COMMA:int = 44;
		public static const GLFW_KEY_MINUS:int = 45;
		public static const GLFW_KEY_PERIOD:int = 46;
		public static const GLFW_KEY_SLASH:int = 47;
		public static const GLFW_KEY_0:int = 48;
		public static const GLFW_KEY_1:int = 49;
		public static const GLFW_KEY_2:int = 50;
		public static const GLFW_KEY_3:int = 51;
		public static const GLFW_KEY_4:int = 52;
		public static const GLFW_KEY_5:int = 53;
		public static const GLFW_KEY_6:int = 54;
		public static const GLFW_KEY_7:int = 55;
		public static const GLFW_KEY_8:int = 56;
		public static const GLFW_KEY_9:int = 57;
		public static const GLFW_KEY_SEMICOLON:int = 59;
		public static const GLFW_KEY_EQUAL:int = 61;
		public static const GLFW_KEY_A:int = 65;
		public static const GLFW_KEY_B:int = 66;
		public static const GLFW_KEY_C:int = 67;
		public static const GLFW_KEY_D:int = 68;
		public static const GLFW_KEY_E:int = 69;
		public static const GLFW_KEY_F:int = 70;
		public static const GLFW_KEY_G:int = 71;
		public static const GLFW_KEY_H:int = 72;
		public static const GLFW_KEY_I:int = 73;
		public static const GLFW_KEY_J:int = 74;
		public static const GLFW_KEY_K:int = 75;
		public static const GLFW_KEY_L:int = 76;
		public static const GLFW_KEY_M:int = 77;
		public static const GLFW_KEY_N:int = 78;
		public static const GLFW_KEY_O:int = 79;
		public static const GLFW_KEY_P:int = 80;
		public static const GLFW_KEY_Q:int = 81;
		public static const GLFW_KEY_R:int = 82;
		public static const GLFW_KEY_S:int = 83;
		public static const GLFW_KEY_T:int = 84;
		public static const GLFW_KEY_U:int = 85;
		public static const GLFW_KEY_V:int = 86;
		public static const GLFW_KEY_W:int = 87;
		public static const GLFW_KEY_X:int = 88;
		public static const GLFW_KEY_Y:int = 89;
		public static const GLFW_KEY_Z:int = 90;
		public static const GLFW_KEY_LEFT_BRACKET:int = 91;
		public static const GLFW_KEY_BACKSLASH:int = 92;
		public static const GLFW_KEY_RIGHT_BRACKET:int = 93;
		public static const GLFW_KEY_GRAVE_ACCENT:int = 96;
		public static const GLFW_KEY_WORLD_1:int = 161;
		public static const GLFW_KEY_WORLD_2:int = 162;
		public static const GLFW_KEY_ESCAPE:int = 256;
		public static const GLFW_KEY_ENTER:int = 257;
		public static const GLFW_KEY_TAB:int = 258;
		public static const GLFW_KEY_BACKSPACE:int = 259;
		public static const GLFW_KEY_INSERT:int = 260;
		public static const GLFW_KEY_DELETE:int = 261;
		public static const GLFW_KEY_RIGHT:int = 262;
		public static const GLFW_KEY_LEFT:int = 263;
		public static const GLFW_KEY_DOWN:int = 264;
		public static const GLFW_KEY_UP:int = 265;
		public static const GLFW_KEY_PAGE_UP:int = 266;
		public static const GLFW_KEY_PAGE_DOWN:int = 267;
		public static const GLFW_KEY_HOME:int = 268;
		public static const GLFW_KEY_END:int = 269;
		public static const GLFW_KEY_CAPS_LOCK:int = 280;
		public static const GLFW_KEY_SCROLL_LOCK:int = 281;
		public static const GLFW_KEY_NUM_LOCK:int = 282;
		public static const GLFW_KEY_PRINT_SCREEN:int = 283;
		public static const GLFW_KEY_PAUSE:int = 284;
		public static const GLFW_KEY_F1:int = 290;
		public static const GLFW_KEY_F2:int = 291;
		public static const GLFW_KEY_F3:int = 292;
		public static const GLFW_KEY_F4:int = 293;
		public static const GLFW_KEY_F5:int = 294;
		public static const GLFW_KEY_F6:int = 295;
		public static const GLFW_KEY_F7:int = 296;
		public static const GLFW_KEY_F8:int = 297;
		public static const GLFW_KEY_F9:int = 298;
		public static const GLFW_KEY_F10:int = 299;
		public static const GLFW_KEY_F11:int = 300;
		public static const GLFW_KEY_F12:int = 301;
		public static const GLFW_KEY_F13:int = 302;
		public static const GLFW_KEY_F14:int = 303;
		public static const GLFW_KEY_F15:int = 304;
		public static const GLFW_KEY_F16:int = 305;
		public static const GLFW_KEY_F17:int = 306;
		public static const GLFW_KEY_F18:int = 307;
		public static const GLFW_KEY_F19:int = 308;
		public static const GLFW_KEY_F20:int = 309;
		public static const GLFW_KEY_F21:int = 310;
		public static const GLFW_KEY_F22:int = 311;
		public static const GLFW_KEY_F23:int = 312;
		public static const GLFW_KEY_F24:int = 313;
		public static const GLFW_KEY_F25:int = 314;
		public static const GLFW_KEY_KP_0:int = 320;
		public static const GLFW_KEY_KP_1:int = 321;
		public static const GLFW_KEY_KP_2:int = 322;
		public static const GLFW_KEY_KP_3:int = 323;
		public static const GLFW_KEY_KP_4:int = 324;
		public static const GLFW_KEY_KP_5:int = 325;
		public static const GLFW_KEY_KP_6:int = 326;
		public static const GLFW_KEY_KP_7:int = 327;
		public static const GLFW_KEY_KP_8:int = 328;
		public static const GLFW_KEY_KP_9:int = 329;
		public static const GLFW_KEY_KP_DECIMAL:int = 330;
		public static const GLFW_KEY_KP_DIVIDE:int = 331;
		public static const GLFW_KEY_KP_MULTIPLY:int = 332;
		public static const GLFW_KEY_KP_SUBTRACT:int = 333;
		public static const GLFW_KEY_KP_ADD:int = 334;
		public static const GLFW_KEY_KP_ENTER:int = 335;
		public static const GLFW_KEY_KP_EQUAL:int = 336;
		public static const GLFW_KEY_LEFT_SHIFT:int = 340;
		public static const GLFW_KEY_LEFT_CONTROL:int = 341;
		public static const GLFW_KEY_LEFT_ALT:int = 342;
		public static const GLFW_KEY_LEFT_SUPER:int = 343;
		public static const GLFW_KEY_RIGHT_SHIFT:int = 344;
		public static const GLFW_KEY_RIGHT_CONTROL:int = 345;
		public static const GLFW_KEY_RIGHT_ALT:int = 346;
		public static const GLFW_KEY_RIGHT_SUPER:int = 347;
		public static const GLFW_KEY_MENU:int = 348;
		public static const GLFW_KEY_LAST:int = GLFW_KEY_MENU;
		public static const GLFW_MOD_SHIFT:int = 0x0001;
		public static const GLFW_MOD_CONTROL:int = 0x0002;
		public static const GLFW_MOD_ALT:int = 0x0004;
		public static const GLFW_MOD_SUPER:int = 0x0008;
		public static const GLFW_MOD_CAPS_LOCK:int = 0x0010;
		public static const GLFW_MOD_NUM_LOCK:int = 0x0020;
		public static const GLFW_MOUSE_BUTTON_1:int = 0;
		public static const GLFW_MOUSE_BUTTON_2:int = 1;
		public static const GLFW_MOUSE_BUTTON_3:int = 2;
		public static const GLFW_MOUSE_BUTTON_4:int = 3;
		public static const GLFW_MOUSE_BUTTON_5:int = 4;
		public static const GLFW_MOUSE_BUTTON_6:int = 5;
		public static const GLFW_MOUSE_BUTTON_7:int = 6;
		public static const GLFW_MOUSE_BUTTON_8:int = 7;
		public static const GLFW_MOUSE_BUTTON_LAST:int = GLFW_MOUSE_BUTTON_8;
		public static const GLFW_MOUSE_BUTTON_LEFT:int = GLFW_MOUSE_BUTTON_1;
		public static const GLFW_MOUSE_BUTTON_RIGHT:int = GLFW_MOUSE_BUTTON_2;
		public static const GLFW_MOUSE_BUTTON_MIDDLE:int = GLFW_MOUSE_BUTTON_3;
		public static const GLFW_JOYSTICK_1:int = 0;
		public static const GLFW_JOYSTICK_2:int = 1;
		public static const GLFW_JOYSTICK_3:int = 2;
		public static const GLFW_JOYSTICK_4:int = 3;
		public static const GLFW_JOYSTICK_5:int = 4;
		public static const GLFW_JOYSTICK_6:int = 5;
		public static const GLFW_JOYSTICK_7:int = 6;
		public static const GLFW_JOYSTICK_8:int = 7;
		public static const GLFW_JOYSTICK_9:int = 8;
		public static const GLFW_JOYSTICK_10:int = 9;
		public static const GLFW_JOYSTICK_11:int = 10;
		public static const GLFW_JOYSTICK_12:int = 11;
		public static const GLFW_JOYSTICK_13:int = 12;
		public static const GLFW_JOYSTICK_14:int = 13;
		public static const GLFW_JOYSTICK_15:int = 14;
		public static const GLFW_JOYSTICK_16:int = 15;
		public static const GLFW_JOYSTICK_LAST:int = GLFW_JOYSTICK_16;
		public static const GLFW_GAMEPAD_BUTTON_A:int = 0;
		public static const GLFW_GAMEPAD_BUTTON_B:int = 1;
		public static const GLFW_GAMEPAD_BUTTON_X:int = 2;
		public static const GLFW_GAMEPAD_BUTTON_Y:int = 3;
		public static const GLFW_GAMEPAD_BUTTON_LEFT_BUMPER:int = 4;
		public static const GLFW_GAMEPAD_BUTTON_RIGHT_BUMPER:int = 5;
		public static const GLFW_GAMEPAD_BUTTON_BACK:int = 6;
		public static const GLFW_GAMEPAD_BUTTON_START:int = 7;
		public static const GLFW_GAMEPAD_BUTTON_GUIDE:int = 8;
		public static const GLFW_GAMEPAD_BUTTON_LEFT_THUMB:int = 9;
		public static const GLFW_GAMEPAD_BUTTON_RIGHT_THUMB:int = 10;
		public static const GLFW_GAMEPAD_BUTTON_DPAD_UP:int = 11;
		public static const GLFW_GAMEPAD_BUTTON_DPAD_RIGHT:int = 12;
		public static const GLFW_GAMEPAD_BUTTON_DPAD_DOWN:int = 13;
		public static const GLFW_GAMEPAD_BUTTON_DPAD_LEFT:int = 14;
		public static const GLFW_GAMEPAD_BUTTON_LAST:int = GLFW_GAMEPAD_BUTTON_DPAD_LEFT;
		public static const GLFW_GAMEPAD_BUTTON_CROSS:int = GLFW_GAMEPAD_BUTTON_A;
		public static const GLFW_GAMEPAD_BUTTON_CIRCLE:int = GLFW_GAMEPAD_BUTTON_B;
		public static const GLFW_GAMEPAD_BUTTON_SQUARE:int = GLFW_GAMEPAD_BUTTON_X;
		public static const GLFW_GAMEPAD_BUTTON_TRIANGLE:int = GLFW_GAMEPAD_BUTTON_Y;
		public static const GLFW_GAMEPAD_AXIS_LEFT_X:int = 0;
		public static const GLFW_GAMEPAD_AXIS_LEFT_Y:int = 1;
		public static const GLFW_GAMEPAD_AXIS_RIGHT_X:int = 2;
		public static const GLFW_GAMEPAD_AXIS_RIGHT_Y:int = 3;
		public static const GLFW_GAMEPAD_AXIS_LEFT_TRIGGER:int = 4;
		public static const GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER:int = 5;
		public static const GLFW_GAMEPAD_AXIS_LAST:int = GLFW_GAMEPAD_AXIS_RIGHT_TRIGGER;
		public static const GLFW_NO_ERROR:int = 0;
		public static const GLFW_NOT_INITIALIZED:int = 0x00010001;
		public static const GLFW_NO_CURRENT_CONTEXT:int = 0x00010002;
		public static const GLFW_INVALID_ENUM:int = 0x00010003;
		public static const GLFW_INVALID_VALUE:int = 0x00010004;
		public static const GLFW_OUT_OF_MEMORY:int = 0x00010005;
		public static const GLFW_API_UNAVAILABLE:int = 0x00010006;
		public static const GLFW_VERSION_UNAVAILABLE:int = 0x00010007;
		public static const GLFW_PLATFORM_ERROR:int = 0x00010008;
		public static const GLFW_FORMAT_UNAVAILABLE:int = 0x00010009;
		public static const GLFW_NO_WINDOW_CONTEXT:int = 0x0001000A;
		public static const GLFW_FOCUSED:int = 0x00020001;
		public static const GLFW_ICONIFIED:int = 0x00020002;
		public static const GLFW_RESIZABLE:int = 0x00020003;
		public static const GLFW_VISIBLE:int = 0x00020004;
		public static const GLFW_DECORATED:int = 0x00020005;
		public static const GLFW_AUTO_ICONIFY:int = 0x00020006;
		public static const GLFW_FLOATING:int = 0x00020007;
		public static const GLFW_MAXIMIZED:int = 0x00020008;
		public static const GLFW_CENTER_CURSOR:int = 0x00020009;
		public static const GLFW_TRANSPARENT_FRAMEBUFFER:int = 0x0002000A;
		public static const GLFW_HOVERED:int = 0x0002000B;
		public static const GLFW_FOCUS_ON_SHOW:int = 0x0002000C;
		public static const GLFW_RED_BITS:int = 0x00021001;
		public static const GLFW_GREEN_BITS:int = 0x00021002;
		public static const GLFW_BLUE_BITS:int = 0x00021003;
		public static const GLFW_ALPHA_BITS:int = 0x00021004;
		public static const GLFW_DEPTH_BITS:int = 0x00021005;
		public static const GLFW_STENCIL_BITS:int = 0x00021006;
		public static const GLFW_ACCUM_RED_BITS:int = 0x00021007;
		public static const GLFW_ACCUM_GREEN_BITS:int = 0x00021008;
		public static const GLFW_ACCUM_BLUE_BITS:int = 0x00021009;
		public static const GLFW_ACCUM_ALPHA_BITS:int = 0x0002100A;
		public static const GLFW_AUX_BUFFERS:int = 0x0002100B;
		public static const GLFW_STEREO:int = 0x0002100C;
		public static const GLFW_SAMPLES:int = 0x0002100D;
		public static const GLFW_SRGB_CAPABLE:int = 0x0002100E;
		public static const GLFW_REFRESH_RATE:int = 0x0002100F;
		public static const GLFW_DOUBLEBUFFER:int = 0x00021010;
		public static const GLFW_CLIENT_API:int = 0x00022001;
		public static const GLFW_CONTEXT_VERSION_MAJOR:int = 0x00022002;
		public static const GLFW_CONTEXT_VERSION_MINOR:int = 0x00022003;
		public static const GLFW_CONTEXT_REVISION:int = 0x00022004;
		public static const GLFW_CONTEXT_ROBUSTNESS:int = 0x00022005;
		public static const GLFW_OPENGL_FORWARD_COMPAT:int = 0x00022006;
		public static const GLFW_OPENGL_DEBUG_CONTEXT:int = 0x00022007;
		public static const GLFW_OPENGL_PROFILE:int = 0x00022008;
		public static const GLFW_CONTEXT_RELEASE_BEHAVIOR:int = 0x00022009;
		public static const GLFW_CONTEXT_NO_ERROR:int = 0x0002200A;
		public static const GLFW_CONTEXT_CREATION_API:int = 0x0002200B;
		public static const GLFW_SCALE_TO_MONITOR:int = 0x0002200C;
		public static const GLFW_COCOA_RETINA_FRAMEBUFFER:int = 0x00023001;
		public static const GLFW_COCOA_FRAME_NAME:int = 0x00023002;
		public static const GLFW_COCOA_GRAPHICS_SWITCHING:int = 0x00023003;
		public static const GLFW_X11_CLASS_NAME:int = 0x00024001;
		public static const GLFW_X11_INSTANCE_NAME:int = 0x00024002;
		public static const GLFW_NO_API:int = 0;
		public static const GLFW_OPENGL_API:int = 0x00030001;
		public static const GLFW_OPENGL_ES_API:int = 0x00030002;
		public static const GLFW_NO_ROBUSTNESS:int = 0;
		public static const GLFW_NO_RESET_NOTIFICATION:int = 0x00031001;
		public static const GLFW_LOSE_CONTEXT_ON_RESET:int = 0x00031002;
		public static const GLFW_OPENGL_ANY_PROFILE:int = 0;
		public static const GLFW_OPENGL_CORE_PROFILE:int = 0x00032001;
		public static const GLFW_OPENGL_COMPAT_PROFILE:int = 0x00032002;
		public static const GLFW_CURSOR:int = 0x00033001;
		public static const GLFW_STICKY_KEYS:int = 0x00033002;
		public static const GLFW_STICKY_MOUSE_BUTTONS:int = 0x00033003;
		public static const GLFW_LOCK_KEY_MODS:int = 0x00033004;
		public static const GLFW_RAW_MOUSE_MOTION:int = 0x00033005;
		public static const GLFW_CURSOR_NORMAL:int = 0x00034001;
		public static const GLFW_CURSOR_HIDDEN:int = 0x00034002;
		public static const GLFW_CURSOR_DISABLED:int = 0x00034003;
		public static const GLFW_ANY_RELEASE_BEHAVIOR:int = 0;
		public static const GLFW_RELEASE_BEHAVIOR_FLUSH:int = 0x00035001;
		public static const GLFW_RELEASE_BEHAVIOR_NONE:int = 0x00035002;
		public static const GLFW_NATIVE_CONTEXT_API:int = 0x00036001;
		public static const GLFW_EGL_CONTEXT_API:int = 0x00036002;
		public static const GLFW_OSMESA_CONTEXT_API:int = 0x00036003;
		public static const GLFW_ARROW_CURSOR:int = 0x00036001;
		public static const GLFW_IBEAM_CURSOR:int = 0x00036002;
		public static const GLFW_CROSSHAIR_CURSOR:int = 0x00036003;
		public static const GLFW_HAND_CURSOR:int = 0x00036004;
		public static const GLFW_HRESIZE_CURSOR:int = 0x00036005;
		public static const GLFW_VRESIZE_CURSOR:int = 0x00036006;
		public static const GLFW_CONNECTED:int = 0x00040001;
		public static const GLFW_DISCONNECTED:int = 0x00040002;
		public static const GLFW_JOYSTICK_HAT_BUTTONS:int = 0x00050001;
		public static const GLFW_COCOA_CHDIR_RESOURCES:int = 0x00051001;
		public static const GLFW_COCOA_MENUBAR:int = 0x00051002;
		
		
				
		/*! @brief Initializes the GLFW library.
		 *
		 *  This function initializes the GLFW library.  Before most GLFW functions can
		 *  be used, GLFW must be initialized, and before an application terminates GLFW
		 *  should be terminated in order to free any resources allocated during or
		 *  after initialization.
		 *
		 *  If this function fails, it calls @ref glfwTerminate before returning.  If it
		 *  succeeds, you should call @ref glfwTerminate before the application exits.
		 *
		 *  Additional calls to this function after successful initialization but before
		 *  termination will return `GLFW_TRUE` immediately.
		 *
		 *  @return `GLFW_TRUE` if successful, or `GLFW_FALSE` if an
		 *  [error](@ref error_handling) occurred.
		 *
		 *  @errors Possible errors include @ref GLFW_PLATFORM_ERROR.
		 *
		 *  @remark @macos This function will change the current directory of the
		 *  application to the `Contents/Resources` subdirectory of the application's
		 *  bundle, if present.  This can be disabled with the @ref
		 *  GLFW_COCOA_CHDIR_RESOURCES init hint.
		 *
		 *  @remark @x11 This function will set the `LC_CTYPE` category of the
		 *  application locale according to the current environment if that category is
		 *  still "C".  This is because the "C" locale breaks Unicode text input.
		 *
		 *  @thread_safety This function must only be called from the main thread.
		 *
		 *  @sa @ref intro_init
		 *  @sa @ref glfwTerminate
		 *
		 *  @since Added in version 1.0.
		 *
		 *  @ingroup init
		 */
		public static function glfwInit():int
		{
			if (!ANEGLFW.getInstance().isSupported)
			{
				throw Error('ANEGLFW Not Supported');
			}
			return int(ANEGLFW.getInstance().context.call("glfwInit"));
		}
		
		
				
		/*! @brief Terminates the GLFW library.
		 *
		 *  This function destroys all remaining windows and cursors, restores any
		 *  modified gamma ramps and frees any other allocated resources.  Once this
		 *  function is called, you must again call @ref glfwInit successfully before
		 *  you will be able to use most GLFW functions.
		 *
		 *  If GLFW has been successfully initialized, this function should be called
		 *  before the application exits.  If initialization fails, there is no need to
		 *  call this function, as it is called by @ref glfwInit before it returns
		 *  failure.
		 *
		 *  This function has no effect if GLFW is not initialized.
		 *
		 *  @errors Possible errors include @ref GLFW_PLATFORM_ERROR.
		 *
		 *  @remark This function may be called before @ref glfwInit.
		 *
		 *  @warning The contexts of any remaining windows must not be current on any
		 *  other thread when this function is called.
		 *
		 *  @reentrancy This function must not be called from a callback.
		 *
		 *  @thread_safety This function must only be called from the main thread.
		 *
		 *  @sa @ref intro_init
		 *  @sa @ref glfwInit
		 *
		 *  @since Added in version 1.0.
		 *
		 *  @ingroup init
		 */
		public static function glfwTerminate():void
		{
			if (!ANEGLFW.getInstance().isSupported)
			{
				throw Error('ANEGLFW Not Supported');
			}
			ANEGLFW.getInstance().context.call("glfwTerminate");
		}
	
		
		
		/*! @brief Sets the specified window hint to the desired value.
		 *
		 *  This function sets hints for the next call to @ref glfwCreateWindow.  The
		 *  hints, once set, retain their values until changed by a call to this
		 *  function or @ref glfwDefaultWindowHints, or until the library is terminated.
		 *
		 *  Only integer value hints can be set with this function.  String value hints
		 *  are set with @ref glfwWindowHintString.
		 *
		 *  This function does not check whether the specified hint values are valid.
		 *  If you set hints to invalid values this will instead be reported by the next
		 *  call to @ref glfwCreateWindow.
		 *
		 *  Some hints are platform specific.  These may be set on any platform but they
		 *  will only affect their specific platform.  Other platforms will ignore them.
		 *  Setting these hints requires no platform specific headers or functions.
		 *
		 *  @param[in] hint The [window hint](@ref window_hints) to set.
		 *  @param[in] value The new value of the window hint.
		 *
		 *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
		 *  GLFW_INVALID_ENUM.
		 *
		 *  @thread_safety This function must only be called from the main thread.
		 *
		 *  @sa @ref window_hints
		 *  @sa @ref glfwWindowHintString
		 *  @sa @ref glfwDefaultWindowHints
		 *
		 *  @since Added in version 3.0.  Replaces `glfwOpenWindowHint`.
		 *
		 *  @ingroup window
		 */
		public static function glfwWindowHint(hint:int,value:int):void
		{
			if (!ANEGLFW.getInstance().isSupported)
			{
				throw Error('ANEGLFW Not Supported');
			}
			ANEGLFW.getInstance().context.call("glfwWindowHint", hint, value);
		}
		
		
				
		/*! @brief Checks the close flag of the specified window.
		 *
		 *  This function returns the value of the close flag of the specified window.
		 *
		 *  @param[in] window The window to query.
		 *  @return The value of the close flag.
		 *
		 *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
		 *
		 *  @thread_safety This function may be called from any thread.  Access is not
		 *  synchronized.
		 *
		 *  @sa @ref window_close
		 *
		 *  @since Added in version 3.0.
		 *
		 *  @ingroup window
		 */
		public static function glfwWindowShouldClose(window_IntPtr:int):int{
			if (!ANEGLFW.getInstance().isSupported)
			{
				throw Error('ANEGLFW Not Supported');
			}
			return int(ANEGLFW.getInstance().context.call("glfwWindowShouldClose", window_IntPtr));
		}
		
		
				
		/*! @brief Sets the close flag of the specified window.
		 *
		 *  This function sets the value of the close flag of the specified window.
		 *  This can be used to override the user's attempt to close the window, or
		 *  to signal that it should be closed.
		 *
		 *  @param[in] window The window whose flag to change.
		 *  @param[in] value The new value.
		 *
		 *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED.
		 *
		 *  @thread_safety This function may be called from any thread.  Access is not
		 *  synchronized.
		 *
		 *  @sa @ref window_close
		 *
		 *  @since Added in version 3.0.
		 *
		 *  @ingroup window
		 */
		public static function glfwSetWindowShouldClose(window_IntPtr:int,value:Boolean = false):void
		{
			if (!ANEGLFW.getInstance().isSupported)
			{
				throw Error('ANEGLFW Not Supported');
			}
			ANEGLFW.getInstance().context.call("glfwSetWindowShouldClose", window_IntPtr, value?1:0);
		}
		
		
		
		/*! @brief Swaps the front and back buffers of the specified window.
		 *
		 *  This function swaps the front and back buffers of the specified window when
		 *  rendering with OpenGL or OpenGL ES.  If the swap interval is greater than
		 *  zero, the GPU driver waits the specified number of screen updates before
		 *  swapping the buffers.
		 *
		 *  The specified window must have an OpenGL or OpenGL ES context.  Specifying
		 *  a window without a context will generate a @ref GLFW_NO_WINDOW_CONTEXT
		 *  error.
		 *
		 *  This function does not apply to Vulkan.  If you are rendering with Vulkan,
		 *  see `vkQueuePresentKHR` instead.
		 *
		 *  @param[in] window The window whose buffers to swap.
		 *
		 *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED, @ref
		 *  GLFW_NO_WINDOW_CONTEXT and @ref GLFW_PLATFORM_ERROR.
		 *
		 *  @remark __EGL:__ The context of the specified window must be current on the
		 *  calling thread.
		 *
		 *  @thread_safety This function may be called from any thread.
		 *
		 *  @sa @ref buffer_swap
		 *  @sa @ref glfwSwapInterval
		 *
		 *  @since Added in version 1.0.
		 *  @glfw3 Added window handle parameter.
		 *
		 *  @ingroup window
		 */
		public static function glfwSwapBuffers(window_IntPtr:int):void
		{
			if (!ANEGLFW.getInstance().isSupported)
			{
				throw Error('ANEGLFW Not Supported');
			}
			ANEGLFW.getInstance().context.call("glfwSwapBuffers", window_IntPtr);
		}
		
		
		
		/*! @brief Processes all pending events.
		 *
		 *  This function processes only those events that are already in the event
		 *  queue and then returns immediately.  Processing events will cause the window
		 *  and input callbacks associated with those events to be called.
		 *
		 *  On some platforms, a window move, resize or menu operation will cause event
		 *  processing to block.  This is due to how event processing is designed on
		 *  those platforms.  You can use the
		 *  [window refresh callback](@ref window_refresh) to redraw the contents of
		 *  your window when necessary during such operations.
		 *
		 *  Do not assume that callbacks you set will _only_ be called in response to
		 *  event processing functions like this one.  While it is necessary to poll for
		 *  events, window systems that require GLFW to register callbacks of its own
		 *  can pass events to GLFW in response to many window system function calls.
		 *  GLFW will pass those events on to the application callbacks before
		 *  returning.
		 *
		 *  Event processing is not required for joystick input to work.
		 *
		 *  @errors Possible errors include @ref GLFW_NOT_INITIALIZED and @ref
		 *  GLFW_PLATFORM_ERROR.
		 *
		 *  @reentrancy This function must not be called from a callback.
		 *
		 *  @thread_safety This function must only be called from the main thread.
		 *
		 *  @sa @ref events
		 *  @sa @ref glfwWaitEvents
		 *  @sa @ref glfwWaitEventsTimeout
		 *
		 *  @since Added in version 1.0.
		 *
		 *  @ingroup window
		 */
		public static function glfwPollEvents():void
		{
			if (!ANEGLFW.getInstance().isSupported)
			{
				throw Error('ANEGLFW Not Supported');
			}
			ANEGLFW.getInstance().context.call("glfwPollEvents");
		}
		
		
	}

}