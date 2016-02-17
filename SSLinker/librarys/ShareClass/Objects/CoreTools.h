//
//  CoreTools.h
//  sma11case
//
//  Created by sma11case on 9/2/15.
//  Copyright (c) 2015 sma11case. All rights reserved.
//

#import "SCObject.h"
#import "SCModel.h"

#if PLAT_OSX
#define GetUsedMemory() [CoreTools getUsedMemory]
#define SetSystemSleepMode(x) [CoreTools disableSystemSleep:x]
#else
#define GetUsedMemory()
#define SetSystemSleepMode(x)
#endif

#define GetAvailableMemory() [CoreTools getAvailableMemory]

typedef NS_ENUM(NSUInteger, SystemSleepFeatureType)
{
    SystemSleepTypeUnknow = 0,
    SystemSleepTypeDisplaySleepOn,
    SystemSleepTypeDisplaySleepOff,
    SystemSleepTypeIdleSleepOn,
    SystemSleepTypeIdleSleepOff
};

typedef BOOL(^enumContainterElements)(id parent, NSUInteger level, id index, id element, id userParam);

@interface ArgumentParam : SCModel
@property (nonatomic, strong) id param;
@property (nonatomic, strong) NSString *type;
@end

@interface CoreTools : NSObject
+ (double)getAvailableMemory;
+ (void)enumElementsFromObject: (id)object userParam: (id)param block: (enumContainterElements)block;

#if PLAT_OSX
+ (double)getUsedMemory;
+ (void)disableSystemSleep: (SystemSleepFeatureType)type;
+ (NSString *)executeCommand: (NSString *)cmd waitFinished: (BOOL)wait;
+ (NSArray *)getAllProcessWorkDirs;
#endif
@end
