//
//  WeakSet.h
//  sma11case
//
//  Created by sma11case on 11/22/15.
//  Copyright © 2015 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCObject.h"
#import "../SCProtocal.h"

typedef BOOL(^EnumSetBlock)(id element, id userParam);

@interface WeakSet : NSObject<SCSetEnumeration>
@property (nonatomic, assign, readonly) NSUInteger count;

+ (instancetype)setWithCapacity: (NSUInteger)count;
- (instancetype)initWithCapacity: (NSUInteger)count;
- (void)addObject: (id)obj;
- (void)removeObject: (id)obj;
- (id)anyObject;
- (void)removeAllNilObject;
- (void)enumElementsWithUserParam: (id)param block: (EnumSetBlock)block;
@end
