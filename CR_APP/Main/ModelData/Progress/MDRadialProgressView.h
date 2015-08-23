//
//  MDRadialProgressView.h
//  通泰贷
//
//  Created by ATBJB10 on 15/1/15.
//  Copyright (c) 2015年 xibenye. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *keyTheme = @"theme";
static NSString *keyThickness = @"theme.thickness";
static NSString *keyFrame     = @"frame";
static NSString *keyLabelColor = @"theme.labelColor";
static NSString *keyDropLabelShadow = @"theme.dropLabelShadow";
static NSString *keyLabelShadowColor = @"theme.labelShadowColor";
static NSString *keyLabelShadowOffset = @"theme.labelShadowOffset";
static NSString *keyFont = @"theme.font";

@class MDRadialProgressTheme;
@class MDRadialProgressLabel;


@interface MDRadialProgressView : UIView
- (id)initWithFrame:(CGRect)frame andTheme:(MDRadialProgressTheme *)theme;

@property (copy,nonatomic) NSString *Rate;

// The total number of steps in the progress view.
@property (assign, nonatomic) float progressTotal;

// The number of steps currently completed.
@property (assign, nonatomic) float progressCounter;

// Whether the progress is drawn clockwise (YES) or anticlockwise (NO)
@property (assign, nonatomic) BOOL clockwise;

// Whether the progress is in indeterminate mode or not
@property (assign, nonatomic) BOOL isIndeterminateProgress;

// The index of the slice where the first completed step is.
@property (assign, nonatomic) NSUInteger startingSlice;

// The theme currently used
@property (strong, nonatomic) MDRadialProgressTheme *theme;

// The label shown in the view's center.
@property (strong, nonatomic) MDRadialProgressLabel *label;

// The block that is used to update the label text when the progress changes.
@property (nonatomic, copy) NSString *(^labelTextBlock)(MDRadialProgressView *progressView);
@end
