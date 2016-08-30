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
    LogFunctionName();
    
    NSString *temp = [NSString stringWithFormat:@"-b=%@ -l=%u -k=%@ -m=%@ -p=%hu -s=%@ -t=%lu", sparam.host, sparam.port, param.password, param.method, param.port, param.host, param.timeout];
    
    [self runSSClientWithStringParam:temp];
}

+ (void)runSSClientWithStringParam:(NSString *)param
{
    LogFunctionName();
    
    NSString    *ssclient = [NSString stringWithFormat:@"%@/Resources/ss-local", ResourceDirectory];
    NSString    *sscmd = [NSString stringWithFormat:@"'%@' %@", ssclient, param];
    
    executeCommand(@"killall ss-local > /dev/null 2>&1", YES);
    executeCommand(sscmd, NO);
}

+ (NSData *)verifySSWithListenParam:(SCNetworkInfo *)param url:(NSString *)url
{
    LogFunctionName();
    
    
    return nil;
}

@end


@implementation ShadowSocksHelper (SSLink)
+ (void)load
{
    LogFunctionName();
    
    curl_global_init(CURL_GLOBAL_ALL);
}

+ (void)get: (NSString *)url block: (NetResponeBlock)block
{
    LogFunctionName();
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPMethod = @"GET";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (block) block(data, error);
    }];
    [task resume];
}

+ (void)post: (NSString *)url post: (NSDictionary *)pp block: (NetResponeBlock)block
{
    LogFunctionName();
    
    NSMutableString *post = NewMutableString();
    
    // email=udf.q%40qq.com&redirect=%2Fmy&password=49618d3ebb1b06ef102add8828e423c1
    NSUInteger count = 0;
    NSCharacterSet *enc = [NSCharacterSet  URLQueryAllowedCharacterSet];
    for (NSString *key in pp.allKeys)
    {
        id value = pp[key];
        
        if (count++)
        {
            [post appendFormat:@"&%@=%@", key, [value stringByAddingPercentEncodingWithAllowedCharacters:enc]];
        }
        else
        {
            [post appendFormat:@"%@=%@", key, [value stringByAddingPercentEncodingWithAllowedCharacters:enc]];
        }
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    request.HTTPBody = [post toUTF8Data];
    request.HTTPMethod = @"POST";
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (block) block(data, error);
    }];
    [task resume];
}

+ (void)request: (NSString *)url post: (NSDictionary *)pp block: (NetResponeBlock)block
{
    LogFunctionName();
    
    if (pp)
    {
        [self post:url post:pp block:block];
        return;
    }
    
    [self get:url block:block];
}

+ (void)sslink_loginWithUser:(NSString *)user password:(NSString *)pwd block:(BoolBlock)block
{
    LogFunctionName();
    
    NSDictionary *post = @{@"email":user,
                           @"redirect":@"/my",
                           @"password":[pwd md5]};
    
    [self request:@"http://www.ss-link.com/login" post:post  block:^(id respone, NSError *error) {
        respone = [respone toUTF8String];
        
        if (block) {
            block(StringHasSubstring(respone, @"注册时间") ? YES : NO);
        }
    }];
}

+ (void)sslink_getServersWithBlock:(ArrayBlock)block
{
    LogFunctionName();
    
    [self request:@"http://www.ss-link.com/my/hostings" post:nil  block:^(id respone, NSError *error) {
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
            NSString *passwd = node[@"密码"];
            config.password = [passwd regexpFirstMatch:@"\\S+"];
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
    LogFunctionName();
    
    [self request:@"http://www.ss-link.com/buy" post:nil  block:^(id respone, NSError *error) {
        
        if (nil == block) return ;
        
        TFHpple *hpple = [TFHpple hppleWithHTMLData:respone];
        
        if (nil == hpple) {
            return;
        }
        
        NSArray *nodes = [hpple searchWithXPathQuery:@"//a"];
        
        if (0 == nodes.count) return ;
        
        NSMutableArray *result = NewMutableArray();
        
        for (TFHppleElement *node in nodes)
        {
            NSString *data = node.attributes[@"data"];
            NSString *class = node.attributes[@"class"];
            
            if (0 == data.length || 0 == class.length) continue;
            
            NSString *name = data;
            NSString *value = @"";
            
            if (name.length) {
                name = [name regexpReplace:@"^\\s+|\\s+$" replace:@""];
                [result addObject:@{@"name":name, @"host":value}];
            }
        }
        
        if (0 == result.count) result = nil;
        block(result);
    }];
}

+ (void)sslink_buyServerWithName:(NSString *)name block:(BoolBlock)block
{
    LogFunctionName();
    
    NSDictionary *param = @{@"serviceId":name, @"term":@"year"};
    
    [self request:@"http://www.ss-link.com/order" post:param  block:^(id respone, NSError *error) {
        
        if (block) {
            respone = [respone toJSONObject];
            BOOL state = (0 == FType(NSNumber *, respone[@"result"]).integerValue);
            
            if (state) {
                [self request:@"http://www.ss-link.com/pay" post:@{}  block:^(id respone, NSError *error) {
                    
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
    LogFunctionName();
    
    NSDictionary *param = @{@"hostingId":hostingId};
    
    [self request:@"http://www.ss-link.com/createHosting" post:param  block:^(id respone, NSError *error) {
        respone = [respone toJSONObject];
        NSInteger state = FType(NSNumber *, respone[@"result"]).integerValue;
        NSString *message = respone[@"msg"];
        
        if (block) {
            block(state, message);
        }
    }];
}

@end

