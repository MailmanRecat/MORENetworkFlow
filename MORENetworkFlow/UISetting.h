//
//  UISetting.h
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *const UISETTING_HAD_CHANGE = @"UISETTING_HAD_CHANGE";

static NSString *const USERUNIT = @"userUnit";
static NSString *const UNITAUTO = @"auto";
static NSString *const UNITMB   = @"unitMB";
static NSString *const UNITGB   = @"unitGB";

static NSString *const WIFIOFFSET = @"WIFIOFFSET";
static NSString *const CELLULAROFFSET = @"CELLULAROFFSET";

static NSString *const USER_DISPLAY_AMOUNT = @"userDisplayAmount";

static NSString *const OPTION_UNIT = @"optionUnit";
static NSString *const OPTION_DISPLAY_FLOW = @"displayFlow";

typedef NS_ENUM(NSUInteger, DataType) {
    DataTypeWiFiRecevied,
    DataTypeWiFiSent,
    DataTypeWWANRecevied,
    DataTypeWWANSent
};

typedef NS_ENUM(NSUInteger, progessTargetType){
    progessTargetTypeWiFi = 0,
    progessTargetTypeWWAN
};

@interface UISetting : NSObject

+ (NSString *)startDate;
+ (NSString *)endDate;

+ (NSInteger)setWiFiReceviedOffset:(NSInteger)offset;
+ (NSInteger)setWifiSentOffset:(NSInteger)offset;

+ (NSInteger)setWWANReceviedOffset:(NSInteger)offset;
+ (NSInteger)setWWANSentOffset:(NSInteger)offset;

+ (void)clearOffset:(DataType)type;

+ (NSInteger)getWiFiReceviedOffset;
+ (NSInteger)getWifiSentOffset;

+ (NSInteger)getWWANReceviedOffset;
+ (NSInteger)getWWANSentOffset;

//+ (void)setLastDataRecord:(NSInteger)WiFiR :(NSInteger)WiFiS :(NSInteger)WWANR :(NSInteger)WWANS;
//+ (NSArray *)lastDataRecord;

+ (BOOL)autoCorrectOffset:(NSInteger)WiFiR :(NSInteger)WiFiS :(NSInteger)WWANR :(NSInteger)WWANS;

+ (NSString *)userUnit;
+ (NSString *)setUserUnit:(NSString *)unit;

+ (NSInteger)userWIFIOffset;
+ (NSInteger)setUserWIFIOffset:(NSInteger)offset;

+ (NSInteger)userCELLULAROffset;
+ (NSInteger)setUSerCELLULAROffset:(NSInteger)offset;

//cache == 0 or target == 0 to get the targetvalue
+ (NSUInteger)progressCache:(progessTargetType)type cache:(NSUInteger)cache;
+ (NSUInteger)progressTarget:(progessTargetType)type target:(NSUInteger)target;

+ (BOOL)isDEBUG;
+ (void)debug:(BOOL)debug;

@end
