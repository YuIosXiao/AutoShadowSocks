//
//  SCDataModel.h
//  sma11case
//
//  Created by sma11case on 8/30/15.
//  Copyright (c) 2015 sma11case. All rights reserved.
//

#import "../Objects/SCModel.h"
#import "../ExternalsSource/ExternalsSource.h"

extern NSString *const SCDataModelTypeFilePath;
extern NSString *const SCDataModelTypeFileData;
extern NSString *const SCDataModelTypeUseBlock;

typedef void(^SCFormDataBlock)(id <AFMultipartFormData> formData, id content);

@interface SCDataModel : SCModel
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) id content;
@end
