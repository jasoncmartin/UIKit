//
//  UIKit_DemoAppDelegate.h
//  UIKit Demo
//
//  Created by Jason C. Martin on 2/13/10.
//  Copyright 2010 New Media Geekz. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class UIWindow;

@interface UIKit_DemoAppDelegate : NSObject {
    UIWindow *window;
}

@property (assign) IBOutlet UIWindow *window;

- (IBAction)setBadge:(id)sender;

@end
