//
//  UIKit_DemoAppDelegate.m
//  UIKit Demo
//
//  Created by Jason C. Martin on 2/13/10.
//  Copyright 2010 New Media Geekz. All rights reserved.
//

#import "UIKit_DemoAppDelegate.h"
#import <UIKit/UIKit.h>

@implementation UIKit_DemoAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)app {
	// Insert code here to initialize your application
	
	[window makeKeyAndOrderFront:nil];
}

- (IBAction)setBadge:(id)sender {
	[[UIApplication sharedApplication] setApplicationIconBadgeNumber:[sender intValue]];
}

@end
