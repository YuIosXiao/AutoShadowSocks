//
//  SCDataTable.h
//  sma11case
//
//  Created by sma11case on 11/24/15.
//  Copyright © 2015 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../Macros.h"
#import "SCObject.h"

@interface SCDataTable : NSObject
@property (nonatomic, assign, readonly) NSUInteger count;

+ (instancetype)tableWithColumnCount: (NSUInteger)count;
- (instancetype)initWithColumnCount: (NSUInteger)count;
- (void)reset;
- (void)removeAllRows;
- (void)addRowWithArray: (NSArray *)datas;
- (id)elementWithRow: (NSUInteger)row column: (NSUInteger)column;
- (void)setElementWithRow: (NSUInteger)row column: (NSUInteger)column value: (id)object;
- (void)setRowWithArray: (NSArray *)datas row: (NSUInteger)row;
- (NSMutableArray *)objectsAtRow: (NSUInteger)idx;
- (void)removeRow: (NSUInteger)row;
- (void)removeLastRow;

#if !IS_DEV_MODE
- (instancetype)init SC_DISABLED;
#endif
@end
