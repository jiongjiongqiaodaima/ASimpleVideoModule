//
//  VideoPlayDetailsController.m
//  ZhongRenBang
//
//  Created by 看楼听雨 on 16/7/31.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "VideoPlayDetailsController.h"
#import "VideoPlayDetailsIntroduceCell.h"
#import "VideoPlayDetailsToolsCell.h"
#import "VideoPlayDetailsMessageCell.h"
#import "VideoPlayDetailsCommentView.h"
#import "VideoPlayDetailsHeader.h"
#import "Common.h"
#import "MoviePlayer.h"
#import "UIColor+Tools.h"
#import "VideoPlayDetailHeadCell.h"
#import "ShareSdkUtils.h"
#import "PersonDetailController.h"
#import "FunctionDetailReportViewController.h"

@interface VideoPlayDetailsController ()
<
UITableViewDelegate,
UITableViewDataSource,
VideoPlayDetailsToolsDelegate,
VideoPlayDetailHeaderDelegate,
VideoPlayDetailsMessageDelegate
>
/**
 *  主视图
 */
@property (nonatomic, weak) UITableView *mainTableView;
@property (strong, nonatomic) MoviePlayer *moviePlayer;
@property (nonatomic, strong)UIView *blackBackGroundView;
@end

@implementation VideoPlayDetailsController
{
    VideoPlayDetailsBaseClass *bassClass;
}

static NSString * const introduceCellID = @"VideoPlayDetailsIntroduceCell";
static NSString * const headCellID      = @"VideoPlayDetailHeadCell";
static NSString * const messageCellID   = @"VideoPlayDetailsMessageCell";
static NSString * const toolsCellID     = @"VideoPlayDetailsToolsCell";
static CGFloat    const bottomH  = 49.0f;
static CGFloat          naviTopH = 64.0f;

static NSString * const cellID = @"cellID";

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor colorWithHexString:@"1c1a2a" alpha:1.0];
    [self playTheVideo];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        UITableView *mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, naviTopH, ScreenWidth, ScreenHeight - bottomH - naviTopH) style:(UITableViewStylePlain)];
        mainTableView.delegate = self;
        mainTableView.dataSource = self;
        mainTableView.backgroundColor = [UIColor colorWithHexString:@"1c1a2a" alpha:1.0];
        mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;        
        mainTableView.estimatedRowHeight = 50;
        [mainTableView registerNib:[UINib nibWithNibName:@"VideoPlayDetailsIntroduceCell" bundle:nil] forCellReuseIdentifier:introduceCellID];
                [mainTableView registerNib:[UINib nibWithNibName:@"VideoPlayDetailHeadCell" bundle:nil] forCellReuseIdentifier:headCellID];
        [mainTableView registerNib:[UINib nibWithNibName:@"VideoPlayDetailsToolsCell" bundle:nil] forCellReuseIdentifier:toolsCellID];
        [mainTableView registerNib:[UINib nibWithNibName:@"VideoPlayDetailsMessageCell" bundle:nil] forCellReuseIdentifier:messageCellID];
        [self.view addSubview:mainTableView];
        self.mainTableView = mainTableView;
        
    }return _mainTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavTitle:@"视频详情"];
    [self addNavRightBtnWithTitle:@"举报" color:white rect:CGRectMake(ScreenWidth - 66 - 5, 22, 66, 44)];
    [self createBottomView];
    [self loadHeadData];
}

- (void)actNavBack
{
    for (UIViewController *vc in self.navigationController.childViewControllers) {
        if ([vc isKindOfClass:NSClassFromString(@"DiscoverViewController")]) {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"jumpToDisCoverViewController" object:nil];
}

- (void)zanClick
{
    
    
    // updateMyvideo.action
    NSString *url = [ServerAddress stringByAppendingPathComponent:@"updateMyvideo.action"];
    
    
    url = [NSString stringWithFormat:@"%@?myvideoId=%@",url,_videoID];
    NSString *videoUserId = bassClass.messageHelper.entity.user.userid;
    if (!videoUserId || !(videoUserId.length > 0)) {
        [MBProgressHUD showError:@"无法为Ta点赞"];
        return;
    }
    
    if ([NSString getUserID].length < 1) {
        //发起通知
        NSNotificationCenter * centerTwo = [NSNotificationCenter defaultCenter];
        [centerTwo postNotificationName:@"login" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    [self showLoadingView];
    
    [[ZRBNetWorking shareNewWorking] startGetRequest:url withParameters:nil callBack:^(NSDictionary *responseObject) {
        [weakSelf closeLoadingView];

        if ([responseObject[@"messageHelper"][@"result"] isEqualToString:@"S"]) {
            bassClass.messageHelper.entity.jz +=1;
            [MBProgressHUD showSuccess:@"点赞成功"];

        }else
        {
            [MBProgressHUD showError:@"点赞失败"];
        }
        [weakSelf.mainTableView reloadData];
    }];
}

- (void)loadHeadData
{
    NSString *url = [ServerAddress stringByAppendingPathComponent:@"getMyvideo.action"];
    NSDictionary *parameters = @{@"myvideoId" : _videoID};
    
    __weak typeof(self)weakSelf = self;
    [self showLoadingView];
    [[ZRBNetWorking shareNewWorking] startPostRequest:url withParameters:parameters callBack:^(NSDictionary *responseObject) {
        [weakSelf closeLoadingView];
        bassClass = [VideoPlayDetailsBaseClass modelObjectWithDictionary:responseObject];
        [weakSelf.mainTableView reloadData];
    }];
}

- (void)loadContentDataWith:(NSString *)content
{
    if ([NSString getUserID].length < 1) {
        //发起通知
        NSNotificationCenter * centerTwo = [NSNotificationCenter defaultCenter];
        [centerTwo postNotificationName:@"login" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    NSString *videoUserId = bassClass.messageHelper.entity.user.userid;
    if (!videoUserId || !(videoUserId.length > 0)) {
        [MBProgressHUD showError:@"无法评论Ta的视频"];
        return;
    }
    NSString *url = [ServerAddress stringByAppendingPathComponent:@"addIcanNotesp.action"];
    NSDictionary *parameters = @{@"userId" : [NSString getUserID],
                                 @"spid" : _videoID,
                                 @"content" : content};
    [self showLoadingView];
    [[ZRBNetWorking shareNewWorking] startPostRequest:url withParameters:parameters callBack:^(NSDictionary *responseObject) {
        [self closeLoadingView];
        if ([responseObject[@"messageHelper"][@"result"] isEqualToString:@"S"]) {
            // 评论成功
            ZRBLog(@"%@",@"评论成功");
        }else
        {
            // 评论失败
            
        }
        [self loadHeadData];
        
    }];
}

- (void)createBottomView
{
    VideoPlayDetailsCommentView *bottomView = [VideoPlayDetailsCommentView shareVideoPlayDetailsCommentView];

    bottomView.frame = CGRectMake(0, ScreenHeight - 49, ScreenWidth, 49);
    __weak typeof(self)weakSelf = self;
    bottomView.submitCommentText = ^(NSString * text){
        [weakSelf loadContentDataWith:text];
    };
    [self.view addSubview:bottomView];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60 + 400 * RelativeHeight;
    }else if (indexPath.section == 1)
    {
        NSString *content = bassClass.messageHelper.entity.describes;
        return [self heightWithModel:content size:CGSizeMake(ScreenWidth - 24, 0) font:14];
        
    }else if (indexPath.section == 2)
    {
        return 90;
    }
    else
    {
        VideoPlayDetailsListcollection *model = bassClass.messageHelper.entity.listcollection[indexPath.row];
        return [self heightWithModel:model.content size:CGSizeMake(ScreenWidth - 70, 0) font:14];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3) {
        return bassClass.messageHelper.entity.listcollection.count;
    }else
    {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        VideoPlayDetailHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:headCellID forIndexPath:indexPath];
        cell.model = bassClass;
        cell.delegate = self;
        return cell;
        
    }else if (indexPath.section == 1)
    {
        VideoPlayDetailsIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:introduceCellID forIndexPath:indexPath];
        cell.model = bassClass;
        return cell;
        
    }else if (indexPath.section == 2)
    {
        VideoPlayDetailsToolsCell *cell = [tableView dequeueReusableCellWithIdentifier:toolsCellID forIndexPath:indexPath];
        cell.delegate = self;
        cell.model = bassClass.messageHelper.entity;
        return cell;
    }
    else
    {
        VideoPlayDetailsMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCellID forIndexPath:indexPath];
        VideoPlayDetailsListcollection *model = bassClass.messageHelper.entity.listcollection[indexPath.row];
        cell.model = model;
        cell.delegate = self;
        return cell;
    }
    return nil;
}

#pragma mark - VideoPlayDetailsToolsDelegate
- (void)clickBtnWith:(NSInteger)tag num:(NSInteger)num
{
    if ([NSString getUserID].length < 1) {
        //发起通知
        NSNotificationCenter * centerTwo = [NSNotificationCenter defaultCenter];
        [centerTwo postNotificationName:@"login" object:nil];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    switch (tag) {
        case 0: // 喜欢
            [self zanClick];
            break;
            
        case 1: // 评论
            
            break;
            
        case 2: // 分享
        {
            NSString *videoUserId = bassClass.messageHelper.entity.user.userid;
            if (!videoUserId || !(videoUserId.length > 0)) {
                [MBProgressHUD showError:@"视频内容为空,暂时无法分享"];
                return;
            }
            
            [ShareSdkUtils shareWithActionSheetInView:self.view
                                                title:bassClass.messageHelper.entity.videoname
                                                 text:bassClass.messageHelper.entity.describes
                                                  url:bassClass.messageHelper.entity.url
                                                image:bassClass.messageHelper.entity.videoimg];
        }
            break;
             
        default:
            break;
    }
}

#pragma mark - 播放
- (void)playVideoWith:(NSString *)url{
    NSLog(@"www");
}

- (void)clickBtnWithUserID:(NSString *)userID{
    [self colseTheMovie];
    [self pushToPersonDetailController:userID];
}

#pragma mark - VideoPlayDetailsMessageDelegate
- (void)messageIconClick:(NSString *)userID{
    [self colseTheMovie];
    [self pushToPersonDetailController:userID];
}

- (void)pushToPersonDetailController:(NSString *)userID{
    if (!userID &&! (userID.length > 0)) {
        [MBProgressHUD showError:@"无法进入Ta的个人详情页"];
        return;
    }
    
    PersonDetailController *personVC = [[PersonDetailController alloc] init];
    personVC.userID = userID;
    [self.navigationController pushViewController:personVC animated:YES];
}

- (CGFloat)heightWithModel:(NSString *)string size:(CGSize)size font:(CGFloat)font
{
    CGSize stringSize = [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil].size;
    return stringSize.height + 38 + 5;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)playTheVideo{
    VideoPlayDetailHeadCell *cell = (VideoPlayDetailHeadCell *)[self.mainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell) {
        [cell.player.moviePlay play];
    }
}

- (void)colseTheMovie{
    VideoPlayDetailHeadCell *cell = (VideoPlayDetailHeadCell *)[self.mainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell) {
        [cell.player.moviePlay pause];
    }
}

- (void)actNavRightBtn{
    FunctionDetailReportViewController * functionDetailReportVC = [[FunctionDetailReportViewController alloc]init];
    functionDetailReportVC.serviceIdString = _videoID;
    [self colseTheMovie];
    [self.navigationController pushViewController:functionDetailReportVC animated:YES];
}

- (void)dealloc{
    VideoPlayDetailHeadCell *cell = (VideoPlayDetailHeadCell *)[self.mainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if (cell) {
        [cell.player.moviePlay stop];
        cell.player.moviePlay = nil;
    }
}

@end
