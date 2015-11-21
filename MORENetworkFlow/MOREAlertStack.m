//
//  MOREAlertStack.m
//  MORENetworkFlow
//
//  Created by caine on 11/21/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "MOREStack.h"

#import "MOREAlertStack.h"

@interface MOREAlertStack()

@property( nonatomic, strong ) MOREStack *alertStack;

@end

@implementation MOREAlertStack

+ (instancetype)shareAlertStack{
    static MOREAlertStack *stack = nil;
    
    if( stack ) return stack;
    
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        stack = [MOREAlertStack new];
        
        stack.alertStack = [MOREStack new];
    });
    
    return stack;
}

- (void)addAlert:(NSDictionary *)alert{
    [self.alertStack addObj:alert];
}

- (id)popAlert{
    return [self.alertStack popObj];
}

@end
