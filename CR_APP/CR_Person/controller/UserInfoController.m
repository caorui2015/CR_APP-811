//
//  UserInfoController.m
//  CR_APP
//
//  Created by Itachi on 15/8/1.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import "UserInfoController.h"

@interface UserInfoController ()

@end

@implementation UserInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillInUserInfo];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

#pragma mark - Methods

- (void)fillInUserInfo{
    NSDictionary *user = [Operation getUser];
    
    self.realName.text = [user valueForKey:@"userRealName"];
    self.userCardNum.text = [user valueForKey:@"userDocNo"];
    self.userPhonenNum.text = [user valueForKey:@"userPhone"];
    self.userEmail.text =  [user valueForKey:@"userEmail"];
    
    if ([[user valueForKey:@"isOpenAccount"] isEqualToString:@"1"]) {
        self.confirmButton.enabled = NO;
    }else{
        self.confirmButton.enabled = YES;
    }
}


#pragma  mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
   
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
    
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
