//
//  UIView+MOREStackLayoutView.h
//  more check
//
//  Created by caine on 11/11/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSLayoutConstraint+SpectacledBearEdgeConstraint.h"

typedef NS_ENUM(NSInteger, autolayoutStackOrientation){
    autolayoutStackOrientationHorizontal = 0,
    autolayoutStackOrientationVertical
};

typedef NS_ENUM(NSUInteger, autolayoutStackDirection){
    autolayoutStackDirectionTop = 0,
    autolayoutStackDirectionRight,
    autolayoutStackDirectionBottom,
    autolayoutStackDirectionLeft
};

typedef NS_ENUM(NSUInteger, autolayoutStackOption){
    autolayoutStackOptionLeading = 0,
    autolayoutStackOptionTrailing
};

@interface UIView (MOREStackLayoutView)

//use autolayoutPushSubviews for UIview
//use autolayoutSubviews     for UIScrollView

- (void)autolayoutSubviews:(NSArray *)subviews
                edgeInsets:(UIEdgeInsets)insets
                multiplier:(CGFloat)multiplier
                 constants:(CGFloat)constant
          stackOrientation:(autolayoutStackOrientation)orientation;

- (void)autolayoutPushSubviews:(NSArray *)subviews
                edgeInsets:(UIEdgeInsets)insets
                multiplier:(CGFloat)multiplier
                 constants:(CGFloat)constant
          stackOrientation:(autolayoutStackOrientation)orientation;

- (void)autolayoutSubviews:(NSArray *)subviews
                edgeInsets:(UIEdgeInsets)insets
                multiplier:(CGFloat)multiplier
                  constant:(CGFloat)constant
                 constants:(NSArray *)constants
          stackOrientation:(autolayoutStackOrientation)orientation
                 direction:(autolayoutStackDirection)direction
                    option:(autolayoutStackOption)option;

- (void)autolayoutPushSubviews:(NSArray *)subviews
                    edgeInsets:(UIEdgeInsets)insets
                     constants:(NSArray *)constants
              stackOrientation:(autolayoutStackOrientation)orientation
                     direction:(autolayoutStackDirection)direction
                        option:(autolayoutStackOption)option;

@end
