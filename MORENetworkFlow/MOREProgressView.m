//
//  MOREProgressView.m
//  GGAnimationTestProject
//
//  Created by caine on 11/17/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "NSLayoutConstraint+SpectacledBearEdgeConstraint.h"

#import "MOREProgressView.h"

@interface MOREProgressView()

@property( nonatomic, strong ) UIView *track;
@property( nonatomic, strong ) NSLayoutConstraint *con;
@property( nonatomic, assign ) BOOL once;

@end

@implementation MOREProgressView

- (instancetype)init{
    self = [super init];
    if( self ){
        
        self.clipsToBounds = YES;
        
        _progress = 0;
        _track = [UIView new];
        _track.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_track];
        
        _con = [NSLayoutConstraint constraintWithItem:_track
                                            attribute:NSLayoutAttributeWidth
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:nil
                                            attribute:NSLayoutAttributeNotAnAttribute
                                           multiplier:1.0
                                             constant:0];
        [_track addConstraint:_con];
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_track to:self type:EdgeTopLeftBottomZero]];
    }
    return self;
}

- (void)setTrackColor:(UIColor *)trackColor{
    _track.backgroundColor = trackColor;
}

- (void)setProgress:(CGFloat)progress animation:(BOOL)animation{
    if( progress > 1 ) progress = 1;
    if( progress < 0 ) progress = 0;
    
    CGFloat percentage = (self.frame.size.width == 0 ? 1 : self.frame.size.width) * progress;
    _con.constant = percentage;
    
    if( animation )
        [UIView animateWithDuration:fabs(_progress - progress) < 0.75 ? fabs(_progress - progress) + 0.25 : fabs(_progress - progress)
                         animations:^{
                             [self layoutIfNeeded];
                         }];
    else
        self.frame.size.width != 0 ? [self layoutIfNeeded] : 0;
    
    _progress = progress;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if( !_once ){
        _con.constant = self.frame.size.width * _progress;
        [self layoutIfNeeded];
        _once = YES;
    }
}

@end
