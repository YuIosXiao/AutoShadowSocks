//
//  Masorny+Ext.h
//  ibosvip
//
//  Created by sma11case on 15/7/24.
//  Copyright (c) 2015年 ibos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Masonry/Masonry.h"
#import "ViewsConfig.h"

typedef void(^MasonryBlock)(MASConstraintMaker *make);

@interface MASConstraint(sma11case_ShareClass)
- (MASConstraint *)equalToZero;
@end

@interface CPView(sma11case_shareClass)

// 使用前需要先设置大小 make.size.equalTo(); 首个元素需要设置位置
- (void)distributeSpacingWithVertically:(NSArray*)views edge: (CPEdgeInsets)edge;
- (void)distributeSpacingWithHorizontally:(NSArray*)views edge: (CPEdgeInsets)edge;
@end

