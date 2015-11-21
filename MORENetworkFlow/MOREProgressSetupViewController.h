//
//  MOREProgressSetupViewController.h
//  MORENetworkFlow
//
//  Created by caine on 11/19/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "MOREBasicViewController.h"

static NSString *const UIDidChangeProgessMaxNotification = @"UIDidChangeProgressMaxNotification";

@interface MOREProgressSetupViewController : MOREBasicViewController

@property( nonatomic, assign ) progessTargetType type;

@end
