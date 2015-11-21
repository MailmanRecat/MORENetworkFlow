//
//  MOREAlertStack.h
//  MORENetworkFlow
//
//  Created by caine on 11/21/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const MOREALERT_ICON_KEY = @"MOREALERT_ICON_KEY";
static NSString *const MOREALERT_MESSAGE_KEY = @"MOREALERT_MESSAGE_KEY";
static NSString *const MOREALERT_CONFIRM_KEY = @"MOREALERT_CONFIRM_KEY";
static NSString *const MOREALERT_CANCEL_KEY = @"MOREALERT_CANCEL_KEY";
static NSString *const MOREALERT_COLORS_KEY = @"MOREALERT_COLORS_KEY";
static NSString *const MOREALERT_REQUIRE_KEY = @"MOREALERT_ANSWER_REQUIRE_KEY";
static NSString *const MOREALERT_DELEGATE_KET = @"MOREALERT_DELEGATE_KEY";

@interface MOREAlertStack : NSObject

+ (instancetype)shareAlertStack;

- (void)addAlert:(NSDictionary *)alert;
- (id)popAlert;

@end

