//
//  MOREDateUICell.m
//  GGAnimationTestProject
//
//  Created by caine on 11/17/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "UIView+MOREStackLayoutView.h"

#import "MOREDateUICell.h"

@interface MOREDateUICell()

@end

@implementation MOREDateUICell

- (instancetype)init{
    self = [super init];
    if( self ){
        
        _icon = [UILabel new];
        _firstname = [UILabel new];
        _lastname = [UILabel new];
        
        _icon.textAlignment = NSTextAlignmentCenter;
        _lastname.textAlignment = NSTextAlignmentRight;
        
        for( UILabel *label in @[ _icon, _firstname, _lastname ] ){
            label.translatesAutoresizingMaskIntoConstraints = NO;
            [self addSubview:label];
            [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:label to:self type:EdgeTopBottomZero]];
        }
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_icon to:self type:EdgeLeftZero constant:8]];
        [_icon addConstraints:[NSLayoutConstraint SpactecledBearFixed:_icon type:SpactecledBearFixedWidth constant:56]];
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_firstname to:self type:EdgeLeftZero constant:56 + 16]];
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_lastname to:self type:EdgeRightZero constant:16]];
        
        [self addConstraints:[NSLayoutConstraint spactecledTwoBearFixed:_lastname
                                                            anotherBear:self
                                                                   type:SpactecledBearFixedWidth
                                                             multiplier:( 1 - 0.618 )
                                                               constant:0]];
        [self addConstraints:[NSLayoutConstraint spactecledTwoBearFixed:_firstname
                                                            anotherBear:self
                                                                   type:SpactecledBearFixedWidth
                                                             multiplier:0.618
                                                               constant:-( 56 + 16 )]];
    }
    return self;
}

@end
