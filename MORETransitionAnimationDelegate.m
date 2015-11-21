//
//  MORETransitionAnimationDelegate.m
//  MORENetworkFlow
//
//  Created by caine on 10/5/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "MORETransitionAnimationDelegate.h"

@implementation MORETransitionAnimationDelegate

- (instancetype)init{
    
    self = [super init];
    if( self ){
        
        self.animationPresent = [MORETransitionAnimationPresent new];
        self.animationDismiss = [MORETransitionAnimationDismiss new];
        
    }
    
    return self;
    
}

- (instancetype)initWithV{
    
    self = [super init];
    if( self ){
        
        self.animationPresentV = [MORETransitionAnimationPresentV new];
        self.animationDismissV = [MORETransitionAnimationDismissV new];
        
    }
    
    return self;
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    if( self.animationPresent )
        return self.animationPresent;
    else
        return self.animationPresentV;
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    if( self.animationDismiss )
        return self.animationDismiss;
    else
        return self.animationDismissV;
    
}

@end
