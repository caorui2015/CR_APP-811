//
//  MDRadialProgressTheme.m
//  通泰贷
//
//  Created by ATBJB10 on 15/1/15.
//  Copyright (c) 2015年 xibenye. All rights reserved.
//

#import "MDRadialProgressTheme.h"

@implementation MDRadialProgressTheme

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (id)themeWithName:(const NSString *)themeName
{
    return [[MDRadialProgressTheme alloc] init];
}

+ (id)standardTheme
{
    return [MDRadialProgressTheme themeWithName:STANDARD_THEME];
}

- (id)init
{
    self = [super init];
    if (self) {
        // View
        self.completedColor = [UIColor colorWithRed:32/255.0 green:144/255.0 blue:248/255.0 alpha:1.0];
        self.incompletedColor = [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1.0];
        self.sliceDividerColor = [UIColor whiteColor];
        self.centerColor = [UIColor clearColor];
        self.thickness = 16;
        self.sliceDividerHidden = NO;
        self.sliceDividerThickness = 2;
        self.drawIncompleteArcIfNoProgress = NO;
        
        // Label
        self.labelColor = [UIColor colorWithRed:32/255.0 green:144/255.0 blue:248/255.0 alpha:1.0];
        self.dropLabelShadow = YES;
        self.labelShadowColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        self.labelShadowOffset = CGSizeMake(1, 1);
        self.font = [UIFont systemFontOfSize:12.5];
    }
    
    return self;
}


@end
