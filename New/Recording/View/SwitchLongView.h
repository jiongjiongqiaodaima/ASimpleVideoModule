//
//  SwitchLongView.h
//  GPU-Video-Edit
//
//  Created by 童臣001 on 16/6/29.
//  Copyright © 2016年 m-h. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwitchLongView;

/**
 *	@brief  代理
 */
@protocol SwitchLongViewDelegate <NSObject>

/**
 *	@brief	点击
 *
 *	@param 	themeImageView 	被点击的主题
 */
- (void)theSwitchLongViewWasTapped:(SwitchLongView *)coverView;

@end


@interface SwitchLongView : UIView<UIGestureRecognizerDelegate>

@property (nonatomic, strong) id<SwitchLongViewDelegate> delegate;          /*< 事件代理 >*/
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UIView *lineView;

- (id)initWithFrame:(CGRect)frame;
- (void)setLabelText:(NSString *)str color:(UIColor *)textcolor lineColor:(UIColor *)lineColor;
@end

