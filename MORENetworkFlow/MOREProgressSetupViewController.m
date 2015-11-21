//
//  MOREProgressSetupViewController.m
//  MORENetworkFlow
//
//  Created by caine on 11/19/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "MOREInfiniteLabel.h"

#import "MOREProgressSetupViewController.h"

@interface MOREProgressSetupViewController ()

@property( nonatomic, strong ) UITextField *textField;

@end

@implementation MOREProgressSetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.park.backgroundColor = [UIColor googleGreen];
    
    [self.park nameplate:@"Goal"];
    self.park.nameplate.textColor = [UIColor whiteColor];
    
    if( !_type ) _type = progessTargetTypeWiFi;
    
    UITextField *textField = [UITextField new];
    textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:textField];
    _textField = textField;
    
    textField.font = [UIFont fontWithName:@"Roboto" size:27];
    textField.textColor = [UIColor googleGreen];
    textField.keyboardAppearance = UIKeyboardAppearanceLight;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.placeholder = @"0";
    textField.tintColor = [UIColor googleGreen];
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:textField
                                                                  to:self.view
                                                                type:EdgeTopZero
                                                            constant:56 + STATUS_BAR_HEIGHT + 16]];
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:textField
                                                                  to:self.view
                                                                type:EdgeLeftZero
                                                            constant:16]];
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:textField
                                                                  to:self.view
                                                                type:EdgeRightZero
                                                            constant:80 + 16]];
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearFixed:textField
                                                                 type:SpactecledBearFixedHeight
                                                             constant:36]];
    
    UIButton *start = [UIButton new];
    start.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:start];
    
    start.backgroundColor = [UIColor whiteColor];
    
    start.layer.cornerRadius = 3.0f;
    start.layer.shadowColor = [UIColor blackColor].CGColor;
    start.layer.shadowOffset = CGSizeMake(0, 1);
    start.layer.shadowRadius = 3;
    start.layer.shadowOpacity = 0.17;
    
    start.titleLabel.font = [UIFont fontWithName:@"Roboto-bold" size:15];
    [start setTitleColor:[UIColor googleGreen] forState:UIControlStateNormal];
    [start setTitle:@"START" forState:UIControlStateNormal];
    
    [start addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:start
                                                                  to:self.view
                                                                type:EdgeRightZero
                                                            constant:16]];
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearFixed:start
                                                                 type:SpactecledBearFixedHeight
                                                             constant:36]];
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearFixed:start
                                                                 type:SpactecledBearFixedWidth
                                                             constant:98]];
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:start
                                                                  to:self.view
                                                                type:EdgeTopZero
                                                            constant:STATUS_BAR_HEIGHT + 56 + 16 + 36 + 16 + 16]];
    
    MOREInfiniteLabel *unit = [[MOREInfiniteLabel alloc] initWIthTitle:@"MB" color:[UIColor googleGreen]];
    unit.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:unit];
    
    unit.testAlignment = NSTextAlignmentRight;
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:unit
                                                                  to:self.view
                                                                type:EdgeRightZero
                                                            constant:16]];
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:unit
                                                                  to:self.view
                                                                type:EdgeTopZero
                                                            constant:56 + STATUS_BAR_HEIGHT + 16]];
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearFixed:unit
                                                                 type:SpactecledBearFixedHeight
                                                             constant:36]];
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearFixed:unit
                                                                 type:SpactecledBearFixedWidth
                                                             constant:80]];
    
    UIButton *unitButton = [UIButton new];
    unitButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:unitButton];
    
    unitButton.backgroundColor = [UIColor clearColor];
    unitButton.layer.cornerRadius = 3.0f;
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:unitButton
                                                                  to:self.view
                                                                type:EdgeRightZero
                                                            constant:16]];
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:unitButton
                                                                  to:self.view
                                                                type:EdgeTopZero
                                                            constant:56 + STATUS_BAR_HEIGHT + 16]];
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearFixed:unitButton
                                                                 type:SpactecledBearFixedHeight
                                                             constant:36]];
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearFixed:unitButton
                                                                 type:SpactecledBearFixedWidth
                                                             constant:80]];
    
    [_textField becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didKeyboardShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didKeyboardHide:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

- (void)didKeyboardShow:(NSNotification *)notification{
}

- (void)didKeyboardHide:(NSNotification *)notification{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissSelf{
    [_textField resignFirstResponder];
}

- (void)start{
    
    if( [_textField.text isEqualToString:@"DEBUG"] ){
        if( [UISetting isDEBUG] ){
            [UISetting debug:NO];
        }else{
            [UISetting debug:YES];
        }
        [self dismissSelf];
        return;
    }
    
    NSUInteger target = [_textField.text integerValue];
    
    if( target > 999999999 ) target = 999999999;
    
    [UISetting progressTarget:_type target:target];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:UIDidChangeProgessMaxNotification
                                                        object:@[ @(_type) ]];
    
    if( [_textField isFirstResponder] ){
        [_textField resignFirstResponder];
        
        return;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
