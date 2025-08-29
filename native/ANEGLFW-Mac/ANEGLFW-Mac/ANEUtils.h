#pragma once

#include <memory>
#include <stdio.h>
#include <assert.h>
#include <vector>
#include <sstream>
#include <fstream>
#include <iostream>
#include <set>
#include <string>
#include <locale>
#include <codecvt>

// Mac specific includes
#ifdef __OBJC__
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#endif

#include "/Users/ray.lei/Documents/ANEGLFW/native/3rdparty/airsdk/FlashRuntimeExtensions.h"

using std::string;
using namespace std;

typedef signed char			int8;
typedef signed short		int16;
typedef signed int			int32;
typedef signed long long	int64;
typedef unsigned char		uint8;
typedef unsigned short		uint16;
typedef unsigned int		uint32;
typedef unsigned long long	uint64;

#ifndef SafeDelete
#define SafeDelete(p) { delete (p); (p) = NULL; }
#endif //SafeDelete

#define SafeDeleteVideoArr(pArr) {delete[] pArr; pArr = 0;}

class ANEUtils {

public:

	FREObject AS_String(std::string value) {
		FREObject result;
		FRENewObjectFromUTF8(uint32_t(value.length()), reinterpret_cast<const uint8_t*>(value.data()), &result);
		return result;
	}
	
	FREObject AS_String(const char* value) {
		FREObject result;
		FRENewObjectFromUTF8(uint32_t(strlen(value)) + 1, reinterpret_cast<const uint8_t*>(value), &result);
		return result;
	}

	FREObject AS_int(int32_t value) {
		FREObject result;
		FRENewObjectFromInt32(value, &result);
		return result;
	}

	FREObject AS_uint(uint32_t value) {
		FREObject result;
		FRENewObjectFromUint32(value, &result);
		return result;
	}
	
	FREObject AS_uint(uint8_t value) {
		FREObject result;
		FRENewObjectFromUint32(value, &result);
		return result;
	}

	FREObject AS_Boolean(bool value) {
		FREObject result;
		FRENewObjectFromBool(value, &result);
		return result;
	}

	FREObject AS_Number(double value) {
		FREObject result;
		FRENewObjectFromDouble(value, &result);
		return result;
	}

	FREObject AS_Point(double x, double y) {
		FREObject obj;
		FREObject argv[] = {
			AS_Number(x),
			AS_Number(y)
		};
		FRENewObject((const uint8_t*)"flash.geom.Point", 2, argv, &obj, NULL);
		return obj;
	}

	// Getter methods
	uint32_t getUInt32(FREObject freObject);
	int32_t getInt32(FREObject freObject);
	std::string getString(FREObject freObject);
	bool getBool(FREObject freObject);
	double getDouble(FREObject freObject);

	// Utility methods
	std::string intToStdString(int value);
	std::string string_To_UTF8(const std::string& str);
	
#ifdef __OBJC__
	// Mac specific utility methods
	NSString* stringToNSString(const std::string& str) const;
	std::string NSStringToString(NSString* nsStr) const;
#endif
	
	// Context and event handling
	FREContext ctxContext;
	void dispatchEvent(std::string name, std::string value);
	void trace(std::string message) const;
	
	// File operations
	bool LoadBundle(std::string strRealPath, vector<char>& data);
	string UrlUTF8(char * str);

private:
	bool isFREResultOK(FREResult errorCode, std::string errorMessage);
};