//
//  VideoPlayDetailsIntroduceCell.m
//  ZhongRenBang
//
//  Created by 看楼听雨 on 16/7/31.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "VideoPlayDetailsIntroduceCell.h"
#import "VideoPlayDetailsHeader.h"
@implementation VideoPlayDetailsIntroduceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(VideoPlayDetailsBaseClass *)model
{
    _model = model;
    _introduceLabel.text = model.messageHelper.entity.describes;
    _introduceLabel.textColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
