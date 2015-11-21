//
//  MORELanguage.m
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "MORELanguage.h"

@implementation MORELanguage

+ (NSString *)currentLanguage{
    
    NSArray *languages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    return currentLanguage;
}

+ (NSString *)language:(NSDictionary *)text{
    
    NSString *lang = [self currentLanguage];
    
    NSString *string = text[ lang ];
    if( !string )
        string = text[ @"en-US" ];
    
    return string;
    
}

+ (NSString *)stringWWAN{
    
    NSDictionary *text = @{
                           @"en-US": @"WWAN"
                           };
    
    return [self language:text];
    
}

+ (NSString *)stringWIFI{
    
    NSDictionary *text = @{
                           @"en-US": @"WIFI"
                           };
    
    return [self language:text];
    
}

+ (NSString *)stringSettingUnitAuto{
    
    NSString *language = [self currentLanguage];
    return language;
    
}

+ (NSString *)stringSettingUnitMGAlways{
    
    NSString *language = [self currentLanguage];
    return language;
    
}

+ (NSString *)stringSettingUnitGBAlways{
    
    NSString *language = [self currentLanguage];
    return language;
    
}

+ (NSString *)stringSettingDisplayFlowAmountYES{
    
    NSString *language = [self currentLanguage];
    return language;
    
}

+ (NSString *)stringSettingDisplayFlowAmountNO{
    
    NSString *language = [self currentLanguage];
    return language;
    
}

@end
