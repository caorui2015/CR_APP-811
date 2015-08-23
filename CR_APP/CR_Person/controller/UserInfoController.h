//
//  UserInfoController.h
//  CR_APP
//
//  Created by Itachi on 15/8/1.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *realName;
@property (strong, nonatomic) IBOutlet UITextField *userCardNum;
@property (strong, nonatomic) IBOutlet UILabel *userPhonenNum;
@property (strong, nonatomic) IBOutlet UITextField *userEmail;

@property (strong, nonatomic) IBOutlet UILabel *allMoney;
@property (strong, nonatomic) IBOutlet UILabel *avalibleMoney;
@property (strong, nonatomic) IBOutlet UILabel *frozenMoney;


@property (strong, nonatomic) IBOutlet UIButton *confirmButton;

@end
