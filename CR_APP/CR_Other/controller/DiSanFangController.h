//
//  DiSanFangController.h
//  CR_APP
//
//  Created by Itachi on 15/8/6.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
@interface DiSanFangController : UIViewController <WKNavigationDelegate>
@property (strong, nonatomic) NSString *postData;
@property (strong, nonatomic) NSURL *submitURL;

@property (strong, nonatomic) WKWebView *webView;
@end
