//
//  VideoPlayDetailHeadCell.h
//  ZhongRenBang
//
//  Created by 看楼听雨 on 16/8/3.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoviePlayer.h"

@class MoviePlayer;
@protocol VideoPlayDetailHeaderDelegate <NSObject>

@optional

- (void)playVideoWith:(NSString *)url;

- (void)theViewWasTapped:(MoviePlayer *)player;

- (void)clickBtnWithUserID:(NSString *)userID;

- (void)theViewWasDoubleTapped:(MoviePlayer *)player;

@end

@class VideoPlayDetailsBaseClass;
@interface VideoPlayDetailHeadCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *iconBtn;

@property (weak, nonatomic) IBOutlet UIImageView *genderImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *playImg;
@property (weak, nonatomic) IBOutlet UILabel *videoNameLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *headerBgView;

@property (strong, nonatomic) UIImageView *animationVIew;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic, strong) MoviePlayer *player;

@property (weak, nonatomic) id <VideoPlayDetailHeaderDelegate> delegate;

@property (nonatomic, strong) VideoPlayDetailsBaseClass *model;

@end
