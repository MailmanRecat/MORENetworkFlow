//
//  MOREBasicViewController.m
//  MORENetworkFlow
//
//  Created by caine on 11/19/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "MOREBasicViewController.h"

@interface MOREBasicViewController ()

@end

@implementation MOREBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _park = [WindPark new];
    _park.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_park];
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_park to:self.view type:EdgeTopLeftRightZero]];
    
    _park.herb.titleLabel.font = [UIFont MaterialDesignIcons];
    [_park.herb setTitle:[UIFont mdiArrowLeft] forState:UIControlStateNormal];
    [_park.herb setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_park.herb addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
}

- (void)dismissSelf{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
