//
//  SingletonManager.h
//  sma11case
//
//  Created by sma11case on 15/8/23.
//  Copyright (c) 2015年 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCObject.h"

@interface SingletonManager : NSObject
@property (nonatomic, strong, readonly) NSMutableDictionary *singletons;

- (void)setSingleton: (id)obj;
- (void)removeSingleton: (Class)cls;
- (id)newSingleton: (Class)cls;
- (id)getSingleton: (Class)cls;
@end
