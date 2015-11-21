//
//  MOREPageView.h
//  GGAnimationTestProject
//
//  Created by caine on 11/18/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOREPageView : UIView

@property( nonatomic, strong ) UIColor *color;

- (instancetype)initWithCount:(NSUInteger)count;
- (void)updateIndex:(NSUInteger)index percentage:(CGFloat)percentage;

@end
