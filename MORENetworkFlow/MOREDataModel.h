//
//  MOREDataModel.h
//  MORENetworkFlow
//
//  Created by caine on 11/9/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOREDataModel : NSObject

@property( nonatomic, strong ) NSString *DATE;
@property( nonatomic, strong ) NSString *SPEED;
@property( nonatomic, strong ) NSString *UPLOAD_SPEED;
@property( nonatomic, strong ) NSString *WiFi_USAGE;
@property( nonatomic, strong ) NSString *WiFi_SENT;
@property( nonatomic, strong ) NSString *WiFi_AMOUNT;
@property( nonatomic, strong ) NSString *WWAN_USAGE;
@property( nonatomic, strong ) NSString *WWAN_SENT;
@property( nonatomic, strong ) NSString *WWAN_AMOUNT;

@property( nonatomic, strong ) NSString *userUnit;

@property( nonatomic, assign ) CGFloat progressWiFiPercentage;
@property( nonatomic, assign ) CGFloat progressWWANPercentage;
@property( nonatomic, assign ) NSUInteger progressWiFiCache;
@property( nonatomic, assign ) NSUInteger progressWiFiTarget;
@property( nonatomic, assign ) NSUInteger progressWWANCache;
@property( nonatomic, assign ) NSUInteger progressWWANTarget;

+ (instancetype)currentMOREDataModel;

@end
