//
//  CRNavigationController.m
//  CR_APP
//
//  Created by Itachi on 15/7/10.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import "CRNavigationController.h"

@interface CRNavigationController ()

@end

@implementation CRNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置全局导航栏的文字背景
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                         forKey:NSForegroundColorAttributeName];
    
    //添加全局向右滑动手势处理
    [self addSwipeRecognizer];
}

/**
 *  重写系统的push方法用于控制系统全局push操作
 *  @param viewController 即将push进来的控制器
 *  @param animated       动画效果默认yes
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //设置导航条背景(如果不每次push都重新设置导航栏背景在登录界面背景透明处就会更换图片,之前设置就会失效)
    [self.navigationBar setBackgroundImage:[UIImage resizeImage:@"789"] forBarMetrics:UIBarMetricsDefault];
    
    //如果是非栈底控制器就隐藏底部Dock操作条
    if (self.childViewControllers.count>0){
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置导航栏按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply target:self action:@selector(back)];
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"home" highImageName:@"home" target:self action:@selector(goHome)];
    }
    [super pushViewController:viewController animated:animated];
}

/**
 *  添加右滑手势
 */
- (void)addSwipeRecognizer
{
    // 初始化手势并添加执行方法
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(return)];
    // 手势方向
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    // 响应的手指数
    swipeRecognizer.numberOfTouchesRequired = 1;
    // 添加手势
    [[self view] addGestureRecognizer:swipeRecognizer];
}

#pragma mark 返回上一级
- (void)return
{
    // 最低控制器无需返回
    if (self.viewControllers.count <= 1) return;
    
    // pop返回上一级
    [self popViewControllerAnimated:YES];
    
}

- (void)back
{
    //这里用的是self, 因为self就是当前正在使用的导航控制器
    [self popViewControllerAnimated:YES];
}

- (void)goHome
{
    [self popToRootViewControllerAnimated:YES];
}


@end
