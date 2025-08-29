#include "ANEUtils.h"

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
    NSLog(@"isFREResultOK = %s", errorMessage.c_str());
    return false;
}

std::string ANEUtils::string_To_UTF8(const std::string& str) {
    // On Mac, strings are typically already UTF-8
    return str;
}

std::string ANEUtils::intToStdString(int value) {
    std::stringstream str_stream;
    str_stream << value;
    std::string str = str_stream.str();
    return str;
}

// Mac specific utility methods
NSString* ANEUtils::stringToNSString(const std::string& str) const {
    return [NSString stringWithUTF8String:str.c_str()];
}

std::string ANEUtils::NSStringToString(NSString* nsStr) const {
    if (nsStr == nil) {
        return "";
    }
    const char* cStr = [nsStr UTF8String];
    return cStr ? std::string(cStr) : "";
}

void ANEUtils::dispatchEvent(std::string name, std::string value) {
    FREDispatchStatusEventAsync(ctxContext, reinterpret_cast<const uint8_t *>(name.data()), reinterpret_cast<const uint8_t *>(value.data()));
}

void ANEUtils::trace(std::string message) const {
    NSLog(@"ANEGLFW: %@", stringToNSString(message));
}

bool ANEUtils::LoadBundle(std::string strRealPath, vector<char>& data) {
    NSString* path = stringToNSString(strRealPath);
    NSData* fileData = [NSData dataWithContentsOfFile:path];
    
    if (fileData == nil) {
        trace("Failed to load file: " + strRealPath);
        return false;
    }
    
    const char* bytes = static_cast<const char*>([fileData bytes]);
    NSUInteger length = [fileData length];
    
    data.clear();
    data.reserve(length);
    data.assign(bytes, bytes + length);
    
    return true;
}

string ANEUtils::UrlUTF8(char * str) {
    if (str == nullptr) {
        return "";
    }
    
    NSString* nsStr = [NSString stringWithUTF8String:str];
    NSString* encodedStr = [nsStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    return NSStringToString(encodedStr);
}