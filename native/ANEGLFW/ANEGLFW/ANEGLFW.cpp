// ANEGLFW.cpp : ���� DLL Ӧ�ó���ĵ���������
//
#include "ANEGLFW.h"

extern "C" {

	const char* TAG = "ANEGLFW";

	ANEUtils* ANEutils = new ANEUtils();

	bool debug = false;


	std::string FGS = "||";
	FREContext ctxContext;
	/*
	��ʼ��
	*/
	FREObject isSupported(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		printf("\n%s %s", TAG, "isSupport");
		return ANEutils->AS_Boolean(true);
	}

	FREObject isDeBug(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		debug = ANEutils->getBool(argv[0]);
		printf("\n%s %s  %d", TAG, "isDeBug",debug);
		return NULL;
	}


	FREObject ANE_AIRWindowHwnd(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int hwnd = 0;
		FRENativeWindow nativeWindow;
		FREObject window = argv[0];
		FREResult ret = FREAcquireNativeWindowHandle(window, &nativeWindow);
		if (ret == FRE_OK) {
			hwnd = (int)nativeWindow;
			FREReleaseNativeWindowHandle(window);
		}
		return ANEutils->AS_int(hwnd);
	}

	FREObject ANE_SetParent(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int hwnd = ANEutils->getInt32(argv[0]);
		int phwnd = ANEutils->getInt32(argv[1]);
		printf("\n%s %s  %d  %d", TAG, "ANE_SetParent", hwnd, phwnd);
		SetParent((HWND)hwnd, (HWND)phwnd);
		return NULL;
	}


	FREObject ANE_openGLToNativeWindow(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		HWND hwNative = (HWND)ANEutils->getInt32(argv[0]);

		FRENativeWindow nativeWindow;
		FREObject window = argv[1];
		FREResult ret = FREAcquireNativeWindowHandle(window, &nativeWindow);
		if (ret == FRE_OK) {
			SetParent(hwNative, nativeWindow);
			FREReleaseNativeWindowHandle(window);

			long style = GetWindowLong(hwNative, GWL_STYLE);
			style &= ~WS_POPUP; // remove popup style
			style |= WS_CHILDWINDOW; // add childwindow style
			SetWindowLong(hwNative, GWL_STYLE, style);

			ShowWindow(hwNative, SW_SHOW);
		}

		return NULL;
	}
	


	///--GLFW----------------------------------------------------------------------------------------------

	
	FREObject ANE_glfwGetVersionString(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		if (debug)printf("\n%s %s", TAG, "glfwGetVersionString");
		return ANEutils->AS_String(glfwGetVersionString());
	}


	FREObject ANE_glfwSetErrorCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		std::string funName = ANEutils->getString(argv[0]);
		if (debug)printf("\n%s %s  %s  ", TAG, "ANE_glfwSetErrorCallback", funName.c_str());

		if (funName.length()) {
			glfwSetErrorCallback([](int error_code, const char* description)
				{
					ANEutils->dispatchEvent("ErrorCallback", std::to_string(error_code) + FGS + std::string(description));
				});
		}
		else {
			glfwSetErrorCallback(NULL);
		}
		return NULL;
	}
	

	FREObject ANE_glfwInit(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		if (debug)printf("\n%s %s", TAG, "ANE_glfwInit");
		return ANEutils->AS_int(glfwInit());
	}


	FREObject ANE_glfwTerminate(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		if (debug)printf("\n%s %s", TAG, "ANE_glfwTerminate");
		glfwTerminate();
		return NULL;
	}
	


	FREObject ANE_glfwWindowHint(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int hint = ANEutils->getInt32(argv[0]);
		int value= ANEutils->getInt32(argv[1]);

		if (debug)printf("\n%s %s  %d = %d", TAG, "ANE_glfwWindowHint", hint,value);

		glfwWindowHint(hint, value);
		return NULL;
	}
	



	FREObject ANE_glfwCreateWindow(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int width = ANEutils->getInt32(argv[0]);
		int height = ANEutils->getInt32(argv[1]);
		std::string title = ANEutils->getString(argv[2]);

		int monitor_IntPtr = ANEutils->getInt32(argv[3]);
		int window_share_IntPtr = ANEutils->getInt32(argv[4]);

		if (debug)printf("\n%s %s  %d  %d   %s   %d %d", TAG, "ANE_glfwCreateWindow", width, width, title.c_str(), monitor_IntPtr,window_share_IntPtr);


		GLFWmonitor* monitor = nullptr;
		GLFWwindow * share = nullptr;

		if (monitor_IntPtr) {
			monitor = reinterpret_cast<GLFWmonitor*>((uintptr_t)monitor_IntPtr);
		}
		if (window_share_IntPtr) {
			share = reinterpret_cast<GLFWwindow*>((uintptr_t)window_share_IntPtr);
		}

		GLFWwindow* window = glfwCreateWindow(width, height, title.c_str(), monitor, share);
		if (!window)
		{
			std::cerr << "failed to create window" << std::endl;
			return ANEutils->AS_int(0);
		}
		
		double int_window = (intptr_t)window;

		if (debug) {
			std::cout << "\n intptr_t=" << int_window << std::endl;
		}

		return ANEutils->AS_Number(int_window);
	}


	FREObject ANE_glfwDestroyWindow(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		double intptr = ANEutils->getDouble(argv[0]);
		if (debug)printf("\n%s %s  %lf", TAG, "ANE_glfwDestroyWindow", intptr);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			glfwDestroyWindow(window);
		}
		return NULL;
	}

	FREObject ANE_glfwGetWin32Window(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		double intptr = ANEutils->getDouble(argv[0]);
		if (debug)printf("\n%s %s  %lf", TAG, "ANE_glfwGetWin32Window", intptr);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
		  HWND hwnd = glfwGetWin32Window(window);
		  return ANEutils->AS_int((int)hwnd);
		}
		return ANEutils->AS_int(0);
	}

	FREObject ANE_glfwMakeContextCurrent(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		double intptr = ANEutils->getDouble(argv[0]);

		if (debug)printf("\n%s %s  %lf", TAG, "ANE_glfwMakeContextCurrent", intptr);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			glfwMakeContextCurrent(window);
		}

		return NULL;
	}


	

	FREObject ANE_glfwSetWindowPos(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		double intptr = ANEutils->getDouble(argv[0]);
		int x = ANEutils->getInt32(argv[1]);
		int y = ANEutils->getInt32(argv[2]);

		if (debug)printf("\n%s %s  %lf    %d   %d", TAG, "ANE_glfwSetWindowPos", intptr, x, y);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			glfwSetWindowPos(window, x, y);
		}
		return NULL;
	}
	FREObject ANE_glfwSetWindowSize(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		double intptr = ANEutils->getDouble(argv[0]);
		int width = ANEutils->getInt32(argv[1]);
		int height = ANEutils->getInt32(argv[2]);

		if (debug)printf("\n%s %s  %lf    %d   %d", TAG, "ANE_glfwSetWindowSize", intptr , width,height);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			glfwSetWindowSize(window,width,height);
		}
		return NULL;
	}

	FREObject ANE_glfwSetWindowSizeCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		double intptr = ANEutils->getDouble(argv[0]);

		std::string funName = ANEutils->getString(argv[1]);

		if (debug)printf("\n%s %s  %lf  ", TAG, "ANE_glfwSetWindowSize", intptr);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {

			if (funName.length()) {
				glfwSetWindowSizeCallback(window, [](GLFWwindow* window, int width, int height)
					{
						auto int_window = (intptr_t)window;

						ANEutils->dispatchEvent("WindowSizeCallback", std::to_string(int_window) + FGS + std::to_string(width) + FGS + std::to_string(height));
					});
			}
			else {
				glfwSetWindowSizeCallback(window, NULL);
			}
		}
		return NULL;
	}


	FREObject ANE_glfwSwapInterval(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int interval = ANEutils->getInt32(argv[0]);

		if (debug)printf("\n%s %s  %d", TAG, "ANE_glfwSwapInterval", interval);
		glfwSwapInterval(interval);
		return NULL;
	}

	FREObject ANE_glfwWindowShouldClose(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		double intptr = ANEutils->getDouble(argv[0]);

		//if (debug)printf("\n%s %s  %lf", TAG, "ANE_glfwWindowShouldClose", intptr);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			return ANEutils->AS_int(glfwWindowShouldClose(window));
		}
		return ANEutils->AS_int(0);
	}


	FREObject ANE_glfwSetWindowShouldClose(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		double intptr = ANEutils->getDouble(argv[0]);
		int value = ANEutils->getInt32(argv[1]);

		if (debug)printf("\n%s %s  %lf", TAG, "ANE_glfwSetWindowShouldClose", intptr);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			glfwSetWindowShouldClose(window, value);
		}
		return NULL;
	}


	FREObject ANE_glfwSwapBuffers(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		double intptr = ANEutils->getDouble(argv[0]);

		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			glfwSwapBuffers(window);
		}
		return NULL;
	}



	FREObject ANE_glfwPollEvents(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		if (debug)printf("\n%s %s", TAG, "ANE_glfwPollEvents");
		glfwPollEvents();
		return NULL;
	}


	FREObject ANE_glfwSetInputMode(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		double intptr = ANEutils->getDouble(argv[0]);
		int model = ANEutils->getInt32(argv[1]);
		int value = ANEutils->getInt32(argv[2]);
		if (debug)printf("\n%s %s  %lf  ", TAG, "ANE_glfwSetInputMode", intptr);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			glfwSetInputMode(window,model,value);
		}
		return NULL;
	}
	FREObject ANE_glfwGetCursorPos(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		double xpos, ypos;
		double intptr = ANEutils->getDouble(argv[0]);
		if (debug)printf("\n%s %s  %lf  ", TAG, "ANE_glfwGetCursorPos", intptr);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			glfwGetCursorPos(window, &xpos, &ypos);
		}
		return ANEutils->AS_Point(xpos, ypos);
	}

	FREObject ANE_glfwSetCursorPosCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		double intptr = ANEutils->getDouble(argv[0]);

		std::string funName = ANEutils->getString(argv[1]);
		if (debug)printf("\n%s %s  %lf  ", TAG, "ANE_glfwSetCursorPosCallback", intptr);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			if (funName.length()) {
				glfwSetCursorPosCallback(window, [](GLFWwindow* window, double xpos, double ypos)
					{
						auto int_window = (intptr_t)window;

						ANEutils->dispatchEvent("CursorPosCallback", std::to_string(int_window) + FGS + std::to_string(xpos) + FGS + std::to_string(ypos));
				});
			}
			else {
				glfwSetCursorPosCallback(window, NULL);
			}
		}
		return NULL;
	}
	
	FREObject ANE_glfwSetMouseButtonCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		double intptr = ANEutils->getDouble(argv[0]);

		std::string funName = ANEutils->getString(argv[1]);
		if (debug)printf("\n%s %s  %lf  ", TAG, "ANE_glfwSetMouseButtonCallback", intptr);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			if (funName.length()) {
				glfwSetMouseButtonCallback(window, [](GLFWwindow* window, int button, int action, int mods)
					{
						auto int_window = (intptr_t)window;

						ANEutils->dispatchEvent("MouseButtonCallback", std::to_string(int_window) + FGS + std::to_string(button) + FGS + std::to_string(action) + FGS + std::to_string(mods));
					});
			}
			else {
				glfwSetMouseButtonCallback(window, NULL);
			}
		}
		return NULL;
	}



	///--GLFW----------------------------------------------------------------------------------------------


	///--GL----------------------------------------------------------------------------------------------

	FREObject ANE_gladLoadGLLoader(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		return ANEutils->AS_int(gladLoadGLLoader((GLADloadproc)glfwGetProcAddress));
	}


	
	FREObject ANE_glViewport(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int x = ANEutils->getInt32(argv[0]);
		int y = ANEutils->getInt32(argv[1]);
		int width = ANEutils->getInt32(argv[2]);
		int height = ANEutils->getInt32(argv[3]);
		glViewport(x,y,width,height);
		return NULL;
	}
	
	FREObject ANE_glGenVertexArrays(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int sizei = ANEutils->getInt32(argv[0]);
		GLuint VBO;
		glGenVertexArrays(sizei, &VBO);
		return ANEutils->AS_int((int)VBO);
	}

	FREObject ANE_glBindVertexArray(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int target = ANEutils->getInt32(argv[0]);
		glBindVertexArray(target);
		return NULL;
	}


	FREObject ANE_glGenBuffers(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int sizei = ANEutils->getInt32(argv[0]);
		GLuint VBO;
		glGenBuffers(sizei, &VBO);
		return ANEutils->AS_int((int)VBO);
	}


	FREObject ANE_glCreateBuffers(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int sizei = ANEutils->getInt32(argv[0]);
		GLuint  buffers;
		glCreateBuffers(sizei, &buffers);
		return ANEutils->AS_int(buffers);
	}

	FREObject ANE_glDeleteBuffers(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int sizei = ANEutils->getInt32(argv[0]);
		uint32_t buffers = ANEutils->getUInt32(argv[1]);
		glDeleteBuffers(sizei, (GLuint*)buffers);
		return NULL;
	}

	FREObject ANE_glBindBuffer(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int target = ANEutils->getInt32(argv[0]);
		int buffer = ANEutils->getInt32(argv[1]);
		glBindBuffer(target, buffer);
		return NULL;
	}

	FREObject ANE_glBufferData(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int target = ANEutils->getInt32(argv[0]);
		int usage = ANEutils->getInt32(argv[3]);

		int dataSize = ANEutils->getInt32(argv[1]);
		FREObject data = argv[2];
		uint32_t length;
		FREGetArrayLength(data, &length);

		if (debug)printf("\n%s %s  %d  %d  %d  %d", TAG, "ANE_glBufferData", target,usage,dataSize,length);

		//float *Vector = new float[length];
		std::vector<float> Vector;
		for (uint32_t i = 0; i < length; i++) {
			FREObject value;
			FREGetArrayElementAt(data, i, &value);
			//Vector[i] = (float)ANEutils->getDouble(value);
			float valuef = static_cast<float>(ANEutils->getDouble(value)) + 0.0f;
			Vector.push_back(valuef);
		}

		int size = sizeof(float) * Vector.size();
		if (debug)printf("\n%s %s  %d  %d   ", TAG, "ANE_glBufferData Length", dataSize, size);
		if (size > dataSize) {
			dataSize = size;
		}
		glBufferData(target, dataSize, &Vector[0], usage);

		//SafeDelete(Vector);
		return NULL;
	}


	FREObject ANE_glVertexAttribPointer(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		uint32_t index = ANEutils->getUInt32(argv[0]);
		int size = ANEutils->getInt32(argv[1]);
		uint32_t type = ANEutils->getUInt32(argv[2]);
		bool normalized = ANEutils->getBool(argv[3]);
		int stride = ANEutils->getInt32(argv[4]);
		int pointer_IntPtr = ANEutils->getInt32(argv[5]);
		glVertexAttribPointer(index, size, type, normalized, stride, reinterpret_cast<void*>(pointer_IntPtr));
		return NULL;
	}


	FREObject ANE_glEnableVertexAttribArray(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		uint32_t index = ANEutils->getUInt32(argv[0]);
		glEnableVertexAttribArray((GLuint)index);
		return NULL;
	}


	FREObject ANE_glDisableVertexAttribArray(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		uint32_t index = ANEutils->getUInt32(argv[0]);
		glDisableVertexAttribArray((GLuint)index);
		return NULL;
	}
	

	FREObject ANE_glCreateShader(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int shader = ANEutils->getInt32(argv[0]);
		return ANEutils->AS_int((int)glCreateShader(shader));
	}
	FREObject ANE_glShaderSource(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int shader = ANEutils->getInt32(argv[0]);
		int count = ANEutils->getInt32(argv[1]);
		std::string shaderString = ANEutils->getString(argv[2]);
		const char* ShaderSource = shaderString.c_str();
		//int length = ANEutils->getInt32(argv[3]);
		glShaderSource(shader, count, &ShaderSource,NULL);
		return NULL;
	}
	FREObject ANE_glCompileShader(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int shader = ANEutils->getInt32(argv[0]);
		glCompileShader(shader);
		return NULL;
	}
	FREObject ANE_glDeleteShader(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int shader = ANEutils->getInt32(argv[0]);
		glDeleteShader(shader);
		return NULL;
	}

	
	FREObject ANE_glCreateProgram(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		return ANEutils->AS_int((int)glCreateProgram());
	}
	FREObject ANE_glAttachShader(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int program = ANEutils->getInt32(argv[0]);
		int shader = ANEutils->getInt32(argv[1]);
		glAttachShader(program,shader);
		return NULL;
	}
	FREObject ANE_glLinkProgram(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int program = ANEutils->getInt32(argv[0]);
		glLinkProgram(program);
		return NULL;
	}

	FREObject ANE_glUseProgram(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int program = ANEutils->getInt32(argv[0]);
		glUseProgram(program);
		return NULL;
	}

	FREObject ANE_glDeleteProgram(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int program = ANEutils->getInt32(argv[0]);
		glDeleteProgram(program);
		return NULL;
	}

	//
	FREObject ANE_glGenTextures(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int size = ANEutils->getInt32(argv[0]);
		unsigned int texture;
		glGenTextures(size, &texture);
		return ANEutils->AS_int(texture);
	}
	FREObject ANE_glBindTexture(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int target = ANEutils->getInt32(argv[0]);
		int texture = ANEutils->getInt32(argv[1]);
		glBindTexture(target, texture);
		return NULL;
	}
	FREObject ANE_glTexParameteri(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int target = ANEutils->getInt32(argv[0]);
		int pname = ANEutils->getInt32(argv[1]);
		int param = ANEutils->getInt32(argv[2]);
		glTexParameteri(target, pname,param);
		return NULL;
	}
	FREObject ANE_glTexImage2D(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int target = ANEutils->getInt32(argv[0]);
		int level = ANEutils->getInt32(argv[1]);
		int internalformat = ANEutils->getInt32(argv[2]);
		int width = ANEutils->getInt32(argv[3]);
		int height = ANEutils->getInt32(argv[4]);
		int border = ANEutils->getInt32(argv[5]);
		int format = ANEutils->getInt32(argv[6]);
		int type = ANEutils->getInt32(argv[7]);
		FREByteArray byte;
		FREAcquireByteArray(argv[8], &byte);
			glTexImage2D(target, level, internalformat, width, height, border, format, type, byte.bytes);
		FREReleaseByteArray(argv[8]);

		return NULL;
	}
	FREObject ANE_glGenerateMipmap(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int target = ANEutils->getInt32(argv[0]);
		glGenerateMipmap(target);
		return NULL;
	}
	
	//
	FREObject ANE_glGetUniformLocation(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int program = ANEutils->getInt32(argv[0]);
		std::string name = ANEutils->getString(argv[1]);
		return ANEutils->AS_int((int)glGetUniformLocation(program, name.c_str()));
	}
	

	FREObject ANE_glUniform1f(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int location = ANEutils->getInt32(argv[0]);
		float v0 = (float)ANEutils->getDouble(argv[1]);
		glUniform1f(location, v0);
		return NULL;
	}
	FREObject ANE_glUniform2f(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int location = ANEutils->getInt32(argv[0]);
		float v0 = (float)ANEutils->getDouble(argv[1]);
		float v1 = (float)ANEutils->getDouble(argv[2]);
		glUniform2f(location, v0 , v1);
		return NULL;
	}
	FREObject ANE_glUniform3f(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int location = ANEutils->getInt32(argv[0]);
		float v0 = (float)ANEutils->getDouble(argv[1]);
		float v1 = (float)ANEutils->getDouble(argv[2]);
		float v2 = (float)ANEutils->getDouble(argv[3]);
		glUniform3f(location, v0 ,v1 ,v2);
		return NULL;
	}



	FREObject ANE_glUniformMatrix4fv(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int location = ANEutils->getInt32(argv[0]);
		int count = ANEutils->getInt32(argv[1]);
		int transpose = ANEutils->getInt32(argv[2]);

		FREObject asData = argv[3];

		FREObject rawData;
		FREGetObjectProperty(asData, (uint8_t*)"rawData", &rawData, NULL);
		if (rawData) {
			uint32_t length;
			FREGetArrayLength(rawData,&length);

			GLfloat* matrix4 = new GLfloat[length];
			for (uint32_t i = 0; i < length; i++) {
				FREObject value;
				FREGetArrayElementAt(rawData, i, &value);
				matrix4[i] = (GLfloat)ANEutils->getDouble(value);
				//if(debug)std::cout << "\n" << i << "=" << matrix4[i] << std::endl;
			}
			glUniformMatrix4fv(location, count, (GLboolean)transpose, (const GLfloat*)matrix4);
		}
		return NULL;
	}
	

	FREObject ANE_glfwGetTime(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		return ANEutils->AS_Number(glfwGetTime());
	}

	FREObject ANE_glDrawArrays(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int mode = ANEutils->getInt32(argv[0]);
		int first = ANEutils->getInt32(argv[1]);
		int count = ANEutils->getInt32(argv[2]);
		glDrawArrays(mode,first,count);
		return NULL;
	}

	

	FREObject ANE_glDrawElements(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int mode = ANEutils->getInt32(argv[0]);
		int count = ANEutils->getInt32(argv[1]);
		int type = ANEutils->getInt32(argv[2]);
		int indices = ANEutils->getInt32(argv[3]);

		glDrawElements(mode, count, type, &indices);

		return NULL;
	}


	FREObject ANE_glClearColor(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		double red = ANEutils->getDouble(argv[0]);
		double green = ANEutils->getDouble(argv[1]);
		double blue = ANEutils->getDouble(argv[2]);
		double alpha = ANEutils->getDouble(argv[3]);
		glClearColor((float)red, (float)green, (float)blue, (float)alpha);
		return NULL;
	}

	FREObject ANE_glClear(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		uint32_t bit = ANEutils->getUInt32(argv[0]);
		glClear(bit);
		return NULL;
	}


	FREObject ANE_glPolygonMode(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
	//	GLenum face, GLenum mode
		glPolygonMode(ANEutils->getInt32(argv[0]), ANEutils->getInt32(argv[1]));
		return NULL;
	}
	

	FREObject ANE_glPointSize(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		//	GLenum face, GLenum mode
		glPointSize((float)ANEutils->getDouble(argv[0]));
		return NULL;
	}


	FREObject ANE_glCullFace(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		//mode
		glCullFace(ANEutils->getInt32(argv[0]));
		return NULL;
	}

	FREObject ANE_glEnable(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		glEnable(ANEutils->getInt32(argv[0]));
		return NULL;
	}
	FREObject ANE_glDisable(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		glDisable(ANEutils->getInt32(argv[0]));
		return NULL;
	}
	FREObject ANE_glClearDepth(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		glClearDepth(ANEutils->getDouble(argv[0]));
		return NULL;
	}

	/**
	 * 设置深度测试函数
	 * @param func 深度测试函数类型
	 */
	FREObject ANE_glDepthFunc(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int func = ANEutils->getInt32(argv[0]);
		glDepthFunc(func);
		return NULL;
	}

	/**
	 * 设置混合函数
	 * @param sfactor 源混合因子
	 * @param dfactor 目标混合因子
	 */
	FREObject ANE_glBlendFunc(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int sfactor = ANEutils->getInt32(argv[0]);
		int dfactor = ANEutils->getInt32(argv[1]);
		glBlendFunc(sfactor, dfactor);
		return NULL;
	}

	/**
	 * 设置4个浮点数uniform变量
	 * @param location uniform变量位置
	 * @param v0 第一个浮点值
	 * @param v1 第二个浮点值
	 * @param v2 第三个浮点值
	 * @param v3 第四个浮点值
	 */
	FREObject ANE_glUniform4f(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int location = ANEutils->getInt32(argv[0]);
		float v0 = (float)ANEutils->getDouble(argv[1]);
		float v1 = (float)ANEutils->getDouble(argv[2]);
		float v2 = (float)ANEutils->getDouble(argv[3]);
		float v3 = (float)ANEutils->getDouble(argv[4]);
		glUniform4f(location, v0, v1, v2, v3);
		return NULL;
	}

	/**
	 * 设置整数uniform变量
	 * @param location uniform变量位置
	 * @param v0 整数值
	 */
	FREObject ANE_glUniform1i(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int location = ANEutils->getInt32(argv[0]);
		int v0 = ANEutils->getInt32(argv[1]);
		glUniform1i(location, v0);
		return NULL;
	}

	/**
	 * 激活纹理单元
	 * @param texture 纹理单元编号
	 */
	FREObject ANE_glActiveTexture(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int texture = ANEutils->getInt32(argv[0]);
		glActiveTexture(texture);
		return NULL;
	}

	/**
	 * 删除纹理对象
	 * @param n 要删除的纹理数量
	 * @param textures 纹理ID
	 */
	FREObject ANE_glDeleteTextures(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int n = ANEutils->getInt32(argv[0]);
		uint32_t texture = ANEutils->getUInt32(argv[1]);
		glDeleteTextures(n, (GLuint*)&texture);
		return NULL;
	}

	/**
	 * 删除顶点数组对象
	 * @param n 要删除的顶点数组数量
	 * @param arrays 顶点数组ID
	 */
	FREObject ANE_glDeleteVertexArrays(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int n = ANEutils->getInt32(argv[0]);
		uint32_t array = ANEutils->getUInt32(argv[1]);
		glDeleteVertexArrays(n, (GLuint*)&array);
		return NULL;
	}

	FREObject ANE_render(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		std::vector<float> sphereVertices;


		const GLfloat  PI = 3.14159265358979323846f;
		//������ݻ��ֳ�50X50������
		const int Y_SEGMENTS = 50;
		const int X_SEGMENTS = 50;
		// ������Ķ���
		for (int y = 0; y <= Y_SEGMENTS; y++)
		{
			for (int x = 0; x <= X_SEGMENTS; x++)
			{
				float xSegment = (float)x / (float)X_SEGMENTS;
				float ySegment = (float)y / (float)Y_SEGMENTS;
				float xPos = std::cos(xSegment * 2.0f * PI) * std::sin(ySegment * PI);
				float yPos = std::cos(ySegment * PI);
				float zPos = std::sin(xSegment * 2.0f * PI) * std::sin(ySegment * PI);


				sphereVertices.push_back(xPos);
				sphereVertices.push_back(yPos);
				sphereVertices.push_back(zPos);
			}
		}

		glBufferData(GL_ARRAY_BUFFER, sizeof(float) * sphereVertices.size(), &sphereVertices[0], GL_STATIC_DRAW);

		GLuint element_buffer_object; //EBO
		glGenBuffers(1, &element_buffer_object);
		glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, element_buffer_object);
		std::vector<int> sphereIndices;
		// �������Indices
		for (int i = 0; i < Y_SEGMENTS; i++)
		{
			for (int j = 0; j < X_SEGMENTS; j++)
			{

				sphereIndices.push_back(i * (X_SEGMENTS + 1) + j);
				sphereIndices.push_back((i + 1) * (X_SEGMENTS + 1) + j);
				sphereIndices.push_back((i + 1) * (X_SEGMENTS + 1) + j + 1);

				sphereIndices.push_back(i * (X_SEGMENTS + 1) + j);
				sphereIndices.push_back((i + 1) * (X_SEGMENTS + 1) + j + 1);
				sphereIndices.push_back(i * (X_SEGMENTS + 1) + j + 1);
			}
		}
		int leng2 = sphereIndices.size() * sizeof(int);
		glBufferData(GL_ELEMENT_ARRAY_BUFFER, leng2, &sphereIndices[0], GL_STATIC_DRAW);
		return NULL;


		int model_location = ANEutils->getInt32(argv[0]);
		int view_location = ANEutils->getInt32(argv[1]);
		int projection_location = ANEutils->getInt32(argv[2]);


		//��Ұ
		float fov = 45.0f;
		//�������
		glm::vec3 camera_position = glm::vec3(0.0f, 0.0f, 3.0f);     //�����λ��
		glm::vec3 camera_front = glm::vec3(0.0f, 0.0f, -1.0f);       //���������
		glm::vec3 camera_up = glm::vec3(0.0f, 1.0f, 0.0f);           //�����������


		// Transform����任����
		glm::mat4 model(1);//model���󣬾ֲ�����任����������
		model = glm::translate(model, glm::vec3(0.0, 0.0, 0.0));
		model = glm::rotate(model, (float)glfwGetTime(), glm::vec3(0.5f, 1.0f, 0.0f));
		model = glm::scale(model, glm::vec3(1.0f, 1.0f, 1.0f));
		glm::mat4 view(1);//view������������任���۲�����ϵ
		view = glm::lookAt(camera_position, camera_position + camera_front, camera_up);
		glm::mat4 projection(1);//projection����ͶӰ����
		projection = glm::perspective(glm::radians(fov), (float)800 / 450, 0.1f, 100.0f);

		glUniformMatrix4fv(model_location, 1, GL_FALSE, glm::value_ptr(model));//д�����ֵ
		glUniformMatrix4fv(view_location, 1, GL_FALSE, glm::value_ptr(view));
		glUniformMatrix4fv(projection_location, 1, GL_FALSE, glm::value_ptr(projection));

		return NULL;
	}

	///--GL----------------------------------------------------------------------------------------------
	/////////////


	///
	// Flash Native Extensions stuff	
	void ANEGLFWContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {

		ANEutils->ctxContext = ctx;

		static FRENamedFunction extensionFunctions[] =
		{
			{ (const uint8_t*)"isSupported",					NULL, &isSupported },
			{ (const uint8_t*)"debug",					NULL, &isDeBug },

			
			{ (const uint8_t*)"AIRWindowHwnd",					NULL, &ANE_AIRWindowHwnd },
			{ (const uint8_t*)"SetParent",					NULL, &ANE_SetParent },
			{ (const uint8_t*)"openGLToNativeWindow",					NULL, &ANE_openGLToNativeWindow },
			
			{ (const uint8_t*)"glfwGetVersionString",					NULL, &ANE_glfwGetVersionString },
			{ (const uint8_t*)"glfwSetErrorCallback",					NULL, &ANE_glfwSetErrorCallback },
			{ (const uint8_t*)"glfwInit",					NULL, &ANE_glfwInit },
			{ (const uint8_t*)"glfwTerminate",					NULL, &ANE_glfwTerminate },

			{ (const uint8_t*)"glfwWindowHint",					NULL, &ANE_glfwWindowHint },
			{ (const uint8_t*)"glfwCreateWindow",					NULL, &ANE_glfwCreateWindow },
			{ (const uint8_t*)"glfwDestroyWindow",					NULL, &ANE_glfwDestroyWindow },			
			{ (const uint8_t*)"glfwGetWin32Window",					NULL, &ANE_glfwGetWin32Window },

			{ (const uint8_t*)"glfwMakeContextCurrent",					NULL, &ANE_glfwMakeContextCurrent },			
			{ (const uint8_t*)"glfwSetWindowPos",					NULL, &ANE_glfwSetWindowPos },
			{ (const uint8_t*)"glfwSetWindowSize",					NULL, &ANE_glfwSetWindowSize },
			{ (const uint8_t*)"glfwSetWindowSizeCallback",					NULL, &ANE_glfwSetWindowSizeCallback },
			
			
			{ (const uint8_t*)"glfwSwapInterval",					NULL, &ANE_glfwSwapInterval },
			{ (const uint8_t*)"glfwWindowShouldClose",					NULL, &ANE_glfwWindowShouldClose },
			{ (const uint8_t*)"glfwSetWindowShouldClose",					NULL, &ANE_glfwSetWindowShouldClose },
			
			{ (const uint8_t*)"glfwSwapBuffers",					NULL, &ANE_glfwSwapBuffers },
			{ (const uint8_t*)"glfwPollEvents",					NULL, &ANE_glfwPollEvents },

			{ (const uint8_t*)"glfwGetCursorPos",					NULL, &ANE_glfwGetCursorPos },
			{ (const uint8_t*)"glfwSetInputMode",					NULL, &ANE_glfwSetInputMode },
			{ (const uint8_t*)"glfwSetCursorPosCallback",					NULL, &ANE_glfwSetCursorPosCallback },
			{ (const uint8_t*)"glfwSetMouseButtonCallback",					NULL, &ANE_glfwSetMouseButtonCallback },
			

			//GL
			{ (const uint8_t*)"gladLoadGLLoader",					NULL, &ANE_gladLoadGLLoader },
						
			
			{ (const uint8_t*)"glViewport",					NULL, &ANE_glViewport },

			{ (const uint8_t*)"glGenVertexArrays",					NULL, &ANE_glGenVertexArrays },
			{ (const uint8_t*)"glBindVertexArray",					NULL, &ANE_glBindVertexArray },
			{ (const uint8_t*)"glDeleteVertexArrays",					NULL, &ANE_glDeleteVertexArrays },


			{ (const uint8_t*)"glCreateBuffers",					NULL, &ANE_glCreateBuffers },
			{ (const uint8_t*)"glDeleteBuffers",				NULL, &ANE_glDeleteBuffers },
			

			{ (const uint8_t*)"glGenBuffers",					NULL, &ANE_glGenBuffers },
			{ (const uint8_t*)"glBindBuffer",					NULL, &ANE_glBindBuffer },
			{ (const uint8_t*)"glBufferData",					NULL, &ANE_glBufferData },

			{ (const uint8_t*)"glVertexAttribPointer",					NULL, &ANE_glVertexAttribPointer },
			{ (const uint8_t*)"glEnableVertexAttribArray",					NULL, &ANE_glEnableVertexAttribArray },
			{ (const uint8_t*)"glDisableVertexAttribArray",					NULL, &ANE_glDisableVertexAttribArray },
			
			{ (const uint8_t*)"glCreateShader",					NULL, &ANE_glCreateShader },
			{ (const uint8_t*)"glShaderSource",					NULL, &ANE_glShaderSource },
			{ (const uint8_t*)"glCompileShader",					NULL, &ANE_glCompileShader },
			{ (const uint8_t*)"glDeleteShader",					NULL, &ANE_glDeleteShader },
			
			{ (const uint8_t*)"glCreateProgram",					NULL, &ANE_glCreateProgram },
			{ (const uint8_t*)"glAttachShader",					NULL, &ANE_glAttachShader },
			{ (const uint8_t*)"glLinkProgram",					NULL, &ANE_glLinkProgram },
			{ (const uint8_t*)"glUseProgram",					NULL, &ANE_glUseProgram },
			{ (const uint8_t*)"glDeleteProgram",					NULL, &ANE_glDeleteProgram },


			{ (const uint8_t*)"glGenTextures",					NULL, &ANE_glGenTextures },
			{ (const uint8_t*)"glBindTexture",					NULL, &ANE_glBindTexture },
			{ (const uint8_t*)"glTexParameteri",					NULL, &ANE_glTexParameteri },
			{ (const uint8_t*)"glTexImage2D",					NULL, &ANE_glTexImage2D },
			{ (const uint8_t*)"glGenerateMipmap",					NULL, &ANE_glGenerateMipmap },
			{ (const uint8_t*)"glActiveTexture",					NULL, &ANE_glActiveTexture },
			{ (const uint8_t*)"glDeleteTextures",					NULL, &ANE_glDeleteTextures },


			{ (const uint8_t*)"glGetUniformLocation",					NULL, &ANE_glGetUniformLocation },
			{ (const uint8_t*)"glUniform1f",					NULL, &ANE_glUniform1f },
			{ (const uint8_t*)"glUniform2f",					NULL, &ANE_glUniform2f },
			{ (const uint8_t*)"glUniform3f",					NULL, &ANE_glUniform3f },
			{ (const uint8_t*)"glUniform4f",					NULL, &ANE_glUniform4f },
			{ (const uint8_t*)"glUniform1i",					NULL, &ANE_glUniform1i },

			{ (const uint8_t*)"glUniformMatrix4fv",					NULL, &ANE_glUniformMatrix4fv },

			
			
			{ (const uint8_t*)"glfwGetTime",					NULL, &ANE_glfwGetTime },
			{ (const uint8_t*)"glDrawArrays",					NULL, &ANE_glDrawArrays },
			{ (const uint8_t*)"glDrawElements",					NULL, &ANE_glDrawElements },
			
			{ (const uint8_t*)"glClearColor",					NULL, &ANE_glClearColor },
			{ (const uint8_t*)"glClear",					NULL, &ANE_glClear },


			{ (const uint8_t*)"glPolygonMode",					NULL, &ANE_glPolygonMode },
			{ (const uint8_t*)"glPointSize",					NULL, &ANE_glPointSize },
			{ (const uint8_t*)"glCullFace",					NULL, &ANE_glCullFace },
			{ (const uint8_t*)"glEnable",					NULL, &ANE_glEnable },
			{ (const uint8_t*)"glDisable",					NULL, &ANE_glDisable },
			{ (const uint8_t*)"glClearDepth",					NULL, &ANE_glClearDepth },
			{ (const uint8_t*)"glDepthFunc",					NULL, &ANE_glDepthFunc },
			{ (const uint8_t*)"glBlendFunc",					NULL, &ANE_glBlendFunc },


			//test
			{ (const uint8_t*)"ANE_render",					NULL, &ANE_render },
			{ (const uint8_t*)"glClearColor",					NULL, &ANE_glClearColor },
			{ (const uint8_t*)"glClear",					NULL, &ANE_glClear },
			

			//test
			//{ (const uint8_t*)"ANE_render",					NULL, &ANE_render },

		};

		*numFunctionsToSet = sizeof(extensionFunctions) / sizeof(FRENamedFunction);
		*functionsToSet = extensionFunctions;
	}

	void ANEGLFWContextFinalizer(void* extData)
	{
		printf("\n%s,%s", TAG, "ANEGLFWContextFinalizer��release()");

		
	}


	void ANEGLFWExtInitializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer)
	{
		*ctxInitializer = &ANEGLFWContextInitializer;
		*ctxFinalizer = &ANEGLFWContextFinalizer;
	}

	void ANEGLFWExtFinalizer(void* extData)
	{
		printf("\n%s,%s", TAG, "ANEGLFWExtFinalizer��release()");
	}

}