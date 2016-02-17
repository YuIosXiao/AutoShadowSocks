//
//  SCModel.h
//  sma11case
//
//  Created by sma11case on 15/8/23.
//  Copyright (c) 2015年 sma11case. All rights reserved.
//

#import "SCObject.h"

typedef id(^SetValueBlock)(NSString *name, NSString *attribute, BOOL *notUpdate);

@interface SCModel : NSObject <NSCoding>
@property (nonatomic, strong, readonly) NSMutableDictionary *dictionary;

+ (instancetype)modelWithDictionary: (NSDictionary *)dictionary;
- (BOOL)cachePropertyList;
- (void)updateWithDictionary: (NSDictionary *)dictionary;
- (NSMutableDictionary *)dictionaryWithRecursive: (BOOL)recursive;
- (NSMutableDictionary *)dictionaryWithKeys: (NSArray *)keys;
- (void)replaceObjectValue: (id)oValue toValue: (id)nValue recursive: (BOOL)recursive;
- (void)setAllValueWithBlock: (SetValueBlock)block;
@end
