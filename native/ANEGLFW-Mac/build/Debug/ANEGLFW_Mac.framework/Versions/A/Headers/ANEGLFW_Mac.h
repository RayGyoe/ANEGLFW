//
//  ANEGLFW_Mac.h
//  ANEGLFW-Mac
//
//  Created by ray.lei on 2025/1/19.
//

//! Project version number for ANEGLFW_Mac.
FOUNDATION_EXPORT double ANEGLFW_MacVersionNumber;

//! Project version string for ANEGLFW_Mac.
FOUNDATION_EXPORT const unsigned char ANEGLFW_MacVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ANEGLFW_Mac/PublicHeader.h>

#pragma once

#include "ANEUtils.h"

#ifdef __OBJC__
#import <Foundation/Foundation.h>
#endif

#define GLFW_EXPOSE_NATIVE_COCOA
#define GLFW_EXPOSE_NATIVE_NSGL
#define GLFW_NATIVE_INCLUDE_NONE

#include "/Users/ray.lei/Documents/ANEGLFW/native/3rdparty/glad/include/glad/glad.h"
#include "/Users/ray.lei/Documents/ANEGLFW/native/3rdparty/glfw/x64/include/GLFW/glfw3.h"
#include "/Users/ray.lei/Documents/ANEGLFW/native/3rdparty/glfw/x64/include/GLFW/glfw3native.h"

#include "/Users/ray.lei/Documents/ANEGLFW/native/3rdparty/glm/glm/glm.hpp"
#include "/Users/ray.lei/Documents/ANEGLFW/native/3rdparty/glm/glm/gtc/matrix_transform.hpp"
#include "/Users/ray.lei/Documents/ANEGLFW/native/3rdparty/glm/glm/gtc/type_ptr.hpp"

extern "C"
{
    void ANEGLFWExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);
    void ANEGLFWExtFinalizer(void* extData);
}


