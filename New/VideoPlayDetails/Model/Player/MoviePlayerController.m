//
//  MoviePlayerController.m
//  BestNotEelderSister
//
//  Created by 看楼听雨 on 16/3/28.
//  Copyright © 2016年 XJ. All rights reserved.
//

#import "MoviePlayerController.h"
#import "MoviePlayer.h"
#import "AppDelegate.h"

@interface MoviePlayerController ()<MoviePlayerDelegate>

//防止模拟器视频播放不出来，直接设置为属性
@property (strong, nonatomic) MoviePlayer *moviePlayer;

@end

@implementation MoviePlayerController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSURL *url = nil;

    url = [NSURL URLWithString:self.url];
    self.moviePlayer = [[MoviePlayer alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.height, self.view.bounds.size.width) URL:url];
    self.moviePlayer.title = self.titleName;
    self.moviePlayer.delegate = self;
    [self.view addSubview:self.moviePlayer];

}

- (void)back{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;

//    appDelegate.isRotation = NO;
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
