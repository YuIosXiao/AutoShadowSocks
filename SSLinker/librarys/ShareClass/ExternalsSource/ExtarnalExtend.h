//
//  ExtarnalExtend.h
//  sma11case
//
//  Created by sma11case on 12/25/15.
//  Copyright © 2015 sma11case. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MWFeedParser/MWFeedParser.h"

extern NSString *const AVCaptureSessionPresetPhoto;
extern NSString *const AVCaptureSessionPresetHigh;
extern NSString *const AVCaptureSessionPresetMedium;
extern NSString *const AVCaptureSessionPresetLow;
extern NSString *const AVCaptureSessionPreset352x288;
extern NSString *const AVCaptureSessionPreset640x480;
extern NSString *const AVCaptureSessionPreset1280x720;
extern NSString *const AVCaptureSessionPreset1920x1080;
extern NSString *const AVCaptureSessionPresetiFrame960x540;
extern NSString *const AVCaptureSessionPresetiFrame1280x720;
extern NSString *const AVCaptureSessionPresetInputPriority;

@interface MWFeedParser(sma11case_ShareClass)
+ (void)parseWithData: (NSData *)data delegate:(id<MWFeedParserDelegate>)delegate;
+ (void)parseWithURL: (NSURL *)url delegate:(id<MWFeedParserDelegate>)delegate;
@end
