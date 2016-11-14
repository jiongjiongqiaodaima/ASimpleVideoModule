//
//  NewPersonDelegateViewController.m
//  ZhongRenBang
//
//  Created by 童臣001 on 16/8/24.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "NewPersonDelegateViewController.h"
#import "Define.h"
@interface NewPersonDelegateViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)UIWebView *webView;

@end

@implementation NewPersonDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createTheView];
}

- (void)createTheView{
    self.view.backgroundColor=[UIColor whiteColor];
    
    [self setNavTitle:@"众人帮用户协议"];
    
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64)];
    webView.scalesPageToFit=YES;//自动对页面进行缩放以适应屏幕
    NSURL * url =[[NSURL alloc] initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"useragreement" ofType:@"html"]];
    NSURLRequest * request =[NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
