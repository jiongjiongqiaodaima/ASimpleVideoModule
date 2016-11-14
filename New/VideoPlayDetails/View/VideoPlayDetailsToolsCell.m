//
//  VideoPlayDetailsToolsCell.m
//  ZhongRenBang
//
//  Created by 看楼听雨 on 16/7/31.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "VideoPlayDetailsToolsCell.h"
#import "VideoPlayDetailsEntity.h"
#import "UIColor+Tools.h"

@implementation VideoPlayDetailsToolsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(VideoPlayDetailsEntity *)model
{
    _model = model;
    _likeBtn.backgroundColor =[UIColor colorWithHexString:@"2e2b3f" alpha:1.0];
    _comBtn.backgroundColor =[UIColor colorWithHexString:@"2e2b3f" alpha:1.0];
    _shareBtn.backgroundColor =[UIColor colorWithHexString:@"2e2b3f" alpha:1.0];

    [_likeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_comBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _lineViewLeft .backgroundColor = [UIColor colorWithHexString:@"1b182a" alpha:1.0];
    _lineViewRight.backgroundColor = [UIColor colorWithHexString:@"1b182a" alpha:1.0];
    
    [_likeBtn setTitle:[NSString stringWithFormat:@"%.0f",model.jz] forState:(UIControlStateNormal)];
    [_comBtn setTitle:[NSString stringWithFormat:@"%.0f 次",model.lx] forState:(UIControlStateNormal)];
}

- (IBAction)likeClick:(UIButton *)sender
{
    // tag值为 0
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickBtnWith:num:)]) {
        [self.delegate clickBtnWith:sender.tag num:0];
    }
}

- (IBAction)commentClick:(UIButton *)sender
{
    // tag值为 1
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickBtnWith:num:)]) {
        [self.delegate clickBtnWith:sender.tag num:0];
    }
}
- (IBAction)shareClick:(UIButton *)sender
{
    // tag值为 2
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickBtnWith:num:)]) {
        [self.delegate clickBtnWith:sender.tag num:0];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
