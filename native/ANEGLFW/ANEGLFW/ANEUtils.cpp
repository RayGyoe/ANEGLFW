#include "ANEUtils.h"

template<typename T> string toString(const T& t) {
	std::ostringstream oss;  //����һ����ʽ�������
	oss << t;             //��ֵ����������
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

	wchar_t* pwBuf = new wchar_t[nwLen + 1];//һ��Ҫ��1����Ȼ�����Fβ��
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
	//����һ���յ�std::wstring
	std::wstring wstr = L"";

	/**
	 * CodePage:�ò�������ִ��ת��ʱʹ�õı����ʽ,����ʹ�ñ����ʽΪUTF8,����ʹ��CP_UTF8.
	 *dwFlags:ʹ��0����
	 *lpMultiByteStr:Ҫת�����ַ���ָ��,ʹ��c_str()���ɻ��
	 *cbMultiByte:Ҫת�����ַ����ĳ���,�ֽ�Ϊ��λ,����ʹ��size()���
	 *lpWideCharStr:ָ�����ת�����ַ����Ļ�������ָ��
	 *cchWideChar:��������С,���Ϊ0,�򷵻�����Ҫ�Ļ�������С
	*���https://docs.microsoft.com/zh-cn/windows/win32/api/stringapiset/nf-stringapiset-multibytetowidechar?redirectedfrom=MSDN
	 */

	 //lpWideCharStr��ΪNULL,cchWideChar��Ϊ0,�ò������ڻ�ȡ��������С
	int len = MultiByteToWideChar(CP_UTF8, 0, str.c_str(), str.size(), NULL, 0);

	//����wchar_t������Ϊ������,���ڽ���ת������������,���鳤��Ϊlen+1��ԭ�����ַ�����Ҫ��'\0'��β,����+1�����洢'\0'
	wchar_t* wchar = new wchar_t[len + 1];

	//�����������軺������С����ȷ��,ִ��ת��
	MultiByteToWideChar(CP_UTF8, 0, str.c_str(), str.size(), wchar, len);

	//ʹ��'\0'��β
	wchar[len] = '\0';

	//������ƴ�ӵ�std::wstring
	wstr.append(wchar);

	//�м�Ҫ��ջ�����,�����ڴ�й©
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
		if (isalnum((BYTE)tt.at(i))) //�ж��ַ����Ƿ����������Ӣ��
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
		//�����Ӣ��ֱ�Ӹ��ƾͿ���
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
	// ע�� WCHAR�ߵ��ֵ�˳��,���ֽ���ǰ�����ֽ��ں�
	char* pchar = (char *)pText;

	pOut[0] = (0xE0 | ((pchar[1] & 0xF0) >> 4));
	pOut[1] = (0x80 | ((pchar[1] & 0x0F) << 2)) + ((pchar[0] & 0xC0) >> 6);
	pOut[2] = (0x80 | (pchar[0] & 0x3F));

	return;
}