//
//  LoginViewController.m
//  ATjiujiu
//
//  Created by ATBJB10 on 15/4/20.
//  Copyright (c) 2015年 ATBJB10. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"


//#import "RegisterViewController.h"

@interface LoginViewController ()





@end

@implementation LoginViewController
@synthesize RegistButton;
@synthesize LoginButton;
@synthesize userfiled;
@synthesize pwdfiled;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户登录";
    
    UIButton *returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(20,25,30,30)];
    [returnBtn setImage:[UIImage imageNamed:@"jiantou"] forState:UIControlStateNormal];
    [returnBtn setImage:[UIImage imageNamed:@"jiantou_sel"] forState:UIControlStateHighlighted];
    [returnBtn addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:returnBtn];

  
}



- (IBAction)RegistBtn:(UIButton *)sender
{
    RegisterViewController *registVC = [[RegisterViewController alloc] init];
    
    [self.navigationController pushViewController:registVC animated:YES];
}

- (IBAction)FindBtn:(UIButton *)sender
{

}
//登录操作
- (IBAction)LoginBtn:(UIButton *)sender
{
    if (!userfiled.text || [userfiled.text isEqualToString:@""]) {
        ATSHOW_ALERT(@"用户名不能为空");
        return;
    }
    if (!pwdfiled.text || [pwdfiled.text isEqualToString:@""]) {
        ATSHOW_ALERT(@"密码不能为空");
        return;
    }
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setValue:userfiled.text forKey:@"username"];
    [param setValue:pwdfiled.text forKey:@"password"];
  
    MKNetworkEngine *engine = enginer;
   
    MKNetworkOperation *op = [engine operationWithPath:login_url params:param httpMethod:@"POST"];
    [MBProgressHUD showMessage:@"正在登录"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        HideProcessView
        NSLog(@"%@",JSON);
        if ([[JSON valueForKey:@"resultCode"] isEqualToString:@"200"]) {
            NSDictionary *user = [completedOperation.responseJSON objectForKey:@"result"];
            NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:user];
            
            [APPDefualts setObject:userData forKey:USER];
            Login;
            [APPDefualts synchronize];
        
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            ATSHOW_ALERT(@"登录信息错误，请重新填写");
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        HideProcessView
        ERROR_InterNet
    }];
    
    [engine enqueueOperation:op];
    
    
    
    
    
}


#pragma mark - UITextField Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // When the user presses return, take focus away from the text field so that the keyboard is dismissed.
    NSTimeInterval animationDuration = 0.25f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    
    [textField resignFirstResponder];
    
    [self LoginBtn:nil];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 32 - (self.view.frame.size.height - 260.0);//键盘高度260
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    float width = self.view.frame.size.width;
    float height = self.view.frame.size.height;
    if(offset > 0)
    {
        CGRect rect = CGRectMake(0.0f, -offset,width,height);
        self.view.frame = rect;
    }
    [UIView commitAnimations];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSTimeInterval animationDuration = 0.25f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    CGRect rect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    self.view.frame = rect;
    [UIView commitAnimations];
    [self.view endEditing:YES];
}



- (void)returnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
