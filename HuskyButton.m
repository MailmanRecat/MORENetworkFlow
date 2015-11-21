//
//  HuskyButton.m
//  Animation
//
//  Created by caine on 7/7/15.
//  Copyright (c) 2015 com.caine. All rights reserved.
//

#define DURATION 0.37
#define OFFSET 7
#define FURCOLOR [UIColor blackColor]
#define FURALPHA 0.1

#import "HuskyButton.h"

@interface HuskyButton()

@property( nonatomic, strong ) CAShapeLayer *LittleHusky;
@property( nonatomic, assign ) BOOL          isButtonTouching;
@property( nonatomic, assign ) BOOL          shouldManualRemoveHusky;
@property( nonatomic, assign ) NSUInteger    huskyCount;

@property( nonatomic, assign ) BOOL          isMoving;

@end

@implementation HuskyButton

- (instancetype)init{
    self = [super init];
    
    if( self ){
        self.AaoAaoAaoDuration = DURATION;
        self.FurColor          = FURCOLOR;
        self.FurAlpha          = FURALPHA;
        self.huskyCount        = 0;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if( self ){
        self.AaoAaoAaoDuration = DURATION;
        self.FurColor          = FURCOLOR;
        self.FurAlpha          = FURALPHA;
        self.huskyCount        = 0;
    }

    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    _isButtonTouching =YES;
    CGPoint location;
    if( _isPlayFromCenter ){
        location = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    }else{
        location = [[[event allTouches] anyObject] locationInView:self];
    }
    [self LetsMove:location completion:self.huskyCompletion];
    
    [super touchesBegan:touches withEvent:event];
    [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    _isButtonTouching = NO;
    if( _shouldManualRemoveHusky ){
        [_LittleHusky removeFromSuperlayer];
        _huskyCount--;
        if( self.huskyCompletion )
            self.huskyCompletion();
    }
    
    [super touchesEnded:touches withEvent:event];
    [self.nextResponder touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    
    _isButtonTouching = NO;
    if( _LittleHusky )
        [_LittleHusky removeFromSuperlayer];
}

- (void)LetsMove:(CGPoint)location completion:(void(^)(void))block{
    
    if( _huskyCount == 1 || _huskyCount > 1 ) return;
    _huskyCount++;
    
    CAShapeLayer *LittleHusky = [self LittleHuskyWithLocation:location];
    LittleHusky.backgroundColor = [UIColor clearColor].CGColor;
    LittleHusky.fillColor       = self.FurColor.CGColor;
    LittleHusky.opacity         = self.FurAlpha;
    self.layer.masksToBounds = YES;
    [self.layer insertSublayer:LittleHusky atIndex:0];
    
    _LittleHusky             = LittleHusky;
    _shouldManualRemoveHusky = NO;
    
    CGFloat SoundSize = 1.0 / LittleHusky.frame.size.width;
    CABasicAnimation *AaoAaoAao = [self AaoAaoAaoWithSoundSize:SoundSize];
    LittleHusky.transform = [AaoAaoAao.toValue CATransform3DValue];
    
    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
        if( !_isButtonTouching ){
            [LittleHusky removeFromSuperlayer];
            _shouldManualRemoveHusky = NO;
            _huskyCount--;
            if( block )
                block();
        }else{
            _shouldManualRemoveHusky = YES;
        }
    }];
    [LittleHusky addAnimation:AaoAaoAao forKey:@"LittleHuskuAnimating"];
    [CATransaction commit];
}

- (CGFloat)MapDiameterWithLocation:(CGPoint)location{
    CGPoint mapEdge[] = {
        { 0, 0 },
        { 0, self.bounds.size.height },
        { self.bounds.size.width, 0 },
        { self.bounds.size.width, self.bounds.size.height }
    };
    CGFloat radius = 0; int turtel;
    CGPoint edge;
    CGFloat dist;
    for( turtel = 0 ; turtel < 4; turtel++ ){
        edge = mapEdge[ turtel ];
        dist = sqrt(pow( location.x - edge.x, 2.0 ) + pow( location.y - edge.y, 2.0 ));
        radius = dist > radius ? dist : radius;
    }
    
    return radius * 2 + OFFSET;
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
    AaoAaoAao.duration       = self.AaoAaoAaoDuration;
    AaoAaoAao.removedOnCompletion = YES;
    
    return AaoAaoAao;
}

@end
