//
//  DiSanFangController.m
//  CR_APP
//
//  Created by Itachi on 15/8/6.
//  Copyright (c) 2015年 Itachi. All rights reserved.
//

#import "DiSanFangController.h"

@interface DiSanFangController ()
@property (strong, nonatomic) IBOutlet UIProgressView *webProgress;

@end

@implementation DiSanFangController
@synthesize webView,submitURL,postData;
#warning 还没给有webView设置进度条等等。。。。
- (void)viewDidLoad {
    [super viewDidLoad];
/**********************初始化导航栏**********************/
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.tintColor = ThemeRed;
    
/**********************初始化导航栏**********************/
    
/**********************初始化WebView**********************/
    webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height-66)];
    webView.navigationDelegate = self;
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
/**********************初始化WebView**********************/
}

#pragma mark - WebKit Methods

- (void)loadWebView{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:submitURL];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[postData dataUsingEncoding:NSUTF8StringEncoding]];
    [webView loadRequest:request];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        if (webView.estimatedProgress == 1) {
            self.webProgress.hidden = YES;
        }else{
            self.webProgress.hidden = NO;
            self.webProgress.progress = self.webView.estimatedProgress;
        }    }
}


- (IBAction)webBack:(UIBarButtonItem *)sender {
    [webView goBack];
}


- (IBAction)webRefresh:(UIBarButtonItem *)sender {
    [webView reload];
}

- (IBAction)webForward:(UIBarButtonItem *)sender {
    [webView goForward];
}



#pragma mark - WKNavigation Delelgate


- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    ATSHOW_ALERT(@"连接失败!请点击下方刷新按钮");
}



@end
