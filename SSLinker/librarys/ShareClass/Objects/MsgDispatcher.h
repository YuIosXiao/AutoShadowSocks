//
//  MsgDispatcher.h
//  sma11case
//
//  Created by sma11case on 15/8/14.
//  Copyright (c) 2015年 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCObject.h"

extern NSString *const MsgTypeUnknow;
extern NSString *const MsgTypeMsgDispatcherDealloc;

@class MsgDispatcher;
@protocol MsgDispatcherDelegate <NSObject>
@required
- (void)didReceivedMessage: (NSString *)type msgDispatcher: (MsgDispatcher *)sender userParam: (id)param;
@end

@interface MsgDispatcher : NSObject

+ (id)sendMessageWithNil: (BOOL)endByNil target: (id)target selector: (SEL)selector params: (NSArray *)params;
+ (void)sendMessageAsyncWithNil: (BOOL)endByNil target: (id)target selector: (SEL)selector params: (NSArray *)params;

- (BOOL)addReceiver: (id<MsgDispatcherDelegate>)obj type: (NSString *)type;
- (void)removeReceiver: (id)obj type: (NSString *)type;
- (void)removeReceiver: (id)obj;
- (void)removeInvalidReceiver;

- (void)dispatchMessageToAllReceiversWithUserParam: (id)param;
- (void)dispatchMessageToAllReceivers: (NSString *)type Param: (id)param;

- (void)dispatchMessage: (NSString *)type userParam: (id)param;
- (void)dispatchMessageAsync: (NSString *)type userParam: (id)param;
@end
