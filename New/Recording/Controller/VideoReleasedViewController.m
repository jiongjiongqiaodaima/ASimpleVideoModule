//
//  VideoReleasedViewController.m
//  ZhongRenBang
//
//  Created by 童臣001 on 16/7/30.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "VideoReleasedViewController.h"
#import "CoverView.h"
#import "Define.h"
#import "PlaceholderTextView.h"
#import "UploadStaticResourceManager.h"
#import "MMProgressHUD.h"
#define MAXVALUE 130
#import <QiniuSDK.h>
#import "NSString+Extension.h"
#import "Common.h"
#import "VerticalButton.h"
#import "ShareSdkUtils.h"
#import "AppDelegate.h"
#import "MBProgressHUD+MJ.h"

#define kContentLimit 130

@interface VideoReleasedViewController ()<CoverViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView * bgScrollView;
@property (nonatomic, strong) CoverView *coverView;
@property (nonatomic, strong) UIButton *cancelBtn; //返回
@property (nonatomic, strong) UIButton *releaseBtn; //立即发布
@property (nonatomic, strong) PlaceholderTextView *textView;
@property (nonatomic, strong) UITextField * titleField;
@property (nonatomic, strong) UILabel * remindLabel;
@property (nonatomic, strong) UIImage *videoImage;

@property (nonatomic, strong) UIButton * sinaBtn;
@property (nonatomic, strong) UIButton * qqSpaceBtn;
@property (nonatomic, strong) UIButton * qqBtn;
@property (nonatomic, strong) UIButton * weChatSpaceBtn;
@property (nonatomic, strong) UIButton * weChatBtn;

@property (nonatomic, assign) BOOL  sinaSelected;
@property (nonatomic, assign) BOOL  qqSpaceSelected;
@property (nonatomic, assign) BOOL  qqSelected;
@property (nonatomic, assign) BOOL  weChatSpaceSelected;
@property (nonatomic, assign) BOOL  weChatSelected;

@end

@implementation VideoReleasedViewController{
    NSInteger count;
    NSString *imagePath;
    BOOL isShare;
    NSInteger shareType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [CommonViewController colorWirhNSString:@"f5f5f5"];
    
    _bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, SCREEN_WIDTH, 800)];
    _bgScrollView.delegate = self;
    _bgScrollView.backgroundColor = [CommonViewController colorWirhNSString:@"f5f5f5"];
    _bgScrollView.pagingEnabled = NO;
    _bgScrollView.scrollEnabled = YES;
    _bgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1000);
    [self.view addSubview:_bgScrollView];
    
    [self creatTheView];
    [self createTheShareView];
}

- (void)creatTheView{
    //上半部分
    self.coverView = [[CoverView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
    self.coverView.delegate = self;
    
    [_bgScrollView addSubview:_coverView];
    
    //返回按钮
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(12, 20, 35, 35);
    [_cancelBtn setImage:[UIImage imageNamed:@"video_release_back"] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(cancelToBackView:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bgScrollView addSubview:_cancelBtn];
    
    //发布按钮
    self.releaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _releaseBtn.frame = CGRectMake((SCREEN_WIDTH - 275) / 2, 660, 275, 40);
    _releaseBtn.backgroundColor = [UIColor redColor];
    [_releaseBtn setTitle:@"立即发布" forState:UIControlStateNormal];
    _releaseBtn.titleLabel.text = @"立即发布";
    _releaseBtn.titleLabel.textColor = [CommonViewController colorWirhNSString:@"ff4d4d"];
    _releaseBtn.layer.cornerRadius = 20;
    [_releaseBtn addTarget:self action:@selector(releaseTheVideo:) forControlEvents:UIControlEventTouchUpInside];
    
    [_bgScrollView addSubview:_releaseBtn];
    
    //视频标题
    UIView * titleBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 250, SCREEN_WIDTH, 40)];
    titleBgView.backgroundColor = [UIColor whiteColor];
    [_bgScrollView addSubview:titleBgView];
    
    _titleField = [[UITextField alloc] initWithFrame:CGRectMake(12, 0, SCREEN_WIDTH-80, 40)];
    _titleField.font = [UIFont systemFontOfSize:15];
    _titleField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _titleField.placeholder = @"请输入标题";
    _titleField.delegate = self;
    _titleField.tag = 200;
    _titleField.keyboardType = UIKeyboardTypeDefault;
    _titleField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [titleBgView addSubview:_titleField];
    
    _remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 80, 0, 70, 40)];
    _remindLabel.textColor = [UIColor lightGrayColor];
    _remindLabel.textAlignment = NSTextAlignmentRight;
    _remindLabel.text = @"0/20";
    _remindLabel.font = [UIFont systemFontOfSize:14];
    [titleBgView addSubview:_remindLabel];
    
    //视频描述
    self.textView = [[PlaceholderTextView alloc]initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 150)];
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor whiteColor];
    [_textView specialForZL];
    [_bgScrollView addSubview:_textView];
    
    UILabel *label  = [[UILabel alloc]initWithFrame:CGRectMake(12, 450, SCREEN_WIDTH / 2, 35)];
    label.text = @"同步到";
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = ZLColorFromRGB(0x999999);
    label.font = [UIFont systemFontOfSize:15];
    [_bgScrollView addSubview:label];
}

- (void)createTheShareView {
    UIView * whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 485, SCREEN_WIDTH, 150)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [_bgScrollView addSubview:whiteView];
    
    CGFloat btnW = 80;
    
    NSArray *titles = @[@"新浪微博",@"QQ空间",@"QQ好友",@"微信朋友圈",@"微信好友"];
    NSArray *images = @[@"share_sns_icon_1",@"share_sns_icon_6",@"share_sns_icon_24",@"share_sns_icon_23",@"share_sns_icon_22"];
    
    CGFloat maregeX = 40 * RelativeWidth;
    CGFloat btnMarge = (ScreenWidth - maregeX * 2 - 80 * 3) * 0.5;
    
    for (int i = 0; i < titles.count; i++) {
        CGFloat btnX = 0;
        CGFloat btnY = i / 3 * 50 + 10 + i / 3 * 24;
        
        switch (i) {
            case 0:
                btnX = maregeX;
                break;
            case 1:
                btnX = maregeX + btnW + btnMarge;
                break;
            case 2:
                btnX = maregeX + (btnW  + btnMarge) * 2;
                break;
            case 3:
                btnX = maregeX;
                break;
            case 4:
                btnX = maregeX + btnW + btnMarge;
                break;
            default:
                break;
        }
        
        UIButton *button = [self buttonWith:titles[i] img:images[i] tag:i+100];
        button.frame = CGRectMake(btnX, btnY, btnW + 10, 50);
        button.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [whiteView addSubview:button];
    }
}

- (VerticalButton *)buttonWith:(NSString *)title img:(NSString *)img tag:(NSInteger)tag{
    VerticalButton *button = [VerticalButton buttonWithType:(UIButtonTypeCustom)];
    button.width = 80;
    button.height = 35;
    button.tag = tag;
    [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:img] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(shareClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    return button;
}

- (void)shareClick:(UIButton *)sender{
    NSInteger type = sender.tag - 100;
    AppDelegate * app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSDictionary *dic = [app.openThirdDic mutableCopy];
    if (dic.count > 0) {
        
    }
    switch (type) {
        case 0:
        {
            // 微博可以调起浏览器
//            if (![dic objectForKey:@"Weibo"]) {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有安装微博,不能使用微博进行分享" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//                [alert show];
//                return;
//            }
        }
            break;
        case 1:
        {
            if (![dic objectForKey:@"QQ"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有安装QQ,不能使用QQ进行分享" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
        }
            break;
        case 2:
        {
            if (![dic objectForKey:@"QQ"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有安装QQ,不能使用QQ进行分享" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
        }
            break;
        case 3:
        {
            if (![dic objectForKey:@"WX"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有安装微信,不能使用微信进行分享" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
        }
            break;
        case 4:
        {
            if (![dic objectForKey:@"WX"]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您没有安装微信,不能使用微信进行分享" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                return;
            }
        }
            break;
        default:
            break;
    }
    
    isShare = YES;
    shareType = type;
    [self uploadVideoToQiNiu];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self.textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSInteger value = textView.text.length;
    //高亮不进入统计 避免未输入的中文在拼音状态被统计入总长度限制
    value -= [textView textInRange:[textView markedTextRange]].length;
    if (value <= kContentLimit) {
        NSLog(@"%@",[NSString stringWithFormat:@"%d/%d",(int)value,kContentLimit]);
        self.textView.tipLabel.text = [NSString stringWithFormat:@"%d/%d字", (int)value,kContentLimit];
    } else {
        //截断长度限制以后的字符 避免截断字符
        NSString *tempStr = [textView.text substringWithRange:[textView.text rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, kContentLimit)]];
        textView.text=tempStr;

        [MBProgressHUD showError:[NSString stringWithFormat:@"最多只能输入%d字",kContentLimit]];
    }
}

#pragma mark - method
- (void)cancelToBackView:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/**
 *  就这儿
 */
- (void)releaseTheVideo:(UIButton *)sender{
    
    isShare = NO;
    [self setProgressBarDefaultStyle];
    NSString *title = NSLocalizedString(@"处理中", nil);
    [self updateProgressBarTitle:title status:@""];
    
    [self uploadVideoToQiNiu];
    
    NSLog(@"发布视频啦");
}

- (void)uploadVideoToQiNiu{
    NSLog(@"uploadVideoToQiNiu");
    if (self.videoUrl && self.videoUrl.absoluteString)
    {
        if (count == 0) {
            _videoImage = [self getVideoPreViewImage:self.videoUrl];
        };
        
        NSData *data = [NSData dataWithContentsOfURL:_videoUrl];
        
        NSData *imageData =UIImageJPEGRepresentation(_videoImage, 0.3);
        
        if (data == nil || imageData == nil) {
            NSLog(@"空的你让我怎么玩");
            return;
        }
        
        UploadStaticResourceManager *manager = [UploadStaticResourceManager shareManager];
        
        __weak typeof(self)weakSelf = self;
        
            [manager uploadResourceData:imageData CompletionBlock:^(NSString *returnUrl) {
                NSLog(@"1111:%@",returnUrl);
                imagePath = returnUrl;
                [manager uploadResourceData:data CompletionBlock:^(NSString *returnUrl) {
                    NSString *http = @"www";
                    NSArray *array = [returnUrl componentsSeparatedByString:http];
                    NSString *shareVideoUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",http,array.lastObject];
                    
                    if (isShare) {
                        UIImage *image = [UIImage imageWithData:imageData];
                        [ShareSdkUtils shareWithTitle:self.titleField.text text:self.textView.text url:shareVideoUrl image:image type:shareType];
                    }else
                    {
                        [weakSelf uploadToServer:returnUrl];
                    }
                }];
            }];
    }else{
        [self dismissProgressBar:@"发布失败"];
    }
}

- (void)uploadToServer:(NSString *)videoUrl
{
    CGFloat latit  = [[[NSUserDefaults standardUserDefaults] objectForKey:@"latit"] floatValue];
    CGFloat longit = [[[NSUserDefaults standardUserDefaults] objectForKey:@"longit"] floatValue];
    
    if (longit == 0.0f) {
        latit = 40.7143528f;
        longit = -74.0059731f;
    }
    
    if (count == 0) {
        _videoImage = [self getVideoPreViewImage:self.videoUrl];
    }
    
    if (!(self.titleField.text.length > 0)) {
        [MBProgressHUD showError:@"视频标题不能为空"];
        [MMProgressHUD dismiss];
        return;
    }
    
    if (!(self.textView.text.length > 0)) {
        [MBProgressHUD showError:@"视频描述不能为空"];
        [MMProgressHUD dismiss];
        return;
    }
    NSString *http = @"www";
    NSArray *array = [videoUrl componentsSeparatedByString:http];
    NSString *videopath = [NSString stringWithFormat:@"%@%@%@",@"http://",http,array.lastObject];
    NSString *url = [ServerAddress stringByAppendingPathComponent:@"addMyvideo.action"];
    
    NSArray *videos = [imagePath componentsSeparatedByString:http];
    NSString *videoimg = [NSString stringWithFormat:@"%@%@%@",@"http://",http,videos.lastObject];
    NSDictionary *parameters = @{@"userid" : [NSString getUserID],
                                 @"videoname" : self.titleField.text,
                                 @"describes" : self.textView.text,
                                 @"types" : @"1",
                                 @"url" : videopath ,
                                 @"weizhi" : [NSString stringWithFormat:@"%f,%f",longit,latit],
                                 @"city" : [NSString getUserCity],
                                 @"area" : [NSString getUserDistrict],
                                 @"videoimg" : videoimg};
    
    [[ZRBNetWorking shareNewWorking] startPostRequest:url withParameters:parameters callBack:^(NSDictionary *responseObject) {
        NSLog(@"%@",responseObject);
        [self dismissProgressBar:@"发布完成"];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    count++;
    NSLog(@"info = %@",info);
    _videoImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];;
    [self.coverView setThumbImageName:_videoImage];
    
    
    [self dismissViewControllerAnimated:YES completion:^(void) {
    }];
}

- (void)theCoverViewWasTapped:(CoverView *)coverView{
    UIImagePickerController *pick = [[UIImagePickerController alloc]init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentViewController:pick animated:YES completion:^{
    }];
    
    pick.delegate = self;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:^(void) {
    }];
}

- (void) setProgressBarDefaultStyle
{
    if (arc4random()%(int)2)
    {
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleSwingLeft];
    }
    else
    {
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleSwingRight];
    }
}

- (void) updateProgressBarTitle:(NSString*)title status:(NSString*)status
{
    [MMProgressHUD updateTitle:title status:status];
}


- (void) dismissProgressBar:(NSString*)status{
    [MMProgressHUD dismissWithSuccess:status];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField isFirstResponder];
    
    if (textField.text.length != 0) {
        NSInteger intString =  _titleField.text.length;
        NSString *string = [[NSString alloc] initWithFormat:@"%zi/20",intString];
        _remindLabel.text = string;
    }
    if (textField.text.length >20) {
        [MBProgressHUD showError:@"请输入20字以内"];
        _titleField.text = @"";
        _remindLabel.text = @"0/20";
    }
    
    return YES;
}

//获取视频第一帧//默认图片
- (UIImage *)getVideoPreViewImage:(NSURL *)videoPath{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoPath options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    CMTime time = CMTimeMakeWithSeconds(1, 1);
    NSError *error = nil;
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *img = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    return img;
}


@end
