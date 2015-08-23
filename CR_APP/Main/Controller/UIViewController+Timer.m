//
//  UIViewController+Timer.m
//  ATjiujiu
//
//  Created by Itachi on 15/7/22.
//  Copyright (c) 2015年 ATBJB10. All rights reserved.
//

#import "UIViewController+Timer.h"
#import "AppDelegate.h"
@implementation UIViewController (Timer)

@dynamic tapDog;

- (void)setTapDog:(UITapGestureRecognizer *)tapDog{

        [self.view addGestureRecognizer:self.tapDog];

    
}

- (UITapGestureRecognizer *)tapDog{
    return [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(creatTimer)];
}

- (void)creatTimer{
//    NSTimer *timer = [NSTimer timerWithTimeInterval:10.0f target:self selector:@selector(autoLogout) userInfo:nil repeats:NO];
    
}


- (void)autoLogout{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
