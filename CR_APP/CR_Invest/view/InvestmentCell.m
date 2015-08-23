//
//  investmentCell.m
//  CR_APP
//
//  Created by Itachi on 15/8/4.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import "InvestmentCell.h"

@implementation InvestmentCell

- (void)awakeFromNib {
    // Initialization code
    self.progressView.theme.sliceDividerHidden = YES;
    self.progressView.progressTotal = 4;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
