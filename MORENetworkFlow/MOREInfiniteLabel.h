//
//  MOREInfiniteLabel.h
//  MORENetworkFlow
//
//  Created by caine on 11/18/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOREInfiniteLabel : UIScrollView

@property( nonatomic, assign ) NSTextAlignment testAlignment;
@property( nonatomic, strong ) UIFont *font;

- (instancetype)initWIthTitle:(NSString *)title color:(UIColor *)color;

- (void)doFuck:(NSString *)bill color:(UIColor *)color;

@end
