//
//  SharedMutableDictionary.h
//  sma11case
//
//  Created by sma11case on 11/17/15.
//  Copyright © 2015 sma11case. All rights reserved.
//

#if !UseShareMethod
#import <Foundation/Foundation.h>
@protocol SCSharedMutableDictionary <NSObject>
#endif

- (void)removeObjectsForKeysWithVAList:(id)first, ...;
- (void)appendDictionary: (NSDictionary *)temp;

#if !UseShareMethod
@end
#endif
