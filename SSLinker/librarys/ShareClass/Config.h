//
//  Config.h
//  sma11case
//
//  Created by sma11case on 15/8/11.
//  Copyright (c) 2015年 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TargetConditionals.h>

#define PLAT_WATCH 0
#define IS_SMA11CASE_VERSION 0

#ifndef PLAT_IOS
#if (TARGET_OS_IPHONE && !TARGET_OS_MAC)
#define PLAT_IOS 1
#endif
#endif

#ifndef PLAT_OSX
#if (TARGET_OS_MAC && !TARGET_OS_IPHONE)
#define PLAT_OSX 1
#endif
#endif

#ifdef DEBUG
#define IS_DEBUG_MODE 1
#endif

#ifndef USE_NSLOGGER
#define USE_NSLOGGER 0000
#endif

#ifndef TARGET_OS_IPHONE
#define TARGET_OS_IPHONE PLAT_IOS
#endif

#ifndef TARGET_OS_IOS
#define TARGET_OS_IOS PLAT_IOS
#endif

#ifndef TARGET_OS_WATCH
#define TARGET_OS_WATCH PLAT_WATCH
#endif

#if PLAT_IOS
#import <UIKit/UIKit.h>
#endif

#if PLAT_OSX
#import <Cocoa/Cocoa.h>
#endif


