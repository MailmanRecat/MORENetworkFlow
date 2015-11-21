//
//  MOREDataUIView.h
//  GGAnimationTestProject
//
//  Created by caine on 11/17/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MOREProgressView.h"

@interface MOREDataUIView : UIView

@property( nonatomic, strong ) UIButton *floatingButton;
@property( nonatomic, strong ) UIButton *actionButton;

@property( nonatomic, strong ) UILabel *downloadSpeed;
@property( nonatomic, strong ) UILabel *uploadSpeed;
@property( nonatomic, strong ) MOREProgressView *progress;
@property( nonatomic, strong ) UILabel *progressMin;
@property( nonatomic, strong ) UILabel *progressMax;
@property( nonatomic, strong ) UILabel *date;
@property( nonatomic, strong ) UILabel *dataSent;
@property( nonatomic, strong ) UILabel *dataRecevied;
@property( nonatomic, strong ) UILabel *dataAmount;

@property( nonatomic, strong ) UIScrollView *bear;

//FOR DEBUG
@property( nonatomic, strong ) UILabel *debugUploadSpeed;
@property( nonatomic, strong ) UILabel *debugDataSent;
@property( nonatomic, strong ) UILabel *debugDataSentStorage;
@property( nonatomic, strong ) UILabel *debugDataRecevied;
@property( nonatomic, strong ) UILabel *debugDataReceviedStorage;

@property( nonatomic, strong ) UILabel *debugProgressCache;
@property( nonatomic, strong ) UILabel *debugProgressTarget;
@property( nonatomic, strong ) UILabel *debugProgressCurrent;
@property( nonatomic, strong ) UILabel *debugProgressPercentage;
//FOR DEBUG END

@end
