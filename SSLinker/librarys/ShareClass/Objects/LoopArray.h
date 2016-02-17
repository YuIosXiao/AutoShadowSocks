//
//  LoopArray.h
//  sma11case
//
//  Created by sma11case on 10/10/15.
//  Copyright © 2015 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCObject.h"
#import "../SCProtocal.h"

#define UseShareMethod 1

@interface LoopArray : NSObject <SCArrayEnumeration>
#if UseShareMethod
#include "../SharedMethod/SharedArray.h"
#endif

@property (nonatomic, assign, readonly)NSUInteger count;
@property (nonatomic, strong) id defaultObject;

- (instancetype)init SC_DISABLED;
- (instancetype)initWithCapacity: (NSUInteger)count;
- (void)recapacityWithCount: (NSUInteger)count;
- (id)objectAtIndex: (NSUInteger)idx;
- (void)addObject: (id)obj;
- (void)removeObject: (id)obj;
- (void)removeObjectAtIndex: (NSUInteger)idx;
- (void)replaceObject: (id)obj index: (NSUInteger)idx;
@end
