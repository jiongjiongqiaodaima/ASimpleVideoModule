//
//  DIYButton.h
//  Eyes
//
//  Created by 雨天记忆 on 15/8/21.
//  Copyright (c) 2015年 Rebirth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DIYButton : UIButton

@property (strong, nonatomic, readonly) UIImageView *icon;//button的图片显示
@property (strong, nonatomic, readonly) UIImageView *iconSelected;//button selected状态下的图片

@property (strong, nonatomic, readonly) UILabel *textLabel;//文字显示

@end
