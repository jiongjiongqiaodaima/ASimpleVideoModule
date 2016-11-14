//
//  FilterChooseView.h
//  ZhongRenBang
//
//  Created by 童臣001 on 16/6/28.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"
typedef void(^callBackFilter)(GPUImageOutput<GPUImageInput> * filter);

@interface FilterChooseView : UIView
@property(nonatomic,copy) callBackFilter backback;

@end



@interface FilterChooseCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView * iconImg;
@property(nonatomic,strong)UILabel * nameLab;
@end