//
//  VideoPlayDetailsMessageCell.m
//  ZhongRenBang
//
//  Created by 看楼听雨 on 16/7/31.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "VideoPlayDetailsMessageCell.h"
#import "VideoPlayDetailsListcollection.h"
#import "UIButton+WebCache.h"
#import "UIColor+Tools.h"
@implementation VideoPlayDetailsMessageCell

- (void)setModel:(VideoPlayDetailsListcollection *)model
{
    _model = model;
    
    self.backgroundColor = [UIColor colorWithHexString:@"2e2b3f" alpha:1.0];
    
    _bgView.backgroundColor = [UIColor colorWithHexString:@"2e2b3f" alpha:1.0];
    
    [_iconBtn sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] forState:(UIControlStateNormal) placeholderImage:[UIImage imageNamed:@"touxiang"]];
    if (model.name && model.name.length > 0) {
        _nameLabel.text = model.name;
    }else
    {
        _nameLabel.text = @"新用户";
    }
    _contentLabel.text = model.content;
    
    NSString * gender = nil;
    if ([model.sex isEqualToString:@"男"]) {
        gender = @"boy";
        _nameLabel.textColor = [UIColor colorWithHexString:@"4297F7" alpha:1.0f];
    }else
    {
        gender = @"girl";
        _nameLabel.textColor = [UIColor colorWithHexString:@"FB3886" alpha:1.0f];
    }
    _genderImg.image = [UIImage imageNamed:gender];
}
- (IBAction)messageIconClick
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(messageIconClick:)]) {
        [self.delegate messageIconClick:_model.userId];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
