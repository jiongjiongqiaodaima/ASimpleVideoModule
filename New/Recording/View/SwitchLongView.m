//
//  SwitchLongView.m
//  GPU-Video-Edit
//
//  Created by 童臣001 on 16/6/29.
//  Copyright © 2016年 m-h. All rights reserved.
//
#import "Define.h"
#import "SwitchLongView.h"

@implementation SwitchLongView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}


- (void)initialize{
    [self setUserInteractionEnabled:YES];
    [self setExclusiveTouch:YES];
    
    UIView *photoBackView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:photoBackView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchSwitchLongView:)];
    [photoBackView addGestureRecognizer:tap];
    
    self.label = [[UILabel alloc]initWithFrame:self.bounds];
    _label.textAlignment = NSTextAlignmentCenter;
    [photoBackView addSubview:_label];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 1, self.bounds.size.width, 1)];
    [photoBackView addSubview:_lineView];
}


- (void)setLabelText:(NSString *)str color:(UIColor *)textcolor lineColor:(UIColor *)lineColor{
    _label.text = str;
    _label.textColor = textcolor;
    _lineView.backgroundColor = lineColor;
}

#pragma mark - 手势代理方法
- (void)touchSwitchLongView:(UITapGestureRecognizer *)tap{
    if ([self.delegate respondsToSelector:@selector(theSwitchLongViewWasTapped:)])
    {
        [self.delegate theSwitchLongViewWasTapped:self];
    }
}


@end
