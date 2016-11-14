//
//  FahuorenViewController.m
//  ZhongRenBang
//
//  Created by 童臣001 on 16/8/22.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "FahuorenViewController.h"
#import "Define.h"
@interface FahuorenViewController ()<UIWebViewDelegate>

@property (nonatomic, strong)UIWebView *webView;

@end

@implementation FahuorenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTheView];
}

- (void)createTheView{
    [self setNavTitle:@"发货人细则"];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64 , SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate=self;
    [self.view addSubview:self.webView];
    
    //加载web
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerAddress,@"/zyhtml/fahuoren.html"]];//创建URL
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    
    [self.webView setScalesPageToFit:YES];//自适应屏幕

    [self.webView loadRequest:request];//加载
    
    _webView.delegate = self;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
