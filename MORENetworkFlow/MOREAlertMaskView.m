//
//  MOREAlertMaskView.m
//  MORENetworkFlow
//
//  Created by caine on 11/21/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "NSLayoutConstraint+SpectacledBearEdgeConstraint.h"
#import "UIWindow+MOREAlertView.h"
#import "MOREAlertMaskView.h"

@implementation MOREAlertMaskView

+ (instancetype)shareMask{
    static MOREAlertMaskView *mask = nil;
    
    if( mask ) return mask;
    
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        mask = [MOREAlertMaskView new];
        
        [mask loadAlert];
    });
    
    return mask;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if( !_answerRequire )
        [self.window MOREAlertDismiss];
}

- (void)loadAlert{
    MOREAlertView *alert = [MOREAlertView shareAlert];
    alert.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:alert];
    
    _alert = alert;
    
    alert.backgroundColor = [UIColor whiteColor];
    alert.layer.shadowColor = [UIColor blackColor].CGColor;
    alert.layer.shadowOpacity = 0.25f;
    alert.layer.shadowOffset = CGSizeMake(0, -0.7);
    alert.layer.shadowRadius = 1.57;
    
    NSLayoutConstraint *bottomCon = [NSLayoutConstraint SpactecledBearEdeg:alert to:self type:EdgeBottomZero constant:-138][0];
    _bottomConstraint = bottomCon;
    [self addConstraint:bottomCon];
    [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:alert to:self type:EdgeLeftRightZero]];
    [self addConstraints:[NSLayoutConstraint SpactecledBearFixed:alert type:SpactecledBearFixedHeight constant:138]];
}

@end
