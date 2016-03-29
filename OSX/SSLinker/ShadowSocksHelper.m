//
//  ShadowSocksHelper.m
//  SSLinker
//
//  Created by sma11case on 2/16/16.
//  Copyright © 2016 sma11case. All rights reserved.
//

#import "ShadowSocksHelper.h"

@implementation ShadowSocksConfig
@end

@implementation SSLinkConfig
@end

@implementation ShadowSocksHelper
#pragma mark 功能方法
+ (void)runSSClientWithParam:(ShadowSocksConfig *)param listenParam:(SCNetworkInfo *)sparam
{
    NSString *temp = [NSString stringWithFormat:@"-b=%@ -l=%u -k=%@ -m=%@ -p=%hu -s=%@ -t=%lu", sparam.host, sparam.port, param.password, param.method, param.port, param.host, param.timeout];

    [self runSSClientWithStringParam:temp];
}

+ (void)runSSClientWithStringParam:(NSString *)param
{
    NSString    *ssclient = [NSString stringWithFormat:@"%@/Resources/ss-local", ResourceDirectory];
    NSString    *sscmd = [NSString stringWithFormat:@"'%@' %@", ssclient, param];

    LogAnything(sscmd);
    [CoreTools executeCommand:@"killall ss-local > /dev/null 2>&1" waitFinished:YES];
    [CoreTools executeCommand:sscmd waitFinished:NO];
}

+ (NSData *)verifySSWithListenParam:(SCNetworkInfo *)param url:(NSString *)url
{
    CURLParam *cp = NewClass(CURLParam);

    cp.writeCbParam = [NSMutableData data];
    cp.writeCallbackBlock = CURLAppendDataBlock;
    cp.url = url;
    //cp.userAgent = @"Firefox";
    cp.userAgent = @"curl/7.47.1";
    CURLParamSetProxy(cp, CURLPROXY_SOCKS5, param.host, param.port);
    CURLcode code = [cp requestWithFinishedBlock:nil];
    if (CURLE_OK == code) return cp.writeCbParam;
    return nil;
}

@end

@implementation ShadowSocksHelper (SSLink)
+ (void)sslink_loginWithUser:(NSString *)user password:(NSString *)pwd block:(BoolBlock)block
{
    NSDictionary *post = @{@"email":user,
                           @"redirect":@"/my",
                           @"password":[pwd md5]};

    [CoreNetwork request:@"http://www2.ss-link.com/login" getParam:nil postParam:post postType:NetPostTypeFormData userParam:nil block:^(id respone, NSError *error, id userParam) {
        respone = [respone toUTF8String];
        LogAnything(respone);

        if (block) {
            block(StringHasSubstring(respone, @"注册时间") ? YES : NO);
        }
    }];
}

+ (void)sslink_getServersWithBlock:(ArrayBlock)block
{
    [CoreNetwork request:@"http://www2.ss-link.com/my/hostings" getParam:nil postParam:nil postType:0 userParam:nil block:^(id respone, NSError *error, id userParam) {
        TFHpple *hpple = [TFHpple hppleWithHTMLData:respone];

        if (nil == hpple) {
            return;
        }

        NSArray *nodes = [hpple searchWithXPathQuery:@"//table[@class='table table-bordered ']"];

        if (0 == nodes.count) {
            return;
        }

        NSMutableArray *ssConfigs = NewMutableArray();

        for (TFHppleElement *node in nodes) {
            NSMutableDictionary *ssConfig = NewMutableDictionary();
            NSArray *infos = [node childrenWithTagName:@"tr"];

            for (TFHppleElement *info in infos) {
                NSArray *configs = [info childrenWithTagName:@"td"];
                NSString *name = [configs[0] text];
                NSString *value = [configs[1] text];
                ssConfig[name] = value;
            }

            [ssConfigs addObject:ssConfig];
        }

        if (0 == ssConfigs.count) {
            return;
        }

        NSMutableArray *result = NewMutableArray();

        for (NSDictionary *node in ssConfigs) {
            SSLinkConfig *config = NewClass(SSLinkConfig);
            config.host = node[@"服务器IP"];
            config.port = FType(NSString *, node[@"服务器端口"]).integerValue;
            config.password = node[@"密码"];
            config.method = node[@"加密算法"];
            config.name = node[@"服务"];
            config.hostingId = node[@"ID"];

            if (config.name.length) {
                config.name = [config.name regexpReplace:@"^\\s+|\\s+$" replace:@""];
                [result addObject:config];
            }

            {
                NSString *string = node[@"到期时间"];

                NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];

                inputFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];

                inputFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";

                NSDate *inputDate = [inputFormatter dateFromString:string];

                config.expireTime = inputDate.timeIntervalSince1970;
            }

            {
                NSString *string = node[@"状态"];

                config.hostingState = NO;
                do {
                    if (IsSameString(string, @"已开通")) {
                        config.hostingState = YES;
                        break;
                    }
                } while (false);
            }
        }

        if (block) {
            block(result);
        }

        BreakPointHere;
    }];
}

+ (void)sslink_getBuyServerList:(ArrayBlock)block
{
    [CoreNetwork request:@"http://www2.ss-link.com/buy" getParam:nil postParam:nil postType:0 userParam:nil block:^(id respone, NSError *error, id userParam) {
        TFHpple *hpple = [TFHpple hppleWithHTMLData:respone];

        if (nil == hpple) {
            return;
        }

        NSArray *nodes = [hpple searchWithXPathQuery:@"//tbody/tr"];

        if (0 == nodes.count) {
            return;
        }

        NSMutableArray *result = NewMutableArray();

        for (TFHppleElement *node in nodes) {
            NSArray *configs = [node childrenWithTagName:@"td"];
            NSString *name = [configs[0] text];
            NSString *value = [configs[1] text];

            if (name.length) {
                name = [name regexpReplace:@"^\\s+|\\s+$" replace:@""];
                [result addObject:@{@"name":name, @"host":value}];
            }
        }

        if (block) {
            block(result);
        }
    }];
}

+ (void)sslink_buyServerWithName:(NSString *)name block:(BoolBlock)block
{
    NSDictionary *param = @{@"serviceId":name, @"term":@"year"};

    [CoreNetwork request:@"http://www2.ss-link.com/order" getParam:nil postParam:param postType:NetPostTypeFormData userParam:nil block:^(id respone, NSError *error, id userParam) {
        
        if (block) {
            respone = [respone toJSONObject];
            BOOL state = (0 == FType(NSNumber *, respone[@"result"]).integerValue);

            if (state) {
                [CoreNetwork request:@"http://www2.ss-link.com/pay" getParam:nil postParam:@{} postType:NetPostTypeFormData userParam:nil block:^(id respone, NSError *error, id userParam) {
                    
                    if (block)
                    {
                        respone = [respone toJSONObject];
                        BOOL state = (1 == FType(NSNumber *, respone[@"result"]).integerValue);
                        block(state);
                    }

                }];
            }
        }

        BreakPointHere;
    }];
}

+ (void)sslink_createHostingWithHostingId:(NSString *)hostingId block:(StateMessageBlock)block
{
    NSDictionary *param = @{@"hostingId":hostingId};

    [CoreNetwork request:@"http://www2.ss-link.com/createHosting" getParam:nil postParam:param postType:NetPostTypeFormData userParam:nil block:^(id respone, NSError *error, id userParam) {
        respone = [respone toJSONObject];
        NSInteger state = FType(NSNumber *, respone[@"result"]).integerValue;
        NSString *message = respone[@"msg"];

        if (block) {
            block(state, message);
        }
    }];
}

@end