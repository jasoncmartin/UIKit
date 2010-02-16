//
//  UIGraphics.h
//  UIKit
//
//  Created by Jason C. Martin on 2/10/10.
//  Copyright 2010 New Media Geekz. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <UIKit/UIKitDefines.h>

UIKIT_EXTERN CGContextRef UIGraphicsGetCurrentContext(void);
UIKIT_EXTERN void UIGraphicsPushContext(CGContextRef context); // Does Nothing
UIKIT_EXTERN void UIGraphicsPopContext(void); // Does Nothing