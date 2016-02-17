//
//  Functions.h
//  sma11case
//
//  Created by sma11case on 15/8/14.
//  Copyright (c) 2015年 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Macros.h"

#define Object(value) packToObject(@encode(__typeof__((value))), (value))
#define LogAnything(x) MLog(@"LogAnything <type:%s> %s = %@", @encode(typeof(x)), #x, Object(x))
#define LogObjectEx(x) do{id temp = x; if (IsKindOfClass(x, NSData)) temp = [[NSString alloc] initWithData:x encoding:NSUTF8StringEncoding]; MLog(@"%s = %@", #x, temp); }while(NO)

#define LogAnythingWithFunctionName(x) MLog(@"%s <type:%s> %s = %@", __FUNCTION__, @encode(typeof(x)), #x, Object(x))

typedef NS_ENUM(NSUInteger, CriticalState)
{
    CriticalStateIdle = 0,
    CriticalStateBusy,
};

typedef struct
{
    CriticalState state;
}Critical, *PCritical;

typedef void(*pfSendMessage0)(id target, SEL selector, ...);
typedef id(*pfSendMessage1)(id target, SEL selector, ...);

extern pfSendMessage0 sc_SendMessage0;
extern pfSendMessage1 sc_SendMessage1;
#define performSelector0(...) sc_SendMessage0(__VA_ARGS__)
#define performSelector1(...) sc_SendMessage1(__VA_ARGS__)

typedef id (^WeakReference)();
WeakReference boxAsWeakReference(id object);
id unboxWeakReference(WeakReference ref);

// NSDefaultRunLoopMode
void enterRunLoop(NSString *runMode);

void *getMethodAddress(id object, SEL selector);

unsigned long hexStringToUnsignedLongValue(const char *string);

id packToObject(const char *type, ...);
#define packToObject(x, y) packToObject(x, y)

id packToObjectEx(size_t *size, const char *type, ...);
#define packToObjectEx(size, type, x) packToObjectEx(size, type, x)

NSString *mergeString(NSString *first, ...);
#define mergeString(...) mergeString(__VA_ARGS__, nil)

NSMutableArray *mergeArray(NSArray *first, ...);
#define mergeArray(...) mergeArray(__VA_ARGS__, nil)

void mergeArrayIntoArray(NSMutableArray *output, NSArray *first, ...);
#define mergeArrayIntoArray(output, ...) mergeArrayIntoArray(output, __VA_ARGS__, nil)

NSMutableDictionary *mergeDictionary(NSDictionary *first, ...);
#define mergeDictionary(...) mergeDictionary(__VA_ARGS__, nil)

void mergeDictionaryIntoDictonary(NSMutableDictionary *output, NSDictionary *first, ...);
#define mergeDictionaryIntoDictonary(output, ...) mergeDictionaryIntoDictonary(output, __VA_ARGS__, nil)

void runBlockWithMain(dispatch_block_t block);
void runBlockWithAsync(dispatch_block_t block);

void runBlockWithMainEx(dispatch_block_t block, ...);
#define runBlockWithMainEx(...) runBlockWithMainEx(__VA_ARGS__, nil)

void runBlockWithAsyncEx(dispatch_block_t block, ...);
#define runBlockWithAsyncEx(...) runBlockWithAsyncEx(__VA_ARGS__, nil)

void runBlock(dispatch_block_t asyncBlock, dispatch_block_t syncBlock);

PCritical createCritical();
BOOL enterCritical(PCritical temp, BOOL wait);
void levelCritical(PCritical temp);
void deleteCritical(PCritical temp);

NSString *getCachesDirectory();
NSString *getDocumentDirectory();
NSString *getTemporaryDirectory();
NSString *getHomeDirectory();

NSString *getPinyin(NSString * string,BOOL isShort);
NSArray *getInstalledAppBundleId();
char *makeRandomString(char *keys, size_t length);

NSMutableArray *getMethodListWithClass(Class cls);
NSMutableDictionary *getPropertyListWithClass(Class cls);
NSMutableDictionary *getIvarListWithClass(Class cls);
BOOL getIvarValue(id instance, const char *name, size_t size, void *buffer);

char *makeCharacterWithCount(NSUInteger count, char character);

BOOL SC_SDKInit(long level, ...);
#define SC_SDKInit(...) SC_SDKInit(__VA_ARGS__, nil)

BOOL SC_SDKUnInit();
