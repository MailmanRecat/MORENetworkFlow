//
//  UIWindow+MOREAlertView.m
//  MORENetworkFlow
//
//  Created by caine on 11/21/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "NSLayoutConstraint+SpectacledBearEdgeConstraint.h"

//#import "MOREAlertQueue.h"
#import "MOREAlertStack.h"

#import "UIWindow+MOREAlertView.h"

@implementation UIWindow (MOREAlertView)

- (void)MOREAlertWithMaterialFontIcon:(NSString *)icon
                              message:(NSString *)message
                              confirm:(NSString *)confirm
                               cancel:(NSString *)cancel
                               colors:(NSArray *)colors
                        answerRequire:(BOOL)require
                             delegate:(id<MOREAlertDelegate>)delegate{
    
    if( ![colors isKindOfClass:[NSArray class]] && [colors count] != 6 ) return;
    
    [[MOREAlertStack shareAlertStack] addAlert:@{
                                                 MOREALERT_ICON_KEY: icon,
                                                 MOREALERT_MESSAGE_KEY: message,
                                                 MOREALERT_CONFIRM_KEY: confirm,
                                                 MOREALERT_CANCEL_KEY: cancel,
                                                 MOREALERT_COLORS_KEY: colors,
                                                 MOREALERT_REQUIRE_KEY: @(require),
                                                 MOREALERT_DELEGATE_KET: delegate
                                                 }];
}

- (void)MOREAlertShow{
    [self doFuck:[[MOREAlertStack shareAlertStack] popAlert]];
}

- (void)doFuck:(NSDictionary *)alert{
    
    UIColor *bearColor = (UIColor *)alert[MOREALERT_COLORS_KEY][0];
    UIColor *alertColor = (UIColor *)alert[MOREALERT_COLORS_KEY][1];
    
    MOREAlertMaskView *bear = [MOREAlertMaskView shareMask];
    bear.answerRequire = [alert[MOREALERT_REQUIRE_KEY] boolValue];
    
    bear.alert.delegate = [alert objectForKey:MOREALERT_DELEGATE_KET];
    bear.alert.icon.text = [alert objectForKey:MOREALERT_ICON_KEY];
    bear.alert.message.text = [alert objectForKey:MOREALERT_MESSAGE_KEY];
    [bear.alert.confirm setTitle:[alert objectForKey:MOREALERT_CONFIRM_KEY] forState:UIControlStateNormal];
    [bear.alert.cancel setTitle:[alert objectForKey:MOREALERT_CANCEL_KEY] forState:UIControlStateNormal];
    
    bear.alert.backgroundColor = alertColor;
    bear.alert.icon.textColor = alert[MOREALERT_COLORS_KEY][2];
    bear.alert.message.textColor = alert[MOREALERT_COLORS_KEY][3];
    [bear.alert.confirm setTitleColor:alert[MOREALERT_COLORS_KEY][4] forState:UIControlStateNormal];
    [bear.alert.cancel setTitleColor:alert[MOREALERT_COLORS_KEY][5] forState:UIControlStateNormal];
    
    bear.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:bear];
    [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:bear to:self type:EdgeAroundZero]];
    
    bear.backgroundColor = [bearColor colorWithAlphaComponent:0.0f];
    
    [bear layoutIfNeeded];
    bear.bottomConstraint.constant = 0;
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options:( 7 << 16 )
                     animations:^{
                         
                         bear.backgroundColor = [bearColor colorWithAlphaComponent:0.27f];
                         [bear layoutIfNeeded];
                     }completion:nil];
}

- (void)MOREAlertDismiss{
    
    MOREAlertMaskView *bear = [MOREAlertMaskView shareMask];
    bear.bottomConstraint.constant = 138;
    
    [UIView animateWithDuration:0.25f
                          delay:0.0f
                        options:( 7 << 16 )
                     animations:^{
                         bear.backgroundColor = [UIColor colorWithWhite:0 / 255.0 alpha:0];
                         [bear layoutIfNeeded];
                         
                     }completion:^( BOOL isFinished ){
                         
                         NSDictionary *alert = [[MOREAlertStack shareAlertStack] popAlert];
                         alert ? [self doFuck:alert] : [bear removeFromSuperview];
                     }];
}

@end
