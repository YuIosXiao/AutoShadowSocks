//
//  typedef.h
//  sma11case
//
//  Created by sma11case on 15/8/18.
//  Copyright (c) 2015年 sma11case. All rights reserved.
//

#if PLAT_IOS
typedef unsigned long ULONG;
#endif

typedef char   CHAR;
typedef short  SHORT;
typedef int    INT;
typedef long   LONG;
typedef float  FLOAT;
typedef double DOUBLE;
typedef unsigned int   UINT;
typedef unsigned short USHORT;
typedef unsigned long long ULongLong;

typedef void(^EmptyBlock)();
typedef NSString*(^GetStringBlock)();

typedef void(^selectorBlock)(id target, SEL selector, id sender);
typedef void(^BoolBlock)(BOOL state);
typedef void(^VAListBlock)(ULONG first, ...);
typedef void(^NSObjectBlock)(id object);
typedef void(^DictionaryBlock) (NSDictionary *respone);
typedef void(^ArrayBlock) (NSArray *respone);
typedef void(^NetResponeBlock)(id respone, NSError *error, id userParam);
typedef void(^NetDictionaryResponeBlock)(NSDictionary *respone, NSError *error, id userParam);

