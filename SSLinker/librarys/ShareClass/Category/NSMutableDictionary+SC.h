//
//  NSMutableDictionary+SC.h
//  sma11case
//
//  Created by sma11case on 11/17/15.
//  Copyright © 2015 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UseShareMethod 1

@interface NSMutableDictionary(sma11case_IOS)
#if UseShareMethod
#include "../SharedMethod/SharedMutableDictionary.h"
#endif
@end
