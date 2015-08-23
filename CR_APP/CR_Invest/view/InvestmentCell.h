//
//  investmentCell.h
//  CR_APP
//
//  Created by Itachi on 15/8/4.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InvestmentCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *itemTitle;
@property (strong, nonatomic) IBOutlet UIImageView *itemIcon;
@property (strong, nonatomic) IBOutlet UILabel *itemMoney;
@property (strong, nonatomic) IBOutlet UILabel *itemRate;
@property (strong, nonatomic) IBOutlet UILabel *itemEndTime;
@property (strong, nonatomic) IBOutlet MDRadialProgressView *progressView;
@property (strong, nonatomic) NSString *type;

@end
