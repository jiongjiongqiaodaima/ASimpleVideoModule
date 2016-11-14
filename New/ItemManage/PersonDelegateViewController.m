//
//  PersonDelegateViewController.m
//  ZhongRenBang
//
//  Created by 童臣001 on 16/8/23.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "PersonDelegateViewController.h"

@interface PersonDelegateViewController ()<UIWebViewDelegate>
@property (nonatomic, strong)UIWebView *webView;
@end

@implementation PersonDelegateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTheView];
}

- (void)createTheView{
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.webView setUserInteractionEnabled:YES];
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSString *htmlPath = [[[NSBundle mainBundle]bundlePath]stringByAppendingString:@"/Users/tongchen001/Desktop/ZRB-app/baituo/Classes/New/ItemManage/useragreement.html"];
    NSString *htmlString = [NSString stringWithContentsOfURL:[NSURL URLWithString:htmlPath] encoding:NSUTF8StringEncoding error:NULL];
    [self.webView loadHTMLString:htmlString baseURL:[NSURL fileURLWithPath:htmlPath]];
}


//html页面的每个按钮点击时触发事件
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString * urlStr = request.URL.absoluteString ;
    
    NSLog(@"url~~:%@",urlStr);
    return YES;
}


/**如果有用的的话 这里是调整html中text的字体大小 100%为原本大小*/
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '90%'"];
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
