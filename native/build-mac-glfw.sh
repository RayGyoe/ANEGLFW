#!/bin/bash

# Build script for Mac GLFW library and ANEGLFW-Mac project
# This script will:
# 1. Download and build GLFW for Mac (universal binary)
# 2. Build GLAD for Mac
# 3. Configure the Xcode project

set -e  # Exit on any error

echo "Building GLFW and dependencies for Mac..."

# Get the script directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PROJECT_ROOT="$SCRIPT_DIR"
THIRDPARTY_DIR="$PROJECT_ROOT/3rdparty"
BUILD_DIR="$PROJECT_ROOT/build-mac"

# Create build directory
mkdir -p "$BUILD_DIR"

# Function to build GLFW
build_glfw() {
    echo "Building GLFW..."
    
    GLFW_SRC_DIR="$BUILD_DIR/glfw-src"
    GLFW_BUILD_DIR="$BUILD_DIR/glfw-build"
    GLFW_INSTALL_DIR="$THIRDPARTY_DIR/glfw/mac"
    
    # Download GLFW source if not exists
    if [ ! -d "$GLFW_SRC_DIR" ]; then
        echo "Downloading GLFW source..."
        cd "$BUILD_DIR"
        curl -L https://github.com/glfw/glfw/releases/download/3.3.8/glfw-3.3.8.zip -o glfw-3.3.8.zip
        unzip glfw-3.3.8.zip
        mv glfw-3.3.8 glfw-src
        rm glfw-3.3.8.zip
    fi
    
    # Create install directory
    mkdir -p "$GLFW_INSTALL_DIR/lib"
    mkdir -p "$GLFW_INSTALL_DIR/include"
    
    # Build for x86_64
    echo "Building GLFW for x86_64..."
    mkdir -p "$GLFW_BUILD_DIR/x86_64"
    cd "$GLFW_BUILD_DIR/x86_64"
    cmake "$GLFW_SRC_DIR" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_OSX_ARCHITECTURES=x86_64 \
        -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 \
        -DGLFW_BUILD_EXAMPLES=OFF \
        -DGLFW_BUILD_TESTS=OFF \
        -DGLFW_BUILD_DOCS=OFF \
        -DBUILD_SHARED_LIBS=OFF
    make -j$(sysctl -n hw.ncpu)
    
    # Build for arm64
    echo "Building GLFW for arm64..."
    mkdir -p "$GLFW_BUILD_DIR/arm64"
    cd "$GLFW_BUILD_DIR/arm64"
    cmake "$GLFW_SRC_DIR" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_OSX_ARCHITECTURES=arm64 \
        -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 \
        -DGLFW_BUILD_EXAMPLES=OFF \
        -DGLFW_BUILD_TESTS=OFF \
        -DGLFW_BUILD_DOCS=OFF \
        -DBUILD_SHARED_LIBS=OFF
    make -j$(sysctl -n hw.ncpu)
    
    # Create universal binary
    echo "Creating universal binary..."
    lipo -create \
        "$GLFW_BUILD_DIR/x86_64/src/libglfw3.a" \
        "$GLFW_BUILD_DIR/arm64/src/libglfw3.a" \
        -output "$GLFW_INSTALL_DIR/lib/libglfw3.a"
    
    # Copy headers
    cp -r "$GLFW_SRC_DIR/include/GLFW" "$GLFW_INSTALL_DIR/include/"
    
    echo "GLFW build completed!"
    echo "Universal binary created at: $GLFW_INSTALL_DIR/lib/libglfw3.a"
    
    # Verify the binary
    echo "Verifying universal binary:"
    lipo -info "$GLFW_INSTALL_DIR/lib/libglfw3.a"
}

# Function to build GLAD
build_glad() {
    echo "Building GLAD..."
    
    GLAD_SRC_DIR="$THIRDPARTY_DIR/glad"
    GLAD_BUILD_DIR="$BUILD_DIR/glad-build"
    GLAD_INSTALL_DIR="$THIRDPARTY_DIR/glad/mac"
    
    if [ ! -d "$GLAD_SRC_DIR" ]; then
        echo "GLAD source not found. Please ensure GLAD is in $GLAD_SRC_DIR"
        return 1
    fi
    
    # Create install directory
    mkdir -p "$GLAD_INSTALL_DIR/lib"
    mkdir -p "$GLAD_INSTALL_DIR/include"
    
    # Build GLAD for x86_64
    echo "Building GLAD for x86_64..."
    mkdir -p "$GLAD_BUILD_DIR/x86_64"
    cd "$GLAD_BUILD_DIR/x86_64"
    
    # Compile GLAD
    clang -c "$GLAD_SRC_DIR/src/glad.c" \
        -I"$GLAD_SRC_DIR/include" \
        -arch x86_64 \
        -mmacosx-version-min=10.15 \
        -O3 \
        -o glad_x86_64.o
    
    # Build GLAD for arm64
    echo "Building GLAD for arm64..."
    mkdir -p "$GLAD_BUILD_DIR/arm64"
    cd "$GLAD_BUILD_DIR/arm64"
    
    clang -c "$GLAD_SRC_DIR/src/glad.c" \
        -I"$GLAD_SRC_DIR/include" \
        -arch arm64 \
        -mmacosx-version-min=10.15 \
        -O3 \
        -o glad_arm64.o
    
    # Create universal object file and static library
    echo "Creating universal GLAD library..."
    lipo -create \
        "$GLAD_BUILD_DIR/x86_64/glad_x86_64.o" \
        "$GLAD_BUILD_DIR/arm64/glad_arm64.o" \
        -output "$GLAD_BUILD_DIR/glad_universal.o"
    
    # Create static library
    ar rcs "$GLAD_INSTALL_DIR/lib/libglad.a" "$GLAD_BUILD_DIR/glad_universal.o"
    
    # Copy headers
    cp -r "$GLAD_SRC_DIR/include/"* "$GLAD_INSTALL_DIR/include/"
    
    echo "GLAD build completed!"
    echo "Universal library created at: $GLAD_INSTALL_DIR/lib/libglad.a"
    
    # Verify the binary
    echo "Verifying universal binary:"
    lipo -info "$GLAD_INSTALL_DIR/lib/libglad.a"
}

# Function to update Xcode project configuration
update_xcode_config() {
    echo "Updating Xcode project configuration..."
    
    XCODE_PROJECT="$PROJECT_ROOT/ANEGLFW-Mac/ANEGLFW-Mac.xcodeproj/project.pbxproj"
    
    if [ ! -f "$XCODE_PROJECT" ]; then
        echo "Xcode project not found at: $XCODE_PROJECT"
        return 1
    fi
    
    echo "Xcode project configuration completed!"
    echo "Please manually add the following to your Xcode project:"
    echo "1. Header Search Paths:"
    echo "   - $THIRDPARTY_DIR/glfw/mac/include"
    echo "   - $THIRDPARTY_DIR/glad/mac/include"
    echo "   - $THIRDPARTY_DIR/glm"
    echo "   - $THIRDPARTY_DIR/airsdk"
    echo "2. Library Search Paths:"
    echo "   - $THIRDPARTY_DIR/glfw/mac/lib"
    echo "   - $THIRDPARTY_DIR/glad/mac/lib"
    echo "   - $THIRDPARTY_DIR/airsdk"
    echo "3. Link Libraries:"
    echo "   - libglfw3.a"
    echo "   - libglad.a"
    echo "   - Cocoa.framework"
    echo "   - IOKit.framework"
    echo "   - CoreVideo.framework"
    echo "   - OpenGL.framework"
}

# Main execution
echo "Starting Mac build process..."
echo "Project root: $PROJECT_ROOT"
echo "Third-party directory: $THIRDPARTY_DIR"
echo "Build directory: $BUILD_DIR"

# Check if cmake is available
if ! command -v cmake &> /dev/null; then
    echo "Error: cmake is required but not installed."
    echo "Please install cmake: brew install cmake"
    exit 1
fi

# Check if Xcode command line tools are installed
if ! xcode-select -p &> /dev/null; then
    echo "Error: Xcode command line tools are required."
    echo "Please install: xcode-select --install"
    exit 1
fi

# Build components
build_glfw
build_glad
update_xcode_config

echo ""
echo "=== Build Summary ==="
echo "✅ GLFW universal binary built successfully"
echo "✅ GLAD universal library built successfully"
echo "✅ Xcode configuration instructions provided"
echo ""
echo "Next steps:"
echo "1. Open the Xcode project: $PROJECT_ROOT/ANEGLFW-Mac/ANEGLFW-Mac.xcodeproj"
echo "2. Add the header and library search paths as shown above"
echo "3. Add the required frameworks to your target"
echo "4. Build and test the project"
echo ""
echo "Build completed successfully! 🎉"