//
//  SCNetwork.h
//  sma11case
//
//  Created by sma11case on 8/30/15.
//  Copyright (c) 2015 sma11case. All rights reserved.
//

#import "../Objects/SCModel.h"
#import "../../ExternalsLibrary/ExternalsLibrary.h"

typedef NS_ENUM(NSUInteger, CURLRequestMode)
{
    CURLRequestModeGet = 1,
    CURLRequestModeHead,
    CURLRequestModeOptions,
    CURLRequestModePropfind
};

@class CURLParam;
typedef size_t (*CURLCallback)(size_t size, size_t count, void *buffer, void *param);
typedef size_t(^CURLWriteBlock)(NSData *data, id param);
typedef size_t(^CURLReadBlock)(size_t length, void *buffer, id param);
typedef void(^CURLFinishedBlock)(CURLcode code, CURLParam *param);

#define CURLParamSetProxy(cp, type, host, port) do {\
cp.proxyHost = host;\
cp.proxyPort = port;\
cp.proxyType = type;\
} while (NO)

#define CURLAppendDataBlock ^(NSData *data, id param){[param appendData:data]; return (size_t)data.length;}
#define CURLNoActionBlock ^(NSData *data, id param){return (size_t)data.length;}

@interface SCNetworkInfo : SCModel
@property (nonatomic, strong) NSString *host;
@property (nonatomic, assign) USHORT port;
@end

@interface CURLParam : SCModel
@property (nonatomic, assign) CURL *curl;
@property (nonatomic, assign) CURLRequestMode mode;

@property (nonatomic, assign) USHORT port;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *userAgent;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSString *proxyHost;
@property (nonatomic, strong) NSString *proxyUser;
@property (nonatomic, strong) NSString *proxyPassword;
@property (nonatomic, assign) USHORT proxyPort;
@property (nonatomic, assign) curl_proxytype proxyType;

@property (nonatomic, strong) NSString *cookies;
@property (nonatomic, strong) NSString *referer;

@property (nonatomic, assign) BOOL notVerifySSL;
@property (nonatomic, assign) BOOL followLocation;

@property (nonatomic, strong) id writeCbParam;
@property (nonatomic, strong) CURLWriteBlock writeCallbackBlock;

@property (nonatomic, strong) id readCbParam;
@property (nonatomic, strong) CURLReadBlock readCallbackBlock;
@end

@interface CURLParam (sma11case_ShareClass)
- (void)requestAsyncWithFinishedBlock: (CURLFinishedBlock)block;
- (CURLcode)requestWithFinishedBlock: (CURLFinishedBlock)block;
- (NSData *)request: (NSString *)path userAgent: (NSString *)ua;
@end

@interface SCNetwork : NSObject
+ (CURLcode)curlGetDataWithCURLParam: (CURLParam *)param;
@end
