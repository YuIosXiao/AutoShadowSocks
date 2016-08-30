//
//  RootWindow.m
//  SSLinker
//
//  Created by sma11case on 2/16/16.
//  Copyright © 2016 sma11case. All rights reserved.
//

#import "RootWindow.h"
#import "ShadowSocksHelper.h"
#import <osxFramework/osxFramework.h>

static NSString *const kMsgTypeFreshMyList = @"MsgTypeFreshMyList";

@interface RootWindow ()

@end

@implementation RootWindow
{
    __unsafe_unretained NSTextField *_userTF;
    __unsafe_unretained NSTextField *_pwdTF;
    __unsafe_unretained NSButton    *_registerBtn;
    __unsafe_unretained NSButton    *_loginBtn;

    __unsafe_unretained NSButton    *_freshBuyListBtn;
    __unsafe_unretained NSButton    *_buyAllBtn;
    __unsafe_unretained CPView      *_buyListView;

    __unsafe_unretained NSButton    *_freshMyListBtn;
    __unsafe_unretained NSButton    *_testBtn;
    __unsafe_unretained CPView      *_myListView;

    __unsafe_unretained NSTextField *_stateTF;
    __unsafe_unretained NSTextField *_verifyTF;
    __unsafe_unretained NSButton    *_verifyBtn;

    NSArray         *_buyServers;
    NSArray         *_myServers;
    SCNetworkInfo   *_listenInfo;
    __unsafe_unretained NSNotificationCenter   *_msgCenter;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)awakeFromNib
{
    LogFunctionName();

    CopyAsWeak(self.contentView, ws);

    CPRect frame = CGRectMake(self.x, self.y, 710, 500);
    [self setFrame:frame display:YES];

    _listenInfo = NewClass(SCNetworkInfo);
    _listenInfo.host = @"127.0.0.1";
    _listenInfo.port = 1080U;

    _msgCenter = [NSNotificationCenter defaultCenter];
    [_msgCenter addObserver:self selector:@selector(didReceivedMessage:) name:kMsgTypeFreshMyList object:nil];

    {
        NSTextField *tf = NewClass(NSTextField);
        tf.alignment = NSTextAlignmentCenter;
        tf.font = [NSFont systemFontOfSize:20];
        tf.textColor = BlackColor;
        tf.placeholderString = @"user name";
        [self.contentView addSubview:tf];
        [tf mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(20);
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(28);
            make.top.mas_equalTo(ws.mas_top).offset(20);
        }];
        _userTF = tf;
    }

    {
        NSSecureTextField *tf = NewClass(NSSecureTextField);
        tf.alignment = NSTextAlignmentCenter;
        tf.font = [NSFont systemFontOfSize:20];
        tf.textColor = BlackColor;
        tf.placeholderString = @"password";
        [self.contentView addSubview:tf];
        [tf mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(20);
            make.width.mas_equalTo(160);
            make.height.mas_equalTo(28);
            make.top.mas_equalTo(_userTF.mas_bottom).offset(20);
        }];
        _pwdTF = tf;
    }

    {
        NSButton *btn = NewClass(NSButton);
        btn.target = self;
        btn.action = @selector(registerBtn:);
        btn.title = @"register";
        [self.contentView addSubview:btn];
        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(_userTF.mas_leading);
            make.top.mas_equalTo(_pwdTF.mas_bottom).offset(20);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(40);
        }];
        _registerBtn = btn;
    }

    {
        NSButton *btn = NewClass(NSButton);
        btn.target = self;
        btn.action = @selector(loginBtn:);
        btn.title = @"login";
        [self.contentView addSubview:btn];
        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.trailing.mas_equalTo(_userTF.mas_trailing);
            make.top.mas_equalTo(_pwdTF.mas_bottom).offset(20);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(40);
        }];
        _loginBtn = btn;
    }

    {
        SCDrawView *view = NewClass(SCDrawView);
        [view setDrawBlock:^(CGRect rect) {
            [RedColor set];
            NSRectFill(rect);
        }];
        [self.contentView addSubview:view];
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(_userTF.mas_trailing).offset(20);
            make.width.mas_equalTo(240);
            make.bottom.mas_equalTo(ws.mas_bottom).offset(-10);
            make.top.mas_equalTo(_userTF.mas_top).offset(60);
        }];
        _buyListView = view;
    }

    {
        NSButton *btn = NewClass(NSButton);
        btn.enabled = NO;
        btn.target = self;
        btn.action = @selector(freshBuyListBtn:);
        btn.title = @"fresh";
        [self.contentView addSubview:btn];
        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userTF.mas_top);
            make.leading.mas_equalTo(_buyListView.mas_leading).offset(20);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(40);
        }];
        _freshBuyListBtn = btn;
    }

    {
        NSButton *btn = NewClass(NSButton);
        btn.enabled = NO;
        btn.title = @"buy all";
        btn.target = self;
        btn.action = @selector(buyAllBtn:);
        [self.contentView addSubview:btn];
        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userTF.mas_top);
            make.leading.mas_equalTo(_freshBuyListBtn.mas_trailing).offset(20);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(40);
        }];
        _buyAllBtn = btn;
    }

    {
        SCDrawView *view = NewClass(SCDrawView);
        [view setDrawBlock:^(CGRect rect) {
            [BlueColor set];
            NSRectFill(rect);
        }];
        [self.contentView addSubview:view];
        [view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(_buyListView.mas_trailing).offset(20);
            make.width.mas_equalTo(240);
            make.bottom.mas_equalTo(ws.mas_bottom).offset(-10);
            make.top.mas_equalTo(_buyListView.mas_top);
        }];
        _myListView = view;
    }

    {
        NSButton *btn = NewClass(NSButton);
        btn.enabled = NO;
        btn.target = self;
        btn.action = @selector(freshServerBtn:);
        btn.title = @"fresh";
        [self.contentView addSubview:btn];
        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userTF.mas_top);
            make.leading.mas_equalTo(_buyListView.mas_trailing).offset(20);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(40);
        }];
        _freshMyListBtn = btn;
    }

    {
        NSButton *btn = NewClass(NSButton);
        btn.title = @"test proxy";
        btn.target = self;
        btn.action = @selector(testBtn:);
        [self.contentView addSubview:btn];
        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userTF.mas_top);
            make.leading.mas_equalTo(_freshMyListBtn.mas_trailing).offset(10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(40);
        }];
        _testBtn = btn;
    }
    
    {
        NSButton *btn = NewClass(NSButton);
        btn.title = @"update PAC";
        btn.target = self;
        btn.action = @selector(updatePacBtn:);
        [self.contentView addSubview:btn];
        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userTF.mas_top);
            make.leading.mas_equalTo(_testBtn.mas_trailing).offset(10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(40);
        }];
    }

    {
        NSButton *btn = NewClass(NSButton);
        btn.target = self;
        btn.action = @selector(verifyBtn:);
        btn.title = @"auto verify proxy";
        [btn setButtonType:NSSwitchButton];
        [self.contentView addSubview:btn];
        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_loginBtn.mas_bottom).offset(20);
            make.leading.mas_equalTo(_userTF.mas_leading);
            make.trailing.mas_equalTo(_userTF.mas_trailing);
            make.height.mas_equalTo(20);
        }];
        _verifyBtn = btn;

        NSTextField *tf = NewClass(NSTextField);
        tf.font = [NSFont systemFontOfSize:12];
        tf.textColor = BlackColor;
        tf.placeholderString = @"verify url";
        [self.contentView addSubview:tf];
        [tf mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_verifyBtn.mas_bottom);
            make.leading.mas_equalTo(_verifyBtn.mas_leading);
            make.trailing.mas_equalTo(_verifyBtn.mas_trailing);
            make.height.mas_equalTo(20);
        }];
        _verifyTF = tf;
    }

    {
        NSTextField *tf = NewClass(NSTextField);
        tf.enabled = NO;
        tf.alignment = NSTextAlignmentCenter;
        tf.font = [NSFont systemFontOfSize:12];
        tf.textColor = BlackColor;
        tf.stringValue = @"state: unknow";
        [self.contentView addSubview:tf];
        [tf mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_verifyTF.mas_bottom).offset(5);
            make.leading.mas_equalTo(_verifyBtn.mas_leading);
            make.trailing.mas_equalTo(_verifyBtn.mas_trailing);
            make.height.mas_equalTo(20);
        }];
        _stateTF = tf;
    }

    {
        NSString    *user = [NSUD stringForKey:@"userName"];
        NSString    *pwd = [NSUD stringForKey:@"password"];

        if (user.length) {
            _userTF.stringValue = user;

            if (pwd.length) {
                _pwdTF.stringValue = pwd;
            }
        }

        _verifyTF.stringValue = @"https://www.google.com/";
    }
}

- (void)verifyProxyWithUrl:(NSString *)url
{
    LogFunctionName();

    CopyAsWeak(self, ws);
    runBlockWithAsync(^{
        if (NSOnState != _verifyBtn.state) {
            return;
        }

        NSData *state = [ShadowSocksHelper verifySSWithListenParam:_listenInfo url:url];
        runBlockWithMain(^{
            _stateTF.textColor = (state ? GreenColor : RedColor);
            _stateTF.stringValue = (state ? @"state: ok" : @"state: failed");
        });

        [NSThread sleepForTimeInterval:2];
//        performSelector0(ws, _cmd, url);
    });
}

- (void)verifyBtn:(NSButton *)sender
{
    LogFunctionName();

    if (NSOnState == sender.state) {
        _verifyTF.enabled = NO;
        [self verifyProxyWithUrl:@"https://www.google.com"];
        return;
    }

    if (NSOffState == sender.state) {
        _verifyTF.enabled = YES;
        _stateTF.textColor = BlackColor;
        _stateTF.stringValue = @"state: unknow";
        return;
    }
}

- (void)registerBtn:(NSButton *)sender
{
    LogFunctionName();

    executeCommand(@"open 'http://www1.ss-link.com/register'", NO);
}

- (void)loginBtn:(NSButton *)sender
{
    LogFunctionName();
    
    sender.enabled = NO;
    NSString    *user = _userTF.stringValue;
    NSString    *pwd = _pwdTF.stringValue;
    [ShadowSocksHelper sslink_loginWithUser:user password:pwd block:^(BOOL state) {
        runBlockWithMain(^{
            if (state) {
                _freshMyListBtn.enabled = YES;
                _freshBuyListBtn.enabled = YES;
                _buyAllBtn.enabled = YES;
                [self freshServerBtn:_freshMyListBtn];
                [self freshBuyListBtn:_freshBuyListBtn];
                NSUDWriteObject(@"userName", user);
                NSUDWriteObject(@"password", pwd);
            } else {
                sender.enabled = YES;
            }
        });
    }];
}

- (void)updatePacBtn: (NSButton *)sender
{
    LogFunctionName();
    
    sender.enabled = NO;
    
    runBlockWithAsync(^{
        NSString *url = @"https://raw.githubusercontent.com/n0wa11/gfw_whitelist/master/whitelist.pac";
        NSData *pac = [ShadowSocksHelper verifySSWithListenParam:_listenInfo url:url];
        if (pac.length)
        {
            NSString *string = [pac toUTF8String];
            string = [string regexpReplace:@"[\\r\\n]\\s*var\\s+IP_ADDRESS\\s*\\S" replace:@"\n\nvar IP_ADDRESS = '127.0.0.1:1080'\n//"];
            string = [string regexpReplace:@"[\\r\\n]\\s*var\\s+PROXY_TYPE\\s*\\S" replace:@"\n\nvar PROXY_TYPE = 'SOCKS5'\n//"];
            
            NSString *file = [[[NSBundle mainBundle] resourcePath] stringByAppendingString:@"/Resources/gfwlist.js"];
            [string writeToFile:file atomically:YES encoding:NSUTF8StringEncoding error:NULL];
            
            runBlockWithMain(^{
                NSAlert *alert = [[NSAlert alloc] init];
                alert.messageText = @"update success!";
                alert.informativeText = file;
                alert.alertStyle = NSInformationalAlertStyle;
                [alert addButtonWithTitle:@"okay"];
                [alert runModal];
                sender.enabled = YES;
            });
            
            
            BreakPointHere;
        }
        else
        {
            runBlockWithMain(^{
                NSAlert *alert = [[NSAlert alloc] init];
                alert.messageText = @"updated error, you need start proxy at fist";
                alert.alertStyle = NSInformationalAlertStyle;
                [alert addButtonWithTitle:@"okay"];
                [alert runModal];
                sender.enabled = YES;
            });
        }
    });
}

- (void)testBtn:(NSButton *)sender
{
    LogFunctionName();

    sender.enabled = NO;
    runBlockWithAsync(^{
        NSString *url = @"ip.cn";
        NSData *state = [ShadowSocksHelper verifySSWithListenParam:_listenInfo url:url];

        runBlockWithMain(^{
            NSAlert *alert = [[NSAlert alloc] init];
            
            if (state)
            {
                NSString *temp = [state toUTF8String];
                if (temp) alert.messageText = temp;
                else alert.messageText = @"proxy state: reachabled";
            }
            else
            {
                alert.messageText = @"proxy state: unreachable";
            }
            
            alert.alertStyle = NSInformationalAlertStyle;
            [alert addButtonWithTitle:@"okay"];
            [alert runModal];
            sender.enabled = YES;
        });
    });
}

- (void)buyAllBtn:(NSButton *)sender
{
    LogFunctionName();

    sender.enabled = NO;

    runBlockWithAsync(^{
        for (NSDictionary *config in _buyServers) {
            MLog(@"buy %@ ...", config[@"name"]);
            [ShadowSocksHelper sslink_buyServerWithName:config[@"name"] block:^(BOOL state) {
                MLog(@"buy %@ state: %d", config[@"name"], state);
                if (config == _buyServers.lastObject) [self createLastHostingWithBlock:^{
                    runBlockWithMain(^{
                        _buyAllBtn.enabled = YES;
                    });
                }];
            }];
        }
    });
}

- (void)freshBuyListBtn:(NSButton *)sender
{
    LogFunctionName();

    sender.enabled = NO;
    [_buyListView removeAllSubviews];
    [ShadowSocksHelper sslink_getBuyServerList:^(NSArray *respone) {
        [self freshBuyServers:respone];
        runBlockWithMain(^{
            sender.enabled = YES;
        });
    }];
}

- (void)freshServerBtn:(NSButton *)sender
{
    LogFunctionName();

    sender.enabled = NO;
    [_myListView removeAllSubviews];
    [ShadowSocksHelper sslink_getServersWithBlock:^(NSArray *respone) {
        [self freshMyServers:respone];
        runBlockWithMain(^{
            sender.enabled = YES;
        });
    }];
}

- (void)startServerBtn:(NSButton *)sender
{
    LogFunctionName();

    sender.enabled = NO;
    ShadowSocksConfig *config = _myServers[sender.tag];
    [ShadowSocksHelper runSSClientWithParam:config listenParam:_listenInfo];
    sender.enabled = YES;
}

- (void)buyServerBtn:(NSButton *)sender
{
    LogFunctionName();

    sender.enabled = NO;
    NSDictionary *config = _buyServers[sender.tag];

    [ShadowSocksHelper sslink_buyServerWithName:config[@"name"] block:^(BOOL state) {
        runBlockWithMain(^{
            [self createLastHostingWithBlock:^{
                runBlockWithMain(^{
                    sender.enabled = YES;
                });
            }];
        });
    }];
}

- (void)freshBuyServers:(NSArray *)servers
{
    LogFunctionName();

    if (NO == [NSThread isMainThread]) {
        runBlockWithMain(^{
            [self freshBuyServers:servers];
        });
        return;
    }

    _buyServers = servers;
    [_buyListView removeAllSubviews];

    CGFloat         x = 6;
    CGFloat         y = 0;
    const CGFloat   width = 110;
    const CGFloat   height = 35;

    NSUInteger count = servers.count;

    for (NSUInteger a = 0; a < count; ++a) {
        NSDictionary *config = servers[a];

        NSButton *btn = NewClass(NSButton);
        btn.tag = a;
        btn.target = self;
        btn.action = @selector(buyServerBtn:);
        btn.title = config[@"name"];
        [_buyListView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_buyListView.mas_top).offset(20 + y);
            make.leading.mas_equalTo(x);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];

        x += (width + 10);

        if (0 == (a + 1) % 2) {
            x = 6;
            y += (height + 10);
        }
    }
}

- (void)freshMyServers:(NSArray *)servers
{
    LogFunctionName();

    if (NO == [NSThread isMainThread]) {
        runBlockWithMain(^{
            [self freshMyServers:servers];
        });
        return;
    }
    
    NSMutableArray *validServers = NewMutableArray();
    for (SSLinkConfig *config in servers)
    {
        if (NO == config.hostingState) {
            continue;
        }
        
        [validServers addObject:config];
    }
    
    [validServers sortUsingComparator:^NSComparisonResult(SSLinkConfig *obj1, SSLinkConfig * obj2) {
        if (obj1.expireTime > obj2.expireTime) return  NSOrderedAscending;
        if (obj1.expireTime < obj2.expireTime) return  NSOrderedDescending;
        return NSOrderedSame;
            }];
    servers = validServers;

    _myServers = servers;
    [_myListView removeAllSubviews];

    CGFloat         x = 6;
    CGFloat         y = 0;
    const CGFloat   width = 110;
    const CGFloat   height = 35;

    NSUInteger count = servers.count;

    NSTimeInterval now = [NSDate nowTimeStamp];

    for (NSUInteger a = 0; a < count; ++a) {
        SSLinkConfig *config = servers[a];

        NSButton *btn = NewClass(NSButton);
        btn.tag = a;
        btn.target = self;
        btn.action = @selector(startServerBtn:);
        btn.title = config.name;
        [_myListView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_myListView.mas_top).offset(20 + y);
            make.leading.mas_equalTo(x);
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
        }];
        
        if ((now - config.expireTime) >= 86400) {
            [btn setTitleColor:RedColor];
        }
        else if ((now - config.expireTime) < 14400) {
            btn.title = [NSString stringWithFormat:@"* %@", config.name];
        }

        x += (width + 10);

        if (0 == (a + 1) % 2) {
            x = 6;
            y += (height + 10);
        }
    }
}

- (void)createLastHostingWithBlock: (EmptyBlock)block
{
    [ShadowSocksHelper sslink_getServersWithBlock:^(NSArray *respone) {
        for (SSLinkConfig *config in respone)
        {
            if (config.password.length) continue;
            
            [ShadowSocksHelper sslink_createHostingWithHostingId:config.hostingId block:^(NSInteger state, NSString *message) {
                MLog(@"create Hosting: %@ state:%ld message: %@", config.hostingId, state, message);
                [_msgCenter postNotificationName:kMsgTypeFreshMyList object:block];
            }];
            break;
        }
    }];
}

#pragma mark 消息代理
- (void)didReceivedMessage:(NSNotification *)sender
{
    LogFunctionName();
    
    BreakPointHere;

    if (IsSameString(sender.name, kMsgTypeFreshMyList)) {
        runBlockWithMain(^{
            [self freshServerBtn:_freshMyListBtn];
        });
        EmptyBlock block = sender.object;
        if (block) block();
        return;
    }
}

@end