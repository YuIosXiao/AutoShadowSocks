//
//  RootWindow.m
//  SSLinker
//
//  Created by sma11case on 2/16/16.
//  Copyright © 2016 sma11case. All rights reserved.
//

#import "RootWindow.h"
#import "ShadowSocksHelper.h"
#import "librarys/OSX/staticLibrary_OSX.h"

@implementation RootWindow
{
    __weak NSTextField  *_userTF;
    __weak NSTextField  *_pwdTF;
    __weak NSButton     *_registerBtn;
    __weak NSButton     *_loginBtn;

    __weak NSButton *_freshBuyListBtn;
    __weak NSButton *_buyBtn;
    __weak CPView   *_buyListView;

    __weak NSButton *_freshMyListBtn;
    __weak NSButton *_startServiceBtn;
    __weak CPView   *_myListView;
    
    __weak NSTextField  *_stateTF;
    __weak NSTextField  *_verifyTF;
    __weak NSButton     *_verifyBtn;

    NSArray         *_buyServers;
    NSArray         *_myServers;
    SCNetworkInfo   *_listenInfo;
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
        btn.title = @"buy servers";
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
        //        btn.target = self;
        //        btn.action = @selector(buyBtn:);
        btn.title = @"add";
        [self.contentView addSubview:btn];
        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userTF.mas_top);
            make.leading.mas_equalTo(_freshBuyListBtn.mas_trailing).offset(20);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(40);
        }];
        _buyBtn = btn;
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
        btn.title = @"my servers";
        [self.contentView addSubview:btn];
        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userTF.mas_top);
            make.leading.mas_equalTo(_buyListView.mas_trailing).offset(20);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(40);
        }];
        _freshMyListBtn = btn;
    }

    {
        NSButton *btn = NewClass(NSButton);
        btn.enabled = NO;
        btn.title = @"add";
        [self.contentView addSubview:btn];
        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_userTF.mas_top);
            make.leading.mas_equalTo(_freshMyListBtn.mas_trailing).offset(20);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(40);
        }];
        _startServiceBtn = btn;
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
        NSString *user = [NSUD stringForKey:@"userName"];
        NSString *pwd = [NSUD stringForKey:@"password"];
        if (user.length)
        {
            _userTF.stringValue = user;
            if (pwd.length) _pwdTF.stringValue = pwd;
        }
        
        _verifyTF.stringValue = @"https://www.google.com/";
    }
}

- (void)verifyProxyWithUrl: (NSString *)url
{
    LogFunctionName();
    
    CopyAsWeak(self, ws);
    runBlockWithAsync(^{
        if (NSOnState != _verifyBtn.state) return ;
        
        BOOL state = [ShadowSocksHelper verifySSWithListenParam:_listenInfo url:url];
        runBlockWithMain(^{
            _stateTF.textColor = (state ? GreenColor : RedColor);
            _stateTF.stringValue = (state ? @"state: ok" : @"state: failed");
        });
        
        [NSThread sleepForTimeInterval:2];
        performSelector0(ws, _cmd, url);
    });
}

- (void)verifyBtn: (NSButton *)sender
{
    LogFunctionName();
    
    if (NSOnState == sender.state)
    {
        _verifyTF.enabled = NO;
        [self verifyProxyWithUrl:@"https://www.google.com"];
        return;
    }
    
    if (NSOffState == sender.state)
    {
        _verifyTF.enabled = YES;
        _stateTF.textColor = BlackColor;
        _stateTF.stringValue = @"state: unknow";
        return;
    }
}

- (void)registerBtn: (NSButton *)sender
{
    LogFunctionName();
    
    [CoreTools executeCommand:@"open 'http://www1.ss-link.com/register'" waitFinished:NO];
}

- (void)loginBtn:(NSButton *)sender
{
    LogFunctionName();

    sender.enabled = NO;
    NSString    *user = _userTF.stringValue;
    NSString    *pwd = _pwdTF.stringValue;
    [ShadowSocksHelper sslink_loginWithUser:user password:pwd block:^(BOOL state) {
        LogAnything(state);
        runBlockWithMain(^{
            if (state) {
                _freshMyListBtn.enabled = YES;
                _freshBuyListBtn.enabled = YES;
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

- (void)freshBuyListBtn:(NSButton *)sender
{
    LogFunctionName();

    sender.enabled = NO;
    [_buyListView removeAllSubviews];
    [ShadowSocksHelper sslink_getBuyServerList:^(NSArray *respone) {
        LogAnything(respone);
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
        LogAnything(respone);
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
        if (state) {
            runBlockWithMain(^{
                [self freshServerBtn:_freshMyListBtn];
                sender.enabled = YES;
            });
        }
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

    _myServers = servers;
    [_myListView removeAllSubviews];

    CGFloat         x = 6;
    CGFloat         y = 0;
    const CGFloat   width = 110;
    const CGFloat   height = 35;

    NSUInteger count = servers.count;

    for (NSUInteger a = 0; a < count; ++a) {
        SSLinkConfig *config = servers[a];
        if (NO == config.hostingState) continue;
        
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

        x += (width + 10);

        if (0 == (a + 1) % 2) {
            x = 6;
            y += (height + 10);
        }
    }
}

@end