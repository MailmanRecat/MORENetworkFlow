//
//  MOREAlertView.h
//  MORENetworkFlow
//
//  Created by caine on 11/21/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MOREAlertDelegate <NSObject>

- (void)MOREAlertDidCancel;
- (void)MOREAlertDidConfirm;

@end

@interface MOREAlertView : UIView

@property( nonatomic, weak ) id<MOREAlertDelegate> delegate;

@property( nonatomic, strong ) UILabel  *icon;
@property( nonatomic, strong ) UILabel  *message;
@property( nonatomic, strong ) UIButton *confirm;
@property( nonatomic, strong ) UIButton *cancel;

+ (instancetype)shareAlert;

@end
