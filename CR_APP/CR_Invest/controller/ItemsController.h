//
//  ItemsController.h
//  CR_APP
//
//  Created by Itachi on 15/8/5.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *mainView; //作为控制器的主视图
@property (strong, nonatomic) IBOutlet UIBarButtonItem *leftButton; //导航栏左按钮
@property (strong, nonatomic) IBOutlet UIBarButtonItem *rightButton; //导航栏右按钮


- (IBAction)showInvestment:(UIBarButtonItem *)sender; //左按钮事件

- (IBAction)showBond:(UIBarButtonItem *)sender; //右按钮事件

@end
