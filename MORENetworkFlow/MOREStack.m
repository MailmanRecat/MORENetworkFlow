//
//  MOREStack.m
//  CDemo
//
//  Created by caine on 11/16/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "MOREStack.h"

@interface MOREStack()

@property( nonatomic, strong ) NSMutableArray *stack;

@end

@implementation MOREStack

- (instancetype)init{
    self = [super init];
    if( self ){
        _stack = [NSMutableArray new];
    }
    return self;
}

- (instancetype)initWithArray:(NSArray *)array{
    self = [super init];
    if( self ){
        _stack = [[NSMutableArray alloc] initWithArray:array];
    }
    return self;
}

- (id)popObj{
    if( [_stack count] == 0 ) return nil;
    
    id obj = [_stack lastObject];
    [_stack removeLastObject];
    
    return obj;
}

- (void)addObj:(id)obj{
    [_stack addObject:obj];
}

- (NSUInteger)count{
    return [_stack count];
}

@end
