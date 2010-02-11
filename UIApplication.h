//
//  UIApplication.h
//  UIKit
//
//  Created by Jason C. Martin on 2/8/10.
//  Copyright 2010 New Media Geekz. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import <UIKit/UIKitDefines.h>
#import <UIKit/UIEvent.h>
#import <UIKit/UIResponder.h>

@class UIView, UIWindow;
@protocol UIApplicationDelegate;

typedef enum {
	UICriticalRequest = 0,
	UIInformationalRequest = 10
} UIRequestUserAttentionType;

typedef enum {
	UITerminateCancel = 0,
	UITerminateNow = 1, 
	UITerminateLater = 2
} UIApplicationTerminateReply;

#ifndef MAC_OS_X_VERSION_10_6
UIKIT_EXTERN_CLASS @interface UIApplication : UIResponder {
#else
UIKIT_EXTERN_CLASS @interface UIApplication : UIResponder <NSApplicationDelegate> {
#endif
@package
	id <UIApplicationDelegate>  _delegate;
	NSMenu *dockMenu;
	
	NSInteger applicationIconBadgeNumber;
	BOOL shouldTerminateAfterLastWindowClosed;
}

+ (UIApplication *)sharedApplication;

@property(nonatomic,assign) id<UIApplicationDelegate> delegate;

- (BOOL)openURL:(NSURL*)url;
- (BOOL)canOpenURL:(NSURL *)url;

- (void)sendEvent:(UIEvent *)event;

@property(nonatomic,readonly) UIWindow *keyWindow;
@property(nonatomic,readonly) NSArray  *windows;

@property(nonatomic) NSInteger applicationIconBadgeNumber;  // set to 0 to hide. default is 0

@property (nonatomic, assign) BOOL shouldTerminateAfterLastWindowClosed;
@property (nonatomic, copy) NSMenu *dockMenu;

@end

@interface UIApplication (NSApplicationAdditions)

- (void)hide:(id)sender;
- (void)unhide:(id)sender;

- (void)hideOtherApplications:(id)sender;
- (void)unhideAllApplications:(id)sender;

- (void)terminate:(id)sender;

- (void)replyToApplicationShouldTerminate:(BOOL)shouldTerminate;

@end

@protocol UIApplicationDelegate<NSObject>

@optional

- (void)applicationDidFinishLaunching:(UIApplication *)application;

- (void)applicationDidBecomeActive:(UIApplication *)application;
- (void)applicationWillResignActive:(UIApplication *)application;
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url;  // no equiv. notification. return NO if the application can't open for some reason

- (void)applicationSignificantTimeChange:(UIApplication *)application;        // midnight, carrier time update, daylight savings time change

// NSApplication Delegate Methods
- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender;

@end

UIKIT_EXTERN int UIApplicationMain(int argc, char *argv[], NSString *principalClassName, NSString *delegateClassName);

UIKIT_EXTERN NSString *const UIApplicationDidFinishLaunchingNotification;
UIKIT_EXTERN NSString *const UIApplicationDidBecomeActiveNotification;
UIKIT_EXTERN NSString *const UIApplicationWillResignActiveNotification;
UIKIT_EXTERN NSString *const UIApplicationWillTerminateNotification;
UIKIT_EXTERN NSString *const UIApplicationSignificantTimeChangeNotification;
UIKIT_EXTERN NSString *const UIApplicationLaunchOptionsURLKey; // userInfo constains NSURL with launch URL
UIKIT_EXTERN NSString *const UIApplicationLaunchOptionsSourceApplicationKey; // userInfo constains NSString with launch app bundle ID
UIKIT_EXTERN NSString *const UIApplicationLaunchOptionsRemoteNotificationKey; // userInfo constains NSDictionary with payload
UIKIT_EXTERN NSString *const UIApplicationLaunchOptionsAnnotationKey; // userInfo constains object with annotation property list
