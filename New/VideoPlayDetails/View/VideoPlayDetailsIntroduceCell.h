//
//  VideoPlayDetailsIntroduceCell.h
//  ZhongRenBang
//
//  Created by 看楼听雨 on 16/7/31.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoPlayDetailsBaseClass;
@interface VideoPlayDetailsIntroduceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *introduceLabel;
@property (nonatomic, strong) VideoPlayDetailsBaseClass *model;
@end
