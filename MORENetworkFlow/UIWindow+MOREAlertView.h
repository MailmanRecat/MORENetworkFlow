//
//  UIWindow+MOREAlertView.h
//  MORENetworkFlow
//
//  Created by caine on 11/21/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MOREAlertMaskView.h"

@interface UIWindow (MOREAlertView)

- (void)MOREAlertWithMaterialFontIcon:(NSString *)icon
                              message:(NSString *)message
                              confirm:(NSString *)confirm
                               cancel:(NSString *)cancel
                               colors:(NSArray *)colors
                        answerRequire:(BOOL)require
                             delegate:(id<MOREAlertDelegate>)delegate;
- (void)MOREAlertShow;
- (void)MOREAlertDismiss;

@end
