//
//  PicMoview.h
//  GPU-Video-Edit
//
//  Created by 童臣001 on 16/6/29.
//  Copyright © 2016年 m-h. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicMoview : UIView

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIImageView *imageView;
- (id)initWithFrame:(CGRect)frame;
- (void)setlabel:(NSString *)str image:(NSString *)image;


@end
