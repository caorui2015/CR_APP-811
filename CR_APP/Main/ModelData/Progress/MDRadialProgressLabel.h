//
//  MDRadialProgressLabel.h
//  通泰贷
//
//  Created by ATBJB10 on 15/1/15.
//  Copyright (c) 2015年 xibenye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MDRadialProgressTheme;

@interface MDRadialProgressLabel : UILabel

- (id)initWithFrame:(CGRect)frame andTheme:(MDRadialProgressTheme *)theme;
- (void)updatedFrame:(CGRect)newFrame;
// If adjustFontSizeToFitBounds is enabled, limit the size of the font to the bounds'width * pointSizeToWidthFactor.
@property (assign, nonatomic) CGFloat pointSizeToWidthFactor;

// Whether the algorithm to autoscale the font size is enabled or not.
@property (assign, nonatomic) BOOL adjustFontSizeToFitBounds;


@end
