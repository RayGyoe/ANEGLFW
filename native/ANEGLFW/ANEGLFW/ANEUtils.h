#pragma once

#define WIN32_LEAN_AND_MEAN

#include <windows.h>

#include <sstream>


#include <memory>
#include <stdio.h>
#include <assert.h>

#include <vector>
#include <sstream>
#include <fstream>
#include <iostream>
#include <set>
#include <vector>

#include <string>
#include <locale>
#include <codecvt>

#include "FlashRuntimeExtensions.h"

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
	FREObject getFREObject(std::string value);
	FREObject getFREObject(const char *value);
	FREObject getFREObject(double value);
	FREObject getFREObject(bool value);
	FREObject getFREObject(int32_t value);
	FREObject getFREObject(uint32_t value);
	FREObject getFREObject(uint8_t value);
	
	
	std::string intToStdString(int value);

	uint32_t getUInt32(FREObject freObject);
	int32_t getInt32(FREObject freObject);
	std::string getString(FREObject freObject);
	bool getBool(FREObject freObject);
	double getDouble(FREObject freObject);

	std::string string_To_UTF8(const std::string& str);
	std::wstring to_wide_string(const std::string & input);
	std::string to_byte_string(const std::wstring & input);
	std::wstring s2ws(const std::string& str);

	wchar_t* chatToWchar(const char* ch);
	char* wcharToChar(const wchar_t* wch);

	FREObject newBool(bool value);

	static void dispatchEvent(FREContext ctx, std::string name, std::string value);

	void trace(std::string message) const;
	void setFREContext(FREContext ctx);
	FREContext ctxContext;


	bool LoadBundle(std::string strRealPath, vector<char>& data);

	string UrlUTF8(char * str);


private:
	bool isFREResultOK(FREResult errorCode, std::string errorMessage);
	void GB2312ToUTF_8(string & pOut, char * pText, int pLen);
	void Gb2312ToUnicode(WCHAR * pOut, char * gbBuffer);
	void UnicodeToUTF_8(char * pOut, WCHAR * pText);
};




