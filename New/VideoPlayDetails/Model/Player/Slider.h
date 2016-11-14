//
//  Slider.h
//  Slider
//
//  Created by 雨天记忆 on 15/8/25.
//  Copyright (c) 2015年 Rebirth. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SliderDelegate <NSObject>

//点击视图后，新的value值
- (void)touchView:(float)value;

@end

@interface Slider : UIView

@property (strong, nonatomic) UIView *thumb;
//可以使用的slider
@property (strong, nonatomic) UISlider *slider;
//缓冲的进度
@property (assign, nonatomic) CGFloat cache;
//缓冲条的颜色
@property (strong, nonatomic) UIColor *cacheColor;

@property (assign, nonatomic) id<SliderDelegate>delegate;

@end
