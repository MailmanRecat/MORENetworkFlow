//
//  MOREAlertMaskView.h
//  MORENetworkFlow
//
//  Created by caine on 11/21/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MOREAlertView.h"

@interface MOREAlertMaskView : UIView

@property( nonatomic, strong ) MOREAlertView *alert;
@property( nonatomic, assign ) BOOL answerRequire;
@property( nonatomic, strong ) NSLayoutConstraint *bottomConstraint;

+ (instancetype)shareMask;

@end
