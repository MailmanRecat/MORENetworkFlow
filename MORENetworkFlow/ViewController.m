//
//  ViewController.m
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#define STATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define BAR_HEIGHT 56 + 20
#define INFOMATION_HEIGHT 72

#define REFRESH_INTERVAL 1

#import "ViewController.h"

#import "UIWindow+MOREAlertView.h"
#import "UIView+MOREStackLayoutView.h"
#import "UIFont+MaterialDesignIcons.h"
#import "HuskyButton.h"
#import "MOREDataUIView.h"
#import "MORENetWork.h"
#import "UISetting.h"
#import "UISettingViewController.h"
#import "WindPark.h"
#import "MORESettingView.h"
#import "MOREInfiniteLabel.h"
#import "MOREPageView.h"

#import "MORELanguage.h"
#import "MORETransitionAnimationPresent.h"
#import "MORETransitionAnimationDismiss.h"
#import "MORETransitionAnimationDelegate.h"

#import "MOREDataModel.h"

#import "MOREProgressSetupViewController.h"

#import "UIColor+Theme.h"

@interface ViewController ()<UIScrollViewDelegate, MOREAlertDelegate>{
    dispatch_queue_t queue;
    dispatch_source_t timer;
}

@property( nonatomic, strong ) WindPark *park;

@property( nonatomic, strong ) UIView *topBear;

@property( nonatomic, strong ) UIView   *bar;
@property( nonatomic, strong ) UILabel  *barTitle;
@property( nonatomic, strong ) UIView   *border;
@property( nonatomic, strong ) MOREPageView *pageControl;

@property( nonatomic, strong ) UIView *bottomBar;
@property( nonatomic, strong ) MOREInfiniteLabel *infiniteLabel;
@property( nonatomic, strong ) MOREInfiniteLabel *alert;
@property( nonatomic, assign ) NSUInteger step;

@property( nonatomic, strong ) HuskyButton *speed;
@property( nonatomic, strong ) HuskyButton *upload;

@property( nonatomic, strong ) UIScrollView *content;

@property( nonatomic, strong ) MOREDataUIView *MOREDataWiFiView;
@property( nonatomic, strong ) MOREDataUIView *MOREDateWWANView;
@property( nonatomic, strong ) UILabel *MOREDataSpeed;
@property( nonatomic, assign ) progessTargetType progressType;

@property( nonatomic, strong ) MORETransitionAnimationDelegate *transitionDelegate;
@property( nonatomic, strong ) MORETransitionAnimationDelegate *transitionDelegateV;

@end

@implementation ViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if( scrollView.tag == 7777 || scrollView.tag == 7778 )
        _MOREDataWiFiView.bear.contentOffset = _MOREDateWWANView.bear.contentOffset = scrollView.contentOffset;
}

- (void)didClickDismissButton:(UISettingViewController *)UISettingviewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.clipsToBounds = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadTopBar];
    [self loadScrollView];
    [self loadToolBar];
    [self loadSpeed];
    
    [self refresh];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(shouldProgressUIUpdate:)
                                                 name:UIDidChangeProgessMaxNotification
                                               object:nil];
}

- (void)refresh{
    
    uint64_t interval = REFRESH_INTERVAL * NSEC_PER_SEC;
    
    if( !queue ){
        queue = dispatch_queue_create("myQueue", 0);
    }
    
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
    
    dispatch_source_set_event_handler(timer, ^{
        NSDictionary *info = [MORENetWork NetworkInfoWithUnit:MOREUNITKB];
        
        NSString *userUnit = [MOREDataModel currentMOREDataModel].userUnit;

        [self formatWithUnit:userUnit andData:info];
        
    });
        
    dispatch_resume(timer);
}

- (void)formatWithUnit:(NSString *)unit andData:(NSDictionary *)data{
    
    NSString *date = [NSString stringWithFormat:@"%@ - %@", [UISetting startDate], [UISetting endDate]];
    
    NSInteger autoWIFIR = [data[SWIFIR] integerValue];
    NSInteger autoWIFIS = [data[SWIFIS] integerValue];
    NSInteger autoWWANR = [data[SWWANR] integerValue];
    NSInteger autoWWANS = [data[SWWANS] integerValue];
    
    [UISetting autoCorrectOffset:autoWIFIR :autoWIFIS :autoWWANR :autoWWANS];
    
    CGFloat WIFIR = [data[SWIFIR] floatValue] + [UISetting getWiFiReceviedOffset];
    CGFloat WIFIS = [data[SWIFIS] floatValue] + [UISetting getWifiSentOffset];
    CGFloat WWANR = [data[SWWANR] floatValue] + [UISetting getWWANReceviedOffset];
    CGFloat WWANS = [data[SWWANS] floatValue] + [UISetting getWWANSentOffset];
    CGFloat SPEED = [data[SSPEED] floatValue];
    CGFloat UPLOAD = [data[SUPLOAD] floatValue];
    
    CGFloat WIFIA = WIFIR + WIFIS;
    CGFloat WWANA = WWANR + WWANS;
    
    MOREDataModel *model = [MOREDataModel currentMOREDataModel];
    
    model.WiFi_USAGE = [self UIStringWithFlow:WIFIR andUnit:unit];
    model.WiFi_SENT  = [self UIStringWithFlow:WIFIS andUnit:unit];
    model.WiFi_AMOUNT = [self UIStringWithFlow:WIFIA andUnit:unit];
    model.WWAN_USAGE = [self UIStringWithFlow:WWANR andUnit:unit];
    model.WWAN_SENT = [self UIStringWithFlow:WWANS andUnit:unit];
    model.WWAN_AMOUNT = [self UIStringWithFlow:WWANA andUnit:unit];
    
    model.progressWiFiPercentage = (WIFIA / 1024.0 - model.progressWiFiCache) / (model.progressWiFiTarget | 1);
    model.progressWWANPercentage = (WWANA / 1024.0 - model.progressWWANCache) / (model.progressWWANTarget | 1);
    
    NSString *speed;
    if( SPEED > 1024 )
        speed = [NSString stringWithFormat:@"%0.1f MB/S", SPEED / 1024];
    else
        speed = [NSString stringWithFormat:@"%d KB/S", (int)SPEED];
    
    NSString *upload;
    if( UPLOAD > 1024 )
        upload = [NSString stringWithFormat:@"%0.1f MB/S", UPLOAD / 1024];
    else
        upload = [NSString stringWithFormat:@"%d KB/S", (int)UPLOAD];
    
    model.DATE = date;
    model.SPEED = speed;
    model.UPLOAD_SPEED = upload;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MORESPEED" object:speed];
        
        if( [UISetting isDEBUG] ){
            
            _MOREDataWiFiView.debugUploadSpeed.text = _MOREDateWWANView.debugUploadSpeed.text = upload;
            
            _MOREDataWiFiView.debugDataRecevied.text = [NSString stringWithFormat:@"%ld MB", autoWIFIR / 1024];
            _MOREDataWiFiView.debugDataReceviedStorage.text = [NSString stringWithFormat:@"%ld MB", [UISetting getWiFiReceviedOffset] / 1024];
            _MOREDataWiFiView.debugDataSent.text = [NSString stringWithFormat:@"%ld MB", autoWIFIS / 1024];
            _MOREDataWiFiView.debugDataSentStorage.text = [NSString stringWithFormat:@"%ld MB", [UISetting getWWANSentOffset] / 1024];
            
            _MOREDataWiFiView.debugProgressCache.text = [NSString stringWithFormat:@"%ld MB", model.progressWiFiCache];
            _MOREDataWiFiView.debugProgressCurrent.text = [NSString stringWithFormat:@"%ld MB", (NSUInteger)(WIFIA / 1024.0 - model.progressWiFiCache)];
            _MOREDataWiFiView.debugProgressPercentage.text = [NSString stringWithFormat:@"%f MB", model.progressWiFiPercentage];
            _MOREDataWiFiView.debugProgressTarget.text = [NSString stringWithFormat:@"%ld MB", model.progressWiFiTarget];
            
            _MOREDateWWANView.debugDataRecevied.text = [NSString stringWithFormat:@"%ld MB", autoWWANR / 1024];
            _MOREDateWWANView.debugDataReceviedStorage.text = [NSString stringWithFormat:@"%ld MB", [UISetting getWWANReceviedOffset] / 1024];
            _MOREDateWWANView.debugDataSent.text = [NSString stringWithFormat:@"%ld MB", autoWWANS / 1024];
            _MOREDateWWANView.debugDataSentStorage.text = [NSString stringWithFormat:@"%ld MB", [UISetting getWWANSentOffset] / 1024];
            
            _MOREDateWWANView.debugProgressCache.text = [NSString stringWithFormat:@"%ld MB", model.progressWWANCache];
            _MOREDateWWANView.debugProgressCurrent.text = [NSString stringWithFormat:@"%ld MB", (NSUInteger)(WWANA / 1024.0 - model.progressWWANCache)];
            _MOREDateWWANView.debugProgressPercentage.text = [NSString stringWithFormat:@"%f MB", model.progressWWANPercentage];
            _MOREDateWWANView.debugProgressTarget.text = [NSString stringWithFormat:@"%ld MB", model.progressWWANTarget];
        }
        
    });
    
    [self UIUpdate];
}

- (NSString *)UIStringWithFlow:(CGFloat)flow andUnit:(NSString *)unit{
    NSString *result;
    
    if( [unit isEqualToString:UNITAUTO] ){
        NSString *unitString = @"MB";
        if( flow / 1024 > 1024 ){
            
            unitString = @"GB";
            flow = flow / (1024 * 1024);
            result = [NSString stringWithFormat:@"%.2lf %@", flow, unitString];
            
        }else{
            
            flow = flow / 1024;
            result = [NSString stringWithFormat:@"%d %@", (int)flow, unitString];
            
        }
    }else if( [unit isEqualToString:UNITMB] ){
        NSString *unitString = @"MB";
        flow = flow / 1024;
        result = [NSString stringWithFormat:@"%d %@", (int)flow, unitString];
        
    }else if( [unit isEqualToString:UNITGB] ){
        NSString *unitString = @"GB";
        flow = flow / (1024 * 1024);
        result = [NSString stringWithFormat:@"%.2lf %@", flow, unitString];
        
    }
    
    return result;
}

- (void)UIUpdate{
    dispatch_async(dispatch_get_main_queue(), ^{
        MOREDataModel *model = [MOREDataModel currentMOREDataModel];
        
        _MOREDataWiFiView.dataRecevied.text = model.WiFi_USAGE;
        _MOREDataWiFiView.dataSent.text = model.WiFi_SENT;
        _MOREDataWiFiView.dataAmount.text = model.WiFi_AMOUNT;
        
        [_MOREDataWiFiView.progress setProgress:model.progressWiFiPercentage animation:YES];
        
        _MOREDateWWANView.dataRecevied.text = model.WWAN_USAGE;
        _MOREDateWWANView.dataSent.text = model.WWAN_SENT;
        _MOREDateWWANView.dataAmount.text = model.WWAN_AMOUNT;
        
        [_MOREDateWWANView.progress setProgress:model.progressWWANPercentage animation:YES];
        
        _MOREDataSpeed.text = model.SPEED;
    });
}

- (void)shouldProgressUIUpdate:(NSNotification *)notifacation{
    if( [[notifacation object][0] integerValue] == progessTargetTypeWiFi ){
        _MOREDataWiFiView.progressMax.text = [NSString stringWithFormat:@"%ld MB", [MOREDataModel currentMOREDataModel].progressWiFiTarget];
    }else if( [[notifacation object][0] integerValue] == progessTargetTypeWWAN ){
        _MOREDateWWANView.progressMax.text = [NSString stringWithFormat:@"%ld MB", [MOREDataModel currentMOREDataModel].progressWWANTarget];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)settingViewController{
    
    UISettingViewController *settingViewController = [UISettingViewController new];
    
    [self presentViewController:settingViewController animated:YES completion:nil];
}

- (void)progressSetupViewController:(UIButton *)sender{
    
    if( sender.tag == 1000 )
        _progressType = progessTargetTypeWiFi;
    else if( sender.tag == 1001 )
        _progressType = progessTargetTypeWWAN;
    
    MOREProgressSetupViewController *setup = [MOREProgressSetupViewController new];
    setup.type = _progressType;
    
    [self presentViewController:setup animated:YES completion:nil];
}

- (void)loadTopBar{
    
    UIView *topBear = [UIView new];
    topBear.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:topBear];
    
    topBear.backgroundColor = [UIColor whiteColor];
    topBear.backgroundColor = [UIColor backgroundColor];
    
    topBear.layer.shadowColor = [UIColor blackColor].CGColor;
    topBear.layer.shadowOpacity = 0.25f;
    topBear.layer.shadowOffset = CGSizeMake(0, 0.7);
    topBear.layer.shadowRadius = 1.57;
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:topBear to:self.view type:EdgeTopLeftRightZero]];
    [topBear addConstraints:[NSLayoutConstraint SpactecledBearFixed:topBear type:SpactecledBearFixedHeight constant:STATUS_BAR_HEIGHT + 56 + 16]];
    
    UILabel *dashboard = [UILabel new];
    dashboard.translatesAutoresizingMaskIntoConstraints = NO;
    [topBear addSubview:dashboard];
    
    dashboard.textColor = [UIColor whiteColor];
    dashboard.font = [UIFont fontWithName:@"Roboto-bold" size:18];
    dashboard.textAlignment = NSTextAlignmentCenter;
    dashboard.text = @"Dashboard";
    
    [topBear addSubview:dashboard];
    [topBear addConstraints:[NSLayoutConstraint SpactecledBearEdeg:dashboard to:topBear type:EdgeLeftRightZero]];
    [topBear addConstraints:[NSLayoutConstraint SpactecledBearEdeg:dashboard to:topBear type:EdgeTopZero constant:STATUS_BAR_HEIGHT]];
    [topBear addConstraints:[NSLayoutConstraint SpactecledBearEdeg:dashboard to:topBear type:EdgeBottomZero constant:16]];
    
    _topBear = topBear;
    
    MOREPageView *pageControl = [[MOREPageView alloc] initWithCount:2];
    pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    [topBear addSubview:pageControl];
    
    [topBear addConstraints:[NSLayoutConstraint SpactecledBearEdeg:pageControl
                                                                to:topBear
                                                              type:EdgeLeftRightZero
                                                          constant:(self.view.frame.size.width - 56) / 2.0]];
    [topBear addConstraints:[NSLayoutConstraint SpactecledBearEdeg:pageControl
                                                                to:topBear
                                                              type:EdgeBottomZero
                                                          constant:12]];
    [topBear addConstraints:[NSLayoutConstraint SpactecledBearFixed:pageControl
                                                               type:SpactecledBearFixedHeight
                                                           constant:8]];
    pageControl.color = [UIColor whiteColor];
    pageControl.backgroundColor = [UIColor clearColor];
    _pageControl = pageControl;
    
}

- (void)loadSpeed{
    
    CGFloat PROPORTION = 0.618;
    CGFloat UISCREENT_HEIGHT = [UIScreen mainScreen].bounds.size.height;
    CGFloat edgeTop = STATUS_BAR_HEIGHT + 56 + 16;
    CGFloat height = ((UISCREENT_HEIGHT - edgeTop) * ( 1 - PROPORTION ));
    
    UIView *backgorundView = [UIView new];
    backgorundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view insertSubview:backgorundView belowSubview:_content];
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:backgorundView to:self.view type:EdgeLeftRightZero]];
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:backgorundView to:self.view type:EdgeTopZero constant:edgeTop]];
    [backgorundView addConstraints:[NSLayoutConstraint SpactecledBearFixed:backgorundView type:SpactecledBearFixedHeight constant:height]];
    
    UILabel *speedBear = [UILabel new];
    speedBear.translatesAutoresizingMaskIntoConstraints = NO;
    [backgorundView addSubview:speedBear];
    
    [backgorundView addConstraints:[NSLayoutConstraint SpactecledBearEdeg:speedBear to:backgorundView type:EdgeLeftRightZero]];
    [backgorundView addConstraints:[NSLayoutConstraint SpactecledBearFixed:speedBear type:SpactecledBearFixedHeight constant:height * PROPORTION - 24]];
    [backgorundView addConstraints:[NSLayoutConstraint SpactecledBearEdeg:speedBear to:backgorundView type:EdgeTopZero constant:24]];
    
    speedBear.textAlignment = NSTextAlignmentCenter;
    speedBear.font = [UIFont fontWithName:@"Roboto" size:47];
    speedBear.text = @"0 KB/S";
    speedBear.textColor = [UIColor textColor];

    _MOREDataSpeed = speedBear;
}

- (void)loadToolBar{
    
    UIView *bottomBear = [UIView new];
    bottomBear.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bottomBear];
    
    bottomBear.backgroundColor = [UIColor whiteColor];
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:bottomBear to:self.view type:EdgeBottomLeftRightZero]];
    [bottomBear addConstraints:[NSLayoutConstraint SpactecledBearFixed:bottomBear type:SpactecledBearFixedHeight constant:52]];
    
    HuskyButton *settingHusky = [HuskyButton new];
    HuskyButton *unitHusky = [HuskyButton new];
    settingHusky.translatesAutoresizingMaskIntoConstraints =
    unitHusky.translatesAutoresizingMaskIntoConstraints = NO;
    
    [bottomBear addSubview:settingHusky];
    [bottomBear addSubview:unitHusky];
    
    settingHusky.layer.cornerRadius = unitHusky.layer.cornerRadius = 3.0f;
    
    [settingHusky setTitle:@"SETTINGS" forState:UIControlStateNormal];
    [settingHusky setTitleColor:[UIColor textColor] forState:UIControlStateNormal];
    
    NSUInteger index = 0;
    for( HuskyButton *husky in @[ settingHusky, unitHusky ] ){
        husky.titleLabel.font = [UIFont fontWithName:@"Roboto-bold" size:15];
        [husky addConstraints:[NSLayoutConstraint SpactecledBearFixed:husky type:SpactecledBearFixedHeight constant:36]];
        [husky addConstraints:[NSLayoutConstraint SpactecledBearFixed:husky type:SpactecledBearFixedWidth constant:92]];
        [bottomBear addConstraints:[NSLayoutConstraint SpactecledBearEdeg:husky to:bottomBear type:EdgeBottomZero constant:8]];
        CGFloat edgeRight = (index * 100) + 8;
        [bottomBear addConstraints:[NSLayoutConstraint SpactecledBearEdeg:husky to:bottomBear type:EdgeRightZero constant:edgeRight]];
        index++;
    }
    
    [settingHusky addTarget:self action:@selector(settingViewController) forControlEvents:UIControlEventTouchUpInside];
    [unitHusky addTarget:self action:@selector(toggleUnit) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *jerk;
    if( [[UISetting userUnit] isEqualToString:UNITMB] )
        jerk = @"UNIT: MB";
    else if( [[UISetting userUnit] isEqualToString:UNITGB] )
        jerk = @"UNIT: GB";
    else if( [[UISetting userUnit] isEqualToString:UNITAUTO] )
        jerk = @"UNIT: AUTO";
    
    MOREInfiniteLabel *infinite = [[MOREInfiniteLabel alloc] initWIthTitle:jerk color:[UIColor textColor]];
    infinite.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomBear insertSubview:infinite belowSubview:unitHusky];
    
    infinite.layer.cornerRadius = 3.0f;
    infinite.testAlignment = NSTextAlignmentCenter;
    
    [infinite addConstraints:[NSLayoutConstraint SpactecledBearFixed:infinite type:SpactecledBearFixedHeight constant:36]];
    [infinite addConstraints:[NSLayoutConstraint SpactecledBearFixed:infinite type:SpactecledBearFixedWidth constant:92]];
    [bottomBear addConstraints:[NSLayoutConstraint SpactecledBearEdeg:infinite to:bottomBear type:EdgeBottomZero constant:8]];
    [bottomBear addConstraints:[NSLayoutConstraint SpactecledBearEdeg:infinite to:bottomBear type:EdgeRightZero constant:108]];
    
    _infiniteLabel = infinite;
    
    MOREInfiniteLabel *alert = [[MOREInfiniteLabel alloc] initWIthTitle:@"" color:[UIColor googleRed]];
    alert.translatesAutoresizingMaskIntoConstraints = NO;
    [bottomBear addSubview:alert];
    
    alert.testAlignment = NSTextAlignmentLeft;
    alert.clipsToBounds = YES;
    alert.layer.cornerRadius = 3.0f;
    _alert = alert;
    
    [bottomBear addConstraints:[NSLayoutConstraint SpactecledBearEdeg:alert to:bottomBear type:EdgeLeftZero constant:16]];
    [bottomBear addConstraints:[NSLayoutConstraint SpactecledBearFixed:alert type:SpactecledBearFixedHeight constant:36]];
    [bottomBear addConstraints:[NSLayoutConstraint SpactecledBearEdeg:alert to:bottomBear type:EdgeBottomZero constant:8]];
    [bottomBear addConstraints:[NSLayoutConstraint SpactecledBearEdeg:alert to:bottomBear type:EdgeRightZero constant:108 + 92 + 8]];
    
}

- (void)toggleUnit{
    if( [[UISetting userUnit] isEqualToString:UNITMB] ){
        [_infiniteLabel doFuck:@"UNIT: GB" color:[UIColor textColor]];
        [UISetting setUserUnit:UNITGB];
        
    }else if( [[UISetting userUnit] isEqualToString:UNITGB] ){
        [_infiniteLabel doFuck:@"UNIT: AUTO" color: [UIColor textColor]];
        [UISetting setUserUnit:UNITAUTO];
        
    }else if( [[UISetting userUnit] isEqualToString:UNITAUTO] ){
        [_infiniteLabel doFuck:@"UNIT: MG" color:[UIColor textColor]];
        [UISetting setUserUnit:UNITMB];
        
    }
}

- (void)loadScrollView{
    
    UIScrollView *scrollView = [UIScrollView new];
    [scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view insertSubview:scrollView belowSubview:_topBear];
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:scrollView to:self.view type:EdgeBottomLeftRightZero]];
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:scrollView
                                                                  to:self.view
                                                                type:EdgeTopZero constant:STATUS_BAR_HEIGHT + 56 + 16]];
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    _content = scrollView;

    MOREDataUIView *UIWifi = [MOREDataUIView new];
    MOREDataUIView *UIWwan = [MOREDataUIView new];
    UIWifi.translatesAutoresizingMaskIntoConstraints =
    UIWwan.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIWifi.bear.delegate = self;
    UIWwan.bear.delegate = self;
    
    [UISetting debug:YES];
    
    _MOREDataWiFiView = UIWifi;
    _MOREDateWWANView = UIWwan;
    
    _MOREDataWiFiView.date.text = @"WiFi";
    _MOREDateWWANView.date.text = @"Cellular";
    
    _MOREDataWiFiView.bear.tag = 7777;
    _MOREDateWWANView.bear.tag = 7778;
    
    [scrollView autolayoutSubviews:@[ UIWifi, UIWwan ]
                            edgeInsets:UIEdgeInsetsZero
                            multiplier:1.0
                             constants:0
                      stackOrientation:autolayoutStackOrientationHorizontal];
    
    scrollView.scrollEnabled = NO;
    
    UISwipeGestureRecognizer *gestureLeft = [UISwipeGestureRecognizer new];
    gestureLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [scrollView addGestureRecognizer:gestureLeft];
    [gestureLeft addTarget:self action:@selector(scrollViewGestureLeftHandler)];
    
    UISwipeGestureRecognizer *gestureRight = [UISwipeGestureRecognizer new];
    gestureRight.direction = UISwipeGestureRecognizerDirectionRight;
    [scrollView addGestureRecognizer:gestureRight];
    [gestureRight addTarget:self action:@selector(scrollViewGestureRightHandler)];
    
    _MOREDataWiFiView.floatingButton.tag = 1000;
    _MOREDateWWANView.floatingButton.tag = 1001;
    
    _MOREDataWiFiView.progressMax.text = [NSString stringWithFormat:@"%ld MB", [MOREDataModel currentMOREDataModel].progressWiFiTarget];
    _MOREDateWWANView.progressMax.text = [NSString stringWithFormat:@"%ld MB", [MOREDataModel currentMOREDataModel].progressWWANTarget];
    
    [_MOREDataWiFiView.floatingButton addTarget:self
                                         action:@selector(progressSetupViewController:)
                               forControlEvents:UIControlEventTouchUpInside];
    [_MOREDateWWANView.floatingButton addTarget:self
                                         action:@selector(progressSetupViewController:)
                               forControlEvents:UIControlEventTouchUpInside];
    
    [_MOREDataWiFiView.actionButton addTarget:self action:@selector(MOREAlert) forControlEvents:UIControlEventTouchUpInside];
}

- (void)scrollViewGestureLeftHandler{
    CGFloat pointX = _content.contentOffset.x;
    
    if( pointX < self.view.frame.size.width ){
        [UIView animateWithDuration:1.0f
                              delay:0.0f
                            options:( 7 << 16 )
                         animations:^{
                             _content.contentOffset = CGPointMake(self.view.frame.size.width, 0);
                         }completion:nil];
        [_pageControl updateIndex:1 percentage:0];
    }
}

- (void)scrollViewGestureRightHandler{
    CGFloat pointX = _content.contentOffset.x;
    
    if( pointX > 0 ){
        [UIView animateWithDuration:1.0f
                              delay:0.0f
                            options:( 7 << 16 )
                         animations:^{
                             _content.contentOffset = CGPointMake(0, 0);
                         }completion:nil];
        [_pageControl updateIndex:0 percentage:0];
    }
}

- (void)MOREAlert{
    [self.view.window MOREAlertWithMaterialFontIcon:[UIFont mdiBroom]
                                            message:@"Are you sure clear all data?"
                                            confirm:@"CONFIRM"
                                             cancel:@"CANCEL"
                                             colors:@[
                                                      [UIColor blackColor],
                                                      [UIColor whiteColor],
                                                      [UIColor googleRed],
                                                      [UIColor googleRed],
                                                      [UIColor googleRed],
                                                      [UIColor googleGreen]
                                                      ]
                                      answerRequire:NO
                                           delegate:self];
    [self.view.window MOREAlertShow];
}

- (void)MOREAlertDidCancel{}

- (void)MOREAlertDidConfirm{
    [UISetting progressCache:progessTargetTypeWiFi cache:100];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
    NSLog(@"memory warning");
}

@end
