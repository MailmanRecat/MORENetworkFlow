//
//  MORENetWork.h
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *const MORENetworkNil = @"MORENetworkNil";
static NSString *const MORENetworkWIFI = @"MORENetworkWIFI";
static NSString *const MORENetworkWWAN = @"MORENetworkWWAN";

static NSString *const DataCounterKeyWWANSent = @"WWANSent";
static NSString *const DataCounterKeyWWANReceived = @"WWANReceived";
static NSString *const DataCounterKeyWiFiSent = @"WIFISent";
static NSString *const DataCounterKeyWiFiReceived = @"WIFIReceived";

static NSString *const SWIFIS = @"WIFIS";
static NSString *const SWIFIR = @"WIFIR";
static NSString *const SWWANS = @"WWANS";
static NSString *const SWWANR = @"WWANR";
static NSString *const SSPEED = @"SPEED";
static NSString *const SUPLOAD = @"SUPLOAD";

static NSString *const MOREUNITBIT = @"BIT";
static NSString *const MOREUNITKB = @"KB";
static NSString *const MOREUNITMB = @"MB";
static NSString *const MOREUNITGB = @"GB";
static NSString *const MOREUNITTB = @"TB";

@interface MORENetWork : NSObject

+ (NSString *)NetWorktype;
+ (NSDictionary *)NetworkFlow;
+ (NSDictionary *)NetworkInfoWithUnit:(NSString *)unit;

@end
