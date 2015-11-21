//
//  MOREProgressView.h
//  GGAnimationTestProject
//
//  Created by caine on 11/17/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MOREProgressView : UIView

@property( nonatomic, strong ) UIColor *trackColor;

@property( nonatomic, assign, readonly ) CGFloat progress;

- (void)setProgress:(CGFloat)progress animation:(BOOL)animation;

@end
