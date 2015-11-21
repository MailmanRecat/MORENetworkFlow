//
//  MOREPageView.m
//  GGAnimationTestProject
//
//  Created by caine on 11/18/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "UIView+MOREStackLayoutView.h"

#import "MOREPageView.h"

@interface MOREPageView()

@property( nonatomic, strong ) NSArray *dots;
@property( nonatomic, assign ) NSUInteger currentIndex;

@end

@implementation MOREPageView

- (instancetype)initWithCount:(NSUInteger)count{
    self = [super init];
    if( self ){
        
        NSMutableArray *ddots = [NSMutableArray new];
        _currentIndex = 0;
        _color = [UIColor grayColor];
        
        for( NSUInteger fox = 0; fox < count; fox++ ){
            [ddots addObject:[UIView new]];
        }
        
        _dots = (NSArray *)ddots;
        
        NSUInteger index = 1;
        for( UIView *view in _dots ){
            view.translatesAutoresizingMaskIntoConstraints = NO;
            view.backgroundColor = [UIColor clearColor];
            if( index - 1 == _currentIndex ) view.backgroundColor = _color;
            [self addSubview:view];
            [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:view to:self type:EdgeEqualHeight]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:view
                                                             attribute:NSLayoutAttributeHeight
                                                            multiplier:1.0
                                                              constant:0]];
            [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:view to:self type:EdgeCenterY]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeRight
                                                            multiplier:( (int)index / ( count + 1.0 ) )
                                                              constant:0]];
            
            index++;
        }
    }
    return self;
}

- (void)setColor:(UIColor *)color{
    _color = color;
    UIView *dot = _dots[_currentIndex];
    for( UIView *view in _dots ){
        view.layer.borderColor = _color.CGColor;
        dot.backgroundColor = _color;
    }
}

- (void)updateIndex:(NSUInteger)index percentage:(CGFloat)percentage{
    if( index > [_dots count] - 1 || index == _currentIndex ) return;
    
    UIView *ddot = (UIView *)[_dots objectAtIndex:_currentIndex];
    UIView *dot = (UIView *)[_dots objectAtIndex:index];
    
    [UIView animateWithDuration:0.27f
                     animations:^{
                         ddot.backgroundColor = [UIColor clearColor];
                         dot.backgroundColor = _color;
                     } completion:nil];
    _currentIndex = index;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat selfHeight = self.frame.size.height;
    
    self.layer.cornerRadius = selfHeight / 2.0;
    
    for( UIView *view in _dots ){
        view.layer.cornerRadius = selfHeight / 2.0;
        view.layer.borderWidth = selfHeight / 8.0;
        view.layer.borderColor = _color.CGColor;
    }
}

@end
