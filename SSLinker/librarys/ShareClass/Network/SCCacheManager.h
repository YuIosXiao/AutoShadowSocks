//
//  SCCacheManager.h
//  sma11case
//
//  Created by sma11case on 12/25/15.
//  Copyright © 2015 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Objects/SCObject.h"

#define DefaultIDMaxQueueCount 20UL

typedef void(^CacheBlock)(NSData *data, BOOL isFromCache);

typedef NS_ENUM(NSUInteger, CacheType)
{
    CacheTypeUnknow = 0,
    CacheTypeMemory = 1,
    CacheTypeFile = 2,
};

@interface SCCacheManager : NSObject
@property (nonatomic, strong, readonly) NSString *cacheDirPath;
@property (nonatomic, assign, readonly) NSUInteger maxQueueCount;

- (instancetype)initWithCacheDir: (NSString *)path maxQueueCount: (NSUInteger)count;
- (void)cancelAllOperations;
- (void)setCache: (NSData *)object forPath: (NSString *)path;
- (void)removeAllCachesWithType: (CacheType)type;
- (void)removeCacheWithPath: (NSString *)path isMaskFileName: (BOOL)mfn type: (CacheType)type;
- (void)cacheWithPath: (NSString *)path keepInMemory: (BOOL)kim forceMaskFileName: (BOOL)mmn block: (CacheBlock)block;
@end
