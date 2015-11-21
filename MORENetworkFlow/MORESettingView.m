//
//  MORESettingView.m
//  MORENetworkFlow
//
//  Created by caine on 11/10/15.
//  Copyright © 2015 com.caine. All rights reserved.
//
#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define BAR_HEIGHT 56

#import "MORESettingView.h"
#import "UIColor+Theme.h"
#import "NSLayoutConstraint+SpectacledBearEdgeConstraint.h"

@interface MORESettingView()

@end

@implementation MORESettingView

- (instancetype)init{
    self = [super init];
    if( self ){
        
        [self loadbar];
        
    }
    return self;
}

- (void)loadbar{
    
    UIView *bar = [UIView new];
    bar.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:bar];
    
    [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:bar to:self type:EdgeTopLeftRightZero]];
    [bar addConstraints:[NSLayoutConstraint SpactecledBearFixed:bar type:SpactecledBearFixedHeight constant:BAR_HEIGHT + STATUS_BAR_HEIGHT]];
    
    UIView *borderBottom = [UIView new];
    borderBottom.translatesAutoresizingMaskIntoConstraints = NO;
    [bar addSubview:borderBottom];
    
    [bar addConstraints:[NSLayoutConstraint SpactecledBearEdeg:borderBottom to:bar type:EdgeBottomLeftRightZero]];
    [borderBottom addConstraints:[NSLayoutConstraint SpactecledBearFixed:borderBottom type:SpactecledBearFixedHeight constant:1]];
    
    borderBottom.backgroundColor = [UIColor backgroundColor];
    
    UILabel *barTitle = [UILabel new];
    barTitle.translatesAutoresizingMaskIntoConstraints = NO;
    [bar addSubview:barTitle];
    
    [bar addConstraints:[NSLayoutConstraint SpactecledBearEdeg:barTitle to:bar type:EdgeBottomLeftRightZero]];
    [bar addConstraints:[NSLayoutConstraint SpactecledBearEdeg:barTitle to:bar type:EdgeTopZero constant:STATUS_BAR_HEIGHT]];
    
    barTitle.textAlignment = NSTextAlignmentCenter;
    barTitle.font = [UIFont fontWithName:@"Roboto-bold" size:18];
    barTitle.textColor = [UIColor backgroundColor];
    barTitle.text = @"Settings";
}



@end
