//
//  UIColor+Theme.h
//  MORENetworkFlow
//
//  Created by caine on 10/25/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Theme)

+ (UIColor *)backgroundColor;
+ (UIColor *)textColor;
+ (UIColor *)subTextColor;

+ (UIColor *)googleRed;
+ (UIColor *)googleBlue;
+ (UIColor *)googleGreen;
+ (UIColor *)googleYellow;

+ (UIColor *)randomColor;
+ (UIColor *)randomColorWithOpacity:(CGFloat)opacity;

@end
