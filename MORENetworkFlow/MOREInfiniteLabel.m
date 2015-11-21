//
//  MOREInfiniteLabel.m
//  MORENetworkFlow
//
//  Created by caine on 11/18/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "UIView+MOREStackLayoutView.h"
#import "MOREQueue.h"
#import "UIColor+Theme.h"

#import "MOREInfiniteLabel.h"

@interface MOREInfiniteLabel()

@property( nonatomic, strong ) MOREQueue *queue;
@property( nonatomic, assign ) BOOL fucking;

@property( nonatomic, strong ) UILabel *leading;
@property( nonatomic, strong ) UILabel *trailing;

@end

@implementation MOREInfiniteLabel

- (instancetype)initWIthTitle:(NSString *)title color:(UIColor *)color{
    self = [super init];
    if( self ){
        
        _queue = [MOREQueue new];
        _fucking = NO;
        
        self.showsHorizontalScrollIndicator =
        self.showsVerticalScrollIndicator = NO;
        self.scrollEnabled = NO;
        
        [self initLabel];
        _leading.text = title;
        _leading.textColor = color;
    }
    return self;
}

- (void)setTestAlignment:(NSTextAlignment)testAlignment{
    _testAlignment = testAlignment;
    _leading.textAlignment = testAlignment;
    _trailing.textAlignment = testAlignment;
}

- (void)setFont:(UIFont *)font{
    _font = font;
    _leading.font = font;
}

- (void)doFuck:(NSString *)bill color:(UIColor *)color{
    
    NSArray *obj = @[ bill, color ];
    
    [_queue addObj:obj];
    
    if( _fucking ) return;
    [self fuck:[_queue popObj]];
}

- (void)fuck:(NSArray *)bill{
    _fucking = YES;
    
    _trailing.text = (NSString *)bill[0];
    _trailing.textColor = (UIColor *)bill[1];
    _trailing.alpha = 0;
    
    [UIView animateWithDuration:0.57f
                     animations:^{
                         
                         _trailing.alpha = 1;
                         _leading.alpha = 0;
                         self.contentOffset = CGPointMake(0, self.frame.size.height);
                         
                     }completion:^( BOOL isFinished ){
                         
                         _leading.alpha = 1;
                         _leading.text = _trailing.text;
                         _leading.textColor = _trailing.textColor;
                         
                         self.contentOffset = CGPointMake(0, 0);
                         
                         NSArray *mike = (NSArray *)[_queue popObj];
                         mike ? [self fuck:mike] : (_fucking = NO);
                     }];
}

- (void)initLabel{
    
    _leading = [UILabel new];
    _trailing = [UILabel new];
    
    for( UILabel *dick in @[ _leading, _trailing ] ){
        dick.font = [UIFont fontWithName:@"Roboto-bold" size:15];
        dick.textColor = [UIColor textColor];
        dick.backgroundColor = [UIColor clearColor];
    }
    
    [self autolayoutSubviews:@[ _leading, _trailing ]
                  edgeInsets:UIEdgeInsetsZero
                  multiplier:1.0f
                   constants:0
            stackOrientation:autolayoutStackOrientationVertical];
    
}

@end
