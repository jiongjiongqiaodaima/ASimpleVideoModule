//
//  DiscoverViewController.m
//  ZhongRenBang
//
//  Created by 看楼听雨 on 16/8/1.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "DiscoverViewController.h"
#import "Common.h"
#import "DiscoverMovieCell.h"
#import "UIColor+Tools.h"
#import "NSString+Additions.h"
#import "MJRefresh.h"
//#import "VideoPlayDetailsController.h"
#import "showViewController.h"
#import "DiscoverListDataModels.h"
//#import "LocalVideoEditViewController.h"
//#import "TZImagePickerController.h"
//#import "HJImagesToVideo.h"
//#import <ALBBQuPaiPlugin/ALBBQuPaiPlugin.h>
//#import "MMProgressHUD.h"
#import "CustomeCollectionViewLayout.h"
@interface DiscoverViewController ()
<
UITextViewDelegate,
UIAlertViewDelegate,
UIActionSheetDelegate,
UINavigationBarDelegate,
UICollectionViewDelegate,
UICollectionViewDataSource,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate,
>
{
    BOOL recorded;
    BOOL fromImg;
    UILabel * textviewLable;
    NSMutableArray *_selectedPhotos;
}

@property (nonatomic, weak) UICollectionView *mainCollectionView;
/**
 *  选择底图(最新 热门等...)
 */
@property (nonatomic, weak) UIView *headerView;
/**
 *  选中下划线
 */
@property (nonatomic, weak) UIView *lineView;
/**
 *  右侧按钮
 */
@property (nonatomic, weak) UIButton *rightBtn;

@property (nonatomic, strong)UIViewController *recordController;
@property (nonatomic, strong)UIImagePickerController *videoPicker;
@property (nonatomic, strong)NSURL *videoUrl;
@property (nonatomic, strong)NSMutableArray *assets;
@property (nonatomic, strong)NSMutableArray *dataAssets;
@property (nonatomic, strong) NSMutableArray *videos;
@property (nonatomic, strong)LocalVideoEditViewController *localVC;
@end

static NSString * const movieCellID = @"DiscoverMovieCell";
static CGFloat btnW;

@implementation DiscoverViewController
{
    /**
     *  上个按钮的tag值
     */
    NSInteger lastTag;
    /**
     *  当前页码
     */
    NSInteger page;
    /**
     *  是否为尾页
     */
    BOOL islastPage;
    DiscoverListBaseClass *bassClass;
}

- (NSMutableArray *)videos
{
    if (!_videos) {
        self.videos = [NSMutableArray array];
    }return _videos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self->navLeftBtn.hidden = YES;
    lastTag = 100;
    page = 1;
    [self createHeaderView];

    [self setNavTitle:@"发现"];
    [self createMainCollecionView];
    [self createRightBarButtonItem];
    
    [self loadDataWithTag:lastTag];
    [self.mainCollectionView.mj_header endRefreshing];
}

- (void)loadDataWithTag:(NSInteger)tag
{
    
    NSString *url = [ServerAddress stringByAppendingPathComponent:@"querylistvideo.action"];
    CGFloat latit  = [[[NSUserDefaults standardUserDefaults] objectForKey:@"latit"] floatValue];
    CGFloat longit = [[[NSUserDefaults standardUserDefaults] objectForKey:@"longit"] floatValue];
    NSString *city = [NSString getUserCity];

    NSString *type = nil;
    switch (lastTag - 100) {
        case 0:
            type = @"1";
            break;
            
        case 1:
            type = @"3";
            break;
            
        case 2:
            type = @"2";
            
            break;
            
        default:
            break;
    }
    NSDictionary *parameters = @{
                                   @"type" : type,
                                   @"lat2" : [NSNumber numberWithFloat:latit],
                                 @"longt2" : [NSNumber numberWithFloat:longit],
                                 @"pageNo" : [NSString stringWithFormat:@"%ld",(long)page],
                                  @"citys" : city
                                 };
    __weak typeof(self)weakSelf = self;
    [[ZRBNetWorking shareNewWorking] startPostRequest:url withParameters:parameters callBack:^(NSDictionary *responseObject) {
        [self closeLoadingView];
        if (page == 1) {
            [self.videos removeAllObjects];
            self.videos = nil;
        }
       bassClass  = [DiscoverListBaseClass modelObjectWithDictionary:responseObject];
        if (bassClass.messageHelper.list.count < 20) {
            islastPage = YES;
        }
        if (bassClass.messageHelper.list.count > 0) {
            [self.videos addObjectsFromArray:bassClass.messageHelper.list];
        }
        [weakSelf.mainCollectionView reloadData];
        NSLog(@"%@",responseObject);
    }];
}

- (void)loadNewData
{
    page = 1;
    islastPage = NO;
    [self showLoadingView];
    [self loadDataWithTag:lastTag];
    [self.mainCollectionView.mj_header endRefreshing];
    [self.mainCollectionView.mj_footer endRefreshing];
}

- (void)loadMoreData
{
    if (islastPage) {
        [self.mainCollectionView.mj_footer endRefreshingWithNoMoreData];
        return;
    }else
    {
        page++;
        [self showLoadingView];
        [self loadDataWithTag:lastTag];
    }
    [self.mainCollectionView.mj_header endRefreshing];
    [self.mainCollectionView.mj_footer endRefreshing];
}

- (void)createRightBarButtonItem
{
    self.rightBtn = [self buttonPhoto:@"discover_release" hilPhoto:nil rect:CGRectMake(ScreenWidth - 50, 20, 40, 44) title:nil select:@selector(choose_click) Tag:1 View:self.view textColor:[UIColor whiteColor] Size:font16 background:nil];
}

//UIButton
-(UIButton*)buttonPhoto:(NSString*)photo hilPhoto:(NSString*)Hphoto rect:(CGRect)rect  title:(NSString*)title  select:(SEL)sel Tag:(NSInteger)tag View:(UIView*)ViewA textColor:(UIColor*)textcolor Size:(UIFont*)size background:(UIColor *)background {
    UIButton* button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = rect;
    [button setImage:[UIImage imageNamed:photo] forState:UIControlStateNormal];
    [button addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    button.tag=tag;
    [button setTitleColor:textcolor forState:UIControlStateNormal];
    button.titleLabel.font=size;
    button.backgroundColor=background;
    
    [ViewA addSubview:button];
    return button;
}

- (void)createHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 40)];
    headerView.backgroundColor = [UIColor colorWithHexString:@"2e2b3f" alpha:1.0f];
    
    NSArray *array = @[@"最新",@"热门",@"附近"];
    CGFloat btnH = 35;
    btnW = ScreenWidth / 3;
    for (int i = 0; i < 3; i++) {
        UIButton *button = [self buttonWith:array[i] tag:i + 100 frame:CGRectMake(btnW * i, 2, btnW, btnH)];
        [headerView addSubview:button];
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, btnW, 1)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"FF4D77" alpha:1.0f];
    [headerView addSubview:lineView];
    [self.view addSubview:headerView];
    self.headerView = headerView;
    self.lineView = lineView;
}

- (UIButton *)buttonWith:(NSString *)title tag:(NSInteger)tag frame:(CGRect)rect
{
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = rect;
    if (tag == 100) {
        button.selected = YES;
    }
    [button setTitle:title forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor colorWithHexString:@"FF4D77" alpha:1.0f] forState:(UIControlStateSelected)];
    [button setTitleColor:[UIColor colorWithHexString:@"FFFFFF" alpha:1.0f] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    button.tag = tag;
    return button;
}

#pragma mark - buttonClick
-(void)buttonClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    NSInteger lastBtnTag = sender.tag;
    if (lastTag != lastBtnTag) {
        // 上个按钮改为未选中状态
        UIButton *button = [self.headerView viewWithTag:lastTag];
        button.selected = NO;
        
        lastTag = lastBtnTag;
        CGRect rect = self.lineView.frame;
        rect.origin.x = (lastTag - 100) * btnW;
        self.lineView.frame = rect;
        // 请求数据
        [self loadNewData];
    }
}

#pragma mark - 初始化
- (void)createMainCollecionView
{
    if (!_mainCollectionView) {
        
        CustomeCollectionViewLayout *layout = [[CustomeCollectionViewLayout alloc] init];

        UICollectionView *mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 104, ScreenWidth, ScreenHeight - 64 - 49 - 40) collectionViewLayout:layout];
        mainCollectionView.delegate = self;
        mainCollectionView.dataSource = self;
        mainCollectionView.backgroundColor = [UIColor colorWithHexString:@"2e2b3f" alpha:1.0f];
        [mainCollectionView registerNib:[UINib nibWithNibName:@"DiscoverMovieCell" bundle:nil] forCellWithReuseIdentifier:movieCellID];
        mainCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        mainCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        [self.view addSubview:mainCollectionView];
        self.mainCollectionView = mainCollectionView;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.videos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverMovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:movieCellID forIndexPath:indexPath];
    DiscoverListList *model = _videos[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    VideoPlayDetailsController *VC = [[VideoPlayDetailsController alloc] init];
    DiscoverListList *model = _videos[indexPath.row];

    VC.videoID = [NSString stringWithFormat:@"%.0f",model.listIdentifier];
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ---new
#pragma mark ---------------------------------从这开始就是视频相关的内容了
#pragma mark - UIAlertController For New Video
- (void)choose_click{
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"选择视频来源" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"从相机拍摄" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self initToShabi];
        NSLog(@"选取视频 相机");
        recorded = YES;
    }];
    
    UIAlertAction *picAction = [UIAlertAction actionWithTitle:@"从照片选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"选取图片 相册");
        [self pickPicturesOut];
        fromImg = YES;
    }];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self selectImageFromAlbum];
        NSLog(@"选取视频 相册");
        recorded = NO;
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVc addAction:cameraAction];
    [alertVc addAction:picAction];
    [alertVc addAction:photoAction];
    [alertVc addAction:cancelAction];
    [self presentViewController:alertVc animated:YES completion:nil];
}
#pragma mark - QupaiSDK init 录制视频功能模块
- (void)initToShabi{
    QupaiSDK *sdk = [QupaiSDK shared];
    [sdk setDelegte:(id<QupaiSDKDelegate>)self];
    /*可选设置*/
    sdk.thumbnailCompressionQuality = 0.8;//压缩图片比例
    sdk.combine = YES;//合成
    sdk.progressIndicatorEnabled = YES;//进度条显示字
    sdk.beautySwitchEnabled = YES;//美颜
    sdk.flashSwitchEnabled = YES;//闪光灯
    sdk.beautyDegree = 0.8;//美颜度
    sdk.tintColor = [UIColor colorWithRed:255/255.0 green:77/255.0 blue:119/255.0 alpha:1];//进度条颜色
    sdk.recordGuideEnabled = YES;//拍摄引导
    sdk.bottomPanelHeight = SCREEN_HEIGHT / 50 * 9;//底部高度
    sdk.cameraPosition = QupaiSDKCameraPositionBack;//默认后置摄像头
    /*基本设置*/
    CGSize videoSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    
    _recordController = [sdk createRecordViewControllerWithMinDuration:3
                                                           maxDuration:10
                                                               bitRate:800000
                                                             videoSize:videoSize];
    [self presentViewController:_recordController animated:YES completion:nil];
}
#pragma mark - QupaiSDK Delegate --------即时录制--------
//取消拍摄代理方法
- (void)qupaiSDKCancel:(QupaiSDK *)sdk{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self.recordController dismissViewControllerAnimated:YES completion:nil];
}
//完成拍摄代理方法
- (void)qupaiSDK:(QupaiSDK *)sdk compeleteVideoPath:(NSString *)videoPath thumbnailPath:(NSString *)thumbnailPath{
    NSLog(@"Qupai SDK compelete %@",videoPath);
    
    if (videoPath) {
        UISaveVideoAtPathToSavedPhotosAlbum(videoPath, nil, nil, nil);
    }
    
    if (thumbnailPath) {
        UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:thumbnailPath], nil, nil, nil);
    }
    
    [self saveVideo:videoPath thumbnail:thumbnailPath];
}

- (void)qupaiSDK:(QupaiSDK *)sdk packName:(NSString *)packName{
    [self dismissViewControllerAnimated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
    }];
    
    [[QupaiSDK shared] combinePackName:packName completionBlock:^(NSString *videoPath, NSError *error) {
        UISaveVideoAtPathToSavedPhotosAlbum(videoPath, nil, nil, nil);
        NSLog(@"Qupai SDK pack compelete %@",videoPath);
    }];
}

- (void)saveVideo:(NSString *)videoPath thumbnail:(NSString *)thumbnailPath {
    // 把视频从临时目录拷贝出来，因为下次录制时会清空临时目录。
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *testDirPath = [documentPath stringByAppendingPathComponent:@"Test"];
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:testDirPath]) {
        [fileMgr createDirectoryAtPath:testDirPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSString *testVideoPath = [testDirPath stringByAppendingPathComponent:[videoPath lastPathComponent]];
    [[NSFileManager defaultManager] copyItemAtPath:videoPath toPath:testVideoPath error:nil];
    
    NSString *testThumbnailPath = [testDirPath stringByAppendingPathComponent:[thumbnailPath lastPathComponent]];
    [[NSFileManager defaultManager] copyItemAtPath:thumbnailPath toPath:testThumbnailPath error:nil];
    
    [self pushToTheEditView:videoPath];
}
#pragma mark - 去到编辑页面
- (void)pushToTheEditView:(NSString *)path{
    if (!_localVC) {
        self.localVC = [[LocalVideoEditViewController alloc]init];
    }
    self.localVC.videoUrl = [NSURL URLWithString:path];
    //录制
    if (recorded == YES && fromImg == NO) {
        self.localVC.systemOrNot = YES;
        NSString *str = [NSString stringWithFormat:@"file://%@",path];
        self.localVC.videoUrl = [NSURL URLWithString:str];
        [self.recordController presentViewController:self.localVC animated:YES completion:nil];
        NSLog(@"进入编辑页面:实时拍摄");
    }
    //照片电影
    else if(fromImg == YES && self.localVC.videoUrl != nil) {
        NSString *str = [NSString stringWithFormat:@"file://%@",path];
        self.localVC.videoUrl = [NSURL URLWithString:str];
        [self presentViewController:self.localVC animated:YES completion:nil];
        NSLog(@"进入编辑页面:照片电影");
        fromImg = !fromImg;
    }
    //本地选取
    else{
        self.localVC.systemOrNot = NO;
        [self presentViewController:self.localVC animated:YES completion:nil];
    }
}
#pragma mark - localVideo     --------选择本地视频----------
- (void)selectImageFromAlbum{
    self.videoPicker = [[UIImagePickerController alloc]init];
    _videoPicker.delegate = self;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
    {
        _videoPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _videoPicker.videoMaximumDuration = MAXFLOAT;
        _videoPicker.mediaTypes = [[NSArray alloc] initWithObjects:(NSString*) kUTTypeMovie, (NSString*) kUTTypeVideo, (NSString*) kUTTypeMPEG4,(NSString*) kUTTypeMPEG4Audio,nil];
    }
    
    [self presentModalViewController:_videoPicker animated:YES];
}

#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    if (picker == _videoPicker) {
        _videoUrl = info[@"UIImagePickerControllerMediaURL"];
        if ([self getVideoDuration:_videoUrl] > kMaxRecordDuration)
        {
            NSString *ok = NSLocalizedString(@"ok", nil);
            NSString *error = NSLocalizedString(@"error", nil);
            NSString *fileLenHint = NSLocalizedString(@"fileLenHint", nil);
            NSString *seconds = NSLocalizedString(@"seconds", nil);
            NSString *hint = [fileLenHint stringByAppendingFormat:@" %d ", kMaxRecordDuration];
            hint = [hint stringByAppendingString:seconds];
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:error
                                                            message:hint
                                                           delegate:nil
                                                  cancelButtonTitle:ok
                                                  otherButtonTitles: nil];
            [alert show];
            return;
        }
        [_videoPicker dismissModalViewControllerAnimated:NO];
        [self pushToTheEditView:_videoUrl.absoluteString];
    }else{
        NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]){
        }else{
            //如果是视频
            NSURL *url = info[UIImagePickerControllerMediaURL];
            _videoUrl = url;
            //保存视频至相册（异步线程)
            NSString *urlStr = [url path];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
                    
                    UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
                }
            });
        }
    }
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (picker == _videoPicker) {
        [_videoPicker dismissModalViewControllerAnimated:NO];
    }else{
        [picker dismissModalViewControllerAnimated:YES];
    }
}
#pragma mark 视频保存完毕的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextIn {
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"视频保存成功.");
        [MBProgressHUD showSuccess:@"视频保存成功"];
    }
}
#pragma mark - picVideo //-------去相册选取合成为视频的图片(用来做图片视频的图片选择器)
- (void)pickPicturesOut{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.selectedAssets = _selectedPhotos; // optional, 可选的
    imagePickerVc.allowPickingOriginalPhoto = NO;
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.pickerDelegate = self;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark TZImagePickerControllerDelegate
/// User click cancel button
/// 用户点击了取消
- (void)TZimagePickerControllerDidCancel:(TZImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}
/// User finish picking photo，if assets are not empty, user picking original photo.
/// 用户选择好了图片，如果assets非空，则用户选择了原图。
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    [self makePicturesToVideo:_selectedPhotos];
    [picker dismissModalViewControllerAnimated:YES];
}

#pragma mark - 将图片合成为视频(图片视频)
- (void)makePicturesToVideo:(NSArray *)array{
    //    [MBProgressHUD showMessage:@"视频合成中"];
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:
                      [NSString stringWithFormat:@"Documents/photoMovie.mp4"]];
    [[NSFileManager defaultManager] removeItemAtPath:path error:NULL];
    
    
    [HJImagesToVideo videoFromImages:array
                              toPath:path
                   withCallbackBlock:^(BOOL success) {
                       [self setProgressBarDefaultStyle];
                       [self updateProgressBarTitle:GBLocalizedString(@"转换中") status:@"等待"];
                       
                       if (success) {
                           [self dismissProgressBar:@"成功"];
                           fromImg = YES;
                           NSURL *pathUrl = [NSURL URLWithString:path];
                           [self pushToTheEditView:pathUrl.absoluteString];
                       } else {
                           [self dismissProgressBar:@"失败"];
                       }
                   }];
}

#pragma mark --有些地方需要用到progress
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

- (void) updateProgressBarTitle:(NSString*)title status:(NSString*)status{
    [MMProgressHUD updateTitle:title status:status];
}

- (void) dismissProgressBar:(NSString *)status{
    [MMProgressHUD dismissWithSuccess:status];
}

#pragma mark --获取视频长度
- (CGFloat)getVideoDuration:(NSURL*)URL
{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:URL options:opts];
    float second = 0;
    second = urlAsset.duration.value/urlAsset.duration.timescale;
    
    return second;
}



@end
