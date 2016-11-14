//
//  VideoPlayDetailsCommentView.m
//  ZhongRenBang
//
//  Created by 看楼听雨 on 16/7/31.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "VideoPlayDetailsCommentView.h"
#import "ZRBLoginRegistTextField.h"
#import "MBProgressHUD+MJ.h"


@interface VideoPlayDetailsCommentView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet ZRBLoginRegistTextField *commentTextField;

@end

@implementation VideoPlayDetailsCommentView

+ (instancetype)shareVideoPlayDetailsCommentView
{
    return [[NSBundle mainBundle] loadNibNamed:@"VideoPlayDetailsCommentView" owner:nil options:nil].lastObject;
}

- (IBAction)submitClick:(UIButton *)sender
{
    [_commentTextField resignFirstResponder];
    if ( _commentTextField.text.length > 0) {
        if (_submitCommentText) {
            _submitCommentText(_commentTextField.text);
        }
        _commentTextField.text = @"";
    }else
    {
        [MBProgressHUD showError:@"请输入文字"];
    }
    
}

@end
