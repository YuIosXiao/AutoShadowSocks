//
//  SCTimer.h
//  sma11case
//
//  Created by sma11case on 11/25/15.
//  Copyright © 2015 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCRoot.h"

typedef NS_ENUM(NSUInteger, SCTimerState)
{
    SCTimerStateUnknow = 0,
    SCTimerStateRunning,
    SCTimerStatePaused,
    SCTimerStateStopped
};

@interface SCTimer : SCRoot
@property (nonatomic, assign, readonly) NSUInteger executeCount;
@property (nonatomic, assign, readonly) SCTimerState state;
@end
