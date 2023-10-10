// ANEGLFW.cpp : 定义 DLL 应用程序的导出函数。
//
#include "ANEGLFW.h"

extern "C" {

	const char* TAG = "ANEGLFW";

	ANEUtils* ANEutils;

	bool debug = false;


	FREContext ctxContext;
	/*
	初始化
	*/
	FREObject isSupported(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		printf("\n%s %s", TAG, "isSupport");
		FREObject result;
		auto status = FRENewObjectFromBool(true, &result);
		
		return result;
	}

	FREObject isDeBug(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		debug = ANEutils->getBool(argv[0]);
		printf("\n%s %s  %d", TAG, "isDeBug",debug);
		return NULL;
	}
	///--GLFW----------------------------------------------------------------------------------------------


	FREObject ANE_glfwInit(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		if (debug)printf("\n%s %s", TAG, "ANE_glfwInit");

		FREObject result;
		auto status = FRENewObjectFromInt32(glfwInit(), &result);
		return result;
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
			return ANEutils->getFREObject(0);
		}
		
		int int_window = (intptr_t)window; 
		return ANEutils->getFREObject(int_window);
	}

	FREObject ANE_glfwMakeContextCurrent(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int intptr = ANEutils->getInt32(argv[0]);

		if (debug)printf("\n%s %s  %d", TAG, "ANE_glfwMakeContextCurrent", intptr);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			glfwMakeContextCurrent(window);
		}

		return NULL;
	}

	
	FREObject ANE_glfwSetWindowSize(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int intptr = ANEutils->getInt32(argv[0]);
		int width = ANEutils->getInt32(argv[1]);
		int height = ANEutils->getInt32(argv[2]);

		if (debug)printf("\n%s %s  %d    %d   %d", TAG, "ANE_glfwSetWindowSize", intptr , width,height);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			glfwSetWindowSize(window,width,height);
		}
		return NULL;
	}

	
	FREObject ANE_glfwSetWindowSizeCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int intptr = ANEutils->getInt32(argv[0]);

		std::string funName = ANEutils->getString(argv[1]);

		if (debug)printf("\n%s %s  %d  ", TAG, "ANE_glfwSetWindowSize", intptr);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			auto callback = [](GLFWwindow* window, int width, int height)
			{
				int int_window = (intptr_t)window;

				FREObject asData;
				if (FREGetContextActionScriptData(ctxContext, &asData) == FRE_OK)
				{
					FREObject callback;
					FREGetObjectProperty(asData, (uint8_t*)"callback", &callback, NULL);
					
					std::string callName = "WindowSizeCallback_" + std::to_string(int_window);

					FREObject argv[3];
					argv[0] = ANEutils->getFREObject(int_window);
					argv[1] = ANEutils->getFREObject(width);
					argv[2] = ANEutils->getFREObject(height);
					
					FRECallObjectMethod(callback, (uint8_t*)callName.c_str(), 3, argv, NULL, NULL);

				}
			};
			glfwSetWindowSizeCallback(window, callback);
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
		int intptr = ANEutils->getInt32(argv[0]);

		if (debug)printf("\n%s %s  %d", TAG, "ANE_glfwWindowShouldClose", intptr);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			return ANEutils->getFREObject(glfwWindowShouldClose(window));
		}
		return ANEutils->getFREObject(0);
	}


	FREObject ANE_glfwSetWindowShouldClose(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int intptr = ANEutils->getInt32(argv[0]);

		int value = ANEutils->getInt32(argv[1]);

		if (debug)printf("\n%s %s  %d", TAG, "ANE_glfwSetWindowShouldClose", intptr);
		GLFWwindow* window = reinterpret_cast<GLFWwindow*>((uintptr_t)intptr);
		if (window) {
			glfwSetWindowShouldClose(window, value);
		}
		return NULL;
	}


	FREObject ANE_glfwSwapBuffers(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int intptr = ANEutils->getInt32(argv[0]);

		if (debug)printf("\n%s %s  %d", TAG, "ANE_glfwSwapBuffers", intptr);
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

	///--GLFW----------------------------------------------------------------------------------------------


	///--GL----------------------------------------------------------------------------------------------

	FREObject ANE_gladLoadGLLoader(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		return ANEutils->getFREObject(gladLoadGLLoader((GLADloadproc)glfwGetProcAddress));
	}


	
	FREObject ANE_glViewport(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int x = ANEutils->getInt32(argv[0]);
		int y = ANEutils->getInt32(argv[0]);
		int width = ANEutils->getInt32(argv[0]);
		int height = ANEutils->getInt32(argv[0]);
		glViewport(x,y,width,height);
		return NULL;
	}
	
	FREObject ANE_glGenVertexArrays(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int sizei = ANEutils->getInt32(argv[0]);
		GLuint VBO;
		glGenVertexArrays(sizei, &VBO);
		return ANEutils->getFREObject((int)VBO);
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
		return ANEutils->getFREObject((int)VBO);
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

		float *Vector = new float[length];
		for (uint32_t i = 0; i < length; i++) {
			FREObject value;
			FREGetArrayElementAt(data, i, &value);
			Vector[i] = (float)ANEutils->getDouble(value);
		}		
		glBufferData(target, dataSize, Vector, usage);

		SafeDelete(Vector);
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




	FREObject ANE_glCreateShader(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int shader = ANEutils->getInt32(argv[0]);
		return ANEutils->getFREObject((int)glCreateShader(shader));
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
		return ANEutils->getFREObject((int)glCreateProgram());
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



	FREObject ANE_glGetUniformLocation(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int program = ANEutils->getInt32(argv[0]);
		std::string name = ANEutils->getString(argv[1]);
		return ANEutils->getFREObject((int)glGetUniformLocation(program, name.c_str()));
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



	
	FREObject ANE_glfwGetTime(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		return ANEutils->getFREObject(glfwGetTime());
	}

	FREObject ANE_glDrawArrays(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int mode = ANEutils->getInt32(argv[0]);
		int first = ANEutils->getInt32(argv[1]);
		int count = ANEutils->getInt32(argv[2]);
		glDrawArrays(mode,first,count);
		return NULL;
	}
	


	FREObject ANE_glClearColor(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int red = ANEutils->getInt32(argv[0]);
		int green = ANEutils->getInt32(argv[1]);
		int blue = ANEutils->getInt32(argv[2]);
		int alpha = ANEutils->getInt32(argv[3]);
		glClearColor((float)red, (float)green, (float)blue, (float)alpha);
		return NULL;
	}

	FREObject ANE_glClear(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		uint32_t bit = ANEutils->getUInt32(argv[0]);
		glClear(bit);
		return NULL;
	}



	FREObject ANE_render(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int shaderProgram = ANEutils->getInt32(argv[0]);

		glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		//glBindFramebuffer(GL_FRAMEBUFFER, 0);
		glUseProgram(shaderProgram);
		glUniform3f(glGetUniformLocation(shaderProgram, "iResolution")	, (GLfloat)800, (GLfloat)450, 1.0);
		glUniform1f(glGetUniformLocation(shaderProgram, "iTime")		, (GLfloat)glfwGetTime());
		//glUniform1f(glGetUniformLocation(shaderProgram, "iFrame"), frame);
		//glBindVertexArray(VAO);
		glDrawArrays(GL_TRIANGLES, 0, 6);


		return NULL;
	}

	///--GL----------------------------------------------------------------------------------------------
	/////////////


	///
	// Flash Native Extensions stuff	
	void ANEGLFWContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {

		ctxContext = ctx;

		static FRENamedFunction extensionFunctions[] =
		{
			{ (const uint8_t*)"isSupported",					NULL, &isSupported },
			{ (const uint8_t*)"debug",					NULL, &isDeBug },

			{ (const uint8_t*)"glfwInit",					NULL, &ANE_glfwInit },
			{ (const uint8_t*)"glfwTerminate",					NULL, &ANE_glfwTerminate },

			{ (const uint8_t*)"glfwWindowHint",					NULL, &ANE_glfwWindowHint },

			{ (const uint8_t*)"glfwCreateWindow",					NULL, &ANE_glfwCreateWindow },
			{ (const uint8_t*)"glfwMakeContextCurrent",					NULL, &ANE_glfwMakeContextCurrent },
			{ (const uint8_t*)"glfwSetWindowSize",					NULL, &ANE_glfwSetWindowSize },
			{ (const uint8_t*)"glfwSetWindowSizeCallback",					NULL, &ANE_glfwSetWindowSizeCallback },
			
			
			{ (const uint8_t*)"glfwSwapInterval",					NULL, &ANE_glfwSwapInterval },
			{ (const uint8_t*)"glfwWindowShouldClose",					NULL, &ANE_glfwWindowShouldClose },
			{ (const uint8_t*)"glfwSetWindowShouldClose",					NULL, &ANE_glfwSetWindowShouldClose },
			
			{ (const uint8_t*)"glfwSwapBuffers",					NULL, &ANE_glfwSwapBuffers },
			{ (const uint8_t*)"glfwPollEvents",					NULL, &ANE_glfwPollEvents },
			

			//GL
			{ (const uint8_t*)"gladLoadGLLoader",					NULL, &ANE_gladLoadGLLoader },
						
			
			{ (const uint8_t*)"glViewport",					NULL, &ANE_glViewport },

			{ (const uint8_t*)"glGenVertexArrays",					NULL, &ANE_glGenVertexArrays },
			{ (const uint8_t*)"glBindVertexArray",					NULL, &ANE_glBindVertexArray },

			{ (const uint8_t*)"glGenBuffers",					NULL, &ANE_glGenBuffers },
			{ (const uint8_t*)"glBindBuffer",					NULL, &ANE_glBindBuffer },
			{ (const uint8_t*)"glBufferData",					NULL, &ANE_glBufferData },

			{ (const uint8_t*)"glVertexAttribPointer",					NULL, &ANE_glVertexAttribPointer },
			{ (const uint8_t*)"glEnableVertexAttribArray",					NULL, &ANE_glEnableVertexAttribArray },
			
			{ (const uint8_t*)"glCreateShader",					NULL, &ANE_glCreateShader },
			{ (const uint8_t*)"glShaderSource",					NULL, &ANE_glShaderSource },
			{ (const uint8_t*)"glCompileShader",					NULL, &ANE_glCompileShader },
			{ (const uint8_t*)"glDeleteShader",					NULL, &ANE_glDeleteShader },
			
			{ (const uint8_t*)"glCreateProgram",					NULL, &ANE_glCreateProgram },
			{ (const uint8_t*)"glAttachShader",					NULL, &ANE_glAttachShader },
			{ (const uint8_t*)"glLinkProgram",					NULL, &ANE_glLinkProgram },
			{ (const uint8_t*)"glUseProgram",					NULL, &ANE_glUseProgram },


			{ (const uint8_t*)"glGetUniformLocation",					NULL, &ANE_glGetUniformLocation },
			{ (const uint8_t*)"glUniform1f",					NULL, &ANE_glUniform1f },
			{ (const uint8_t*)"glUniform2f",					NULL, &ANE_glUniform2f },
			{ (const uint8_t*)"glUniform3f",					NULL, &ANE_glUniform3f },
			
			
			{ (const uint8_t*)"glfwGetTime",					NULL, &ANE_glfwGetTime },
			{ (const uint8_t*)"glDrawArrays",					NULL, &ANE_glDrawArrays },
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
		printf("\n%s,%s", TAG, "ANEGLFWContextFinalizer：release()");

		
	}


	void ANEGLFWExtInitializer(void** extData, FREContextInitializer* ctxInitializer, FREContextFinalizer* ctxFinalizer)
	{
		*ctxInitializer = &ANEGLFWContextInitializer;
		*ctxFinalizer = &ANEGLFWContextFinalizer;
	}

	void ANEGLFWExtFinalizer(void* extData)
	{
		printf("\n%s,%s", TAG, "ANEGLFWExtFinalizer：release()");
	}

}