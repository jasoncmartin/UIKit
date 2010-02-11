//
//  UIGraphics.m
//  UIKit
//
//  Created by Jason C. Martin on 2/10/10.
//  Copyright 2010 New Media Geekz. All rights reserved.
//

#import "UIGraphics.h"

CGContextRef UIGraphicsGetCurrentContext(void) {
	return (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
}

void UIGraphicsPushContext(CGContextRef context) {
	// Does Nothing
}

void UIGraphicsPopContext(void) {
	// Does Nothing
}