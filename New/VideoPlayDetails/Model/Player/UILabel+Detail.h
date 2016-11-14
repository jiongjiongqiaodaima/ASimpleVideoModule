//
//  UILabel+Detail.h
//  Eyes
//
//  Created by 雨天记忆 on 15/8/20.
//  Copyright (c) 2015年 Rebirth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Detail)

- (void)detailWithStyle:(NSString *)style time:(NSInteger)time;

- (void)dateStrWithdate:(NSTimeInterval)date;

- (void)timeStrWithTime:(NSInteger)time;

@end
