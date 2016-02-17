//
//  SharedMutableArray.h
//  sma11case
//
//  Created by sma11case on 11/17/15.
//  Copyright © 2015 sma11case. All rights reserved.
//

#if !UseShareMethod
#import <Foundation/Foundation.h>
@protocol SCSharedMutableArray <NSObject>
#endif

- (void)addObjectsWithVAList: (id)first, ...;
- (void)removeObjectsWithVAList: (id)first, ...;
- (void)appendArray: (NSArray *)temp;

#if !UseShareMethod
@end
#endif
