//
//  BlackChocolate.m
//  12306
//
//  Created by caine on 7/13/15.
//  Copyright (c) 2015 com.caine. All rights reserved.
//

#import "BlackChocolate.h"
#import "NSLayoutConstraint+SpectacledBearEdgeConstraint.h"
#import "UISetting.h"
#import "UIInfoViewController.h"

@implementation BlackChocolate

- (void)setArrow{
    
    _check.text = [UIFont mdiChevronRight];
    _check.textColor = [UIColor colorWithWhite:204 / 255.0 alpha:1];
    
    _check.alpha = 1;
    
}

- (void)setChecked{
    
    _isCheck = YES;
    [UIView animateWithDuration:0.17 animations:^{
        
        _check.alpha = 1;
    }completion:nil];
}

- (void)setUncheck{
    
    _isCheck = NO;
    [UIView animateWithDuration:0.17 animations:^{
        
        _check.alpha = 0;
    }completion:nil];
}

- (void)checkClick:(UIButton *)sender{
    
    if( self.huskyDelegate && [self.huskyDelegate respondsToSelector:@selector(didHuskyClick:position:)] ){
        [self.huskyDelegate didHuskyClick:self.huskyType position:self.indexPath];
    }
    
}

- (UITableView *)getTableView{
    
    id view = [self superview];
    
    while ( view && [view isKindOfClass:[UITableView class]] == NO ) {
        view = [view superview];
    }
    
    return view;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if( self ){
        self.clipsToBounds = YES;
        
        _husky = [HuskyButton new];
        [_husky setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_husky setTitleColor:[UIColor colorWithRed:37 / 255.0 green:37 / 255.0 blue:37 / 255.0 alpha:1] forState:UIControlStateNormal];
        _husky.FurColor = [UIColor colorWithRed:56 / 255.0 green:66 / 255.0 blue:75 / 255.0 alpha:1];
//        _husky.FurAlpha = 0.17;
        _husky.backgroundColor = [UIColor colorWithWhite:247 / 255.0 alpha:1];
        _husky.titleLabel.font = [UIFont fontWithName:@"Roboto-bold" size:16];
        _husky.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _husky.contentEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
        
        _check = [UILabel new];
        [_check setTranslatesAutoresizingMaskIntoConstraints:NO];
        _check.textAlignment = NSTextAlignmentCenter;
        _check.font = [UIFont MaterialDesignIcons];
        _check.text = [UIFont mdiCheck];
//        _check.textColor = [UIColor colorWithRed:127 / 255.0 green:200 / 255.0 blue:187 / 255.0 alpha:1];
        _check.textColor = [UIColor blackColor];
        _check.alpha = 0;
        
        [_husky addTarget:self action:@selector(checkClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_husky];
        [_husky addSubview:_check];
        
        [self.contentView addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_check to:_husky type:EdgeTopRightZero]];
        [_check addConstraints:[NSLayoutConstraint SpactecledBearFixed:_check type:SpactecledBearFixedEqual constant:60]];
        
        [self.contentView addConstraints:[NSLayoutConstraint SpactecledBearEdeg:_husky to:self.contentView type:EdgeAroundZero]];
    }
    
    return self;
}

- (UIEdgeInsets)layoutMargins{
    
    return UIEdgeInsetsZero;
}

@end
