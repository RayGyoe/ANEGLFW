#pragma once

#include "stdafx.h"


#include "ANEUtils.h"


#include <glad/glad.h>
#include <GLFW/glfw3.h>


extern "C"
{
	__declspec(dllexport) void ANEGLFWExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);
	__declspec(dllexport) void ANEGLFWExtFinalizer(void* extData);
}
