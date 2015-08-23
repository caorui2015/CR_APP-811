//
//  ItemsController.m
//  CR_APP
//
//  Created by Itachi on 15/8/5.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import "ItemsController.h"
#import "InvestmentController.h"
#import "BondController.h"
#define viewHeight ATGetDeviceHeight-113

@interface ItemsController ()
{
    
}
@property (nonatomic, strong) InvestmentController *investmentController;
@property (nonatomic, strong) BondController *bondController;

@end

@implementation ItemsController
@synthesize investmentController,bondController;



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//当控制器出现时就会初始化一次
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.tintColor = ThemeRed;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    self.navigationController.navigationBar.translucent = NO;

    

}

- (void)viewDidLoad {
    [super viewDidLoad];

//初始化主视图
    [self initScrollow];
    
#warning 待处理
    [self.leftButton setTintColor:ThemeRed];
    [self.rightButton setTintColor:[UIColor grayColor]];
 
}
#pragma mark - Methods

- (void)initScrollow{
    self.mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ATGetDeviceWidth, viewHeight)];
    [self.view addSubview:self.mainView];
    self.mainView.delegate = self;
    self.mainView.showsHorizontalScrollIndicator = NO;
    self.mainView.showsVerticalScrollIndicator = NO;
    self.mainView.pagingEnabled = YES;
    self.mainView.contentSize = CGSizeMake(ATGetDeviceWidth*2, viewHeight);
    
    
    investmentController = [[InvestmentController alloc] init];
    investmentController.view.frame = CGRectMake(0, 0, ATGetDeviceWidth, viewHeight);
    [self.mainView addSubview:investmentController.view];
    
    bondController = [[BondController alloc] init];
    bondController.view.frame = CGRectMake(ATGetDeviceWidth, 0, ATGetDeviceWidth, viewHeight);
    [self.mainView addSubview:bondController.view];
}


//当左按钮事件发生时，主视图的左半边内容出现
- (IBAction)showInvestment:(UIBarButtonItem *)sender {
    self.mainView.contentOffset = CGPointMake(0, 0);
    [self showLeftView];
}

//当右按钮事件发生时，主视图的右半边内容出现
- (IBAction)showBond:(UIBarButtonItem *)sender {
    self.mainView.contentOffset = CGPointMake(ATGetDeviceWidth, 0);
    [self showRightView];
}

- (void)showLeftView{
    [self.leftButton setTintColor:ThemeRed];
    [self.rightButton setTintColor:[UIColor grayColor]];
    [investmentController friendsheaderRereshing];
    
}

- (void)showRightView{
    [self.rightButton setTintColor:ThemeRed];
    [self.leftButton setTintColor:[UIColor grayColor]];
    [bondController friendsheaderRereshing];
}

#pragma mark - UIScrollView Delelgate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.x == 0) {
        [self showLeftView];
    }
    
    if (scrollView.contentOffset.x == ATGetDeviceWidth) {
        [self showRightView];
    }
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
