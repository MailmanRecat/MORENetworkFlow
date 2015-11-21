//
//  Hamster.m
//  Animation
//
//  Created by caine on 7/10/15.
//  Copyright (c) 2015 com.caine. All rights reserved.
//

#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define SELF_HEIGHT 56
#define EDGE_INSET  16
#define TINT_DURATION 0.57

#import "WindPark.h"

@interface WindPark()

@property( nonatomic, strong ) UIView *sky;

@property( nonatomic, assign ) BOOL isHerbDisappear;
@property( nonatomic, assign ) BOOL isCliffDisappear;
@property( nonatomic, assign ) BOOL isMountainDisappear;

@end

@implementation WindPark

- (void)disappearHerb{
    
    if( _isHerbDisappear ) return;
    _isHerbDisappear = YES;
    [self layoutGreenland: 0 identifier:@"greenlandLeftEdge"];
}

- (void)appearHerb{
    
    if( !_isHerbDisappear ) return;
    _isHerbDisappear = NO;
    [self layoutGreenland: SELF_HEIGHT identifier:@"greenlandLeftEdge"];
}

- (void)disappearCliff{
    
    if( _isCliffDisappear ) return;
    _isCliffDisappear = YES;
    [self layoutGreenland: 0 identifier:@"greenlandRightEdge"];
}

- (void)appearCliff{
    
    if( !_isCliffDisappear ) return;
    _isCliffDisappear = NO;
    [self layoutGreenland: -SELF_HEIGHT identifier:@"greenlandRightEdge"];
}

- (void)disappearMountain{
    
    if( _isMountainDisappear ) return;
    _isMountainDisappear = YES;
    [self layoutGreenland: -SELF_HEIGHT identifier:@"greenlandRightEdge"];
}

- (void)appearMountain{
    
    if( !_isMountainDisappear ) return;
    _isMountainDisappear = NO;
    [self layoutGreenland: -SELF_HEIGHT * 2 identifier:@"greenlandRightEdge"];
}

- (void)layoutGreenland:(CGFloat)constant identifier:(NSString *)identifier{
    
    for( NSLayoutConstraint *Bear in [self constraints] ){
        
        if( [Bear.identifier isEqualToString:identifier] )
            Bear.constant = constant;
    }
    
    [UIView animateWithDuration:0.37 animations:^{
        [self layoutIfNeeded];
    }completion:nil];
}

- (void)colorfulDay:(UIColor *)color :(balanceBlock)block{
    CGPoint localtion;
    localtion = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    [self LetsMove:localtion color:color completion:block];
}

- (void)nameplate:(NSString *)nameplate{
    
    if( _nameplate ){
        
        _nameplate.text = nameplate;
        return;
    }
    _nameplate = [UILabel new];
    _nameplate.font = [UIFont boldSystemFontOfSize:21];
    [_nameplate setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_greenland addSubview:_nameplate];
    NSArray *Bears = [NSLayoutConstraint SpactecledBearEdeg:_nameplate to:_greenland type:EdgeAroundZero];
    for( NSLayoutConstraint *Bear in Bears ){
        if( Bear.firstAttribute == NSLayoutAttributeLeft )
            Bear.constant = EDGE_INSET;
        if( Bear.firstAttribute == NSLayoutAttributeRight )
            Bear.constant = -EDGE_INSET;
    }
    [self addConstraints:Bears];
    _nameplate.text = nameplate;
}

- (void)sunShadowOpacity:(CGFloat)opacity offset:(CGSize)offset radius:(CGFloat)radius{
    self.layer.shadowOpacity = opacity;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
}

- (void)sunset{
    self.layer.shadowOpacity = 0.3f;
}

- (void)sunrise{
    self.layer.shadowOpacity = 0.0f;
}

- (instancetype)init{
    self = [super init];
    if( self ){
//        self.layer.shadowColor = [UIColor blackColor].CGColor;
//        self.layer.shadowOpacity = 0.0f;
//        self.layer.shadowOffset = CGSizeMake(1, 4);
//        self.layer.shadowRadius = 3.0f;
        
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.0f;
        self.layer.shadowOffset = CGSizeMake(1, 1);
        self.layer.shadowRadius = 0.3f;
        
        _sky = [UIView new];
        [_sky setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self insertSubview:_sky atIndex:0];
        
        _herb     = [HuskyButton new];
        _cliff    = [HuskyButton new];
        _mountain = [HuskyButton new];
        [[NSArray arrayWithObjects:_herb, _cliff, _mountain, nil] enumerateObjectsUsingBlock:^( id obj, NSUInteger coyote, BOOL *shouldStop ){
            
            HuskyButton *husky = (HuskyButton *)obj;
            [husky setTranslatesAutoresizingMaskIntoConstraints:NO];
            husky.isPlayFromCenter = YES;
            husky.layer.cornerRadius = SELF_HEIGHT / 2;
            [self addSubview:husky];
            husky.backgroundColor = [UIColor clearColor];
            
        }];
        
        _isHerbDisappear = NO;
        _isCliffDisappear = NO;
        _isMountainDisappear = NO;
        
        _greenland = [UIView new];
        [_greenland setTranslatesAutoresizingMaskIntoConstraints:NO];
        _greenland.backgroundColor = [UIColor clearColor];
        [self addSubview:_greenland];
        
        [self solidViewLayout];
    }
    return self;
}

- (void)LetsMove:(CGPoint)location color:(UIColor *)color completion:(void(^)(void))block{
    
    CAShapeLayer *colorBug = [self LittleHuskyWithLocation:location];
    colorBug.backgroundColor = [UIColor clearColor].CGColor;
    colorBug.fillColor       = color.CGColor;
    [self insertSubview:_sky atIndex:0];
    [_sky.layer addSublayer:colorBug];
    
    CGFloat SoundSize = 1.0 / colorBug.frame.size.width;
    CABasicAnimation *AaoAaoAao = [self AaoAaoAaoWithSoundSize:SoundSize];
    colorBug.transform = [AaoAaoAao.toValue CATransform3DValue];
    
    __block UIView *refRat = self;
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        
        refRat.backgroundColor = color;
        [colorBug removeFromSuperlayer];
        if( block )
            block();
    }];
    [colorBug addAnimation:AaoAaoAao forKey:@"colorBug"];
    [CATransaction commit];
}

- (CGFloat)MapDiameterWithLocation:(CGPoint)location{
    CGPoint mapEdge[] = {
        { 0, 0 },
        { 0, self.bounds.size.height },
        { self.bounds.size.width, 0 },
        { self.bounds.size.width, self.bounds.size.height }
    };
    CGFloat radius = 0; int i = 0;
    for( ; i < 4; i++ ){
        CGPoint edge = mapEdge[i];
        CGFloat dist = sqrt(pow( location.x - edge.x, 2.0 ) + pow( location.y - edge.y, 2.0 ));
        radius = dist > radius ? dist : radius;
    }
    
    return radius * 2;
}

- (CAShapeLayer *)LittleHuskyWithLocation:(CGPoint)location{
    CAShapeLayer *husky = [CAShapeLayer layer];
    CGFloat      mapDiameter = [self MapDiameterWithLocation:location];
    
    husky.frame = CGRectMake(floor(location.x - mapDiameter * 0.5), floor(location.y - mapDiameter * 0.5), mapDiameter, mapDiameter);
    husky.path  = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, mapDiameter, mapDiameter)].CGPath;
    
    return husky;
}

- (CABasicAnimation *)AaoAaoAaoWithSoundSize:(CGFloat)SoundSize{
    CABasicAnimation *AaoAaoAao = [CABasicAnimation animationWithKeyPath:@"transform"];
    AaoAaoAao.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(SoundSize, SoundSize, 1.0)];
    AaoAaoAao.toValue   = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    NSString *timingFunction = kCAMediaTimingFunctionDefault;
    AaoAaoAao.timingFunction = [CAMediaTimingFunction functionWithName:timingFunction];
    AaoAaoAao.duration       = TINT_DURATION;
    AaoAaoAao.removedOnCompletion = YES;
    
    return AaoAaoAao;
}

- (void)solidViewLayout{
    
    NSLayoutConstraint *Bear;
    
    NSLayoutConstraint *solidHeight = [NSLayoutConstraint
                                       constraintWithItem:self
                                       attribute:NSLayoutAttributeHeight
                                       relatedBy:NSLayoutRelationEqual
                                       toItem:nil
                                       attribute:NSLayoutAttributeNotAnAttribute
                                       multiplier:1.0
                                       constant: SELF_HEIGHT + STATUS_BAR_HEIGHT];
    [self addConstraint:solidHeight];
    
    NSArray *bears = [NSLayoutConstraint SpactecledBearFixed:_herb type:SpactecledBearFixedEqual constant:SELF_HEIGHT];
    [_herb addConstraints:bears];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_herb
                         attribute:NSLayoutAttributeRight
                         relatedBy:NSLayoutRelationEqual
                         toItem:_greenland
                         attribute:NSLayoutAttributeLeft
                         multiplier:1.0f
                         constant: 0]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_herb
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0f
                         constant:STATUS_BAR_HEIGHT]];
    
    bears = [NSLayoutConstraint SpactecledBearEdeg:_greenland to:self type:EdgeBottomZero];
    [self addConstraints:bears];
    Bear = [NSLayoutConstraint
            constraintWithItem:_greenland
            attribute:NSLayoutAttributeLeft
            relatedBy:NSLayoutRelationEqual
            toItem:self
            attribute:NSLayoutAttributeLeft
            multiplier:1.0
            constant:SELF_HEIGHT];
    Bear.identifier = @"greenlandLeftEdge";
    [self addConstraint:Bear];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_greenland
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0
                         constant:STATUS_BAR_HEIGHT]];
    Bear = [NSLayoutConstraint
            constraintWithItem:_greenland
            attribute:NSLayoutAttributeRight
            relatedBy:NSLayoutRelationEqual
            toItem:self
            attribute:NSLayoutAttributeRight
            multiplier:1.0
            constant: -SELF_HEIGHT * 2];
    Bear.identifier = @"greenlandRightEdge";
    [self addConstraint:Bear];
    
    bears = [NSLayoutConstraint SpactecledBearFixed:_cliff type:SpactecledBearFixedEqual constant:SELF_HEIGHT];
    [_cliff addConstraints:bears];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_cliff
                         attribute:NSLayoutAttributeLeft
                         relatedBy:NSLayoutRelationEqual
                         toItem:_greenland
                         attribute:NSLayoutAttributeRight
                         multiplier:1.0f
                         constant:0]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_cliff
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0f
                         constant:STATUS_BAR_HEIGHT]];
    
    bears = [NSLayoutConstraint SpactecledBearFixed:_mountain type:SpactecledBearFixedEqual constant:SELF_HEIGHT];
    [_mountain addConstraints:bears];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_mountain
                         attribute:NSLayoutAttributeLeft
                         relatedBy:NSLayoutRelationEqual
                         toItem:_cliff
                         attribute:NSLayoutAttributeRight
                         multiplier:1.0f
                         constant:0]];
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:_mountain
                         attribute:NSLayoutAttributeTop
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeTop
                         multiplier:1.0f
                         constant:STATUS_BAR_HEIGHT]];
    
    _sky.backgroundColor = [UIColor clearColor];
    [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_sky to:self type:EdgeAroundZero]];
    _sky.layer.masksToBounds = YES;

}

@end
