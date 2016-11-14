//
//  CoverView.h
//  ZhongRenBang
//
//  Created by 童臣001 on 16/7/30.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoverView;

/**
 *	@brief  代理
 */
@protocol CoverViewDelegate <NSObject>

/**
 *	@brief	点击
 *
 *	@param 	themeImageView 	被点击的主题
 */
- (void)theCoverViewWasTapped:(CoverView *)coverView;

@end

@interface CoverView : UIView

@property (nonatomic, strong) id<CoverViewDelegate> delegate;          /*< 事件代理 >*/
@property (nonatomic, strong) UIImage *thumbImageName;                    /*< 主题缩略图名称 >*/

- (void)setbackgroundImage:(NSURL *)url;


@end
