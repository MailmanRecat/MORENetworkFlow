//
//  MORETransitionAnimationPresent.m
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "MORETransitionAnimationPresent.h"

@implementation MORETransitionAnimationPresent

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 1.f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    // 1. Get controllers from transition context
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // 2. Set init frame for toVC
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    //    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    CGRect finalFrame = CGRectMake(0, 0, toVC.view.frame.size.width, toVC.view.frame.size.height);
    //    toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);
    toVC.view.frame = CGRectMake(screenBounds.size.width, 0, toVC.view.frame.size.width, toVC.view.frame.size.height);
    
    UIView *bg = [[UIView alloc] initWithFrame:screenBounds];
    bg.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    bg.tag = 7777;
    
    // 3. Add toVC's view to containerView
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toVC.view];
    
    [containerView insertSubview:bg belowSubview:toVC.view];
    
    // 4. Do animate now
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
//    [UIView animateWithDuration:duration
//                          delay:0.0f
//                        options:UIViewAnimationOptionCurveEaseIn
//                     animations:^{
//                         
//                         toVC.view.frame = finalFrame;
//                         bg.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.97];
//                         
//                     }completion:^( BOOL Finished ){
//                         [transitionContext completeTransition:YES];
//                     }];
//    [UIView animateWithDuration:duration
//                     animations:^{
//                         
//                         fromVC.view.transform = CGAffineTransformMakeScale(0.93, 0.95);
//                         toVC.view.frame = finalFrame;
//                         bg.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.97];
//                         
//                     }completion:^( BOOL Finished ){
//                         [transitionContext completeTransition:YES];
//                     }];
    
    [UIView animateWithDuration:duration
                          delay:0.0f
                        options:(7 << 16)
                     animations:^{
                         
                         fromVC.view.transform = CGAffineTransformMakeScale(0.93, 0.95);
                         toVC.view.frame = finalFrame;
                         bg.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.97];
                         
                     }completion:^( BOOL Finished ){
                         [transitionContext completeTransition:YES];
                     }];
    
}

@end
