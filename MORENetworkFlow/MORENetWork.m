//
//  MORENetWork.m
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>

#import "MORENetWork.h"

@interface MORENetWork()

@end

@implementation MORENetWork

+ (NSString *)NetWorktype{
    
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKey:@"statusBar"] valueForKey:@"foregroundView"] subviews];
    NSNumber *dataNetwrokItemView = nil;
    
    for( id subview in subviews ){
        if( [subview isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]] ){
            
            dataNetwrokItemView = subview;
            break;
            
        }
    }
    
    NSString *type;
    
    switch ( [[dataNetwrokItemView valueForKey:@"dataNetworkType"] integerValue] ) {
        case 0:
            
            type = MORENetworkNil;
            break;
        case 1:
            
            type = MORENetworkWWAN;
            break;
        case 2:
            
            type = MORENetworkWWAN;
            break;
        case 3:
            
            type = MORENetworkWWAN;
            break;
        case 4:
            
            type = MORENetworkWWAN;
            break;
        case 5:
            
            type = MORENetworkWIFI;
            break;
            
        default:
            break;
    }
    
    return type;
    
}

+ (NSDictionary *)NetworkFlow{
    struct ifaddrs *addrs;
    const struct ifaddrs *cursor;
    
    u_int32_t WiFiSent = 0;
    u_int32_t WiFiReceived = 0;
    u_int32_t WWANSent = 0;
    u_int32_t WWANReceived = 0;
    
    if (getifaddrs(&addrs) == 0)
    {
        cursor = addrs;
        while (cursor != NULL)
        {
            if (cursor->ifa_addr->sa_family == AF_LINK)
            {
                const struct if_data *ifa_data = (struct if_data *)cursor->ifa_data;
                if(ifa_data != NULL){}
                
                // name of interfaces:
                // en0 is WiFi
                // pdp_ip0 is WWAN
                NSString *name = [NSString stringWithFormat:@"%s",cursor->ifa_name];
                if ([name hasPrefix:@"en"])
                {
                    const struct if_data *ifa_data = (struct if_data *)cursor->ifa_data;
                    if(ifa_data != NULL)
                    {
                        WiFiSent += ifa_data->ifi_obytes;
                        WiFiReceived += ifa_data->ifi_ibytes;
                    }
                }
                
                if ([name hasPrefix:@"pdp_ip"])
                {
                    const struct if_data *ifa_data = (struct if_data *)cursor->ifa_data;
                    if(ifa_data != NULL)
                    {
                        WWANSent += ifa_data->ifi_obytes;
                        WWANReceived += ifa_data->ifi_ibytes;
                    }
                }
            }
            
            cursor = cursor->ifa_next;
        }
        
        freeifaddrs(addrs);
    }
    
    return @{
                DataCounterKeyWiFiSent:[NSNumber numberWithUnsignedInt:WiFiSent],
                DataCounterKeyWiFiReceived:[NSNumber numberWithUnsignedInt:WiFiReceived],
                DataCounterKeyWWANSent:[NSNumber numberWithUnsignedInt:WWANSent],
                DataCounterKeyWWANReceived:[NSNumber numberWithUnsignedInt:WWANReceived]
             };
}

+ (NSDictionary *)NetworkInfoWithUnit:(NSString *)unit{
    
    NSDictionary *flow = [self NetworkFlow];
    
    NSInteger WIFIS = [[flow valueForKey:DataCounterKeyWiFiSent] integerValue];
    NSInteger WIFIR = [[flow valueForKey:DataCounterKeyWiFiReceived] integerValue];
    NSInteger WWANS = [[flow valueForKey:DataCounterKeyWWANSent] integerValue];
    NSInteger WWANR = [[flow valueForKey:DataCounterKeyWWANReceived] integerValue];
    
    NSString *type = [self NetWorktype];
    NSInteger offset;
    NSInteger uploadOffset = 0;
    
    NSInteger cacheWIFIR = [[[NSUserDefaults standardUserDefaults] valueForKey:DataCounterKeyWiFiReceived] integerValue];
    NSInteger cacheWWANR = [[NSUserDefaults standardUserDefaults] integerForKey:DataCounterKeyWWANReceived];
    NSInteger cacheWIFIS = [[NSUserDefaults standardUserDefaults] integerForKey:DataCounterKeyWiFiSent];
    NSInteger cacheWWANS = [[NSUserDefaults standardUserDefaults] integerForKey:DataCounterKeyWWANSent];
    
    [[NSUserDefaults standardUserDefaults] setInteger:WIFIR forKey:DataCounterKeyWiFiReceived];
    [[NSUserDefaults standardUserDefaults] setInteger:WWANR forKey:DataCounterKeyWWANReceived];
    [[NSUserDefaults standardUserDefaults] setInteger:WIFIS forKey:DataCounterKeyWiFiSent];
    [[NSUserDefaults standardUserDefaults] setInteger:WWANS forKey:DataCounterKeyWWANSent];
    
    if( type == MORENetworkNil ){
        
        offset = uploadOffset = 0;
        
    }else if( type == MORENetworkWIFI ){
        
        offset = WIFIR - cacheWIFIR;
        uploadOffset = WIFIS - cacheWIFIS;
        
    }else if( type == MORENetworkWWAN ){
        
        offset = WWANR - cacheWWANR;
        uploadOffset = WWANS - cacheWWANS;
        
    }
    
    if( offset < 0 ){
        
        offset = uploadOffset = 0;
        
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:DataCounterKeyWiFiReceived];
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:DataCounterKeyWWANReceived];
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:DataCounterKeyWiFiSent];
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:DataCounterKeyWWANSent];
        
    }
    
    if( unit == MOREUNITBIT ){}
    else if( unit == MOREUNITKB ){
        
        WIFIR = WIFIR / 1024;
        WIFIS = WIFIS / 1024;
        WWANR = WWANR / 1024;
        WWANS = WWANS / 1024;
        offset = offset / 1024;
        uploadOffset = uploadOffset / 1024;
        
    }
    else if( unit == MOREUNITMB ){
        
        WIFIR = WIFIR / ( 1024 * 1024 );
        WIFIS = WIFIS / ( 1024 * 1024 );
        WWANR = WWANR / ( 1024 * 1024 );
        WWANS = WWANS / ( 1024 * 1024 );
        offset = offset / ( 1024 * 1024 );
        uploadOffset = uploadOffset / ( 1024 * 1024 );
        
    }
    else if( unit == MOREUNITGB ){
        
        WIFIR = WIFIR / ( 1024 * 1024 * 1024 );
        WIFIS = WIFIS / ( 1024 * 1024 * 1024 );
        WWANR = WWANR / ( 1024 * 1024 * 1024 );
        WWANS = WWANS / ( 1024 * 1024 * 1024 );
        offset = offset / ( 1024 * 1024 * 1024 );
        uploadOffset = uploadOffset / ( 1024 * 1024 * 1024 );
        
    }
    else if( unit == MOREUNITTB ){}

    return @{
            
             SWIFIS: [NSNumber numberWithUnsignedInteger:WIFIS],
             SWIFIR: [NSNumber numberWithUnsignedInteger:WIFIR],
             SWWANS: [NSNumber numberWithUnsignedInteger:WWANS],
             SWWANR: [NSNumber numberWithUnsignedInteger:WWANR],
             SSPEED: [NSNumber numberWithUnsignedInteger:offset],
             SUPLOAD: [NSNumber numberWithUnsignedInteger:uploadOffset]
             
             };
}

@end
