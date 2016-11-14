//
//  VideoPlayDetailsCommentView.h
//  ZhongRenBang
//
//  Created by 看楼听雨 on 16/7/31.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRBLoginRegistTextField.h"

typedef void(^SubmitCommentText)(NSString *);

@interface VideoPlayDetailsCommentView : UIView
@property (weak, nonatomic) IBOutlet ZRBLoginRegistTextField *textField;

+ (instancetype)shareVideoPlayDetailsCommentView;


@property (nonatomic, copy) SubmitCommentText submitCommentText;

@end
