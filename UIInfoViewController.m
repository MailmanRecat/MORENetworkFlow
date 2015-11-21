//
//  UIInfoViewController.m
//  MORENetworkFlow
//
//  Created by caine on 10/5/15.
//  Copyright © 2015 com.caine. All rights reserved.
//

#import "UIInfoViewController.h"
#import "WindPark.h"
#import "UIFont+MaterialDesignIcons.h"
#import "BlackChocolate.h"

@interface UIInfoViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property( nonatomic, strong ) WindPark *park;

@end

@implementation UIInfoViewController

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if( scrollView.contentOffset.y <= - STATUS_BAR_HEIGHT - 56 )
        [self.park sunrise];
    else
        [self.park sunset];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadBar];
    
    [self loadChocolateBox];
    
}

- (void)loadBar{
    
    WindPark *park = [WindPark new];
    [park setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:park];
    _park = park;
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:park to:self.view type:EdgeTopLeftRightZero]];
    
//    park.backgroundColor = [UIColor colorWithRed:56 / 255.0 green:66 / 255.0 blue:75 / 255.0 alpha:1];
    park.backgroundColor = [UIColor whiteColor];
    
    [park disappearCliff];
    
    park.herb.titleLabel.font = [UIFont MaterialDesignIcons];
    [park.herb setTitle:[UIFont mdiArrowLeft] forState:UIControlStateNormal];
    [park.herb setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [park.herb addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
    
    [park nameplate:@"Info"];
//    park.nameplate.textColor = [UIColor whiteColor];
    park.nameplate.textColor = [UIColor blackColor];
    
}

- (void)loadChocolateBox{
    
    UITableView *chocolateBox = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
    [chocolateBox setTranslatesAutoresizingMaskIntoConstraints:NO];
    chocolateBox.dataSource = self;
    chocolateBox.delegate   = self;
    chocolateBox.backgroundColor = [UIColor whiteColor];
    chocolateBox.separatorStyle = UITableViewCellSeparatorStyleNone;
    chocolateBox.contentInset = UIEdgeInsetsMake(SELF_HEIGHT + STATUS_BAR_HEIGHT, 0, 0, 0);
    [self.view insertSubview:chocolateBox belowSubview:_park];
    
    [self.view addConstraints:[NSLayoutConstraint SpactecledBearEdeg:chocolateBox to:self.view type:EdgeAroundZero]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
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
    
    NSString *title = @"More";
    if( section == 0 )
        title = @"Version";
    
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
    
    NSString *text;
    if( indexPath.section == 0 )
        text = @"1.0.0";
    else
        text = @"moredogs";
    
    cell.indexPath = indexPath;
    cell.husky.backgroundColor = tableView.backgroundColor;
    [cell.husky setTitle:text forState:UIControlStateNormal];
    
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//- (UIStatusBarStyle)preferredStatusBarStyle{
//    return UIStatusBarStyleLightContent;
//}

- (void)dismissSelf{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
