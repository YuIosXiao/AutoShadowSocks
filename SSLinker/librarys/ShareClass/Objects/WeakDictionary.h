//
//  WeakDictionary.h
//  sma11case
//
//  Created by sma11case on 15/8/19.
//  Copyright (c) 2015年 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCObject.h"
#import "../SCProtocal.h"

#define UseShareMethod 1

typedef BOOL(^EnumDictionaryBlock)(NSString *key, id element, id userParam);

@interface WeakDictionary : NSObject <SCDictionaryEnumeration>
#if UseShareMethod
#include "../SharedMethod/SharedDictionary.h"
#endif

@property (nonatomic, strong) NSString *comment;
@property (nonatomic, assign, readonly) NSDictionary *dictionary;
@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, assign, readonly) NSArray *allValues;
@property (nonatomic, assign, readonly) NSArray *allKeys;

+ (instancetype)dictionaryWithCapacity: (NSUInteger)count;
- (instancetype)initWithCapacity: (NSUInteger)count;
- (void)setObject:(id)obj forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;
- (void)removeObjectForKey: (NSString *)key;
- (void)removeAllObjects;
- (void)removeInvalidValues;
- (void)enumElementsWithUserParam: (id)param block: (EnumDictionaryBlock)block;
@end
