//
//  NSArray+SC.h
//  sma11case
//
//  Created by sma11case on 11/5/15.
//  Copyright © 2015 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UseShareMethod 1

@interface NSArray(sma11case_ShareClass)
#if UseShareMethod
#include "../SharedMethod/SharedArray.h"
#endif

- (NSData *)toData;
@end

