//
//  LoginViewController.h
//  ATjiujiu
//
//  Created by ATBJB10 on 15/4/20.
//  Copyright (c) 2015年 ATBJB10. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *RegistButton;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
- (IBAction)RegistBtn:(UIButton *)sender;

- (IBAction)LoginBtn:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *userfiled;
@property (weak, nonatomic) IBOutlet UITextField *pwdfiled;
- (IBAction)FindBtn:(UIButton *)sender;

@end
