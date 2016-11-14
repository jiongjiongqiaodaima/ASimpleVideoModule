//
//  LocalVideoEditViewController.m
//  ZhongRenBang
//
//  Created by 童臣001 on 16/6/28.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "LocalVideoEditViewController.h"
#import "FilterChooseView.h"
#import "SwitchLongView.h"
#import "Define.h"
#import "UIView+Tools.h"
#import "PBJVideoPlayerController.h"
#import <ALBBQuPaiPlugin/ALBBQuPaiPlugin.h>
#import "VideoEffect.h"
#import "ThemeScrollView.h"
#import "MMProgressHUD.h"
#import "VideoReleasedViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "ScrollSelectView.h"
#import "StickerView.h"
#import "UIAlertView+Blocks.h"
#import "ExportEffects.h"
#import "GPUImage.h"
#import "ThemeFilterScrollView.h"
#import "VideoEffectForFilter.h"

#define FilterViewHeight 95
#define iOS7AddStatusHeight (IOS7?20:0)
#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
#define BottomViewHeight 50.0
#define SelectViewHeight 50.0


@interface LocalVideoEditViewController ()<UIAlertViewDelegate,UIGestureRecognizerDelegate,UINavigationControllerDelegate,PBJVideoPlayerControllerDelegate,ThemeScrollViewDelegate,SwitchLongViewDelegate,ScrollSelectViewDelegate,ThemeFilterScrollViewScrollViewDelegate>{
    UIButton * _filterBegin;//完成编辑

    VideoEffectForFilter  *videoFilterEffects;

    //new
    NSURL* _videoPickURL;
    NSString* _mp4OutputPath;
    
    BOOL _hasVideo;
    BOOL _hasMp4;
    BOOL sound;
    
    BOOL gifPick;
    BOOL borderPick;
    
    BOOL filter;
    BOOL musicVideo;
}

@property(nullable,nonatomic,assign) id <UINavigationControllerDelegate,UIVideoEditorControllerDelegate> delegate;
@property (nonatomic        ) UIImagePickerControllerQualityType videoQuality;
@property (nonatomic, copy  ) NSString                 *videoPath;// 视频路径
@property (nonatomic        ) NSTimeInterval           videoMaximumDuration;

@property (nonatomic, strong) UIView                   *videoContentView;
@property (nonatomic, strong) PBJVideoPlayerController *videoPlayerController;
@property (nonatomic, strong) UIImageView              *playButton;
@property (nonatomic, strong) UIView                   *parentView;

@property (copy, nonatomic  ) NSURL                    * videoPickURL;
@property (copy, nonatomic  ) NSString                 * mp4OutputPath;
@property (nonatomic, assign) BOOL                     hasVideo;
@property (nonatomic, assign) BOOL                     hasMp4;
@property (nonatomic, assign) BOOL                     sound;
@property (nonatomic, strong) VideoEffect              *videoEffects;

@property (nonatomic, strong) ThemeFilterScrollView    *filterScrollView;
@property (nonatomic, strong) ThemeScrollView          *musicVedioScrollView;
@property (nonatomic, strong) ScrollSelectView         *gifView;
@property (nonatomic, strong) ScrollSelectView         *borderView;
@property (nonatomic, strong) UIScrollView             *contentView;
@property (nonatomic, strong) UIImageView              *borderImageView;
@property (nonatomic, strong) UITapGestureRecognizer   *tap;
//按钮
@property (nonatomic, strong) SwitchLongView           *filtersPick;//选择滤镜
@property (nonatomic, strong) SwitchLongView           *moviePick;//选择MV
@property (nonatomic, strong) SwitchLongView           *stickerPick;//选择贴纸
@property (nonatomic, strong) SwitchLongView           *framePick;//选择相框

@property (nonatomic, strong) NSMutableArray           *gifArray;
#pragma mark ---boder
@property (nonatomic, strong) UIScrollView             *bottomControlView;

@property (nonatomic, strong) NSMutableArray           *assets;
@property (nonatomic, strong) NSMutableDictionary      *evasionDataArray;
@property (nonatomic, strong) NSMutableDictionary      *evasionFilterArray;



- (NSInteger)getFileSize:(NSString*)path;
- (CGFloat)getVideoDuration:(NSURL*)URL;
- (NSString*)getOutputFilePath;

@end

@implementation LocalVideoEditViewController{
    UIButton *exitBtn;            //返回
    UIButton *completeBtn;        //确认
    UILabel  *editVideoLabel;     //编辑视频
    UIView   *floorView;          //下面的 父类视图
    UIButton *soundBtn;           //关闭原声
    
    UIView *viewContainer;        //下面的父类视图
    
    ThemesType lastMVEffect;
    ThemesFilterType lastFilterEffect;
    NSInteger count;
}
@synthesize videoPickURL = _videoPickURL;
@synthesize mp4OutputPath = _mp4OutputPath;
@synthesize hasVideo = _hasVideo;
@synthesize hasMp4 = _hasMp4;
@synthesize videoEffects = _videoEffects;
@synthesize sound = _sound;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        
    }
    return self;
}

- (id) init{
    if (self = [super init])
    {
        self.hasVideo = NO;
        self.hasMp4 = NO;
        self.videoPickURL = nil;
        self.mp4OutputPath = nil;
        self.sound = YES;
        count = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_applicationWillEnterForeground:) name:@"UIApplicationWillEnterForegroundNotification" object:[UIApplication sharedApplication]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_applicationDidEnterBackground:) name:@"UIApplicationDidEnterBackgroundNotification" object:[UIApplication sharedApplication]];
    }
    return self;
}

- (void)dealloc{
    _videoPlayerController = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.videoPickURL = self.videoUrl;
    //给视频添加相框等效果
    self.assets = [NSMutableArray arrayWithCapacity:1];
    //用来规避MV视频
    self.evasionDataArray = [[NSMutableDictionary alloc]initWithCapacity:1];
    //用来规避滤镜视频
    self.evasionFilterArray = [[NSMutableDictionary alloc]initWithCapacity:1];
    
    [self.assets addObject:self.videoUrl];
    
    self.mp4OutputPath = self.videoUrl.absoluteString;
    [self isTheTureUrl:self.mp4OutputPath];
    self.hasVideo = YES;
}

- (void)isTheTureUrl:(NSString *)outPutPath{
    NSString *str1 = [outPutPath substringToIndex:2];
    if (![str1 isEqualToString:@"f"]) {
      self.mp4OutputPath = [NSString stringWithFormat:@"file://%@",self.mp4OutputPath];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"进入视频编辑页面,获取到了视频的地址:%@",_videoUrl);
    [self initTheEditView:_mp4OutputPath];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_videoPlayerController removeFromParentViewController];
    _videoPlayerController = nil;
    [self stopAllVideo];
}
#pragma mark - 新建编辑页面视图
- (void)initTheEditView:(NSString *)videoPath{
    _videoContentView =  [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH + 4, SCREEN_HEIGHT / 4 * 3)];
    [self.view addSubview:_videoContentView];
    
    // Video player of destination
    _videoPlayerController = [[PBJVideoPlayerController alloc] init];
    _videoPlayerController.view.frame = _videoContentView.bounds;
    _videoPlayerController.view.clipsToBounds = YES;
    _videoPlayerController.videoView.videoFillMode = AVLayerVideoGravityResize;
    _videoPlayerController.delegate = self;
    [_videoContentView addSubview:_videoPlayerController.view];
    
    _playButton = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"play_button"]];
    _playButton.center = _videoPlayerController.view.center;
    [_videoPlayerController.view addSubview:_playButton];
    
    [self playDemoVideo:videoPath withinVideoPlayerController:_videoPlayerController];
    
    exitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    exitBtn.frame = CGRectMake(12, 25, SCREEN_WIDTH /10, SCREEN_WIDTH /10);
    [exitBtn setBackgroundColor:[UIColor whiteColor]];
    [exitBtn setBackgroundImage:[UIImage imageNamed:@"video_edit_back"] forState:UIControlStateNormal];
    [exitBtn makeCornerRadius:SCREEN_WIDTH / 20 borderColor:nil borderWidth:0];
    [exitBtn addTarget:self action:@selector(exit:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:exitBtn];
    
    completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [completeBtn setBackgroundColor:[UIColor whiteColor]];
    completeBtn.frame = CGRectMake(SCREEN_WIDTH - 12 - SCREEN_WIDTH / 10, 25, SCREEN_WIDTH /10, SCREEN_WIDTH /10);
    [completeBtn setBackgroundImage:[UIImage imageNamed:@"videoeditnext"] forState:UIControlStateNormal];
    [completeBtn addTarget:self action:@selector(filterBegin_click:) forControlEvents:UIControlEventTouchUpInside];
    [completeBtn makeCornerRadius:SCREEN_WIDTH / 20 borderColor:nil borderWidth:0];
    [self.view addSubview:completeBtn];
    
    
    editVideoLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 4, 20, SCREEN_WIDTH / 2, 38)];
    [editVideoLabel setFont:ZLSystemFontWithpx(38)];
    [editVideoLabel setTextColor:[UIColor whiteColor]];
    editVideoLabel.text = @"编辑视频";
    editVideoLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:editVideoLabel];
    
    //底部挡板
    floorView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT / 4 * 3, SCREEN_WIDTH, SCREEN_HEIGHT / 4)];
    floorView.backgroundColor = ZLColorFromRGB(0x1c1a2a);
    [self.view addSubview:floorView];
    
    //声音按钮
    soundBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    soundBtn.frame = CGRectMake(SCREEN_WIDTH - 12 - SCREEN_WIDTH / 10, SCREEN_WIDTH / 100 * 3, SCREEN_WIDTH /10, SCREEN_WIDTH /10);
    [soundBtn setBackgroundImage:[UIImage imageNamed:@"microphone"] forState:UIControlStateNormal];
    [soundBtn addTarget:self action:@selector(killTheSound:) forControlEvents:UIControlEventTouchUpInside];
    [soundBtn makeCornerRadius:SCREEN_WIDTH / 20 borderColor:nil borderWidth:0];
    [floorView addSubview:soundBtn];
    
    //划线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH / 100 * 16 - 1, SCREEN_WIDTH, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [floorView addSubview:lineView];
    
    //滤镜
    _filtersPick = [[SwitchLongView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 100 * 16, 0, SCREEN_WIDTH / 100 * 16, SCREEN_WIDTH / 100 * 16)];
    [_filtersPick setLabelText:@"滤镜" color:ZLColorFromRGB(0xff4d77) lineColor:ZLColorFromRGB(0xff4d77)];
    _filtersPick.tag = 1001;
    _filtersPick.delegate = self;
    [floorView addSubview:_filtersPick];
    
    //MV
    _moviePick = [[SwitchLongView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH / 100 * 16, SCREEN_WIDTH / 100 * 16)];
    _moviePick.tag = 1002;
    _moviePick.delegate = self;
    [_moviePick setLabelText:@"MV" color:ZLColorFromRGB(0xffffff) lineColor:nil];
    [floorView addSubview:_moviePick];
    
    //贴纸
    _stickerPick = [[SwitchLongView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH / 100 * 32, 0, SCREEN_WIDTH / 100 * 16, SCREEN_WIDTH/ 100 * 16)];
    _stickerPick.tag = 1003;
    _stickerPick.delegate = self;
    [_stickerPick setLabelText:@"贴纸" color:ZLColorFromRGB(0xffffff) lineColor:nil];
    [floorView addSubview:_stickerPick];
    //
    //相框
    _framePick = [[SwitchLongView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/ 100 * 48, 0, SCREEN_WIDTH/ 100 * 16, SCREEN_WIDTH/ 100 * 16)];
    _framePick.tag = 1004;
    _framePick.delegate = self;
    [_framePick setLabelText:@"相框" color:ZLColorFromRGB(0xffffff) lineColor:nil];
    [floorView addSubview:_framePick];
    
    //滤镜
    _filterScrollView = [[ThemeFilterScrollView alloc] initWithFrame:CGRectMake(0, SCREEN_WIDTH / 100 * 16 + 2, SCREEN_WIDTH, SCREEN_HEIGHT / 4 - SCREEN_WIDTH / 100 * 16)];
    _filterScrollView.backgroundColor = [UIColor clearColor];
    [floorView addSubview:_filterScrollView];
    [self.filterScrollView setDelegate:self];
    [self.filterScrollView setCurrentSelectedItem:0];
    [self.filterScrollView scrollToItemAtIndex:0];
    
    //MV
    _musicVedioScrollView = [[ThemeScrollView alloc]initWithFrame:CGRectMake(0, SCREEN_WIDTH / 100 * 16 + 2, SCREEN_WIDTH, SCREEN_HEIGHT / 4 - SCREEN_WIDTH / 100 * 16)];
    _musicVedioScrollView.backgroundColor = [UIColor clearColor];
    [floorView addSubview:_musicVedioScrollView];
    _musicVedioScrollView.hidden = YES;
    [self.musicVedioScrollView setDelegate:self];
    [self.musicVedioScrollView setCurrentSelectedItem:0];
    [self.musicVedioScrollView scrollToItemAtIndex:0];
    
    //gif
    _gifView = [[ScrollSelectView alloc] initWithFrameFromGif:CGRectMake(0, SCREEN_WIDTH / 100 * 16 + 2, SCREEN_WIDTH, SCREEN_HEIGHT / 4 - SCREEN_WIDTH / 100 * 16)];
    _gifView.delegateSelect = self;
    [floorView addSubview:_gifView];
    _gifView.hidden = YES;
    
    //相框
    _borderView = [[ScrollSelectView alloc] initWithFrameFromBorder:CGRectMake(0, SCREEN_WIDTH / 100 * 16 + 2, SCREEN_WIDTH, SCREEN_HEIGHT / 4 - SCREEN_WIDTH / 100 * 16)];
    _borderView.delegateSelect = self;
    [floorView addSubview:_borderView];
    _borderView.hidden = YES;
}
#pragma mark ----------视频播放相关----------
- (void) playMp4Video{
    if (!_hasMp4)
    {
        NSLog(@"Mp4 file not found!");
        return;
    }
    
    NSLog(@"%@",[NSString stringWithFormat:@"正在播放的文件路径为:%@", _mp4OutputPath]);
    
    [self showVideoPlayView:TRUE];
    _videoPlayerController.videoPath = _mp4OutputPath;
    [_videoPlayerController playFromBeginning];
}

- (void)showVideoPlayView:(BOOL)show{
    if (show)
    {
        _playButton.hidden = NO;
        _videoPlayerController.view.hidden = NO;
    }
    else
    {
        _playButton.hidden = YES;
        _videoPlayerController.view.hidden = YES;
    }
}
#pragma mark - playDemoVideo//播放视频
- (void)playDemoVideo:(NSString*)inputVideoPath withinVideoPlayerController:(PBJVideoPlayerController*)videoPlayerController{
    dispatch_async(dispatch_get_main_queue(), ^{
        videoPlayerController.videoPath = inputVideoPath;
        [videoPlayerController playFromBeginning];
    });
}
#pragma mark - StopAllVideo//关闭视频播放
- (void)stopAllVideo{
    if (_videoPlayerController.playbackState == PBJVideoPlayerPlaybackStatePlaying)
    {
        [_videoPlayerController stop];
    }
}
#pragma mark - reCalc on the basis of video size & view size//计算视频大小的基础上与视图的大小
- (void)reCalcVideoSize:(NSString *)videoPath{
    CGFloat statusBarHeight = iOS7AddStatusHeight;
    CGSize sizeVideo = [self reCalcVideoViewSize:videoPath];
    _videoContentView.frame =  CGRectMake(CGRectGetMidX(self.view.frame) - sizeVideo.width/2, CGRectGetMidY(self.view.frame) - sizeVideo.height/2 + statusBarHeight, sizeVideo.width, sizeVideo.height);
    _videoPlayerController.view.frame = CGRectMake(0, 0, SCREEN_WIDTH + 4, SCREEN_HEIGHT / 4 * 3);
    _playButton.center = _videoPlayerController.view.center;
}
- (CGSize)reCalcVideoViewSize:(NSString *)videoPath{
    CGSize resultSize = CGSizeZero;
    if (isStringEmpty(videoPath))
    {
        return resultSize;
    }
    
    UIImage *videoFrame = getImageFromVideoFrame(getFileURL(videoPath), kCMTimeZero);
    if (!videoFrame || videoFrame.size.height < 1 || videoFrame.size.width < 1)
    {
        return resultSize;
    }
    
    NSLog(@"reCalcVideoViewSize: %@, width: %f, height: %f", videoPath, videoFrame.size.width, videoFrame.size.height);
    
    CGFloat statusBarHeight = 0; //iOS7AddStatusHeight;
    CGFloat navHeight = 0; //CGRectGetHeight(self.navigationController.navigationBar.bounds);
    CGFloat gap = 15;
    CGFloat height = CGRectGetHeight(self.view.frame) - navHeight - statusBarHeight - 2*gap;
    CGFloat width = CGRectGetWidth(self.view.frame) - 2*gap;
    if (height < width)
    {
        width = height;
    }
    else if (height > width)
    {
        height = width;
    }
    CGFloat videoHeight = videoFrame.size.height, videoWidth = videoFrame.size.width;
    CGFloat scaleRatio = videoHeight/videoWidth;
    CGFloat resultHeight = 0, resultWidth = 0;
    if (videoHeight <= height && videoWidth <= width)
    {
        resultHeight = videoHeight;
        resultWidth = videoWidth;
    }
    else if (videoHeight <= height && videoWidth > width)
    {
        resultWidth = width;
        resultHeight = height*scaleRatio;
    }
    else if (videoHeight > height && videoWidth <= width)
    {
        resultHeight = height;
        resultWidth = width/scaleRatio;
    }
    else
    {
        if (videoHeight < videoWidth)
        {
            resultWidth = width;
            resultHeight = height*scaleRatio;
        }
        else if (videoHeight == videoWidth)
        {
            resultWidth = width;
            resultHeight = height;
        }
        else
        {
            resultHeight = height;
            resultWidth = width/scaleRatio;
        }
    }
    
    resultSize = CGSizeMake(resultWidth, resultHeight);
    return resultSize;
}
#pragma mark ------------UI界面中一些按钮以及手势的响应方法
//
- (void)exit:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//滚去发布页(在这加个发布之前加水印的功能)
- (void)filterBegin_click:(UIButton *)sender{
    //1.首先先新建发布页
    VideoReleasedViewController *videoVC = [[VideoReleasedViewController alloc]init];

    //2.判断:如果MV效果和滤镜选择的是原本的效果
    if (lastFilterEffect == kThemeFilterNone && lastMVEffect == kThemeNone) {
        //并且没有选择过贴纸和边框
        if(borderPick == NO && gifPick == NO){
            //那么就将原本的视频传过去
            videoVC.videoUrl = self.videoUrl;
        }else{
            ThemesType curThemeType = kThemeCustom;
            //既然添加了贴纸与边框,就要走处理方法获得处理后的视频地址
            [self handleConvert:curThemeType];
            return;
        }
        //有滤镜和MV效果的话
    }else{
        if(borderPick == NO && gifPick == NO){
            NSLog(@"%@",[NSURL URLWithString:_mp4OutputPath]);
            NSString *str = [_mp4OutputPath substringToIndex:1];
            if (![str isEqualToString:@"f"]) {
                _mp4OutputPath = [NSString stringWithFormat:@"file://%@",_mp4OutputPath];
            }
            videoVC.videoUrl = [NSURL URLWithString:_mp4OutputPath];
        }else{
            ThemesType curThemeType = kThemeCustom;
            //既然添加了贴纸与边框,就要走处理方法获得处理后的视频地址
            [self handleConvert:curThemeType];
            return;
        }
    }
    NSURL *addWaterUrl = videoVC.videoUrl;
    NSLog(@"%@",addWaterUrl);
    
    [self presentViewController:videoVC animated:YES completion:nil];
}
//开关声音
- (void)killTheSound:(UIButton *)sender{
    if (_sound == YES) {//关闭原音
        _videoPlayerController.player.volume = 0.0;
        [soundBtn setBackgroundImage:[UIImage imageNamed:@"uncheck_microphone"] forState:UIControlStateNormal];
    }else{//开启原音
        _videoPlayerController.player.volume = 1.0;
        [soundBtn setBackgroundImage:[UIImage imageNamed:@"microphone"] forState:UIControlStateNormal];
    }
    _sound = !_sound;
}
//清除特效按钮选中效果
- (void)switchViewClear{
    [_filtersPick setLabelText:@"滤镜" color:ZLColorFromRGB(0xffffff) lineColor:nil];
    [_moviePick setLabelText:@"MV" color:ZLColorFromRGB(0xffffff) lineColor:nil];
    [_stickerPick setLabelText:@"贴纸" color:ZLColorFromRGB(0xffffff) lineColor:nil];
    [_framePick setLabelText:@"相框" color:ZLColorFromRGB(0xffffff) lineColor:nil];
}
//
- (void)switchEffectViewClear{
    _musicVedioScrollView.hidden = YES;
    _filterScrollView.hidden = YES;
    _borderView.hidden = YES;
    _gifView.hidden = YES;
    gifPick = NO;
    borderPick = NO;
}
//下方选择特效回调
- (void)theSwitchLongViewWasTapped:(SwitchLongView *)coverView{
    [self switchViewClear];
    [self switchEffectViewClear];

    switch (coverView.tag) {
        case 1001:{
//            [self removeContentView];
            [_filtersPick setLabelText:@"滤镜" color:ZLColorFromRGB(0xff4d77) lineColor:ZLColorFromRGB(0xff4d77)];
            _filterScrollView.hidden = NO;
            break;
        }
        case 1002:{
//            [self removeContentView];
            [_moviePick setLabelText:@"MV" color:ZLColorFromRGB(0xff4d77) lineColor:ZLColorFromRGB(0xff4d77)];
            _musicVedioScrollView.hidden = NO;
            break;
        }
        case 1003:{
            [self createContentViewtype];
            [_stickerPick setLabelText:@"贴纸" color:ZLColorFromRGB(0xff4d77) lineColor:ZLColorFromRGB(0xff4d77)];
            [self weNeedCanTapBorderView];
            _gifView.hidden = NO;
            break;
        }
        case 1004:{
            [self createContentViewtype];
            [_framePick setLabelText:@"相框" color:ZLColorFromRGB(0xff4d77) lineColor:ZLColorFromRGB(0xff4d77)];
            [self weNeedCanTapBorderView];
            _borderView.hidden = NO;
            
            break;
        }
        default:
            break;
    }
}

- (void)weNeedCanTapBorderView{
    if (!_tap) {
        self.tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAndPlay)];
    }
    [_borderImageView addGestureRecognizer:_tap];
}

#pragma mark - PBJVideoPlayerControllerDelegate 视频播放代理
- (void)videoPlayerReady:(PBJVideoPlayerController *)videoPlayer{
    
}

- (void)videoPlayerPlaybackStateDidChange:(PBJVideoPlayerController *)videoPlayer{
    
}

- (void)videoPlayerPlaybackWillStartFromBeginning:(PBJVideoPlayerController *)videoPlayer{
    if (videoPlayer == _videoPlayerController)
    {
        _playButton.alpha = 1.0f;
        _playButton.hidden = NO;
        
        [UIView animateWithDuration:0.1f animations:^{
            _playButton.alpha = 0.0f;
        } completion:^(BOOL finished)
         {
             _playButton.hidden = YES;
         }];
    }
}

- (void)videoPlayerPlaybackDidEnd:(PBJVideoPlayerController *)videoPlayer{
    if (videoPlayer == _videoPlayerController)
    {
        _playButton.hidden = NO;
        
        [UIView animateWithDuration:0.1f animations:^{
            _playButton.alpha = 1.0f;
        } completion:^(BOOL finished)
         {
             
         }];
    }
}
#pragma mark -----通知-----
- (void)_applicationWillEnterForeground:(NSNotification *)notification{
    NSLog(@"applicationWillEnterForeground");
    
    [self.videoEffects resume];
    [videoFilterEffects resume];
    
    // Resume play
    if (_videoPlayerController.playbackState == PBJVideoPlayerPlaybackStatePaused)
    {
        [_videoPlayerController playFromCurrentTime];
    }
    
    [self dismissProgressBar:@"Failed!"];
    
    // Show themes
    if (_hasVideo)
    {
        
    }
}

- (void)tapAndPlay{
    if (_videoPlayerController.playbackState == PBJVideoPlayerPlaybackStatePaused)
    {
        [_videoPlayerController playFromCurrentTime];
    }else if( _videoPlayerController.playbackState == PBJVideoPlayerPlaybackStatePlaying){
        [_videoPlayerController pause];
    }else{
        [_videoPlayerController playFromBeginning];
    }
    
}

- (void)_applicationDidEnterBackground:(NSNotification *)notification{
    NSLog(@"applicationDidEnterBackground");
    
    [self.videoEffects pause];
    [videoFilterEffects pause];
    
    // Pause play
    if (_videoPlayerController.playbackState == PBJVideoPlayerPlaybackStatePlaying)
    {
        [_videoPlayerController pause];
    }
}
#pragma mark - Progress callback
- (void)retrievingProgressFilter:(id)progress{
    if (progress && [progress isKindOfClass:[NSNumber class]])
    {
        NSString *title = NSLocalizedString(@"滤镜", nil);
        [self updateProgressBarTitle:title status:[NSString stringWithFormat:@"%d%%", (int)([progress floatValue] * 100)]];
    }
}

- (void)retrievingProgressMP4:(id)progress{
    if (progress && [progress isKindOfClass:[NSNumber class]])
    {
        NSString *title = NSLocalizedString(@"特效", nil);
        [self updateProgressBarTitle:title status:[NSString stringWithFormat:@"%d%%", (int)([progress floatValue] * 100)]];
    }
}
#pragma mark -----hud相关-----
- (void) showProgressBar:(NSString*)title status:(NSString*)status{
    if (arc4random()%(int)2)
    {
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleSwingLeft];
    }
    else
    {
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleSwingRight];
    }
    
    // Cancelable
    MMProgressHUD *hud = [MMProgressHUD sharedHUD];
    hud.confirmationMessage = @"Cancel?";
    hud.cancelBlock = ^{
        NSLog(@"Task was cancelled!");
    };
}

- (void) setProgressBarDefaultStyle{
    if (arc4random()%(int)2)
    {
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleSwingLeft];
    }
    else
    {
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleSwingRight];
    }
}

- (void) updateProgress:(CGFloat)value{
    [MMProgressHUD updateProgress:value];
}

- (void) updateProgressBarTitle:(NSString*)title status:(NSString*)status{
    [MMProgressHUD updateTitle:title status:status];
}

- (void) dismissProgressBarbyDelay:(NSTimeInterval)delay{
    [MMProgressHUD dismissAfterDelay:delay];
}

- (void) dismissProgressBar:(NSString*)status{
    [MMProgressHUD dismissWithSuccess:status];
}
#pragma mark ------AVAsset出口MP4
- (void)AVAssetExportMP4SessionStatusFailed:(id)object{
    NSString *failed = NSLocalizedString(@"failed", nil);
    [self dismissProgressBar:failed];
    
    // Dispose memory
    [self.videoEffects clearAll];
    [videoFilterEffects clearAll];
    
    NSString *ok = NSLocalizedString(@"ok", nil);
    NSString *msgFailed =  NSLocalizedString(@"转换失败", nil);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:failed message:msgFailed
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:ok, nil];
    [alert show];
}

- (void)AVAssetExportMP4SessionStatusCompleted:(id)object{
    // Dispose memory
    [self.videoEffects clearAll];
    [videoFilterEffects clearAll];
    self.hasMp4 = YES;
    
    NSLog(@"最终输出路径为:%@",self.mp4OutputPath);
    _mp4OutputPath = [NSString stringWithFormat:@"file://%@",_mp4OutputPath];
    NSLog(@"最终输出路径或者为:%@",_mp4OutputPath);
    NSString *success = NSLocalizedString(@"转换成功", nil);
    [self dismissProgressBar:success];
    [self playMp4Video];
}

- (void)AVAssetExportMP4ToAlbumStatusCompleted:(id)object{
    [self.videoEffects clearAll];
    [videoFilterEffects clearAll];

    NSString *success = NSLocalizedString(@"完成", nil);
    NSString *msgSuccess =  NSLocalizedString(@"转码完成", nil);
    NSString *ok = NSLocalizedString(@"确认", nil);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:success message:msgSuccess
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:ok, nil];
    [alert show];
}

- (void)AVAssetExportMP4ToAlbumStatusFailed:(id)object{
    [self.videoEffects clearAll];
    [videoFilterEffects clearAll];

    NSString *failed = NSLocalizedString(@"失败", nil);
    NSString *msgFailed =  NSLocalizedString(@"转码失败", nil);
    NSString *ok = NSLocalizedString(@"确认", nil);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: failed message:msgFailed
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:ok, nil];
    [alert show];
}
#pragma mark 点击选择MV
- (void)themeScrollView:(ThemeScrollView *)themeScrollView didSelectMaterial:(VideoThemes *)videoTheme{
    NSLog(@"准备添加效果");
    if(themeScrollView == _musicVedioScrollView){
        //MV
        ThemesType curThemeType = kThemeNone;
        
        if ((NSNull*)videoTheme != [NSNull null]){
            curThemeType = (ThemesType)videoTheme.ID;
            lastMVEffect = (ThemesType)videoTheme.ID;
        }
        
        if (curThemeType == kThemeNone){
            NSLog(@"目前视频没有特效");
            return;
        }
        
        if (!_videoPickURL && !(_videoPickURL.absoluteString.length > 0)){
            NSLog(@"该视频地址无效");
            return;
        }else{
            
            // 添加progress
            [self setProgressBarDefaultStyle];
            [self updateProgressBarTitle:@"处理中" status:@""];
            
            // 暂停播放
            if (_videoPlayerController.playbackState == PBJVideoPlayerPlaybackStatePlaying){
                [_videoPlayerController pause];
            }
            
            // 添加效果
            [self buildVideoEffect:curThemeType];
        }
    }
}
#pragma mark 点击选择滤镜
- (void)themeFilterScrollView:(ThemeFilterScrollView *)themeScrollView didSelectMaterial:(VideoThemes *)material{
    
    if(themeScrollView == _filterScrollView){
        //MV
        ThemesFilterType curThemeType = kThemeFilterNone;
        if ((NSNull*)material != [NSNull null]){
            curThemeType = (ThemesFilterType)material.ID;
            lastFilterEffect = (ThemesFilterType)material.ID;
        }
        
        if (curThemeType == kThemeFilterNone){
            NSLog(@"目前视频没有特效");
            return;
        }
        
        if (!_videoPickURL && !(_videoPickURL.absoluteString.length > 0)){
            NSLog(@"该视频地址无效");
            return;
        }else{
            
            // 添加progress
            [self setProgressBarDefaultStyle];
            [self updateProgressBarTitle:@"处理中" status:@""];
            
            // 暂停播放
            if (_videoPlayerController.playbackState == PBJVideoPlayerPlaybackStatePlaying){
                [_videoPlayerController pause];
            }
            
            // 添加效果
            [self buildVideoFilterEffect:curThemeType];
        }
    }
}
#pragma mark 添加为MV准备的特效
- (void) buildVideoEffect:(ThemesType)curThemeType{
    _mp4OutputPath = [self getOutputFilePath];

    NSString *str = [[VideoThemesData sharedInstance]myTypeName:curThemeType];
    NSString *videoPath = [self.evasionDataArray objectForKey:str];
    if (videoPath) {
        //该处播放对应的Mp4即可
        [self dismissProgressBar:@"完成"];
        NSLog(@"%@",videoPath);
        _mp4OutputPath = videoPath;
        
        [self playMp4Video];
        
        [self.assets removeAllObjects];
        [self.assets addObject:[NSString stringWithFormat:@"file://%@",_mp4OutputPath]];
        
        return;
    }else{
        //如果没有那么将其加入即可
        [self.evasionDataArray setValue:_mp4OutputPath forKey:str];
    }
    
    
    
    //判断是否有选择特效
    if (self.videoEffects)
    {//有就置为空
        self.videoEffects = nil;
    }
    //重新创建特效
    if (!self.videoEffects) {
        self.videoEffects = [[VideoEffect alloc] initWithDelegate:self];
    }
    self.videoEffects.themeCurrentType = curThemeType;
    
    
    NSLog(@"输出路径为:%@",self.mp4OutputPath);
    NSLog(@"选择的视频路径为:%@",self.videoPickURL);
    
    [self.videoEffects buildVideoBeautify:self.mp4OutputPath inputVideoURL:self.videoUrl fromSystemCamera:self.systemOrNot];
    [self.assets removeAllObjects];
    [self.assets addObject:[NSString stringWithFormat:@"file://%@",self.mp4OutputPath]];

}
#pragma mark 添加为滤镜准备的特效
- (void) buildVideoFilterEffect:(ThemesFilterType)curThemeType{
    _mp4OutputPath = [self getOutputFilterFilePath];
    NSString *str = [[VideoFilterData sharedInstance]myName:curThemeType];
    NSString *videoPath = [self.evasionFilterArray objectForKey:str];
    if (videoPath) {
        //该处播放对应的Mp4即可
        [self dismissProgressBar:@"完成"];
        NSLog(@"%@",videoPath);
        _mp4OutputPath = videoPath;
        
        [self playMp4Video];
        
        [self.assets removeAllObjects];
        [self.assets addObject:[NSString stringWithFormat:@"file://%@",_mp4OutputPath]];
        
        return;
    }else{
        //如果没有那么将其加入即可
        [self.evasionFilterArray setValue:_mp4OutputPath forKey:str];
        
    }
    
    
    
    //判断是否有选择特效
    if (videoFilterEffects)
    {//有就置为空
        videoFilterEffects = nil;
    }
    
    //重新创建特效
    if (!videoFilterEffects) {
        videoFilterEffects = [[VideoEffectForFilter alloc] initWithDelegate:self];
    }
    videoFilterEffects.themeCurrentType = curThemeType;
    
    NSLog(@"输出路径为:%@",self.mp4OutputPath);
    NSLog(@"选择的视频路径为:%@",self.videoPickURL);
    
    [videoFilterEffects buildVideoBeautifyFilter:self.mp4OutputPath andInputVideoURL:self.videoUrl fromSystemCamera:self.systemOrNot];

    
    [self.assets removeAllObjects];
    [self.assets addObject:[NSString stringWithFormat:@"file://%@",self.mp4OutputPath]];
}

#pragma mark ---------------personal methon
#pragma mark  获取视频的秒数
- (CGFloat)getVideoDuration:(NSURL*)URL{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:URL options:opts];
    float second = 0;
    second = urlAsset.duration.value/urlAsset.duration.timescale;
    
    return second;
}
#pragma mark 生成输出文件的地址
- (NSString*)getOutputFilePath{
    NSString *path = [NSString stringWithFormat:@"outputMovie%ld.mp4",(long)count];
    count++;
    NSString* mp4OutputFile = [NSTemporaryDirectory() stringByAppendingPathComponent:path];
    
    return mp4OutputFile;
}

- (NSString*)getOutputFilterFilePath{
    NSString *path = [NSString stringWithFormat:@"outputFilterMovie%ld.mp4",(long)count];
    count++;
    NSString* mp4OutputFile = [NSTemporaryDirectory() stringByAppendingPathComponent:path];
    
    return mp4OutputFile;
}

#pragma mark 获取置顶路径的视频大小
- (NSInteger)getFileSize:(NSString*)path{
    NSFileManager * filemanager = [[NSFileManager alloc]init];
    if([filemanager fileExistsAtPath:path])
    {
        NSDictionary * attributes = [filemanager attributesOfItemAtPath:path error:nil];
        NSNumber *theFileSize;
        if ( (theFileSize = [attributes objectForKey:NSFileSize]) )
            return  [theFileSize intValue]/1024;
        else
            return -1;
    }
    else
    {
        return -1;
    }
}

#pragma mark  保存到本地方法
- (void)save_to_photosAlbum:(NSString *)path{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(path)) {
            
            UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        }
    });
}
#pragma mark  视频保存完毕的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextIn {
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
        [MMProgressHUD showWithTitle:@"视频保存成功"];
    }
}
#pragma mark -----贴纸与边框的对应方法们-----
#pragma mark --添加贴纸View和边框View ⭐️
- (void)createContentViewtype{
    [completeBtn removeFromSuperview];
    [exitBtn removeFromSuperview];
    if (!_contentView) {
        self.contentView =  [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 4 * 3)];
        _contentView.userInteractionEnabled = YES;
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:_contentView];
    }
    
    if (!_borderImageView) {
        // Border
        _borderImageView = [[UIImageView alloc] initWithFrame:_contentView.frame];
        [_borderImageView setBackgroundColor:[UIColor clearColor]];
        _borderImageView.userInteractionEnabled = YES;
        [self.view addSubview:_borderImageView];
    }
    [self.view addSubview:completeBtn];
    [self.view addSubview:exitBtn];
}
#pragma mark --将贴纸和边框干掉.
- (void)removeContentView{
    
    [self.contentView removeFromSuperview];
    self.contentView = nil;
    
    [self.borderImageView removeFromSuperview];
    self.borderImageView = nil;
}
#pragma mark - 选中贴纸响应
- (void)didSelectedGifIndex:(NSInteger)styleIndex{
    gifPick = YES;
    _borderImageView.userInteractionEnabled = NO;
    NSLog(@"didSelectedGifIndex: %ld", (long)styleIndex);
    
    [self createEmbededGifStickerView:styleIndex];
}

#pragma mark - 往贴纸view上加stickerview
- (void)createEmbededGifStickerView:(NSInteger)styleIndex{
    NSString *imageName = [NSString stringWithFormat:@"paper%lu.@3x.png", (long)styleIndex];
    StickerView *view = [[StickerView alloc] initWithFilePath:getFilePath(imageName)];
    CGFloat ratio = MIN( (0.3 * _contentView.width) / view.width, (0.3 * _contentView.height) / view.height);
    [view setScale:ratio];
    CGFloat gap = 50;
    view.center = CGPointMake(_contentView.width/2 - gap, _contentView.height/2 - gap);
    [_contentView addSubview:view];
    
    [StickerView setActiveStickerView:view];
    
    if (!_gifArray)
    {
        _gifArray = [NSMutableArray arrayWithCapacity:1];
    }
    [_gifArray addObject:view];
    
    [view setDeleteFinishBlock:^(BOOL success, id result) {
        if (success)
        {
            if (_gifArray && [_gifArray count] > 0)
            {
                if ([_gifArray containsObject:result])
                {
                    [_gifArray removeObject:result];
                }
            }
        }
    }];
    
    [[ExportEffects sharedInstance]setGifArray:_gifArray];
}

#pragma mark ---border method  添加边框的点击响应方法
- (void)didSelectedBorderIndex:(NSInteger)styleIndex
{
    borderPick = YES;
    NSLog(@"didSelectedBorderIndex: %ld", (long)styleIndex);
    
    NSString *imageName = [NSString stringWithFormat:@"border_%ld",(long)styleIndex];
    UIImage *image = [UIImage imageNamed:imageName];
    [_borderImageView setImage:image];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:imageName forKey:@"imageName"];
    
    NSString *videoBorder = [[VideoThemesData sharedInstance]getVideoBorderByIndex:(int)styleIndex];
    [[[VideoThemesData sharedInstance]getThemeByType:kThemeCustom]setImageVideoBorder:videoBorder];
}

#pragma mark ----超强方法.将处理过的视频合成
- (void)handleConvert:(ThemesType)curThemeType
{
    if (![self getNextStepRunCondition]){
        NSString *message = nil;
        message = GBLocalizedString(@"视频文件为空");
        showAlertMessage(message, nil);
        return;
    }
    
    [MMProgressHUD updateTitle:@"转码中" status:nil];
    
    [StickerView setActiveStickerView:nil];
    
    if (_gifArray && [_gifArray count] > 0){
        for (StickerView *view in _gifArray)
        {
            [view setVideoContentRect:_contentView.frame];
        }
    }
    
    //告诉我加了什么背景!!!
    [[ExportEffects sharedInstance]setThemeCurrentType:curThemeType];
    [[ExportEffects sharedInstance]setExportProgressNewBlock: ^(NSNumber *percentage, NSString *title) {
        // Export progress
        NSString *content = GBLocalizedString(@"保存视频");
        if (!isStringEmpty(title))
        {
            content = title;
        }
    }];
    
    [[ExportEffects sharedInstance] setFinishVideoBlock: ^(BOOL success, id result) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (success)
            {
                [MMProgressHUD dismissWithSuccess:@"成功"];
            }
            else
            {
                [MMProgressHUD dismissWithSuccess:@"失败."];
                NSLog(@"FUCKINGFailed");
            }
            // Alert
            NSString *ok = GBLocalizedString(@"OK");
            [UIAlertView showWithTitle:nil
                               message:result
                     cancelButtonTitle:ok
                     otherButtonTitles:nil
                              tapBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
                                  
                                  if (buttonIndex == [alertView cancelButtonIndex])
                                  {
                                      NSLog(@"Alert Cancelled");
                                      
                                      [NSThread sleepForTimeInterval:0.5];
                                      
                                      // Demo result video
                                      if (!isStringEmpty([ExportEffects sharedInstance].filenameBlock()))
                                      {
                                          _mp4OutputPath = [ExportEffects sharedInstance].filenameBlock();
                                          
                                          VideoReleasedViewController *videoVC = [[VideoReleasedViewController alloc]init];
                                          
                                          NSLog(@"%@",[NSURL URLWithString:_mp4OutputPath]);
                                          
                                          videoVC.videoUrl = [NSURL URLWithString:[NSString stringWithFormat:@"file://%@",_mp4OutputPath]];
                                          
                                          [self presentViewController:videoVC animated:YES completion:nil];
                                      }
                                  }
                              }];
        });
    }];
    [[ExportEffects sharedInstance]addEffectToVideo:self.assets];
    [MMProgressHUD dismiss];
}
//判断视频文件是否在
- (BOOL)getNextStepRunCondition
{
    BOOL result = FALSE;
    if (_mp4OutputPath)
    {
        result = TRUE;
    }
    return result;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

- (BOOL)shouldAutorotate{
    return NO;
}

@end
