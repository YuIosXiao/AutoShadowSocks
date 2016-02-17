//
//  SCNull.h
//  sma11case
//
//  Created by sma11case on 9/1/15.
//  Copyright (c) 2015 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Macros.h"

#define NSNull @"NSNull is disabled, please use SCNull"

id getSCNull();
#define SCNull getSCNull()
#define IsSCNull(x) (IsSameObject(x, SCNull))
