// ANEGLFW.cpp : 定义 DLL 应用程序的导出函数。
//
#include "ANEGLFW.h"

extern "C" {

	const char* TAG = "ANEGLFW";

	ANEUtils* ANEutils;

	bool debug = false;

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

		if (debug)printf("\n%s %s  %d  %d   %s", TAG, "ANE_glfwCreateWindow", width, width, title.c_str());

		GLFWwindow* window = glfwCreateWindow(width, height, title.c_str(), nullptr, nullptr);
		if (!window)
		{
			std::cerr << "failed to create window" << std::endl;
			return ANEutils->getFREObject(0);
		}
		glfwMakeContextCurrent(window);
		int int_window = (intptr_t)window; 
		return ANEutils->getFREObject(int_window);
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



	FREObject ANE_glinit(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
		{
			std::cerr << "failed to initialize glad with processes " << std::endl;

			return ANEutils->getFREObject(0);
		}

		float quadVerts[] = {
		-1.0, -1.0,     0.0, 0.0,
		-1.0, 1.0,      0.0, 1.0,
		1.0, -1.0,      1.0, 0.0,

		1.0, -1.0,      1.0, 0.0,
		-1.0, 1.0,      0.0, 1.0,
		1.0, 1.0,       1.0, 1.0
		};

		GLuint VAO;
		glGenVertexArrays(1, &VAO);
		glBindVertexArray(VAO);

		GLuint VBO;
		glGenBuffers(1, &VBO);
		glBindBuffer(GL_ARRAY_BUFFER, VBO);
		glBufferData(GL_ARRAY_BUFFER, sizeof(quadVerts), quadVerts, GL_STATIC_DRAW);

		std::cout << "sizeof(quadVerts):" << sizeof(quadVerts) << std::endl;

		glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 4 * sizeof(float), reinterpret_cast<void*>(0));
		glEnableVertexAttribArray(0);

		glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 4 * sizeof(float), reinterpret_cast<void*>(2 * sizeof(float)));
		glEnableVertexAttribArray(1);



		std::string vertexShaderString = ANEutils->getString(argv[0]);
		std::string fragmentShaderString = ANEutils->getString(argv[1]);
		const char* vertexShaderSource = vertexShaderString.c_str();
		const char* fragmentShaderSource = fragmentShaderString.c_str();

		//vertex shader
		unsigned int vertexShader = glCreateShader(GL_VERTEX_SHADER);
		glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
		glCompileShader(vertexShader);

		// fragment shader
		unsigned int fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
		glShaderSource(fragmentShader, 1, &fragmentShaderSource, NULL);
		glCompileShader(fragmentShader);
		// check for shader compile errors

		// link shaders
		unsigned int shaderProgram = glCreateProgram();
		glAttachShader(shaderProgram, vertexShader);
		glAttachShader(shaderProgram, fragmentShader);
		glLinkProgram(shaderProgram);
		// check for linking errors

		glDeleteShader(vertexShader);
		glDeleteShader(fragmentShader);

		return ANEutils->getFREObject(shaderProgram);
	}


	FREObject ANE_render(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
	{
		int shaderProgram = ANEutils->getInt32(argv[0]);

		glClearColor(0.1f, 0.1f, 0.1f, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		//glBindFramebuffer(GL_FRAMEBUFFER, 0);
		glUseProgram(shaderProgram);
		glUniform3f(glGetUniformLocation(shaderProgram, "iResolution"), (GLfloat)800, (GLfloat)450, 1.0);
		glUniform1f(glGetUniformLocation(shaderProgram, "iTime"), (GLfloat)glfwGetTime());
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

		static FRENamedFunction extensionFunctions[] =
		{
			{ (const uint8_t*)"isSupported",					NULL, &isSupported },
			{ (const uint8_t*)"debug",					NULL, &isDeBug },

			{ (const uint8_t*)"glfwInit",					NULL, &ANE_glfwInit },
			{ (const uint8_t*)"glfwTerminate",					NULL, &ANE_glfwTerminate },

			{ (const uint8_t*)"glfwWindowHint",					NULL, &ANE_glfwWindowHint },

			{ (const uint8_t*)"glfwCreateWindow",					NULL, &ANE_glfwCreateWindow },

			{ (const uint8_t*)"glfwSwapInterval",					NULL, &ANE_glfwSwapInterval },
			{ (const uint8_t*)"glfwWindowShouldClose",					NULL, &ANE_glfwWindowShouldClose },
			{ (const uint8_t*)"glfwSetWindowShouldClose",					NULL, &ANE_glfwSetWindowShouldClose },
			
			{ (const uint8_t*)"glfwSwapBuffers",					NULL, &ANE_glfwSwapBuffers },
			{ (const uint8_t*)"glfwPollEvents",					NULL, &ANE_glfwPollEvents },
			


			//test
			{ (const uint8_t*)"ANE_glinit",					NULL, &ANE_glinit },
			{ (const uint8_t*)"ANE_render",					NULL, &ANE_render },

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