//
//  NSTimer+SC.h
//  sma11case
//
//  Created by sma11case on 11/25/15.
//  Copyright © 2015 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer(sma11case_ShareClass)
+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)ti unretainTarget:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;
@end
