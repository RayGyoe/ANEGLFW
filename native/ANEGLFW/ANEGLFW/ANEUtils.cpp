#include "ANEUtils.h"

template<typename T> string toString(const T& t) {
	std::ostringstream oss;  //创建一个格式化输出流
	oss << t;             //把值传递如流中
	return oss.str();
}

std::string ANEUtils::getString(FREObject freObject) {
	uint32_t string1Length;
	const uint8_t *val;
	auto status = FREGetObjectAsUTF8(freObject, &string1Length, &val);

	if (isFREResultOK(status, "Could not convert UTF8."))
		return std::string(val, val + string1Length);
	return "";
}

uint32_t ANEUtils::getUInt32(FREObject freObject) {
	uint32_t result = 0;
	auto status = FREGetObjectAsUint32(freObject, &result);
	isFREResultOK(status, "Could not convert FREObject to uint32_t.");
	return result;
}

int32_t ANEUtils::getInt32(FREObject freObject) {
	int32_t result = 0;
	auto status = FREGetObjectAsInt32(freObject, &result);
	isFREResultOK(status, "Could not convert FREObject to int32_t.");
	return result;
}

double ANEUtils::getDouble(FREObject freObject) {
	auto result = 0.0;
	auto status = FREGetObjectAsDouble(freObject, &result);
	isFREResultOK(status, "Could not convert FREObject to double.");
	return result;
}


bool ANEUtils::getBool(FREObject freObject) {
	uint32_t result = 0;
	auto ret = false;
	FREGetObjectAsBool(freObject, &result);
	if (result > 0) ret = true;
	return ret;
}



bool ANEUtils::isFREResultOK(FREResult errorCode, std::string errorMessage) {
	if (FRE_OK == errorCode) return true;
	printf("isFREResultOK = %s", errorMessage.c_str());
	return false;
}

std::string ANEUtils::string_To_UTF8(const std::string& str)
{
	int nwLen = ::MultiByteToWideChar(CP_ACP, 0, str.c_str(), -1, NULL, 0);

	wchar_t* pwBuf = new wchar_t[nwLen + 1];//一定要加1，不然會出現尾巴
	ZeroMemory(pwBuf, nwLen * 2 + 2);

	::MultiByteToWideChar(CP_ACP, 0, str.c_str(), str.length(), pwBuf, nwLen);

	int nLen = ::WideCharToMultiByte(CP_UTF8, 0, pwBuf, -1, NULL, NULL, NULL, NULL);

	char* pBuf = new char[nLen + 1];
	ZeroMemory(pBuf, nLen + 1);

	::WideCharToMultiByte(CP_UTF8, 0, pwBuf, nwLen, pBuf, nLen, NULL, NULL);

	std::string retStr(pBuf);

	delete[]pwBuf;
	delete[]pBuf;

	pwBuf = NULL;
	pBuf = NULL;

	return retStr;
}

// convert string to wstring
std::wstring ANEUtils::to_wide_string(const std::string& input)
{
	std::wstring_convert<std::codecvt_utf8<wchar_t>> converter;
	return converter.from_bytes(input);
}
// convert wstring to string 
std::string ANEUtils::to_byte_string(const std::wstring& input)
{
	std::wstring_convert<std::codecvt_utf8<wchar_t>> converter;
	return converter.to_bytes(input);
}


std::wstring ANEUtils::s2ws(const std::string& str)
{
	//定义一个空的std::wstring
	std::wstring wstr = L"";

	/**
	 * CodePage:该参数决定执行转换时使用的编码格式,本机使用编码格式为UTF8,所以使用CP_UTF8.
	 *dwFlags:使用0即可
	 *lpMultiByteStr:要转换的字符串指针,使用c_str()即可获得
	 *cbMultiByte:要转换的字符串的长度,字节为单位,可以使用size()获得
	 *lpWideCharStr:指向接收转换后字符串的缓冲区的指针
	 *cchWideChar:缓冲区大小,如果为0,则返回所需要的缓冲区大小
	*详见https://docs.microsoft.com/zh-cn/windows/win32/api/stringapiset/nf-stringapiset-multibytetowidechar?redirectedfrom=MSDN
	 */

	 //lpWideCharStr设为NULL,cchWideChar设为0,该步骤用于获取缓冲区大小
	int len = MultiByteToWideChar(CP_UTF8, 0, str.c_str(), str.size(), NULL, 0);

	//创建wchar_t数组作为缓冲区,用于接收转换出来的内容,数组长度为len+1的原因是字符串需要以'\0'结尾,所以+1用来存储'\0'
	wchar_t* wchar = new wchar_t[len + 1];

	//缓冲区和所需缓冲区大小都已确定,执行转换
	MultiByteToWideChar(CP_UTF8, 0, str.c_str(), str.size(), wchar, len);

	//使用'\0'结尾
	wchar[len] = '\0';

	//缓冲区拼接到std::wstring
	wstr.append(wchar);

	//切记要清空缓冲区,否则内存泄漏
	delete[]wchar;

	return wstr;
}


wchar_t* ANEUtils::chatToWchar(const char* ch)
{
	wchar_t* wchar;
	int len = (int )MultiByteToWideChar(CP_ACP, 0, ch, strlen(ch), NULL, 0);
	wchar = new wchar_t[len + 1];
	MultiByteToWideChar(CP_ACP, 0, ch, strlen(ch), wchar, len);
	wchar[len] = '\0';
	return wchar;
}

char* ANEUtils::wcharToChar(const wchar_t* wch)
{
	char* _char;
	int len = (int)WideCharToMultiByte(CP_ACP, 0, wch, wcslen(wch), NULL, 0, NULL, NULL);
	_char = new char[len + 1];
	WideCharToMultiByte(CP_ACP, 0, wch, wcslen(wch), _char, len, NULL, NULL);
	_char[len] = '\0';
	return _char;
}



std::string ANEUtils::intToStdString(int value)
{
	std::stringstream str_stream;
	str_stream << value;
	std::string str = str_stream.str();

	return str;
}


FREObject ANEUtils::getFREObject(std::string value) {
	FREObject result;
	auto status = FRENewObjectFromUTF8(uint32_t(value.length()), reinterpret_cast<const uint8_t *>(value.data()), &result);
	return result;
}

FREObject ANEUtils::getFREObject(const char *value) {
	FREObject result;
	auto status = FRENewObjectFromUTF8(uint32_t(strlen(value)) + 1, reinterpret_cast<const uint8_t *>(value), &result);
	return result;
}

FREObject ANEUtils::getFREObject(double value) {
	FREObject result;
	auto status = FRENewObjectFromDouble(value, &result);
	return result;
}

FREObject ANEUtils::getFREObject(bool value) {
	FREObject result;
	auto status = FRENewObjectFromBool(value, &result);
	return result;
}

FREObject ANEUtils::getFREObject(int32_t value) {
	FREObject result;
	auto status = FRENewObjectFromInt32(value, &result);
	return result;
}

FREObject ANEUtils::getFREObject(uint32_t value) {
	FREObject result;
	auto status = FRENewObjectFromUint32(value, &result);
	return result;
}

FREObject ANEUtils::getFREObject(uint8_t value) {
	FREObject result;
	auto status = FRENewObjectFromUint32(value, &result);
	return result;
}
/*


*/

void ANEUtils::dispatchEvent(FREContext ctx, std::string name, std::string value) {
	FREDispatchStatusEventAsync(ctx, reinterpret_cast<const uint8_t *>(name.data()), reinterpret_cast<const uint8_t *>(value.data()));
}

void ANEUtils::setFREContext(FREContext ctx) {
	ctxContext = ctx;
}
void ANEUtils::trace(std::string message) const
{
	//dispatchEvent(ctxContext, "TRACE", message);
}




bool _ResizeWithMendBlack(uint8* pDst, uint8* pSrc, UINT uDstLen, UINT uSrcLen, const SIZE & dstSize, const SIZE & srcSize, UINT bpp)
{
	if (!pDst || !pSrc)
		return false;

	if (uDstLen == 0 || uDstLen != dstSize.cx * dstSize.cy * bpp)
		return false;

	if (uSrcLen == 0 || uSrcLen != srcSize.cx * srcSize.cy * bpp)
		return false;
	/*
	if(dstSize.cx < srcSize.cx)
	return false;

	if(dstSize.cy < srcSize.cy)
	return false;*/

	UINT dstLineblockSize = dstSize.cx * bpp;
	UINT srcLineblockSize = srcSize.cx * bpp;

	int mendCxLeftEnd = dstSize.cx > srcSize.cx ? (dstSize.cx - srcSize.cx) / 2 : 0;
	int mendCyToEnd = dstSize.cy > srcSize.cy ? (dstSize.cy - srcSize.cy) / 2 : 0;

	for (int y = 0; y < dstSize.cy; y++)
	{
		if (y >= mendCyToEnd && y < mendCyToEnd + srcSize.cy)
		{
			if (mendCxLeftEnd > 0)
				memcpy(pDst + (bpp * mendCxLeftEnd), pSrc, srcLineblockSize);
			else
				memcpy(pDst, pSrc, srcLineblockSize);
			pSrc += srcLineblockSize;
		}
		pDst += dstLineblockSize;
	}
	return true;
}
bool Convert24Image(BYTE *p32Img, BYTE *p24Img, DWORD dwSize32)
{

	if (p32Img != NULL && p24Img != NULL && dwSize32>0)
	{

		DWORD dwSize;

		dwSize = dwSize32 / 4;

		BYTE *pTemp, *ptr;

		pTemp = p32Img;
		ptr = p24Img;

		int ival = 0;
		for (DWORD index = 0; index < dwSize; index++)
		{
			unsigned char r = *(pTemp++);
			unsigned char g = *(pTemp++);
			unsigned char b = *(pTemp++);
			(pTemp++);//skip alpha

			*(ptr++) = r;
			*(ptr++) = g;
			*(ptr++) = b;
		}
	}
	else
	{
		return false;
	}

	return true;
}


static size_t FileSize(ifstream& file)
{
	streampos oldPos = file.tellg();
	file.seekg(0, ios::beg);
	streampos beg = file.tellg();
	file.seekg(0, ios::end);
	streampos end = file.tellg();
	file.seekg(oldPos, ios::beg);
	return static_cast<size_t>(end - beg);
}

bool ANEUtils::LoadBundle(std::string strRealPath, vector<char>& data)
{
	ifstream fin(strRealPath, ios::binary);
	if (false == fin.good())
	{
		fin.close();
		return false;
	}
	size_t size = FileSize(fin);
	if (0 == size)
	{
		fin.close();
		return false;
	}
	data.resize(size);
	fin.read(reinterpret_cast<char*>(&data[0]), size);

	fin.close();
	return true;
}






string  ANEUtils::UrlUTF8(char * str)
{
	string tt;
	string dd;
	GB2312ToUTF_8(tt, str, strlen(str));
	int len = tt.length();
	for (int i = 0; i<len; i++)
	{
		if (isalnum((BYTE)tt.at(i))) //判断字符中是否有数组或者英文
		{
			char tempbuff[2] = { 0 };
			sprintf_s(tempbuff, "%c", (BYTE)tt.at(i));
			dd.append(tempbuff);
		}
		else if (isspace((BYTE)tt.at(i)))
		{
			dd.append("+");
		}
		else
		{
			char tempbuff[4];
			sprintf_s(tempbuff, "%%%X%X", ((BYTE)tt.at(i)) >> 4, ((BYTE)tt.at(i)) % 16);
			dd.append(tempbuff);
		}

	}
	return dd;
}
void ANEUtils::GB2312ToUTF_8(string& pOut, char *pText, int pLen)
{
	char buf[4];
	memset(buf, 0, 4);

	pOut.clear();

	int i = 0;
	while (i < pLen)
	{
		//如果是英文直接复制就可以
		if (pText[i] >= 0)
		{
			char asciistr[2] = { 0 };
			asciistr[0] = (pText[i++]);
			pOut.append(asciistr);
		}
		else
		{
			WCHAR pbuffer;
			Gb2312ToUnicode(&pbuffer, pText + i);

			UnicodeToUTF_8(buf, &pbuffer);

			pOut.append(buf);

			i += 2;
		}
	}

	return;
}
void ANEUtils::Gb2312ToUnicode(WCHAR* pOut, char *gbBuffer)
{
	::MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, gbBuffer, 2, pOut, 1);
	return;
}
void UTF_8ToUnicode(WCHAR* pOut, char *pText)
{
	char* uchar = (char *)pOut;

	uchar[1] = ((pText[0] & 0x0F) << 4) + ((pText[1] >> 2) & 0x0F);
	uchar[0] = ((pText[1] & 0x03) << 6) + (pText[2] & 0x3F);

	return;
}
void  ANEUtils::UnicodeToUTF_8(char* pOut, WCHAR* pText)
{
	// 注意 WCHAR高低字的顺序,低字节在前，高字节在后
	char* pchar = (char *)pText;

	pOut[0] = (0xE0 | ((pchar[1] & 0xF0) >> 4));
	pOut[1] = (0x80 | ((pchar[1] & 0x0F) << 2)) + ((pchar[0] & 0xC0) >> 6);
	pOut[2] = (0x80 | (pchar[0] & 0x3F));

	return;
}