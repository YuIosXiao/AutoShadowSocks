//
//  CoreNetwork.h
//  sma11case
//
//  Created by sma11case on 15/8/18.
//  Copyright (c) 2015年 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCObject.h"
#import "../typedef.h"
#import "../Network/Network.h"
#import "../ExternalsSource/ExternalsSource.h"

typedef NS_ENUM(NSUInteger, NetPostType)
{
    NetPostTypeUnknow = 0,
    NetPostTypeFormData,
    NetPostTypeJson
};

@interface SCNetRequest : SCModel
@property (nonatomic, strong) id userParam;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSDictionary *getParam;
@property (nonatomic, strong) NSDictionary *postParam;
@property (nonatomic, strong) NSDictionary *header;
@property (nonatomic, assign) NSUInteger postType;
@property (nonatomic, strong) NetResponeBlock responeBlock;
@property (nonatomic, strong) dispatch_queue_t completionQueue;
@property (nonatomic, assign) BOOL waitFinished;
@property (nonatomic, strong) NSObjectBlock managerBlock;

@property (nonatomic, weak, readonly) NSOperationQueue *operationQueue;
@end

#define GetAFNErrorRespone(x) [x.userInfo[@"com.alamofire.serialization.response.error.data"] toUTF8String]
#define GetAFNErrorRequest(x) x.userInfo[@"com.alamofire.serialization.response.error.response"]
#define LogAFNErrorRespone(x) MLog(@"AFN error respone:\n%@", GetAFNErrorRespone(x))
#define LogAFNErrorRequest(x) MLog(@"AFN error request:\n%@", GetAFNErrorRequest(x))

NSString *generateURL(NSString *baseURL, NSDictionary *getParam);

@interface CoreNetwork : SCNetwork
+ (NSOperationQueue *)requestForJson: (NSString *)path getParam:(NSDictionary *)getParam postParam:(NSDictionary *)postParam postType:(NetPostType)postType block:(NetDictionaryResponeBlock)block;
+ (NSOperationQueue *)request:(NSString *)path getParam: (NSDictionary *)getParam postParam:(NSDictionary *)postParam postType:(NetPostType)postType userParam: (id)userParam block:(NetResponeBlock)block;
+ (NSOperationQueue *)requestWithNetParam: (SCNetRequest *)param;
@end
