//
//  BlackChocolate.h
//  12306
//
//  Created by caine on 7/13/15.
//  Copyright (c) 2015 com.caine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HuskyButton.h"
#import "UIFont+MaterialDesignIcons.h"

typedef NS_ENUM(NSInteger, BlackChocolateType){
    
    BlackChocolateTypeOption = 1,
    BlackChocolateTypeArrow,
    BlackChocolateTypeAlert,
    BlackChocolateTypeNone
    
};

@protocol BlackChocolateDelegate <NSObject>

- (void)didHuskyClick:(NSInteger)huskyType position:(NSIndexPath *)indexPath;

@end

@interface BlackChocolate : UITableViewCell

@property( nonatomic, strong ) HuskyButton *husky;
@property( nonatomic, strong ) UILabel     *check;
@property( nonatomic, assign ) BOOL         isCheck;
@property( nonatomic, strong ) NSIndexPath *indexPath;

@property( nonatomic, assign ) NSInteger    huskyType;

@property( nonatomic, weak )   id<BlackChocolateDelegate> huskyDelegate;

- (void)setChecked;
- (void)setUncheck;

- (void)setArrow;

@end
