//
//  UIWindow.m
//  UIKit
//
//  Created by Jason C. Martin on 2/10/10.
//  Copyright 2010 New Media Geekz. All rights reserved.
//

#import "UIWindow.h"


@implementation UIWindow

- (id)initWithFrame:(NSRect)aFrame {
	if(self = [super initWithContentRect:aFrame styleMask:(NSTitledWindowMask | NSClosableWindowMask | NSMiniaturizableWindowMask | NSResizableWindowMask) backing:NSBackingStoreRetained defer:YES]) {

	}
	
	return self;
}

- (void)addSubview:(UIView *)aView {
	[[self contentView] addSubview:aView];
}

@end
