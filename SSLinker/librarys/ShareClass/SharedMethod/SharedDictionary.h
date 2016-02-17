//
//  SharedDictionary.h
//  sma11case
//
//  Created by sma11case on 11/8/15.
//  Copyright © 2015 sma11case. All rights reserved.
//

#if !UseShareMethod
#import <Foundation/Foundation.h>
@protocol SCSharedDictionary <NSObject>
#endif

- (id)objectForICaseKey:(id)aKey;
- (NSString *)generateModelPropertyString;
- (NSMutableDictionary *)dictionaryWithKeys: (NSArray *)keys;
- (id)randomKeyObject;
- (id)randomValueObject;
- (NSArray *)findKeyWithValueClassType: (Class)cls maxCount: (NSUInteger)count;
- (NSArray *)findValueWithClassType: (Class)cls maxCount: (NSUInteger)count;
- (BOOL)saveAsJsonFile: (NSString *)path;
- (NSMutableDictionary *)debugScription;

#if !UseShareMethod
@end
#endif
