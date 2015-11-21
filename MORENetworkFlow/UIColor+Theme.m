//
//  UIColor+Theme.m
//  MORENetworkFlow
//
//  Created by caine on 10/25/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "UIColor+Theme.h"

@implementation UIColor (Theme)

+ (UIColor *)backgroundColor{
    return [UIColor colorWithRed:33 / 255.0 green:33 / 255.0 blue:33 / 255.0 alpha:1];
}

+ (UIColor *)textColor{
    return [UIColor colorWithRed:41 / 255.0 green:164 / 255.0 blue:246 / 255.0 alpha:1];
}

+ (UIColor *)subTextColor{
    return [UIColor colorWithRed:31 / 255.0 green:49 / 255.0 blue:72 / 255.0 alpha:1];
}

+ (UIColor *)googleBlue{
    return [UIColor colorWithRed:61 / 255.0 green:138 / 255.0 blue:248 / 255.0 alpha:1];
}

+ (UIColor *)googleRed{
    return [UIColor colorWithRed:249 / 255.0 green:58 / 255.0 blue:57 / 255.0 alpha:1];
}

+ (UIColor *)googleYellow{
    return [UIColor colorWithRed:251 / 255.0 green:185 / 255.0 blue:62 / 255.0 alpha:1];
}

+ (UIColor *)googleGreen{
    return [UIColor colorWithRed:48 / 255.0 green:176 / 255.0 blue:81 / 255.0 alpha:1];
}

+ (UIColor *)randomColor{
    return [UIColor colorWithRed:[self randomRGB] green:[self randomRGB] blue:[self randomRGB] alpha:1];
}

+ (UIColor *)randomColorWithOpacity:(CGFloat)opacity{
    return [UIColor colorWithRed:[self randomRGB] green:[self randomRGB] blue:[self randomRGB] alpha:opacity];
}

+ (CGFloat)randomRGB{
    return (arc4random() % 255) / 255.0;
}

@end
