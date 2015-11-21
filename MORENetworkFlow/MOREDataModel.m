//
//  MOREDataModel.m
//  MORENetworkFlow
//
//  Created by caine on 11/9/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "UISetting.h"

#import "MOREDataModel.h"

@implementation MOREDataModel

+ (instancetype)currentMOREDataModel{
    static MOREDataModel *model = nil;
    
    if( model ) return model;
    
    static dispatch_once_t t;
    dispatch_once(&t, ^{
        model = [MOREDataModel new];
        
        model.DATE =
        model.SPEED =
        model.WiFi_USAGE =
        model.WiFi_SENT =
        model.WiFi_AMOUNT =
        model.WWAN_USAGE =
        model.WWAN_SENT =
        model.WWAN_AMOUNT = [NSString new];
        
        model.userUnit = [UISetting userUnit];
        
        model.progressWiFiCache = [UISetting progressCache:progessTargetTypeWiFi cache:0];
        model.progressWWANCache = [UISetting progressCache:progessTargetTypeWWAN cache:0];
        model.progressWiFiTarget = [UISetting progressTarget:progessTargetTypeWiFi target:0];
        model.progressWWANTarget = [UISetting progressTarget:progessTargetTypeWWAN target:0];
    });
    
    return model;
}

@end
