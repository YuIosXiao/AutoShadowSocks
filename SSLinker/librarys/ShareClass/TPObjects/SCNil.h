//
//  SCNil.h
//  sma11case
//
//  Created by sma11case on 11/22/15.
//  Copyright © 2015 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Macros.h"

id getSCNil();
#define SCNil getSCNil()
#define IsSCNil(x) (IsSameObject(x, SCNil))

