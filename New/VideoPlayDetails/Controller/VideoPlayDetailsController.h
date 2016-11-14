//
//  VideoPlayDetailsController.h
//  ZhongRenBang
//
//  Created by 看楼听雨 on 16/7/31.
//  Copyright © 2016年 ZengWei. All rights reserved.
//  视频详情

#import "CommonViewController.h"

@interface VideoPlayDetailsController : CommonViewController
/**
 *  视频ID
 */
@property (nonatomic, copy) NSString *videoID;

@property (nonatomic, copy) NSString * videoIdStr;

//视频播放 所需要的model
@property (strong, nonatomic) NSString *url;

@property (strong, nonatomic) NSString *titleName;

@end
