//
//  NSData+SC.h
//  sma11case
//
//  Created by sma11case on 9/6/15.
//  Copyright (c) 2015 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData(sma11case_ShareClass)
- (NSDictionary *)toDictionaryByArchivedData;
- (NSDictionary *)toDictionaryByJsonData;
- (NSString *)toUTF8String;
- (NSString *)toStringWithEncoding: (NSStringEncoding)code;
- (NSArray *)toArray;
@end
