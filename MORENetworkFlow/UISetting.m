//
//  UISetting.m
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "UISetting.h"
#import "TimeTalkerBird.h"
#import "MORELanguage.h"
#import "MOREDataModel.h"

static NSString *const STARTDATE = @"startDate";
static NSString *const ENDDATE = @"endDate";

static NSString *const LAST_WIFI_RECEIVED_DATA = @"LAST_WIFI_RECEIVED_DATA";
static NSString *const LAST_WIFI_SENT_DATA     = @"LAST_WIFI_SENT_DATA";
static NSString *const LAST_WWAN_RECEIVED_DATA = @"LAST_WWAN_RECEIVED_DATA";
static NSString *const LAST_WWAN_SENT_DATA     = @"LAST_WWAN_SENT_DATA";

static NSString *const LAST_WIFI_RECEIVED_RECORD = @"LAST_WIFI_RECEVIED_RECORD";
static NSString *const LAST_WIFI_SENT_RECORD = @"LAST_WIFI_SENT_RECOED";
static NSString *const LAST_WWAN_RECEIVED_RECORD = @"LAST_WWAN_RECEVIED_RECORD";
static NSString *const LAST_WWAN_SENT_RECORD = @"LAST_WWAN_SENT_RECORD";

static NSString *const SETTING_OPTIONS = @"SETTING_OPTIONS";

static NSString *const PROGRESS_WIFI_TARGET = @"PROGRESS_WIFI_TARGET";
static NSString *const PROGRESS_WWAN_TARGET = @"PROGRESS_WWAN_TARGET";
static NSString *const PROGRESS_WIFI_CACHE = @"PROGRESS_WIFI_CACHE";
static NSString *const PROGRESS_WWAN_CACHE = @"PROGRESS_WWAN_CACHE";

static NSString *const ISDEBUG = @"DEBUG";

@interface UISetting()

@end

@implementation UISetting

+ (NSString *)m:(NSUInteger)i{
    
    NSArray *name = @[ @"JAN", @"FEB", @"MAR", @"APR", @"MAY", @"JUN", @"JUL", @"AUG", @"SEP", @"OCT", @"NOV", @"DEC" ];
    return name[ i - 1 ];
    
}

+ (NSString *)startDate{
    
    NSString *startDate = [[NSUserDefaults standardUserDefaults] valueForKey:STARTDATE];
    
    if( !startDate ){
        
        NSDateComponents *date = [TimeTalkerBird currentDate];
        startDate = [NSString stringWithFormat:@"%@ %ld", [self m:date.month], (long)date.day];
        [[NSUserDefaults standardUserDefaults] setValue:startDate forKey:STARTDATE];
        
    }
    
    return startDate;
    
}

+ (NSString *)endDate{
    
    NSString *endDate;
    NSDateComponents *date = [TimeTalkerBird currentDate];
    endDate = [NSString stringWithFormat:@"%@ %ld", [self m:date.month], (long)date.day];
    
    return endDate;
    
}

+ (NSInteger)setWiFiReceviedOffset:(NSInteger)offset{
    NSInteger old = [[NSUserDefaults standardUserDefaults] integerForKey:LAST_WIFI_RECEIVED_DATA];
    if( !old ) old = 0;
    [[NSUserDefaults standardUserDefaults] setInteger:offset + old forKey:LAST_WIFI_RECEIVED_DATA];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return offset;
}

+ (NSInteger)setWifiSentOffset:(NSInteger)offset{
    NSInteger old = [[NSUserDefaults standardUserDefaults] integerForKey:LAST_WIFI_SENT_DATA];
    if( !old ) old = 0;
    [[NSUserDefaults standardUserDefaults] setInteger:offset + old forKey:LAST_WIFI_SENT_DATA];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return offset;
}

+ (NSInteger)setWWANReceviedOffset:(NSInteger)offset{
    NSInteger old = [[NSUserDefaults standardUserDefaults] integerForKey:LAST_WWAN_RECEIVED_DATA];
    if( !old ) old = 0;
    [[NSUserDefaults standardUserDefaults] setInteger:offset + old forKey:LAST_WWAN_RECEIVED_DATA];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return offset;
}

+ (NSInteger)setWWANSentOffset:(NSInteger)offset{
    NSInteger old = [[NSUserDefaults standardUserDefaults] integerForKey:LAST_WWAN_SENT_DATA];
    if( !old ) old = 0;
    [[NSUserDefaults standardUserDefaults] setInteger:offset + old forKey:LAST_WWAN_SENT_DATA];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return offset;
}

+ (void)clearOffset:(DataType)type{
    NSInteger zero = 0;
    
    if( type == DataTypeWiFiRecevied )
        [[NSUserDefaults standardUserDefaults] setInteger:zero forKey:LAST_WIFI_RECEIVED_DATA];
    
    else if( type == DataTypeWiFiSent )
        [[NSUserDefaults standardUserDefaults] setInteger:zero forKey:LAST_WIFI_SENT_DATA];
    
    else if( type == DataTypeWWANRecevied )
        [[NSUserDefaults standardUserDefaults] setInteger:zero forKey:LAST_WWAN_RECEIVED_DATA];
    
    else if( type == DataTypeWWANSent )
        [[NSUserDefaults standardUserDefaults] setInteger:zero forKey:LAST_WWAN_SENT_DATA];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger)getWiFiReceviedOffset{
    return [[NSUserDefaults standardUserDefaults] integerForKey:LAST_WIFI_RECEIVED_DATA];
}

+ (NSInteger)getWifiSentOffset{
    return [[NSUserDefaults standardUserDefaults] integerForKey:LAST_WIFI_SENT_DATA];
}

+ (NSInteger)getWWANReceviedOffset{
    return [[NSUserDefaults standardUserDefaults] integerForKey:LAST_WWAN_RECEIVED_DATA];
}

+ (NSInteger)getWWANSentOffset{
    return [[NSUserDefaults standardUserDefaults] integerForKey:LAST_WWAN_SENT_DATA];
}

+ (void)setLastDataRecord:(NSInteger)WiFiR :(NSInteger)WiFiS :(NSInteger)WWANR :(NSInteger)WWANS{
    [[NSUserDefaults standardUserDefaults] setInteger:WiFiR forKey:LAST_WIFI_RECEIVED_RECORD];
    [[NSUserDefaults standardUserDefaults] setInteger:WiFiS forKey:LAST_WIFI_SENT_RECORD];
    [[NSUserDefaults standardUserDefaults] setInteger:WWANR forKey:LAST_WWAN_RECEIVED_RECORD];
    [[NSUserDefaults standardUserDefaults] setInteger:WWANS forKey:LAST_WWAN_SENT_RECORD];
}

+ (NSArray *)lastDataRecord{
    NSInteger wir, wis, wwr, wws;
    wir = [[NSUserDefaults standardUserDefaults] integerForKey:LAST_WIFI_RECEIVED_RECORD];
    wis = [[NSUserDefaults standardUserDefaults] integerForKey:LAST_WIFI_SENT_RECORD];
    wwr = [[NSUserDefaults standardUserDefaults] integerForKey:LAST_WWAN_RECEIVED_RECORD];
    wws = [[NSUserDefaults standardUserDefaults] integerForKey:LAST_WWAN_SENT_RECORD];
    
    if( !wir ) wir = 0;
    if( !wis ) wis = 0;
    if( !wwr ) wwr = 0;
    if( !wws ) wws = 0;
    
    return @[ [NSNumber numberWithInteger:wir],
              [NSNumber numberWithInteger:wis],
              [NSNumber numberWithInteger:wwr],
              [NSNumber numberWithInteger:wws]
            ];
}

+ (BOOL)autoCorrectOffset:(NSInteger)WiFiR :(NSInteger)WiFiS :(NSInteger)WWANR :(NSInteger)WWANS{
    
    NSArray *lastRecord = [self lastDataRecord];
    
    NSInteger wir = [lastRecord[0] integerValue];
    NSInteger wis = [lastRecord[1] integerValue];
    NSInteger wwr = [lastRecord[2] integerValue];
    NSInteger wws = [lastRecord[3] integerValue];
    
    if( wir == 0 ) wir = WiFiR;
    if( wis == 0 ) wis = WiFiS;
    if( wwr == 0 ) wwr = WWANR;
    if( wws == 0 ) wws = WWANS;
    
    NSInteger plusWirR = ( WiFiR - wir ) < 0 ? wir : 0;
    NSInteger plusWisR = ( WiFiS - wis ) < 0 ? wis : 0;
    NSInteger plusWwrR = ( WWANR - wwr ) < 0 ? wwr : 0;
    NSInteger plusWwsR = ( WWANS - wws ) < 0 ? wws : 0;
    
    [self setWiFiReceviedOffset:plusWirR];
    [self setWifiSentOffset:plusWisR];
    [self setWWANReceviedOffset:plusWwrR];
    [self setWWANSentOffset:plusWwsR];
    
    [self setLastDataRecord:WiFiR :WiFiS :WWANR :WWANS];
    
    return YES;
}

+ (NSString *)userUnit{
    
    NSString *unit;
    unit = [[NSUserDefaults standardUserDefaults] stringForKey:USERUNIT];
    if( !unit ){
        
        unit = UNITAUTO;
        [[NSUserDefaults standardUserDefaults] setValue:unit forKey:USERUNIT];
        
    }
    
    [MOREDataModel currentMOREDataModel].userUnit = unit;
    
    return unit;
    
}

+ (NSString *)setUserUnit:(NSString *)unit{
    
    [[NSUserDefaults standardUserDefaults] setValue:unit forKey:USERUNIT];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [MOREDataModel currentMOREDataModel].userUnit = unit;
    
    return unit;
    
}

+ (NSInteger)userWIFIOffset{
    
    NSInteger offset;
    offset = [[NSUserDefaults standardUserDefaults] integerForKey:WIFIOFFSET];
    if( !offset ){
        offset = 0;
        [[NSUserDefaults standardUserDefaults] setInteger:offset forKey:WIFIOFFSET];
    }
    
    return offset;
    
}

+ (NSInteger)setUserWIFIOffset:(NSInteger)offset{
    
    [[NSUserDefaults standardUserDefaults] setInteger:offset forKey:WIFIOFFSET];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return offset;
    
}

+ (NSInteger)userCELLULAROffset{
    
    NSInteger offset;
    offset = [[NSUserDefaults standardUserDefaults] integerForKey:CELLULAROFFSET];
    if( !offset ){
        offset = 0;
        [[NSUserDefaults standardUserDefaults] setInteger:offset forKey:CELLULAROFFSET];
    }
    
    return offset;
    
}

+ (NSInteger)setUSerCELLULAROffset:(NSInteger)offset{
    
    [[NSUserDefaults standardUserDefaults] setInteger:offset forKey:CELLULAROFFSET];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return offset;
    
}

+ (NSUInteger)progressCache:(progessTargetType)type cache:(NSUInteger)cache{
    NSUInteger value;
    
    if( cache == 0 ){
        if( type == progessTargetTypeWiFi ){
            value = [[NSUserDefaults standardUserDefaults] integerForKey:PROGRESS_WIFI_CACHE];
        
        }else if( type == progessTargetTypeWWAN ){
            value = [[NSUserDefaults standardUserDefaults] integerForKey:PROGRESS_WWAN_CACHE];
            
        }
        
    }else if( cache != 0 ){
        if( type == progessTargetTypeWiFi ){
            NSUInteger currentCache = [[MOREDataModel currentMOREDataModel].WiFi_AMOUNT integerValue];
            [[NSUserDefaults standardUserDefaults] setInteger:currentCache
                                                       forKey:PROGRESS_WIFI_CACHE];
            [MOREDataModel currentMOREDataModel].progressWiFiCache = currentCache;
            
        }else if( type == progessTargetTypeWWAN ){
            NSUInteger currentCache = [[MOREDataModel currentMOREDataModel].WWAN_AMOUNT integerValue];
            [[NSUserDefaults standardUserDefaults] setInteger:currentCache
                                                       forKey:PROGRESS_WWAN_CACHE];
            [MOREDataModel currentMOREDataModel].progressWWANCache = currentCache;
            
        }
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return value;
}

+ (NSUInteger)progressTarget:(progessTargetType)type target:(NSUInteger)target{
    NSUInteger value;
    
    if( target == 0 ){
        if( type == progessTargetTypeWiFi ){
            value = [[NSUserDefaults standardUserDefaults] integerForKey:PROGRESS_WIFI_TARGET];
        
        }else if( type == progessTargetTypeWWAN ){
            value = [[NSUserDefaults standardUserDefaults] integerForKey:PROGRESS_WWAN_TARGET];
        }
        
    }else if( target != 0 ){
        if( type == progessTargetTypeWiFi ){
            [[NSUserDefaults standardUserDefaults] setInteger:target forKey:PROGRESS_WIFI_TARGET];
            [self progressCache:progessTargetTypeWiFi cache:100];
            [MOREDataModel currentMOREDataModel].progressWiFiTarget = target;
        
        }else if( type == progessTargetTypeWWAN ){
            [[NSUserDefaults standardUserDefaults] setInteger:target forKey:PROGRESS_WWAN_TARGET];
            [self progressCache:progessTargetTypeWWAN cache:100];
            [MOREDataModel currentMOREDataModel].progressWWANTarget = target;
            
        }
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    return value;
}

+ (BOOL)isDEBUG{
    
    BOOL isDEBUG;
    isDEBUG = [[NSUserDefaults standardUserDefaults] integerForKey:ISDEBUG];
    if( isDEBUG != YES && isDEBUG != NO ) isDEBUG = NO;
    
    return isDEBUG;
}

+ (void)debug:(BOOL)debug{
    [[NSUserDefaults standardUserDefaults] setInteger:debug forKey:ISDEBUG];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
