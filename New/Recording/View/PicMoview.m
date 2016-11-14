//
//  PicMoview.m
//  GPU-Video-Edit
//
//  Created by 童臣001 on 16/6/29.
//  Copyright © 2016年 m-h. All rights reserved.
//

#import "PicMoview.h"

@implementation PicMoview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, frame.size.height / 4 * 3, frame.size.width, frame.size.height / 4)];
        _label.textColor = [UIColor whiteColor];
        _label.textAlignment = NSTextAlignmentCenter;
        //        [_label sizeToFit];
        [self addSubview:_label];
        
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, frame.size.width - 30, frame.size.width - 30)];
        
        [self addSubview:_imageView];
        
    }
    return self;
}

- (void)setlabel:(NSString *)str image:(NSString *)image{
    self.label.text = str;
    self.imageView.image = [UIImage imageNamed:image];
}


@end
