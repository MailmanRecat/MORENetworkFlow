//
//  MOREDataButtonCell.m
//  MORENetworkFlow
//
//  Created by caine on 11/20/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "UIView+MOREStackLayoutView.h"

#import "MOREDataButtonCell.h"

@implementation MOREDataButtonCell

- (instancetype)init{
    self = [super init];
    if( self ){
        
        _action = [UIButton new];
        _action.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_action];
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_action to:self type:EdgeTopBottomZero constant:10]];
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_action to:self type:EdgeLeftZero constant:56 + 16]];
        [self addConstraints:[NSLayoutConstraint SpactecledBearFixed:_action
                                                                type:SpactecledBearFixedHeight
                                                            constant:36]];
        [self addConstraints:[NSLayoutConstraint SpactecledBearFixed:_action
                                                                type:SpactecledBearFixedWidth
                                                            constant:150]];
        
        _action.layer.cornerRadius = 3.0f;
        _action.layer.shadowColor = [UIColor blackColor].CGColor;
        _action.layer.shadowOffset = CGSizeMake(0, 1);
        _action.layer.shadowRadius = 3;
        _action.layer.shadowOpacity = 0.17;
        
        _action.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
