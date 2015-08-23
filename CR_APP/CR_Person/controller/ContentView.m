//
//  contentView.m
//  CR_APP
//
//  Created by Itachi on 15/8/1.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import "ContentView.h"

@implementation ContentView



- (void)drawRect:(CGRect)rect{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rect];
    imageView.image = [UIImage imageNamed:@"tiao.png"];
    [self insertSubview:imageView atIndex:0];
}
@end
