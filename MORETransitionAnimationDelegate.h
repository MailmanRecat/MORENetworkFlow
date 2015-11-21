//
//  MORETransitionAnimationDelegate.h
//  MORENetworkFlow
//
//  Created by caine on 10/5/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "MORETransitionAnimationPresent.h"
#import "MORETransitionAnimationDismiss.h"

#import "MORETransitionAnimationPresentV.h"
#import "MORETransitionAnimationDismissV.h"

@interface MORETransitionAnimationDelegate : NSObject<UIViewControllerTransitioningDelegate>

@property( nonatomic, strong ) MORETransitionAnimationPresent *animationPresent;
@property( nonatomic, strong ) MORETransitionAnimationDismiss *animationDismiss;

@property( nonatomic, strong ) MORETransitionAnimationPresentV *animationPresentV;
@property( nonatomic, strong ) MORETransitionAnimationDismissV *animationDismissV;

- (instancetype)initWithV;

@end
