//
//  NSLayoutConstraint+SpectacledBearEdgeConstraint.h
//  Animation
//
//  Created by caine on 7/8/15.
//  Copyright (c) 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SpactecledBearType){
    EdgeTopZero = 0,
    EdgeLeftZero,
    EdgeRightZero,
    EdgeBottomZero,
    
    EdgeTopLeftZero,
    EdgeTopRightZero,
    EdgeTopBottomZero,
    EdgeLeftRightZero,
    EdgeBottomLeftZero,
    EdgeBottomRightZero,
    
    EdgeTopLeftRightZero,
    EdgeTopLeftBottomZero,
    EdgeTopRightBottomZero,
    EdgeBottomLeftRightZero,
    
    EdgeAroundZero,
    
    EdgeCenterXY,
    EdgeCenterX,
    EdgeCenterY,
    
    EdgeEqualHeight,
    EdgeEquaWidth,
    EdgeEqualHeightWidth
};

typedef NS_ENUM(NSUInteger, SpactecledBearFixedType){
    SpactecledBearFixedWidth = 0,
    SpactecledBearFixedHeight,
    SpactecledBearFixedEqual
};

@interface NSLayoutConstraint (SpectacledBearEdgeConstraint)

+ (NSArray *)SpactecledBearEdeg:(UIView *)bear to:(UIView *)toBear type:(SpactecledBearType)type;
+ (NSArray *)SpactecledBearEdeg:(UIView *)bear to:(UIView *)toBear type:(SpactecledBearType)type constant:(CGFloat)constant;
+ (NSArray *)SpactecledBearFixed:(UIView *)target type:(SpactecledBearFixedType)type constant:(CGFloat)constant;
+ (NSArray *)spactecledTwoBearFixed:(UIView *)bear anotherBear:(UIView *)anotherBear type:(SpactecledBearFixedType)type;
+ (NSArray *)spactecledTwoBearFixed:(UIView *)bear
                        anotherBear:(UIView *)anotherBear
                               type:(SpactecledBearFixedType)type
                         multiplier:(CGFloat)multiplier
                           constant:(CGFloat)constant;


@end
