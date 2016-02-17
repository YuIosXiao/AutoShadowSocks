//
//  SysPrefences.h
//  sma11case
//
//  Created by sma11case on 9/10/15.
//  Copyright (c) 2015 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCObject.h"

#define SysPrefencesShared    [SysPrefences shared]
#define SPScreenSize          [SysPrefences screenSize]
#define SPScreenWidth         [SysPrefences screenWidth]
#define SPScreenHeight        [SysPrefences screenHeight]
#define SPScreenFrame         [SysPrefences screenFrame]

#if PLAT_IOS
#define SPStatusBarHeight           [SysPrefences statusBarHeight]
#define SPNavigationBarHeight       [SysPrefences navigationBarHeight]
#define SPTabBarHeight              [SysPrefences tabBarHeight]
#define SPInvalidViewHeight         [SysPrefences invalidViewHeight]
#define SPValidViewHeight           [SysPrefences validViewHeight]
#define SPNavigationBar             [SysPrefences navigationBar]
#define SPCurrentViewController     [SysPrefences currentViewController]
#define SPAppDelegate               [SysPrefences appDelegate]
#define SPWindow                    [SysPrefences window]
#endif

@interface SysPrefences : NSObject
+ (CGSize)screenSize;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;
+ (CGRect)screenFrame;

#if PLAT_IOS
+ (CGFloat)statusBarHeight;

+ (id<UIApplicationDelegate>) appDelegate;
+ (UIWindow *)window;
+ (void)closeKeyboard;

+ (CGFloat)invalidViewHeight;
+ (CGFloat)validViewHeight;
+ (UINavigationBar *)navigationBar;

// 在viewDidLoad中无法使用(currentViewController为nil)
+ (CGFloat)tabBarHeight;
+ (CGFloat)navigationBarHeight;
+ (UIViewController *)currentViewController;
#endif
@end
