//
//  MORETransitionAnimationDismissV.m
//  MORENetworkFlow
//
//  Created by caine on 10/9/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "MORETransitionAnimationDismissV.h"

@implementation MORETransitionAnimationDismissV

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.25f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    // 1. Get controllers from transition context
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 2. Set init frame for fromVC
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGRect finalFrame = CGRectMake(0, screenBounds.size.height, fromVC.view.frame.size.width, fromVC.view.frame.size.height);
    
    // 3. Add target view to the container, and move it to back.
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    [containerView sendSubviewToBack:toVC.view];
    
    UIView *view = [containerView viewWithTag:7777];
    
    // 4. Do animate now
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:( 7 << 16 )
                     animations:^{
                         
                         toVC.view.transform = CGAffineTransformMakeScale(1, 1);
                         fromVC.view.frame = finalFrame;
                         view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
                         
                     }completion:^( BOOL Finished ){
                         [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
                     }];
    
}


@end
