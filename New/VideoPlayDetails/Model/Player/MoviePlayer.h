//
//  MoviePlayer.h
//  Eyes
//
//  Created by 雨天记忆 on 15/8/24.
//  Copyright (c) 2015年 Rebirth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

typedef NS_ENUM(NSInteger, PanDirection){
    PanDirectionHorizontalMoved,
    PanDirectionVerticalMoved
};

@protocol MoviePlayerDelegate <NSObject>

//点击返回按钮执行的方法
- (void)back;
@optional
- (void)FullOrSmall:(BOOL)isFull;

@end

@interface MoviePlayer : UIView
@property (strong, nonatomic) MPMoviePlayerController *moviePlay;//视频播放视图

@property (strong, nonatomic) NSString *title;//视频名称
@property (assign, nonatomic) BOOL isPresent; // 是否为推出来的界面
//写代理的时候，类型一定要是assign，要不然此视图无法被销毁
@property (assign, nonatomic) id<MoviePlayerDelegate>delegate;
//初始化方法
- (instancetype)initWithFrame:(CGRect)frame URL:(NSURL *)url;

@end
