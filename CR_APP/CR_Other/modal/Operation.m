//
//  Operation.m
//  CR_APP
//
//  Created by Itachi on 15/8/5.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import "Operation.h"

@implementation Operation


+ (NSDictionary *)getUser{
    NSData *userData = [APPDefualts objectForKey:USER];
    NSDictionary *user = [NSKeyedUnarchiver unarchiveObjectWithData:userData];
    return user;
}
@end
