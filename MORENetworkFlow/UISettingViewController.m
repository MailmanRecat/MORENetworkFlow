//
//  UISettingViewController.m
//  MORENetworkFlow
//
//  Created by caine on 10/3/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#define BAR_HEIGHT 56

#import "UIFont+MaterialDesignIcons.h"
#import "UISettingViewController.h"
#import "BlackChocolate.h"

#import "UIInfoViewController.h"

#import "MORETransitionAnimationDelegate.h"

@interface UISettingViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, BlackChocolateDelegate>

@property( nonatomic, strong ) WindPark *park;
@property( nonatomic, strong ) UITableView *chocolateBox;
@property( nonatomic, strong ) NSDictionary *settings;
@property( nonatomic, strong ) NSArray      *settingNames;
@property( nonatomic, strong ) MORETransitionAnimationDelegate *transitionAnimationDelegate;

@end

@implementation UISettingViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if( scrollView.contentOffset.y <= - STATUS_BAR_HEIGHT - BAR_HEIGHT )
        [self.park sunrise];
    else
        [self.park sunset];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:40 / 255.0 green:51 / 255.0 blue:57 / 255.0 alpha:1];
    
    _transitionAnimationDelegate = [MORETransitionAnimationDelegate new];
    
    [self loadBar];
    
    [self loadChocolateBox];
}

- (void)loadBar{
    
    WindPark *park = [WindPark new];
    [park setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:park];
    _park = park;
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:park to:self.view type:EdgeTopLeftRightZero]];
    
    park.backgroundColor = [UIColor whiteColor];
    
    [park disappearCliff];
    
    park.herb.titleLabel.font = [UIFont MaterialDesignIcons];
    [park.herb setTitle:[UIFont mdiArrowLeft] forState:UIControlStateNormal];
    [park.herb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [park.herb addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
    
    [park nameplate:@"Settings"];
    park.nameplate.textColor = [UIColor blackColor];

}

- (void)loadChocolateBox{
    
    UITableView *chocolateBox = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    [chocolateBox setTranslatesAutoresizingMaskIntoConstraints:NO];
    chocolateBox.dataSource = self;
    chocolateBox.delegate   = self;
    chocolateBox.backgroundColor = [UIColor whiteColor];
    chocolateBox.separatorStyle = UITableViewCellSeparatorStyleNone;
    chocolateBox.contentInset = UIEdgeInsetsMake(BAR_HEIGHT + STATUS_BAR_HEIGHT, 0, 0, 0);
    chocolateBox.contentOffset = CGPointMake(0, - BAR_HEIGHT - STATUS_BAR_HEIGHT);
    chocolateBox.showsVerticalScrollIndicator = NO;
    [self.view insertSubview:chocolateBox belowSubview:_park];
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:chocolateBox to:self.view type:EdgeAroundZero]];
    
    _chocolateBox = chocolateBox;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSString *title = @"About";
    
    HuskyButton *hu = [HuskyButton new];
    hu.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    hu.contentEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 0);
    hu.titleLabel.font = [UIFont fontWithName:@"Roboto-bold" size:16];
    [hu setTitle:title forState:UIControlStateNormal];
    [hu setTitleColor:[UIColor colorWithRed:119 / 255.0 green:119 / 255.0 blue:119 / 255.0 alpha:1] forState:UIControlStateNormal];
    hu.backgroundColor = tableView.backgroundColor;
    
    CALayer *border = [CALayer layer];
    border.backgroundColor  = [UIColor clearColor].CGColor;
    CGRect   frame  = CGRectMake(0, 0, tableView.frame.size.width, 1);
    border.frame    = frame;
    
    [hu.layer addSublayer:border];
    
    CALayer *borderBottom = [CALayer layer];
    borderBottom.backgroundColor = [UIColor clearColor].CGColor;
    borderBottom.frame    = CGRectMake(0, 39, tableView.frame.size.width, 1);
    [hu.layer addSublayer:borderBottom];
    
    if( section != 0 ){
        
        border.backgroundColor = [UIColor colorWithRed:214 / 255.0 green:214 / 255.0 blue:214 / 255.0 alpha:1].CGColor;
        
    }
    
    hu.enabled = NO;
    
    return hu;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CELL_ID = @"CELL_ID";
    
    BlackChocolate *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    if( !cell ){
         cell = [[BlackChocolate alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID];
    }
    
    cell.huskyType = BlackChocolateTypeArrow;
    cell.indexPath = indexPath;
    cell.husky.backgroundColor = tableView.backgroundColor;
    [cell.husky setTitle:@"Info" forState:UIControlStateNormal];
    
    cell.huskyDelegate = self;
    
    return cell;
    
}

- (void)didHuskyClick:(NSInteger)huskyType position:(NSIndexPath *)indexPath{
    
    UIInfoViewController *info = [UIInfoViewController new];
    info.transitioningDelegate = _transitionAnimationDelegate;
    
    [self presentViewController:info animated:YES completion:nil];
}

- (void)dismissSelf{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
