//
//  SharedArray.h
//  sma11case
//
//  Created by sma11case on 11/8/15.
//  Copyright © 2015 sma11case. All rights reserved.
//

#if !UseShareMethod
#import <Foundation/Foundation.h>
@protocol SCSharedArray <NSObject>
#endif

- (id)anyObject;
- (NSArray *)findElementWithClassType: (Class)cls maxCount: (NSUInteger)count;
- (NSMutableArray *)debugScription;
- (BOOL)isSameOfArray: (NSArray *)compare;

#if !UseShareMethod
@end
#endif
