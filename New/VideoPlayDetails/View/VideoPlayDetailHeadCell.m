//
//  VideoPlayDetailHeadCell.m
//  ZhongRenBang
//
//  Created by 看楼听雨 on 16/8/3.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "VideoPlayDetailHeadCell.h"
#import "VideoPlayDetailsHeader.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
//#import <IJKMediaFramework/IJKFFMoviePlayerController.h>
#import "Define.h"
#import "Common.h"
#import "UIColor+Tools.h"

@interface VideoPlayDetailHeadCell ()<MoviePlayerDelegate>
@property (weak, nonatomic) IBOutlet UIView *backGroundView;
//@property (nonatomic,strong)IJKFFMoviePlayerController *player;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *groundViewLayout;

@end
@implementation VideoPlayDetailHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _groundViewLayout.constant = 400 * RelativeHeight;
}

- (void)setModel:(VideoPlayDetailsBaseClass *)model{
   
    self.backgroundColor = [UIColor colorWithHexString:@"2e2b3f" alpha:1.0];
    _model = model;
    
    _headerBgView.backgroundColor = [UIColor colorWithHexString:@"2e2b3f" alpha:1.0];
   
    _bgView.backgroundColor = [UIColor colorWithHexString:@"2e2b3f" alpha:1.0];

    VideoPlayDetailsUser *user = model.messageHelper.entity.user;
    [_iconBtn sd_setImageWithURL:[NSURL URLWithString:user.headphoto] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"touxiang"]];
    if (user.name && user.name.length > 0) {
        _nameLabel.text = user.name;
    }else
    {
        _nameLabel.text = @"新用户";
    }
    
    _videoNameLabel.text = model.messageHelper.entity.videoname;
    _videoNameLabel.textColor = [UIColor whiteColor];
    
    NSString * genderImg = nil;
    if ([user.sex isEqualToString:@"男"]) {
        genderImg = @"boy";
        _nameLabel.textColor = [UIColor colorWithHexString:@"4297F7" alpha:1.0f];
    }else
    {
        genderImg = @"girl";
        _nameLabel.textColor = [UIColor colorWithHexString:@"F2448A" alpha:1.0f];
    }
    _genderImg.image = [UIImage imageNamed:genderImg];
    NSString *time =  model.messageHelper.entity.createtime;
    if (time) {
        time = [time substringToIndex:10];
    }
    [_playImg sd_setImageWithURL:[NSURL URLWithString:model.messageHelper.entity.videoimg] placeholderImage:[UIImage imageNamed:@""]];

    _timeLabel.text = time;
    _timeLabel.textColor = [UIColor whiteColor];
    
    if (!_player && model) {
        [self createVideoPlayView:model.messageHelper.entity.url];
    }
}

- (void)createVideoPlayView:(NSString *)url{
    if (!_player) {
        self.player = [[MoviePlayer alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 400 * RelativeHeight) URL:[NSURL URLWithString:url]];
        self.player.title = _model.messageHelper.entity.videoname;
        self.player.delegate = self;
        [_backGroundView addSubview:self.player];
    }
}

- (IBAction)iconClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickBtnWithUserID:)]) {
        [self.delegate clickBtnWithUserID:_model.messageHelper.entity.user.userid];
    }
}

- (IBAction)playVideo:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(playVideoWith:)]) {
        [self.delegate playVideoWith:_model.messageHelper.entity.url];
    }
}

-(void)dealloc{
    if (_player) {
        [_player removeFromSuperview];
        _player = nil;
    }
}




@end

