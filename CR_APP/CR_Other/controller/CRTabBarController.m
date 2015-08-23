//
//  CRTabBarController.m
//  CR_APP
//
//  Created by Itachi on 15/7/10.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import "CRTabBarController.h"

@interface CRTabBarController ()

@end

@implementation CRTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置Dock的背景
    
    self.tabBar.translucent = NO;
    self.tabBar.backgroundImage = [UIImage imageNamed:@"dock"];
    self.tabBar.tintColor = ThemeRed;
    
}

/**
 *  添加一个控制器进入TabBarController
 *  @param controller        要添加的子控制器
 *  @param title             导航栏标题
 *  @param imageName         普通图片名称
 *  @param selectedImageName 高亮图片名称
 */
//- (void) setOneChildController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName
//             selectedImageName:(NSString *)selectedImageName
//{
//    controller.title = title;
//    
//    [controller.tabBarItem setTitleTextAttributes:
//     @{
//       NSForegroundColorAttributeName:[UIColor colorWithRed:20/255.0 green:112/255.0 blue:167/255.0 alpha:1.0],
//       NSFontAttributeName:[UIFont systemFontOfSize:12]
//       }
//                                         forState:UIControlStateSelected];
//    //普通状态
//    [controller.tabBarItem setTitleTextAttributes:
//     @{
//       NSForegroundColorAttributeName:[UIColor whiteColor],
//       NSFontAttributeName:[UIFont systemFontOfSize:12]
//       }
//                                         forState:UIControlStateNormal];
//    controller.tabBarItem.image = [UIImage imageNamed:imageName];
//    UIImage *selectedImage =  [UIImage imageNamed:selectedImageName];
//    
//    //设置图片不渲染使用原始传入图片（在ios7中默认会渲染图片显示选中时蓝色背景）
//    if (iOS7){
//        selectedImage =  [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    }
//    controller.tabBarItem.selectedImage = selectedImage;
//    
//    //
//}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
}
*/

@end
