//
//  CoverView.m
//  ZhongRenBang
//
//  Created by 童臣001 on 16/7/30.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "CoverView.h"
#import "Define.h"

@interface CoverView ()
@property (nonatomic, strong) UILabel *shareLabel;                     /*< 分享Label >*/
@property (nonatomic, strong) UIImageView *backGroundView;                  /*< 背景图片 >*/
@property (nonatomic, strong) UIImageView *photoView;                       /*< 选择图片 >*/

@end


@implementation CoverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Initialization code
        [self initialize];
    }
    return self;
}


- (void)initialize
{
    [self setUserInteractionEnabled:YES];
    [self setExclusiveTouch:YES];
    
    self.thumbImageName = [UIImage imageNamed:@"video_release_background"];
    
    // add theme thumb Image
    //分享label
    self.shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 44)];
    _shareLabel.textAlignment = NSTextAlignmentCenter;
    _shareLabel.text = @"分享";
    _shareLabel.textColor = ZLColorFromRGB(0xFFFFFF);
    _shareLabel.font = [UIFont systemFontOfSize:19];
    [self addSubview:_shareLabel];
    
    //背景
    self.backGroundView = [[UIImageView alloc]initWithFrame:self.bounds];
    [_backGroundView setImage:self.thumbImageName];
    [_backGroundView.layer setMasksToBounds:YES];
    [self addSubview:_backGroundView];
    //  创建需要的毛玻璃特效类型
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    //  毛玻璃view 视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    //添加到要有毛玻璃特效的控件中
    effectView.frame = _backGroundView.bounds;
    [_backGroundView addSubview:effectView];
    //设置模糊透明度
    effectView.alpha = .7f;
    
    
    //封面
    UIView *photoBackView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 150) / 2, 64, 150, 150)];
    [self addSubview:photoBackView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchPhotoView:)];
    [photoBackView addGestureRecognizer:tap];
    
    
    self.photoView = [[UIImageView alloc]init];
    [_photoView setImage:self.thumbImageName];
    [_photoView.layer setMasksToBounds:YES];
    _photoView.frame = photoBackView.bounds;
    [photoBackView addSubview:_photoView];
    
    UIImageView *blackBackView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, 150, 50)];
    blackBackView.backgroundColor = [UIColor clearColor];
    [blackBackView setImage:[UIImage imageNamed:@"video_release_zhezhao"]];
    [photoBackView addSubview:blackBackView];
    
    UILabel *setPhotoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 9, 150, 32)];
    setPhotoLabel.text = @"设置封面";
    setPhotoLabel.textAlignment = NSTextAlignmentCenter;
    setPhotoLabel.textColor = ZLColorFromRGB(0xFFFFFF);
    [blackBackView addSubview:setPhotoLabel];
    
}

#pragma mark - 手势代理方法
- (void)touchPhotoView:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(theCoverViewWasTapped:)])
    {
        [self.delegate theCoverViewWasTapped:self];
    }
}

- (void)setThumbImageName:(UIImage *)thumbImageName
{
    if (_thumbImageName != thumbImageName)
    {
        _thumbImageName = [thumbImageName copy];
        [self.photoView setImage:thumbImageName];
        [self.backGroundView setImage:thumbImageName];
    }
}




@end
