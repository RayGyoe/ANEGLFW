#include "ANEGLFW_Mac.h"

ANEUtils* aneUtils;
bool isDebugMode = false;

// Context management
FREContext ctxContext;

// GLFW error callback
void error_callback(int error, const char* description) {
    if (aneUtils) {
        std::string errorMsg = "GLFW Error " + std::to_string(error) + ": " + std::string(description);
        aneUtils->trace(errorMsg);
    }
}

// Extension initialization
void ANEGLFWExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &ContextInitializer;
    *ctxFinalizerToSet = &ContextFinalizer;
}

void ANEGLFWExtFinalizer(void* extData) {
    // Cleanup
    if (aneUtils) {
        delete aneUtils;
        aneUtils = nullptr;
    }
}

// Context functions
FREResult ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    aneUtils = new ANEUtils();
    aneUtils->ctxContext = ctx;
    ctxContext = ctx;
    
    // Set up function mappings
    static FRENamedFunction functionMap[] = {
        MAP_FUNCTION(isSupported, NULL),
        MAP_FUNCTION(isDeBug, NULL),
        MAP_FUNCTION(ANE_glfwGetVersionString, NULL),
        MAP_FUNCTION(ANE_glfwSetErrorCallback, NULL),
        MAP_FUNCTION(ANE_glfwInit, NULL),
        MAP_FUNCTION(ANE_glfwTerminate, NULL),
        MAP_FUNCTION(ANE_glfwWindowHint, NULL),
        MAP_FUNCTION(ANE_glfwCreateWindow, NULL),
        MAP_FUNCTION(ANE_glfwDestroyWindow, NULL),
        MAP_FUNCTION(ANE_glfwGetCocoaWindow, NULL),
        MAP_FUNCTION(ANE_glfwMakeContextCurrent, NULL),
        MAP_FUNCTION(ANE_glfwSetWindowPos, NULL),
        MAP_FUNCTION(ANE_glfwSetWindowSize, NULL),
        MAP_FUNCTION(ANE_glfwSwapBuffers, NULL),
        MAP_FUNCTION(ANE_glfwPollEvents, NULL),
        MAP_FUNCTION(ANE_glfwWindowShouldClose, NULL),
        MAP_FUNCTION(ANE_glfwSetWindowShouldClose, NULL),
        MAP_FUNCTION(ANE_glfwGetFramebufferSize, NULL),
        MAP_FUNCTION(ANE_glfwSetFramebufferSizeCallback, NULL),
        MAP_FUNCTION(ANE_glfwSetKeyCallback, NULL),
        MAP_FUNCTION(ANE_glfwSetMouseButtonCallback, NULL),
        MAP_FUNCTION(ANE_glfwSetCursorPosCallback, NULL),
        MAP_FUNCTION(ANE_glfwSetScrollCallback, NULL),
        MAP_FUNCTION(ANE_gladLoadGLLoader, NULL)
    };
    
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
    
    return FRE_OK;
}

FREResult ContextFinalizer(FREContext ctx) {
    return FRE_OK;
}

// Helper macro for function mapping
#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }

// ANE Functions Implementation
FREObject isSupported(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    return aneUtils->AS_Boolean(true);
}

FREObject isDeBug(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    if (argc > 0) {
        isDebugMode = aneUtils->getBool(argv[0]);
    }
    return aneUtils->AS_Boolean(isDebugMode);
}

// GLFW Version and Error Handling
FREObject ANE_glfwGetVersionString(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    const char* version = glfwGetVersionString();
    return aneUtils->AS_String(version);
}

FREObject ANE_glfwSetErrorCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    glfwSetErrorCallback(error_callback);
    return aneUtils->AS_Boolean(true);
}

// GLFW Initialization
FREObject ANE_glfwInit(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    int result = glfwInit();
    return aneUtils->AS_Boolean(result == GLFW_TRUE);
}

FREObject ANE_glfwTerminate(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    glfwTerminate();
    return aneUtils->AS_Boolean(true);
}

// Window Hints
FREObject ANE_glfwWindowHint(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    if (argc >= 2) {
        int hint = aneUtils->getInt32(argv[0]);
        int value = aneUtils->getInt32(argv[1]);
        glfwWindowHint(hint, value);
    }
    return aneUtils->AS_Boolean(true);
}

// Window Management
FREObject ANE_glfwCreateWindow(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    if (argc >= 3) {
        int width = aneUtils->getInt32(argv[0]);
        int height = aneUtils->getInt32(argv[1]);
        std::string title = aneUtils->getString(argv[2]);
        
        GLFWwindow* window = glfwCreateWindow(width, height, title.c_str(), NULL, NULL);
        
        if (window) {
            // Return window pointer as uint64
            return aneUtils->AS_Number(reinterpret_cast<uint64_t>(window));
        }
    }
    return aneUtils->AS_Number(0);
}

FREObject ANE_glfwDestroyWindow(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    if (argc >= 1) {
        uint64_t windowPtr = static_cast<uint64_t>(aneUtils->getDouble(argv[0]));
        GLFWwindow* window = reinterpret_cast<GLFWwindow*>(windowPtr);
        if (window) {
            glfwDestroyWindow(window);
        }
    }
    return aneUtils->AS_Boolean(true);
}

// Mac-specific: Get Cocoa window handle
FREObject ANE_glfwGetCocoaWindow(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    if (argc >= 1) {
        uint64_t windowPtr = static_cast<uint64_t>(aneUtils->getDouble(argv[0]));
        GLFWwindow* window = reinterpret_cast<GLFWwindow*>(windowPtr);
        if (window) {
            id cocoaWindow = glfwGetCocoaWindow(window);
            return aneUtils->AS_Number(reinterpret_cast<uint64_t>(cocoaWindow));
        }
    }
    return aneUtils->AS_Number(0);
}

// OpenGL Context
FREObject ANE_glfwMakeContextCurrent(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    if (argc >= 1) {
        uint64_t windowPtr = static_cast<uint64_t>(aneUtils->getDouble(argv[0]));
        GLFWwindow* window = reinterpret_cast<GLFWwindow*>(windowPtr);
        glfwMakeContextCurrent(window);
    }
    return aneUtils->AS_Boolean(true);
}

// Window Properties
FREObject ANE_glfwSetWindowPos(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    if (argc >= 3) {
        uint64_t windowPtr = static_cast<uint64_t>(aneUtils->getDouble(argv[0]));
        int x = aneUtils->getInt32(argv[1]);
        int y = aneUtils->getInt32(argv[2]);
        GLFWwindow* window = reinterpret_cast<GLFWwindow*>(windowPtr);
        if (window) {
            glfwSetWindowPos(window, x, y);
        }
    }
    return aneUtils->AS_Boolean(true);
}

FREObject ANE_glfwSetWindowSize(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    if (argc >= 3) {
        uint64_t windowPtr = static_cast<uint64_t>(aneUtils->getDouble(argv[0]));
        int width = aneUtils->getInt32(argv[1]);
        int height = aneUtils->getInt32(argv[2]);
        GLFWwindow* window = reinterpret_cast<GLFWwindow*>(windowPtr);
        if (window) {
            glfwSetWindowSize(window, width, height);
        }
    }
    return aneUtils->AS_Boolean(true);
}

// Buffer and Events
FREObject ANE_glfwSwapBuffers(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    if (argc >= 1) {
        uint64_t windowPtr = static_cast<uint64_t>(aneUtils->getDouble(argv[0]));
        GLFWwindow* window = reinterpret_cast<GLFWwindow*>(windowPtr);
        if (window) {
            glfwSwapBuffers(window);
        }
    }
    return aneUtils->AS_Boolean(true);
}

FREObject ANE_glfwPollEvents(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    glfwPollEvents();
    return aneUtils->AS_Boolean(true);
}

FREObject ANE_glfwWindowShouldClose(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    if (argc >= 1) {
        uint64_t windowPtr = static_cast<uint64_t>(aneUtils->getDouble(argv[0]));
        GLFWwindow* window = reinterpret_cast<GLFWwindow*>(windowPtr);
        if (window) {
            int shouldClose = glfwWindowShouldClose(window);
            return aneUtils->AS_Boolean(shouldClose == GLFW_TRUE);
        }
    }
    return aneUtils->AS_Boolean(false);
}

FREObject ANE_glfwSetWindowShouldClose(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    if (argc >= 2) {
        uint64_t windowPtr = static_cast<uint64_t>(aneUtils->getDouble(argv[0]));
        bool shouldClose = aneUtils->getBool(argv[1]);
        GLFWwindow* window = reinterpret_cast<GLFWwindow*>(windowPtr);
        if (window) {
            glfwSetWindowShouldClose(window, shouldClose ? GLFW_TRUE : GLFW_FALSE);
        }
    }
    return aneUtils->AS_Boolean(true);
}

// Framebuffer
FREObject ANE_glfwGetFramebufferSize(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    if (argc >= 1) {
        uint64_t windowPtr = static_cast<uint64_t>(aneUtils->getDouble(argv[0]));
        GLFWwindow* window = reinterpret_cast<GLFWwindow*>(windowPtr);
        if (window) {
            int width, height;
            glfwGetFramebufferSize(window, &width, &height);
            
            FREObject result;
            FRENewObject((const uint8_t*)"flash.geom.Point", 0, NULL, &result, NULL);
            FRESetObjectProperty(result, (const uint8_t*)"x", aneUtils->AS_Number(width), NULL);
            FRESetObjectProperty(result, (const uint8_t*)"y", aneUtils->AS_Number(height), NULL);
            return result;
        }
    }
    return aneUtils->AS_Point(0, 0);
}

// Callback placeholders (simplified for now)
FREObject ANE_glfwSetFramebufferSizeCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    // TODO: Implement callback mechanism
    return aneUtils->AS_Boolean(true);
}

FREObject ANE_glfwSetKeyCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    // TODO: Implement callback mechanism
    return aneUtils->AS_Boolean(true);
}

FREObject ANE_glfwSetMouseButtonCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    // TODO: Implement callback mechanism
    return aneUtils->AS_Boolean(true);
}

FREObject ANE_glfwSetCursorPosCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    // TODO: Implement callback mechanism
    return aneUtils->AS_Boolean(true);
}

FREObject ANE_glfwSetScrollCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    // TODO: Implement callback mechanism
    return aneUtils->AS_Boolean(true);
}

// GLAD loader
FREObject ANE_gladLoadGLLoader(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]) {
    int result = gladLoadGLLoader((GLADloadproc)glfwGetProcAddress);
    return aneUtils->AS_Boolean(result != 0);
}

// Function declarations
FREObject isSupported(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject isDeBug(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwGetVersionString(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwSetErrorCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwInit(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwTerminate(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwWindowHint(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwCreateWindow(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwDestroyWindow(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwGetCocoaWindow(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwMakeContextCurrent(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwSetWindowPos(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwSetWindowSize(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwSwapBuffers(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwPollEvents(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwWindowShouldClose(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwSetWindowShouldClose(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwGetFramebufferSize(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwSetFramebufferSizeCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwSetKeyCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwSetMouseButtonCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwSetCursorPosCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_glfwSetScrollCallback(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject ANE_gladLoadGLLoader(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);

// Context function declarations
FREResult ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet);
FREResult ContextFinalizer(FREContext ctx);