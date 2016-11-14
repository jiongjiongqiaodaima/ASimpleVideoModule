//
//  VideoPlayDetailsMessageCell.h
//  ZhongRenBang
//
//  Created by 看楼听雨 on 16/7/31.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VideoPlayDetailsMessageDelegate <NSObject>

@optional
- (void)messageIconClick:(NSString *)userID;

@end

@class VideoPlayDetailsListcollection;
@interface VideoPlayDetailsMessageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *iconBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *genderImg;
@property (nonatomic, weak) id <VideoPlayDetailsMessageDelegate> delegate;

@property (strong, nonatomic) VideoPlayDetailsListcollection *model;

@end
