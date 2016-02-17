//
//  Critical.h
//  sma11case
//
//  Created by sma11case on 11/20/15.
//  Copyright © 2015 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCRoot.h"
#import "../Functions.h"

@interface SCCritical : SCRoot
@property (nonatomic, assign, readonly) CriticalState state;

- (BOOL)enterCriticalWithWait: (BOOL)wait;
- (void)leaveCritical;
@end
