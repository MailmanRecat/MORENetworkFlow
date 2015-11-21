//
//  MOREDataUIView.m
//  GGAnimationTestProject
//
//  Created by caine on 11/17/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#define UISTATUS_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height
#define UISCREENT_HEIGHT [UIScreen mainScreen].bounds.size.height
#define UISCREENT_WIDTH [UIScreen mainScreen].bounds.size.width
#define EDGE_INSET_TOP 92.0
#define PROPORTION 0.618

#import "UISetting.h"
#import "UIColor+Theme.h"
#import "UIFont+MaterialDesignIcons.h"

#import "UIView+MOREStackLayoutView.h"
#import "MOREDateUICell.h"
#import "MOREDataButtonCell.h"

#import "MOREDataUIView.h"

@interface MOREDataUIView()

@property( nonatomic, strong ) UIView *top;
@property( nonatomic, strong ) UIView *bottom;

@end

@implementation MOREDataUIView

- (instancetype)init{
    self = [super init];
    if( self ){
        
        CGFloat topViewHeight = (UISCREENT_HEIGHT - EDGE_INSET_TOP) * (1 - PROPORTION);
        NSNumber *cellHeight = [NSNumber numberWithFloat:56];
        
        NSMutableArray *room = [NSMutableArray new];
        NSMutableArray *roomSize = [NSMutableArray new];
        
        _top = [UIView new];
        _bear = [UIScrollView new];
        
        _top.translatesAutoresizingMaskIntoConstraints =
        _bear.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self addSubview:_bear];
        [self insertSubview:_top belowSubview:_bear];
        
        _bear.contentInset = UIEdgeInsetsMake(topViewHeight, 0, 52, 0);
        _bear.showsHorizontalScrollIndicator = NO;
        _bear.showsVerticalScrollIndicator = NO;
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_bear to:self type:EdgeAroundZero]];
        
        [self addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_top to:self type:EdgeTopLeftRightZero]];
        [self addConstraints:[NSLayoutConstraint SpactecledBearFixed:_top type:SpactecledBearFixedHeight constant:topViewHeight]];
        
        _top.backgroundColor = [UIColor clearColor];
        _bear.backgroundColor = [UIColor clearColor];
        
        UIView *unknow = [UIView new];
        unknow.backgroundColor = [UIColor whiteColor];
        
        UIView *dateContentView = [UIView new];
        dateContentView.backgroundColor = [UIColor whiteColor];
        
        dateContentView.layer.shadowColor = [UIColor blackColor].CGColor;
        dateContentView.layer.shadowOpacity = 0.1f;
        dateContentView.layer.shadowOffset = CGSizeMake(0, -0.7);
        dateContentView.layer.shadowRadius = 1.57;
        
        _date = [UILabel new];
        _date.translatesAutoresizingMaskIntoConstraints = NO;
        
        _date.font = [UIFont fontWithName:@"Roboto-bold" size:15];
        _date.textColor = [UIColor textColor];
        _date.textAlignment = NSTextAlignmentLeft;
        
        [dateContentView addSubview:_date];
        [dateContentView addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_date to:dateContentView type:EdgeTopBottomZero]];
        [dateContentView addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_date to:dateContentView type:EdgeLeftRightZero constant:16]];
        
        MOREDateUICell *ICell = [MOREDateUICell new];
        MOREDateUICell *IICell = [MOREDateUICell new];
        MOREDateUICell *IIICell = [MOREDateUICell new];
        
        NSArray *icons = @[ [UIFont mdiDownload], [UIFont mdiUpload], [UIFont mdiPoll] ];
        NSArray *color = @[
                           [UIColor colorWithRed:61 / 255.0 green:138 / 255.0 blue:248 / 255.0 alpha:1],
                           [UIColor colorWithRed:249 / 255.0 green:58 / 255.0 blue:57 / 255.0 alpha:1],
                           [UIColor colorWithRed:251 / 255.0 green:185 / 255.0 blue:62 / 255.0 alpha:1]
                           ];
        NSUInteger index = 0;
        for( MOREDateUICell *cell in @[ ICell, IICell, IIICell ] ){
            cell.backgroundColor = [UIColor whiteColor];
            cell.icon.font = [UIFont MaterialDesignIconsWithSize:17];
            cell.icon.textColor = color[index];
            cell.icon.text = icons[index];
            
            cell.firstname.font = [UIFont fontWithName:@"Roboto" size:19];
            cell.firstname.textColor = [UIColor colorWithWhite:13 / 255.0 alpha:1];
            
            cell.lastname.font = [UIFont fontWithName:@"Roboto-bold" size:15];
            cell.lastname.textColor = [UIColor colorWithWhite:126 / 255.0 alpha:1];
            
            index++;
        }
        
        _dataRecevied = ICell.lastname;
        _dataSent = IICell.lastname;
        _dataAmount = IIICell.lastname;
        
        _dataRecevied.text = @"0 MB";
        _dataSent.text = @"0 MB";
        _dataAmount.text = @"0 MB";
        
        ICell.firstname.text = @"Data useage";
        IICell.firstname.text = @"Data sent";
        IIICell.firstname.text = @"Data amount";
        
        MOREDataButtonCell *actionButton = [MOREDataButtonCell new];
        actionButton.action.titleLabel.font = [UIFont fontWithName:@"Roboto-bold" size:15];
        [actionButton.action setTitle:@"CLEAR CACHE" forState:UIControlStateNormal];
        [actionButton.action setTitleColor:[UIColor googleRed] forState:UIControlStateNormal];
        actionButton.backgroundColor = [UIColor whiteColor];
        
        _actionButton = actionButton.action;
        
        [room addObject:dateContentView];
        [room addObject:ICell];
        [room addObject:IICell];
        [room addObject:IIICell];
        [room addObject:actionButton];
        
        [roomSize addObject:@36];
        [roomSize addObject:cellHeight];
        [roomSize addObject:cellHeight];
        [roomSize addObject:cellHeight];
        [roomSize addObject:cellHeight];
        
        if( [UISetting isDEBUG] ){
            NSArray *debug = [self debug];
            [room addObjectsFromArray:(NSArray *)debug[0]];
            [roomSize addObjectsFromArray:(NSArray *)debug[1]];
        }
        
        [room addObject:unknow];
        [roomSize addObject:@200];
        
        [_bear autolayoutSubviews:(NSArray *)room
                       edgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)
                       multiplier:1.0
                         constant:0
                        constants:(NSArray *)roomSize
                 stackOrientation:autolayoutStackOrientationVertical
                        direction:autolayoutStackDirectionTop
                           option:autolayoutStackOptionTrailing];
        
        [self initTopView];
        [self initFloatingButton];
    }
    return self;
}

- (void)initFloatingButton{
    _floatingButton = [UIButton new];
    _floatingButton.translatesAutoresizingMaskIntoConstraints = NO;
    [_bear addSubview:_floatingButton];
    
    _floatingButton.titleLabel.font = [UIFont MaterialDesignIcons];
    [_floatingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_floatingButton setTitle:[UIFont mdiPlus] forState:UIControlStateNormal];
    _floatingButton.backgroundColor = [UIColor googleGreen];
    _floatingButton.layer.cornerRadius = 56 / 2.0;
    
    _floatingButton.layer.shadowColor = [UIColor blackColor].CGColor;
    _floatingButton.layer.shadowRadius = 7.0;
    _floatingButton.layer.shadowOpacity = 0.3;
    _floatingButton.layer.shadowOffset = CGSizeMake(0, 6.0f);
    
    [_floatingButton addConstraints:[NSLayoutConstraint SpactecledBearFixed:_floatingButton
                                                                       type:SpactecledBearFixedEqual
                                                                   constant:56]];
    [_bear addConstraint:[NSLayoutConstraint constraintWithItem:_floatingButton
                                                      attribute:NSLayoutAttributeTop
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:_bear
                                                      attribute:NSLayoutAttributeTop
                                                     multiplier:1.0
                                                       constant:-( 56 / 2.0 )]];
    [_bear addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_floatingButton
                                                              to:_bear
                                                            type:EdgeRightZero
                                                        constant:16]];
}

- (void)initTopView{
    
    CGFloat progressViewHeight = 20;
    CGFloat EdgeToBottom = (((UISCREENT_HEIGHT - EDGE_INSET_TOP) * (1 - PROPORTION)) * (1 - PROPORTION)) - progressViewHeight;
    
    _progress = [MOREProgressView new];
    _progress.translatesAutoresizingMaskIntoConstraints = NO;
    [_top addSubview:_progress];
    
    _progress.layer.cornerRadius = 3.0f;
    
    _progress.backgroundColor = [UIColor subTextColor];
    _progress.trackColor = [UIColor textColor];
    
    _progressMin = [UILabel new];
    _progressMax = [UILabel new];
    _progressMin.translatesAutoresizingMaskIntoConstraints =
    _progressMax.translatesAutoresizingMaskIntoConstraints = NO;
    _progressMax.textAlignment = NSTextAlignmentRight;
    
    [_top addSubview:_progressMin];
    [_top addSubview:_progressMax];
    
    _progressMin.backgroundColor = [UIColor whiteColor];
    _progressMax.backgroundColor = [UIColor whiteColor];
    
    _progressMin.font = _progressMax.font = [UIFont fontWithName:@"Roboto-bold" size:15];
    _progressMin.textColor = _progressMax.textColor = [UIColor colorWithWhite:126 / 255.0 alpha:1];
    
    _progressMin.text = @"0 MB";
    _progressMax.text = @"100 MB";
    
    [_top addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_progress to:_top type:EdgeLeftRightZero constant:72]];
    [_top addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_progress
                                                             to:_top
                                                           type:EdgeBottomZero
                                                       constant:EdgeToBottom]];
    [_progress addConstraints:[NSLayoutConstraint SpactecledBearFixed:_progress type:SpactecledBearFixedHeight constant:progressViewHeight]];
    
    [_top addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_progressMin to:_top type:EdgeLeftZero constant:72]];
    [_top addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_progressMax to:_top type:EdgeRightZero constant:72]];
    [_top addConstraints:[NSLayoutConstraint SpactecledBearFixed:_progressMin type:SpactecledBearFixedHeight constant:progressViewHeight]];
    [_top addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_progressMin to:_progressMax type:EdgeEqualHeightWidth]];
    [_top addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_progressMin to:_top type:EdgeBottomZero constant:24]];
    [_top addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_progressMax to:_top type:EdgeBottomZero constant:24]];
    [_top addConstraint:[NSLayoutConstraint constraintWithItem:_progressMin
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_progressMax
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0
                                                      constant:0]];
}

- (NSArray *)debug{
    
    NSMutableArray *objs = [NSMutableArray new];
    NSMutableArray *sizes = [NSMutableArray new];
    
    MOREDateUICell *debugO = [MOREDateUICell new];
    
    MOREDateUICell *debugI = [MOREDateUICell new];
    MOREDateUICell *debugII = [MOREDateUICell new];
    MOREDateUICell *debugIII = [MOREDateUICell new];
    MOREDateUICell *debugIV = [MOREDateUICell new];
    
    MOREDateUICell *debugV = [MOREDateUICell new];
    MOREDateUICell *debugVI = [MOREDateUICell new];
    MOREDateUICell *debugVII = [MOREDateUICell new];
    MOREDateUICell *debugVIII = [MOREDateUICell new];
    
    _debugUploadSpeed = debugO.lastname;
    
    _debugDataRecevied = debugI.lastname;
    _debugDataReceviedStorage = debugII.lastname;
    _debugDataSent = debugIII.lastname;
    _debugDataSentStorage = debugIV.lastname;
    
    _debugProgressCache = debugV.lastname;
    _debugProgressCurrent = debugVI.lastname;
    _debugProgressPercentage = debugVII.lastname;
    _debugProgressTarget = debugVIII.lastname;
    
    NSArray *debug = @[
                       @"upload speed",
                       @"useage",
                       @"useage storage",
                       @"sent",
                       @"sent storage",
                       @"progress cache",
                       @"progress current",
                       @"progress percentage",
                       @"progress target"
                       ];
    NSUInteger fox = 0;
    for( MOREDateUICell *cell in @[ debugO, debugI, debugII, debugIII, debugIV, debugV, debugVI, debugVII, debugVIII ] ){
        cell.backgroundColor = [UIColor whiteColor];
        cell.icon.font = [UIFont MaterialDesignIconsWithSize:17];
        cell.icon.text = [UIFont mdiBug];
        cell.icon.textColor = [UIColor colorWithRed:48 / 255.0 green:176 / 255.0 blue:81 / 255.0 alpha:1];
        
        cell.firstname.font = [UIFont fontWithName:@"Roboto" size:19];
        cell.firstname.textColor = [UIColor colorWithWhite:13 / 255.0 alpha:1];
        cell.firstname.text = debug[fox];
        
        cell.lastname.font = [UIFont fontWithName:@"Roboto-bold" size:15];
        cell.lastname.textColor = [UIColor colorWithWhite:126 / 255.0 alpha:1];
        
        [objs addObject:cell];
        [sizes addObject:@56];
        
        fox++;
    }

    return @[ objs, sizes ];
}

@end
