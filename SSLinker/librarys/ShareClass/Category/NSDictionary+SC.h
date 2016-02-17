//
//  NSDictionary+SC.h
//  sma11case
//
//  Created by sma11case on 8/30/15.
//  Copyright (c) 2015 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UseShareMethod 1

@interface NSDictionary(sma11case_ShareClass)
#if UseShareMethod
#include "../SharedMethod/SharedDictionary.h"
#endif

- (NSData *)toData;
- (NSString *)toJsonString;
- (BOOL)isSameOfDictionary: (NSDictionary *)compare;
@end
