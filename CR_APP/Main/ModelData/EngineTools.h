//
//  EngineTools.h
//  通泰贷
//
//  Created by ATBJB10 on 14/12/16.
//  Copyright (c) 2014年 xibenye. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "MJRefresh.h"
#import "UIView+Extension.h"
#import "UIImage+Fit.h"
#import "UIBarButtonItem+Extension.h"

#import "UIViewController+ENPopUp.h"
#import "LoginViewController.h"
#import "MBProgressHUD+MJ.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressLabel.h"

#define SHOW_ALERT(_message_) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:_message_ delegate:self cancelButtonTitle:@"我知道啦！" otherButtonTitles: nil]; \
[alert show]; \


//注册
#define NAME @"name"
#define PSW @"password"
#define iPhone @"iPhone"

//登录
#define Login_name @"Login_name"
#define Login_pwd @"Login_pwd"
#define Login_Phone @"Login_Phone"

@interface EngineTools : UIViewController

//十六进制转化为颜色
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

+ (void)time: (UIButton *)btn;

+(BOOL) isBlankString:(NSString *)string;

@end
