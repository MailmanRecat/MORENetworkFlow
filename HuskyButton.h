//
//  HuskyButton.h
//  Animation
//
//  Created by caine on 7/7/15.
//  Copyright (c) 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^huskyCompletion)(void);

@interface HuskyButton : UIButton

@property( nonatomic, strong ) UIColor *FurColor;
@property( nonatomic, assign ) CGFloat  FurAlpha;
@property( nonatomic, assign ) NSTimeInterval AaoAaoAaoDuration;
@property( nonatomic, copy   ) huskyCompletion huskyCompletion;
@property( nonatomic, assign ) BOOL     isPlayFromCenter;

@end
