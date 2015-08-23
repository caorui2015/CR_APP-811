//
//  PersonController.h
//  CR_APP
//
//  Created by Itachi on 15/7/10.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PersonController : UIViewController <UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *logInButton;


@property (strong, nonatomic) IBOutlet UIButton *userButton;
@property (strong, nonatomic) IBOutlet UILabel *nickname;
@property (strong, nonatomic) IBOutlet UILabel *lastTime;







@end
