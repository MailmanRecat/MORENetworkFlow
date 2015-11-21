//
//  Hamster.h
//  Animation
//
//  Created by caine on 7/10/15.
//  Copyright (c) 2015 com.caine. All rights reserved.
//

#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define SELF_HEIGHT 56
#define EDGE_INSET  16

#import <UIKit/UIKit.h>
#import "NSLayoutConstraint+SpectacledBearEdgeConstraint.h"
#import "HuskyButton.h"

typedef void(^balanceBlock)(void);

@interface WindPark : UIView

//     greenland
//               cliff    mountain
//
//herb
//--------------------------------

@property( nonatomic, strong ) HuskyButton *herb;
@property( nonatomic, strong ) UIView      *greenland;
@property( nonatomic, strong ) UILabel     *nameplate;
@property( nonatomic, strong ) HuskyButton *cliff;
@property( nonatomic, strong ) HuskyButton *mountain;


//all disappear should be look like:
//     -----------
//herb| greenland |cliff mountian
//     -----------

- (void)disappearHerb;
- (void)appearHerb;
- (void)disappearCliff;
- (void)appearCliff;
- (void)disappearMountain;
- (void)appearMountain;

- (void)nameplate:(NSString *)nameplate;

- (void)colorfulDay:(UIColor *)color :(balanceBlock)block;

- (void)sunShadowOpacity:(CGFloat)opacity offset:(CGSize)offset radius:(CGFloat)radius;
- (void)sunset;
- (void)sunrise;

@end
