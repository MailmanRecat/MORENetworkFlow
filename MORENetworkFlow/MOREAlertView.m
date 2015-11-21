//
//  MOREAlertView.m
//  MORENetworkFlow
//
//  Created by caine on 11/21/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "NSLayoutConstraint+SpectacledBearEdgeConstraint.h"
#import "UIFont+MaterialDesignIcons.h"
#import "UIWindow+MOREAlertView.h"

#import "MOREAlertView.h"

@implementation MOREAlertView

+ (instancetype)shareAlert{
    static MOREAlertView *alert = nil;
    
    if( alert ) return alert;
    
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        alert = [MOREAlertView new];
        
        [alert loadContent];
    });
    
    return alert;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}

- (void)loadContent{
    UILabel *icon = [UILabel new];
    icon.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:icon];
    _icon = icon;
    
    icon.font = [UIFont MaterialDesignIconsWithSize:19];
    icon.textAlignment = NSTextAlignmentCenter;
    
    [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:icon to:self type:EdgeTopLeftZero constant:24]];
    [icon addConstraints:[NSLayoutConstraint SpactecledBearFixed:icon type:SpactecledBearFixedEqual constant:36]];
    
    UILabel *info = [UILabel new];
    info.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:info];
    _message = info;
    
    info.font = [UIFont fontWithName:@"Roboto-bold" size:17];
    
    [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:info to:self type:EdgeTopRightZero constant:24]];
    [info addConstraints:[NSLayoutConstraint SpactecledBearFixed:info type:SpactecledBearFixedHeight constant:36]];
    [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:info to:self type:EdgeLeftZero constant:36 + 24]];
    
    UIButton *cancel = [UIButton new];
    UIButton *confirm = [UIButton new];
    _cancel = cancel;
    _cancel.backgroundColor = [UIColor clearColor];
    _confirm = confirm;
    _confirm.backgroundColor = [UIColor whiteColor];
    
    [_confirm addTarget:self action:@selector(didConfirm) forControlEvents:UIControlEventTouchUpInside];
    [_cancel addTarget:self action:@selector(didCancel) forControlEvents:UIControlEventTouchUpInside];
    
    for( UIButton *button in @[ cancel, confirm ] ){
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:button];
        
        [button addConstraints:[NSLayoutConstraint SpactecledBearFixed:button type:SpactecledBearFixedHeight constant:36]];
        [button addConstraints:[NSLayoutConstraint SpactecledBearFixed:button type:SpactecledBearFixedWidth constant:98]];
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:button to:self type:EdgeBottomZero constant:8]];
        
        button.titleLabel.font = [UIFont fontWithName:@"Roboto-bold" size:15];
    }
    
    [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:confirm to:self type:EdgeRightZero constant:16]];
    [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:cancel to:self type:EdgeRightZero constant:16 + 98 + 16]];
    
    confirm.layer.cornerRadius = 3.0f;
    confirm.layer.shadowColor = [UIColor blackColor].CGColor;
    confirm.layer.shadowOffset = CGSizeMake(0, 1);
    confirm.layer.shadowRadius = 3;
    confirm.layer.shadowOpacity = 0.17;
}

- (void)didConfirm{
    
    if( _delegate && [_delegate respondsToSelector:@selector(MOREAlertDidConfirm)] )
        [_delegate MOREAlertDidConfirm];
        
    [self.window MOREAlertDismiss];
}

- (void)didCancel{
    
    if( _delegate && [_delegate respondsToSelector:@selector(MOREAlertDidCancel)] )
        [_delegate MOREAlertDidCancel];
    
    [self.window MOREAlertDismiss];
}

@end
