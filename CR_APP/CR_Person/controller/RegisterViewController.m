//
//  RegisterViewController.m
//  CR_APP
//
//  Created by Itachi on 15/7/13.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "ProtocolViewController.h"
@interface RegisterViewController ()
{
   
}

@property (strong, nonatomic) IBOutlet UIScrollView *mainView;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *password2;
@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *introducerNumber;
@property (strong, nonatomic) IBOutlet UITextField *tel;
@property (strong, nonatomic) IBOutlet UITextField *verificationCode;
@property (strong, nonatomic) IBOutlet UIButton *registerButton;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) IBOutlet UIButton *codeButton;


@end

@implementation RegisterViewController
@synthesize timer;


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.registerButton.enabled = NO;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.title = @"用户注册";
    self.mainView.contentSize = CGSizeMake(ATGetDeviceWidth, ATGetDeviceHeight * 1.3);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.mainView addGestureRecognizer:tap];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tap{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.25f animations:^{
        self.mainView.contentOffset = CGPointMake(0, 0);
    }];
}


#pragma mark - User Method

- (IBAction)register:(id)sender {
    //这里填写用户注册代码
    //空判断
    if ([self.username.text isEqualToString:@""] || [self.password.text isEqualToString:@""]) {
        
        ATSHOW_ALERT(@"用户名和密码不能为空");
        return;
    }
    //密码相同判断
    if (![self.password.text isEqualToString:self.password2.text]) {
        [self.password2 becomeFirstResponder];
        ATSHOW_ALERT(@"密码前后输入不一致");
        return;
    }
    if (self.password2.text.length < 6 || self.password2.text.length >32) {
        [self.password becomeFirstResponder];
        ATSHOW_ALERT(@"密码长度介于6位至32位");
        return;
    }
    if ([self.tel.text isEqualToString:@""]) {
        [self.tel becomeFirstResponder];
        ATSHOW_ALERT(@"手机号码不能为空");
        return;
    }
    if ([self.verificationCode.text isEqualToString:@""]) {
        [self.verificationCode becomeFirstResponder];
        ATSHOW_ALERT(@"请输入验证码");
        return;
    }
    [self tap];
   
    NSNumber *catalog = [NSNumber numberWithInt:1];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:20];
    [params setValue:catalog forKey:@"catalog"];
    [params setValue:self.username.text forKey:@"username"];
    [params setValue:self.password.text forKey:@"password"];
    [params setValue:self.tel.text forKey:@"custMobile"];
    [params setValue:self.verificationCode.text forKey:@"mobileCode"];
    

    if (![self.email.text isEqualToString:@""]) {
        [params setValue:self.email.text forKey:@"email"];
    }
    if (![self.introducerNumber.text isEqualToString:@""]) {
        [params setValue:self.introducerNumber.text forKey:@"inviteMobile"];
    }
    
    [MBProgressHUD showMessage:@"正在进行注册"];
    MKNetworkEngine *engine = enginer;
    MKNetworkOperation *operation = [engine operationWithPath:register_url params:params httpMethod:@"POST"];
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        HideProcessView
        
        NSDictionary *json = completedOperation.responseJSON;
        ATSHOW_ALERT([json valueForKey:@"resultMessage"]);
        if([[json valueForKey:@"resultCode"] isEqualToString:@"200"]){
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        HideProcessView
        ERROR_InterNet
    }];

    
    [engine enqueueOperation:operation];

}

- (IBAction)login:(id)sender {
    [self tap];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)confirmProtocol:(UISwitch *)sender {
    [self tap];
    self.registerButton.enabled = sender.isOn ? YES : NO;
}

- (IBAction)getVerificationCode:(UIButton *)sender {
    
    if ([self.tel.text isEqualToString:@""]) {
        [self.tel becomeFirstResponder];
        ATSHOW_ALERT(@"请输入手机号码");
        return;
    }
    [self tap];
    NSNumber *catalog = [NSNumber numberWithInt:0];
    NSDictionary *params = @{@"catalog":catalog,@"custMobile":self.tel.text};
    
    MKNetworkEngine *engine = enginer;
    MKNetworkOperation *operation = [engine operationWithPath:register_url params:params httpMethod:@"POST"];
    [MBProgressHUD showMessage:@"正在获取验证码"];
    
    [operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        HideProcessView
        SHOW_ALERT(@"验证码已发送到您的手机");
        dispatch_async(dispatch_get_main_queue(), ^{
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown) userInfo:nil repeats:YES];
        
        });
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        HideProcessView
        ERROR_InterNet
    }];
    [engine enqueueOperation:operation];
}

- (void)countDown{
    static int count = 60;
    
    if (count != 0) {
        self.codeButton.userInteractionEnabled = NO;
        [self.codeButton setTitle:[NSString stringWithFormat:@"%ds",count] forState:UIControlStateNormal];
        count--;
    }else{
        [timer invalidate];
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.codeButton.userInteractionEnabled = YES;
        count = count+60;
    }
}




- (IBAction)loadProtocol:(UIButton *)sender {
    ProtocolViewController *PVC = [[ProtocolViewController alloc] init];
    [self.navigationController pushViewController:PVC animated:YES];
}



#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self tap];
    return YES;
}


- (IBAction)changeMainView:(UITextField *)sender {
    [UIView animateWithDuration:0.25f animations:^{
        self.mainView.contentOffset = CGPointMake(0, 120);
    }];
}






@end
