//
//  WupingxianzhiViewController.m
//  ZhongRenBang
//
//  Created by 童臣001 on 16/8/22.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "WupingxianzhiViewController.h"
#import "Define.h"
@interface WupingxianzhiViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *webView;

@end

@implementation WupingxianzhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createTheView];
}

- (void)createTheView{
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64 , SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.webView.scalesPageToFit = YES;
    self.webView.delegate=self;
    [self.view addSubview:self.webView];
    
    //加载web
    NSURL* url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",ServerAddress,@"/zyhtml/wupin.html"]];//创建URL

    NSURLRequest* request = [NSURLRequest requestWithURL:url];//创建NSURLRequest
    
    [self.webView setScalesPageToFit:YES];//自适应屏幕
    
    [self.webView loadRequest:request];//加载
    
    _webView.delegate = self;
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
