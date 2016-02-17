//
//  WeakArray.h
//  sma11case
//
//  Created by sma11case on 15/8/14.
//  Copyright (c) 2015年 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCObject.h"
#import "../SCProtocal.h"

#define UseShareMethod 1

typedef BOOL(^EnumArrayBlock)(id element, id userParam);

@interface WeakArray : NSObject <SCArrayEnumeration>
#if UseShareMethod
#include "../SharedMethod/SharedArray.h"
#endif

@property (nonatomic, assign, readonly) NSUInteger count;
@property (nonatomic, strong, readonly) NSArray *array;

+ (instancetype)arrayWithCapacity: (NSUInteger)count;
- (instancetype)initWithCapacity: (NSUInteger)count;
- (void)addObject: (id)obj;
- (id)objectAtIndex: (NSUInteger)idx;
- (void)removeObject: (id)obj;
- (void)removeAllObjects;
- (void)removeLastObject;
- (void)removeAllNilObject;
@end


