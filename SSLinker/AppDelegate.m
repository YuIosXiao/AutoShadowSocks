//
//  AppDelegate.m
//  SSLinker
//
//  Created by sma11case on 2/16/16.
//  Copyright © 2016 sma11case. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender
{
    return YES;
}

@end
