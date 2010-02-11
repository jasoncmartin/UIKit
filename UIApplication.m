//
//  UIApplication.m
//  UIKit
//
//  Created by Jason C. Martin on 2/8/10.
//  Copyright 2010 New Media Geekz. All rights reserved.
//

#import "UIApplication.h"

NSString *const UIApplicationDidFinishLaunchingNotification = @"UIApplicationDidFinishLaunchingNotification";
NSString *const UIApplicationDidBecomeActiveNotification = @"UIApplicationDidBecomeActiveNotification";

@implementation UIApplication

@synthesize applicationIconBadgeNumber, shouldTerminateAfterLastWindowClosed, dockMenu, delegate;

static UIApplication *sharedApplication = nil;

+ (void)initialize {
	if([self class] == [UIApplication class]) {
		[[NSApplication sharedApplication] setDelegate:[UIApplication sharedApplication]];
	}
}

+ (UIApplication *)sharedApplication
{
    @synchronized(self)
    {
        if (sharedApplication == nil)
        {
            sharedApplication = [[self alloc] init];
        }
    }
    
    return sharedApplication;
}

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (sharedApplication == nil)
        {
            sharedApplication = [super allocWithZone:zone];
            return sharedApplication;
        }
    }
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (id)retain
{
    return self;
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;
}

- (void)release
{
}

- (id)autorelease
{
    return self;
}

- (id)init {
	if(self = [super init]) {
		NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
		
		if([info valueForKey:@"CFBundleURLTypes"]) {
			[[NSAppleEventManager sharedAppleEventManager] setEventHandler:self andSelector:@selector(getUrl:withReplyEvent:) forEventClass:kInternetEventClass andEventID:kAEGetURL];
		}
		
		shouldTerminateAfterLastWindowClosed = NO;
		dockMenu = nil;
		
		applicationIconBadgeNumber = 0;
	}
	
	return self;
}

- (void)setApplicationIconBadgeNumber:(NSInteger)num {
	if(num == applicationIconBadgeNumber)
		return;
	
	applicationIconBadgeNumber = num;
	
	if(applicationIconBadgeNumber != 0) {
		[[[NSApplication sharedApplication] dockTile] setBadgeLabel:[NSString stringWithFormat:@"%i", applicationIconBadgeNumber]];
	} else {
		[[[NSApplication sharedApplication] dockTile] setBadgeLabel:nil];
	}
}

- (UIWindow *)keyWindow {
	return (UIWindow *)[[NSApplication sharedApplication] keyWindow];
}

- (NSArray *)windows {
	NSArray *windows = [[[NSApplication sharedApplication] windows] copy];
	NSMutableArray *uiWindows = [[NSMutableArray array] copy];
	
	for(NSWindow *window in windows) {
		[uiWindows addObject:(UIWindow *)window];
	}
	
	[windows release];
	
	return [uiWindows autorelease];
}

- (void)sendEvent:(UIEvent *)event {
	[[NSApplication sharedApplication] sendEvent:event];
}

- (void)hide:(id)sender {
	[[NSApplication sharedApplication] hide:sender];
}

- (void)unhide:(id)sender {
	[[NSApplication sharedApplication] unhide:sender];
}

- (void)hideOtherApplications:(id)sender {
	[[NSApplication sharedApplication] hideOtherApplications:sender];
}

- (void)unhideAllApplications:(id)sender {
	[[NSApplication sharedApplication] unhideAllApplications:sender];
}

- (void)terminate:(id)sender {
	[[NSApplication sharedApplication] terminate:sender];
}

- (void)replyToApplicationShouldTerminate:(BOOL)shouldTerminate {
	[[NSApplication sharedApplication] replyToApplicationShouldTerminate:shouldTerminate];
}

- (BOOL)openURL:(NSURL *)url {
	return [[NSWorkspace sharedWorkspace] openURL:url];
}

- (BOOL)canOpenURL:(NSURL *)url {
	FSRef eh;
	
	return LSGetApplicationForURL((CFURLRef)url, kLSRolesAll, &eh, NULL) != kLSApplicationNotFoundErr;
}

- (void)getUrl:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent {
	NSString *url = [[event paramDescriptorForKeyword:keyDirectObject] stringValue];
	
	if([_delegate respondsToSelector:@selector(application:handleOpenURL:)]) {
		[_delegate application:self handleOpenURL:[NSURL URLWithString:url]];
	}
}

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
	return shouldTerminateAfterLastWindowClosed;
}

- (void)applicationDidFinishLaunching:(NSNotification *)notification {
	if([_delegate respondsToSelector:@selector(applicationDidFinishLaunching:)]) {
		[_delegate applicationDidFinishLaunching:self];
	}
}

@end
