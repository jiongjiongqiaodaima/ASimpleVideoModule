//
//  MoviePlayerController.h
//  BestNotEelderSister
//
//  Created by 看楼听雨 on 16/3/28.
//  Copyright © 2016年 XJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoviePlayerController : UIViewController

//视频播放 所需要的model
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *titleName;

@end
