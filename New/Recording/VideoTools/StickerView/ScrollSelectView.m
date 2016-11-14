//
//  ScrollSelectView
//  VideoMoments
//
//  Created by Johnny Xu(徐景周) on 5/30/15.
//  Copyright (c) 2015 Future Studio. All rights reserved.
//

#import "ScrollSelectView.h"
#import "Common.h"
static NSMutableDictionary *filenameDic;

#define ContentHeight 50

@interface ScrollSelectView()

@property (nonatomic, strong) UIButton *selectedViewBtn;

@end


@implementation ScrollSelectView{
    CGSize videoSize;
}

#pragma mark - GIF
- (id)initWithFrameFromGif:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        videoSize = frame.size;
        // Initialization
        [self initResourceFormGif];
    }
    return self;
}

- (void)initResourceFormGif
{
    _ContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 4 - SCREEN_WIDTH / 100 * 16)];
    [_ContentView setBackgroundColor:ZLColorFromRGB(0x1c1a2a)];

    _ContentView.showsHorizontalScrollIndicator = NO;
    _ContentView.showsVerticalScrollIndicator = NO;
    [self addSubview:_ContentView];
    
    // Get files count from resource
//    NSString *filename = @"paper";
    NSMutableArray *fileList = [NSMutableArray arrayWithCapacity:10];
    
    for (int i = 0; i < 20; i++) {
        NSString *name = [NSString stringWithFormat:@"paper%i.",i];
        [fileList addObject:name];
    }
    

    NSLog(@"fileList: %@, Count: %lu", fileList, (unsigned long)[fileList count]);
    
    unsigned long gifCount = [fileList count] + 1;
    CGFloat width = 60;
    CGFloat height = 76;
    for (int i = 0; i < gifCount; i++)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((i*width) + 10, 12 , width, height)];
        NSString *imageName =[NSString stringWithFormat:@"paper%i.", i];
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        
        UIEdgeInsets insets = {1, 1, 1, 1};
        [button setImageEdgeInsets:insets];
        
        [button setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(gifAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:i];
        [_ContentView addSubview:button];
        
        if (i == 0)
        {
//            [button setSelected:YES];
            _selectedViewBtn = button;
        }
    }
    
    [_ContentView setContentSize:CGSizeMake(gifCount*width, 0)];
}

- (void)gifAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
//    if (button == _selectedViewBtn)
//    {
//        return;
//    }
    
    self.selectStyleIndex = button.tag;
//    if (self.selectStyleIndex != 0)
//    {
        [_selectedViewBtn setSelected:NO];
        _selectedViewBtn = button;
        [_selectedViewBtn setSelected:YES];
//    }
    
    if (_delegateSelect && [_delegateSelect respondsToSelector:@selector(didSelectedGifIndex:)])
    {
        [_delegateSelect didSelectedGifIndex:self.selectStyleIndex];
    }
}

#pragma mark - Border
- (id)initWithFrameFromBorder:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Initialization
        [self initResourceFormBorder];
    }
    return self;
}

- (void)initResourceFormBorder
{
//    if (!_ContentView) {
        _ContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT / 4 - SCREEN_WIDTH / 100 * 16)];
        [_ContentView setBackgroundColor:ZLColorFromRGB(0x1c1a2a)];
        //    _ContentView.backgroundColor = [UIColor whiteColor];
        _ContentView.showsHorizontalScrollIndicator = NO;
        _ContentView.showsVerticalScrollIndicator = NO;
        
        [self addSubview:_ContentView];
//    }
//    _ContentView.frame = CGRectMake(0, 0,ScreenWidth, SCREEN_HEIGHT / 4 - SCREEN_WIDTH / 100 * 16);

    
    // Get files count from resource
//    NSString *filename = @"frame";
    NSMutableArray *fileList = [NSMutableArray arrayWithCapacity:20];
    
    for (int i = 0; i < 27; i++) {
        NSString *name = [NSString stringWithFormat:@"border_%i.",i];
        [fileList addObject:name];
    }
    NSLog(@"fileList: %@, Count: %lu", fileList, (unsigned long)[fileList count]);
    
    unsigned long borderCount = [fileList count] + 1;
    CGFloat width = 62;
    CGFloat height = 76;
    for (int i = 0; i < borderCount; i++)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake((i*width) + 10, 10 , width, height)];
        NSString *str = [NSString stringWithFormat:@"border_%i", i];
        [button setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];

        UIEdgeInsets insets = {1, 1, 1, 1};

        [button setImageEdgeInsets:insets];
        
        [button setBackgroundImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(borderAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:i];
        [_ContentView addSubview:button];
        
        if (i == 0)
        {
//            [button setSelected:YES];
            _selectedViewBtn = button;
        }
    }
    
    [_ContentView setContentSize:CGSizeMake(borderCount * width, 0)];
}

- (void)borderAction:(id)sender
{
    UIButton *button = (UIButton *)sender;
//    if (button == _selectedViewBtn)
//    {
//        return;
//    }
    
    self.selectStyleIndex = button.tag;
//    if (self.selectStyleIndex != 0)
//    {
        [_selectedViewBtn setSelected:NO];
        _selectedViewBtn = button;
        [_selectedViewBtn setSelected:YES];
//    }
    
    if (_delegateSelect && [_delegateSelect respondsToSelector:@selector(didSelectedBorderIndex:)])
    {
        [_delegateSelect didSelectedBorderIndex:self.selectStyleIndex];
    }
}

#pragma mark - GetDefaultFilelist
+ (void)getDefaultFilelist
{
    NSString *name = @"gif_1", *type = @"gif";
    NSString *fileFullPath = [[NSBundle mainBundle] pathForResource:name ofType:type];
    NSString *filePathWithoutName = [fileFullPath stringByDeletingLastPathComponent];
    NSString *fileName = [fileFullPath lastPathComponent];
    NSString *fileExt = [fileFullPath pathExtension];
    NSLog(@"filePathWithoutName: %@, fileName: %@, fileExt: %@", filePathWithoutName, fileName, fileExt);
    
    NSString *filenameByGif = @"gif";
    filenameDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [filenameDic setObject:getFilelistBySymbol(filenameByGif, filePathWithoutName, type) forKey:filenameByGif];
    
    NSString *filenameByBorder = @"border";
    type = @"png";
    [filenameDic setObject:getFilelistBySymbol(filenameByBorder, filePathWithoutName, type) forKey:filenameByBorder];
}

@end
