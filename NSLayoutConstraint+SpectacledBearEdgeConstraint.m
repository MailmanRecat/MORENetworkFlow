//
//  NSLayoutConstraint+SpectacledBearEdgeConstraint.m
//  Animation
//
//  Created by caine on 7/8/15.
//  Copyright (c) 2015 com.caine. All rights reserved.
//

#import "NSLayoutConstraint+SpectacledBearEdgeConstraint.h"

@implementation NSLayoutConstraint (SpectacledBearEdgeConstraint)

+ (NSArray *)SpactecledBearEdeg:(UIView *)bear to:(UIView *)toBear type:(SpactecledBearType)type{
    
    NSMutableArray *cons = [NSMutableArray new];
    NSLayoutConstraint *con;
    NSLayoutAttribute *turtle = NULL, *rabbit = NULL;
    
    if( type == EdgeTopZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeLeftZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeLeft };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeBottomZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeBottom };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeRightZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeRight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeTopLeftZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop, NSLayoutAttributeLeft };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeTopRightZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop, NSLayoutAttributeRight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeTopBottomZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop, NSLayoutAttributeBottom };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
            
    }else if( type == EdgeLeftRightZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeLeft, NSLayoutAttributeRight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeBottomLeftZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeBottom, NSLayoutAttributeLeft };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeBottomRightZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeBottom, NSLayoutAttributeRight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeTopLeftRightZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeRight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeTopLeftBottomZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeTopRightBottomZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop, NSLayoutAttributeRight, NSLayoutAttributeBottom };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeBottomLeftRightZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeBottom, NSLayoutAttributeLeft, NSLayoutAttributeRight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeAroundZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }
    else if ( type == EdgeEquaWidth ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeWidth };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeEqualHeight ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeHeight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeEqualHeightWidth ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeWidth, NSLayoutAttributeHeight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }
    else if( type == EdgeCenterXY ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeCenterX, NSLayoutAttributeCenterY };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeCenterX ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeCenterX };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeCenterY ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeCenterY };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }
    
    while( turtle < rabbit ){
        NSLayoutAttribute fox = *turtle;
        con = [NSLayoutConstraint
               constraintWithItem:bear
               attribute:fox
               relatedBy:NSLayoutRelationEqual
               toItem:toBear
               attribute:fox
               multiplier:1.0f
               constant:0];
        
        [cons addObject:con];
        turtle++;
    }
    
    return cons;
}

+ (NSArray *)SpactecledBearEdeg:(UIView *)bear to:(UIView *)toBear type:(SpactecledBearType)type constant:(CGFloat)constant{
    
    NSMutableArray *cons = [NSMutableArray new];
    NSLayoutConstraint *con;
    NSLayoutAttribute *turtle = NULL, *rabbit = NULL;
    
    if( type == EdgeTopZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeLeftZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeLeft };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeBottomZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeBottom };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeRightZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeRight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeTopLeftZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop, NSLayoutAttributeLeft };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeTopRightZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop, NSLayoutAttributeRight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeTopBottomZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop, NSLayoutAttributeBottom };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeLeftRightZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeLeft, NSLayoutAttributeRight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeBottomLeftZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeBottom, NSLayoutAttributeLeft };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeBottomRightZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeBottom, NSLayoutAttributeRight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeTopLeftRightZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeRight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeTopLeftBottomZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeTopRightBottomZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop, NSLayoutAttributeRight, NSLayoutAttributeBottom };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeBottomLeftRightZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeBottom, NSLayoutAttributeLeft, NSLayoutAttributeRight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeAroundZero ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeTop, NSLayoutAttributeLeft, NSLayoutAttributeBottom, NSLayoutAttributeRight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }
    else if ( type == EdgeEquaWidth ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeWidth };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeEqualHeight ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeHeight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeEqualHeightWidth ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeWidth, NSLayoutAttributeHeight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }
    else if( type == EdgeCenterXY ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeCenterX, NSLayoutAttributeCenterY };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeCenterX ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeCenterX };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == EdgeCenterY ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeCenterY };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }
    
    while( turtle < rabbit ){
        NSLayoutAttribute fox = *turtle;
        
        CGFloat offset = 0;
        if( fox == NSLayoutAttributeBottom || fox == NSLayoutAttributeRight )
            offset = constant - 2 * constant;
        else
            offset = constant;
        
        con = [NSLayoutConstraint
               constraintWithItem:bear
               attribute:fox
               relatedBy:NSLayoutRelationEqual
               toItem:toBear
               attribute:fox
               multiplier:1.0f
               constant:offset];
        
        [cons addObject:con];
        turtle++;
    }
    
    return cons;

}

+ (NSArray *)SpactecledBearFixed:(UIView *)target type:(SpactecledBearFixedType)type constant:(CGFloat)constant{
    
    NSMutableArray *cons = [NSMutableArray new];
    NSLayoutConstraint *con;
    NSLayoutAttribute *turtle = NULL, *rabbit = NULL;
    
    if( type == SpactecledBearFixedWidth ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeWidth };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == SpactecledBearFixedHeight ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeHeight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
        
    }else if( type == SpactecledBearFixedEqual ){
        NSLayoutAttribute wolf[] = { NSLayoutAttributeWidth, NSLayoutAttributeHeight };
        turtle = wolf;
        rabbit = wolf + sizeof(wolf) / sizeof(wolf[0]);
    }
    
    while( turtle < rabbit ){
        NSLayoutAttribute fox = *turtle;
        con = [NSLayoutConstraint
               constraintWithItem:target
               attribute:fox
               relatedBy:NSLayoutRelationEqual
               toItem:nil
               attribute:NSLayoutAttributeNotAnAttribute
               multiplier:1.0f
               constant: constant];
        
        [cons addObject:con];
        turtle++;
    }
    
    return cons;
}

+ (NSArray *)spactecledTwoBearFixed:(UIView *)bear anotherBear:(UIView *)anotherBear type:(SpactecledBearFixedType)type{
    return [self spactecledTwoBearFixed:bear anotherBear:anotherBear type:type multiplier:1.0 constant:0];
}

+ (NSArray *)spactecledTwoBearFixed:(UIView *)bear anotherBear:(UIView *)anotherBear type:(SpactecledBearFixedType)type multiplier:(CGFloat)multiplier constant:(CGFloat)constant{
    NSMutableArray *cons = [NSMutableArray new];
    NSLayoutConstraint *con;
    
    if( type == SpactecledBearFixedWidth ){
        con = [NSLayoutConstraint constraintWithItem:bear
                                           attribute:NSLayoutAttributeWidth
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:anotherBear
                                           attribute:NSLayoutAttributeWidth
                                          multiplier:multiplier
                                            constant:constant];
        [cons addObject:con];
        
    }else if( type == SpactecledBearFixedHeight ){
        con = [NSLayoutConstraint constraintWithItem:bear
                                           attribute:NSLayoutAttributeHeight
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:anotherBear
                                           attribute:NSLayoutAttributeHeight
                                          multiplier:multiplier
                                            constant:constant];
        [cons addObject:con];
        
    }else if( type == SpactecledBearFixedEqual ){
        con = [NSLayoutConstraint constraintWithItem:bear
                                           attribute:NSLayoutAttributeWidth
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:anotherBear
                                           attribute:NSLayoutAttributeWidth
                                          multiplier:multiplier
                                            constant:constant];
        [cons addObject:con];
        con = [NSLayoutConstraint constraintWithItem:bear
                                           attribute:NSLayoutAttributeHeight
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:anotherBear
                                           attribute:NSLayoutAttributeHeight
                                          multiplier:multiplier
                                            constant:constant];
        [cons addObject:con];
        
    }
    
    return cons;
}

@end
