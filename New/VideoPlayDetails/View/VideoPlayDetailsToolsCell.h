//
//  VideoPlayDetailsToolsCell.h
//  ZhongRenBang
//
//  Created by 看楼听雨 on 16/7/31.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VideoPlayDetailsToolsDelegate <NSObject>

@optional

/**
 *  点击按钮
 *
 *  @param tag 那个按钮
 *  @param num 是否有数值 num(喜欢, 评论数)
 */
- (void)clickBtnWith:(NSInteger)tag num:(NSInteger)num;

@end

@class VideoPlayDetailsEntity;
@interface VideoPlayDetailsToolsCell : UITableViewCell
/**
 *  喜欢
 */
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
/**
 *  评论
 */
@property (weak, nonatomic) IBOutlet UIButton *comBtn;
/**
 *  分享
 */
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;
@property (weak, nonatomic) IBOutlet UIView *lineViewLeft;
@property (weak, nonatomic) IBOutlet UIView *lineViewRight;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (nonatomic, weak) id <VideoPlayDetailsToolsDelegate> delegate;
@property (nonatomic, strong) VideoPlayDetailsEntity *model;
@end
