//
//  NSString+Crypt.h
//  IBOS-IOS
//
//  Created by IBOS on 15/4/20.
//  Copyright (c) 2015年 IBOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../ExternalsSource/ExternalsSource.h"
#import "../CrossPlatform/CrossPlatform.h"

typedef NS_ENUM(NSUInteger, AESEncryptBitCount)
{
    AESEncryptBit128 = 128,
    AESEncryptBit192 = 192,
    AESEncryptBit256 = 256,
};

extern const NSRegularExpressionOptions kRegexpDefaultOptions;

@interface NSString (sma11case_ShareClass)
+ (NSString *)generateUUIDString;
+ (NSString*)getNowTimeString: (NSString *)format;
+ (NSString *)randomStringWithKeys: (char *)keys length: (size_t)length;
+ (unsigned long)hexStringToUnsignedLongValue: (NSString *)string;

- (NSString *)crc32;
- (NSString *)md5;
- (NSString *)sha1;
- (BOOL)isNumber;
- (BOOL)isLowercaseString;
- (BOOL)isUppercaseString;
- (NSString *)base64Encode;
- (NSData *)base64EncodeToData;
- (NSString *)base64Decode;
- (NSData *)base64DecodeToData;
- (NSData *)toUTF8Data;
- (id)toJSONObject;
- (NSArray *)toArray;
- (NSDictionary *)toDictionary;
- (BOOL)regexpCheck: (NSString *)expression;
- (NSArray *)regexpMatch: (NSString *)expression;
- (NSString *)regexpFirstMatch: (NSString *)expression;
- (NSString *)regexpReplace: (NSString *)expression replace: (NSString *)replace;
- (NSData *)AESEncryptWithKey:(NSString *)key bit:(AESEncryptBitCount)bit;
- (NSString *)AESEncryptToHexStringWithKey:(NSString *)key bit:(AESEncryptBitCount)bit;
- (NSString *)toPinyinWithFirstCharactor;
- (NSString *)toPinyinWithFormat:(HanyuPinyinOutputFormat *)outputFormat seperater:(NSString *)seperater;
- (CGSize)calcSizeWithFont: (CPFont *)font width: (CGFloat)width height: (CGFloat)height;
@end
