//
//  MORELanguage.h
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MORELanguage : NSObject

+ (NSString *)currentLanguage;

+ (NSString *)stringWWAN;
+ (NSString *)stringWIFI;

+ (NSString *)stringSettingUnitAuto;
+ (NSString *)stringSettingUnitMGAlways;
+ (NSString *)stringSettingUnitGBAlways;
+ (NSString *)stringSettingDisplayFlowAmountYES;
+ (NSString *)stringSettingDisplayFlowAmountNO;

@end
