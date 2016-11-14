//
//  FreedomPeopleViewController.m
//  ZhongRenBang
//
//  Created by 童臣001 on 16/8/22.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "FreedomPeopleViewController.h"
#import "Define.h"
#import <WebKit/WebKit.h>
@interface FreedomPeopleViewController ()<UIWebViewDelegate,WKNavigationDelegate>
@property (nonatomic, strong)WKWebView *webView;

@end

@implementation FreedomPeopleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createTheView];
}

- (void)createTheView{
    [self setNavTitle:@"自由快递人细则"];
    
    self.webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 64 , SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.webView.navigationDelegate = self;

    //加载web
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerAddress,@"/zyhtml/free.html"]];//创建URL
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    
    [self.webView loadRequest:request];//加载
    
    [self.view addSubview:self.webView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
