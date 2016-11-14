//
//  VideoEffectForFilter.m
//  ZhongRenBang
//
//  Created by 童臣001 on 16/8/4.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "VideoEffectForFilter.h"
#import "VideoBuilder.h"
#import "CommonDefine.h"
#import "MMProgressHUD.h"


#pragma mark - Private
@interface VideoEffectForFilter()<GPUImageMovieDelegate>
{
    GPUImageMovie *_movieFile;
    GPUImageOutput<GPUImageInput> *_filter;
    GPUImageMovieWriter *_movieWriter;
    
    AVAssetExportSession *_exportSession;
    NSTimer *_timerFilter;
    NSTimer *_timerEffect;
    
    NSMutableDictionary *_themesDic;
    
    VideoBuilder *_videoBuilder;
    
    CGFloat seconds;
    
    NSInteger count;
}

@property (retain, nonatomic) VideoBuilder *videoBuilder;
@property (retain, nonatomic) NSMutableDictionary *themesDic;
@property (assign, nonatomic) id delegate;

@property (retain, nonatomic) AVAssetExportSession *exportSession;

@property (retain, nonatomic) NSTimer *timerFilter;
@property (retain, nonatomic) NSTimer *timerEffect;

@property (nonatomic, retain) NSURL *realUrl;

@end

@implementation VideoEffectForFilter

@synthesize exportSession = _exportSession;

@synthesize timerFilter = _timerFilter;
@synthesize timerEffect = _timerEffect;

@synthesize delegate = _delegate;
@synthesize themeCurrentType = _themeCurrentType;
@synthesize themesDic = _themesDic;
@synthesize videoBuilder = _videoBuilder;

#pragma mark - Init instance
- (id) initWithDelegate:(id)delegate
{
    if (self = [super init])
    {
        _delegate = delegate;
        _movieFile = nil;
        _filter = nil;
        _movieWriter = nil;
        _exportSession = nil;
        _timerFilter = nil;
        _timerEffect = nil;
        _themesDic = nil;
        _realUrl = nil;
        // Default theme
        self.themeCurrentType = kThemeFilterNone;
        count = 0;
        _videoBuilder = [[VideoBuilder alloc] init];
    }
    
    return self;
}

- (void) clearAll
{
    if (_videoBuilder)
    {
        [_videoBuilder release];
        _videoBuilder = nil;
    }
    
    if (_movieFile)
    {
        [_movieFile release];
        _movieFile = nil;
    }
    
    if (_movieWriter)
    {
        _movieWriter.completionBlock = nil;
        _movieWriter.failureBlock = nil;
        [_movieWriter release];
        _movieWriter = nil;
    }
    
    if (_exportSession)
    {
        [_exportSession release];
        _exportSession = nil;
    }
    
    if (_timerFilter)
    {
        [_timerFilter invalidate];
        _timerFilter = nil;
    }
    
    if (_timerEffect) {
        [_timerEffect invalidate];
        _timerEffect = nil;
    }
    
//    if (_filter) {
//        [_filter release];
//        _filter = nil;
//    }
    
    if (_realUrl) {
        [_realUrl release];
        _realUrl = nil;
    }
    
//    if (_themesDic) {
//        [_themesDic release];
//        _themesDic = nil;
//    }
}

- (void)dealloc
{
    [self clearAll];
    
    [super dealloc];
}

- (void) pause
{
    if (_movieFile.progress < 1.0)
    {
        [_movieWriter cancelRecording];
    }
    else if (_exportSession.progress < 1.0)
    {
        [_exportSession cancelExport];
    }
}

- (void) resume
{
    [self clearAll];
}

#pragma mark - Build beautiful video
- (void) initializeVideo:(NSURL*) inputMovieURL fromSystemCamera:(BOOL)fromSystemCamera
{
    // 1.
    _movieFile = [[GPUImageMovie alloc] initWithURL:inputMovieURL];
    _movieFile.runBenchmark = NO;
    _movieFile.playAtActualSpeed = NO;
    
    // 2. Add filter effect
    _filter = nil;
    NSUInteger themesCount = [[[VideoFilterData sharedInstance] getFilterData] count];
    if (self.themeCurrentType != kThemeFilterNone && themesCount >= self.themeCurrentType)
    {
        GPUImageOutput<GPUImageInput> *filterCurrent = [[[VideoFilterData sharedInstance] getThemeFilter:fromSystemCamera] objectForKey:[NSNumber numberWithInt:self.themeCurrentType]];
        _filter = filterCurrent;
    }
    
    // 3.
    if ((NSNull*)_filter != [NSNull null] && _filter != nil)
    {
        [_movieFile addTarget:_filter];
    }
}

- (void) buildVideoBeautifyFilter:(NSString*)exportVideoFile andInputVideoURL:(NSURL*)inputVideoURL fromSystemCamera:(BOOL)fromSystemCamera
{
    if (self.themeCurrentType == kThemeFilterNone)
    {
        NSLog(@"Theme is empty!");
        return;
    }
    
    if (!inputVideoURL || ![inputVideoURL isFileURL])
    {
        NSLog(@"Input file is invalied! = %@", inputVideoURL);
        return;
    }
    
    self.themesDic = [[VideoFilterData sharedInstance] getFilterData];
    
    // 2.
    [self initializeVideo:inputVideoURL fromSystemCamera:fromSystemCamera];
    
    // 3. Movie output temp file
    //    NSString *pathToTempMov = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tempMovie.mov"];
    NSString *pathToTempMov = [NSTemporaryDirectory() stringByAppendingPathComponent:@"tempMovie.mov"];
    unlink([pathToTempMov UTF8String]); // If a file already exists, AVAssetWriter won't let you record new frames, so delete the old movie
    NSURL *outputTempMovieURL = [NSURL fileURLWithPath:pathToTempMov];
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:inputVideoURL options:nil];
    NSArray *assetVideoTracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    if (assetVideoTracks.count <= 0)
    {
        NSLog(@"Video track is empty!");
        return;
    }
    AVAssetTrack *videoAssetTrack = [[asset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    
    // If this if from system camera, it will rotate 90c, and swap width and height
    CGSize sizeVideo = CGSizeMake(videoAssetTrack.naturalSize.width, videoAssetTrack.naturalSize.height);
    if (fromSystemCamera)
    {
        sizeVideo = CGSizeMake(videoAssetTrack.naturalSize.height, videoAssetTrack.naturalSize.width);
    }
    _movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:outputTempMovieURL size:sizeVideo];
    
    if ((NSNull*)_filter != [NSNull null] && _filter != nil)
    {
        [_filter addTarget:_movieWriter];
    }
    else
    {
        [_movieFile addTarget:_movieWriter];
    }
    
    // 4. Configure this for video from the movie file, where we want to preserve all video frames and audio samples
    _movieWriter.shouldPassthroughAudio = YES;
    //    _movieFile.audioEncodingTarget = _movieWriter;
    [_movieFile enableSynchronizedEncodingUsingMovieWriter:_movieWriter];
    
    // 5.
    [_movieWriter startRecording];
    [_movieFile startProcessing];
    
    // 6. Progress monitor for filter
    _timerFilter = [NSTimer scheduledTimerWithTimeInterval:0.3f
                                                    target:self
                                                  selector:@selector(retrievingProgress)
                                                  userInfo:nil
                                                   repeats:YES];
    
    __unsafe_unretained typeof(self) weakSelf = self;
    // 7. Filter effect finished
    [_movieWriter setCompletionBlock:^{
        
        if ((NSNull*)_filter != [NSNull null] && _filter != nil)
        {
            [_filter removeTarget:_movieWriter];
        }
        else
        {
            [_movieFile removeTarget:_movieWriter];
        }
        
        [_movieWriter finishRecordingWithCompletionHandler:^{
            
            
            
            unlink([exportVideoFile UTF8String]);
            
            // Mov convert to mp4 (Add animation and music effect)
            NSURL *inputVideoURL = outputTempMovieURL;
            if (![self buildVideoEffectsToMP4:exportVideoFile inputVideoURL:inputVideoURL])
            {
                NSLog(@"Convert to mp4 file failed");
            }
            else
            {
                
            }
        }];
    }];
    
    
    
    // 8. Filter effect failed
    [_movieWriter setFailureBlock: ^(NSError* error){
        
        if ((NSNull*)_filter != [NSNull null] && _filter != nil)
        {
            [_filter removeTarget:_movieWriter];
        }
        else
        {
            [_movieFile removeTarget:_movieWriter];
        }
        
        [_movieWriter finishRecordingWithCompletionHandler:^{
            
            // Closer timer
            [_timerFilter invalidate];
            _timerFilter = nil;
            
            // Mov convert to mp4 (Add animation and music effect)
            unlink([exportVideoFile UTF8String]);
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                if (_delegate && [_delegate respondsToSelector:@selector(AVAssetExportMP4SessionStatusFailed:)])
                {
                    [_delegate performSelector:@selector(AVAssetExportMP4SessionStatusFailed:) withObject:nil];
                }
                
            });
         
            NSLog(@"Add filter effect failed! - %@", error.description);
            return;
            
        }];
    }];
    
}

// Convert 'space' char
-(NSString *)returnFormatString:(NSString *)str
{
    return [str stringByReplacingOccurrencesOfString:@" " withString:@" "];
}

// Add animation and music effect
- (BOOL)buildVideoEffectsToMP4:(NSString *)exportVideoFile inputVideoURL:(NSURL *)inputVideoURL
{
    // Closer timer
    [_timerFilter invalidate];
    _timerFilter = nil;
    // 1.
    if (!inputVideoURL || ![inputVideoURL isFileURL] || !exportVideoFile || [exportVideoFile isEqualToString:@""])
    {
        NSLog(@"Input filename or Output filename is invalied for convert to Mp4!");
        return NO;
    }

    // 2. Create the composition and tracks
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:inputVideoURL options:nil];
    NSParameterAssert(asset);
    if(asset ==nil || [[asset tracksWithMediaType:AVMediaTypeVideo] count]<1)
    {
        NSLog(@"Input video is invalid!");
        [asset release];
        return NO;
    }
    
    AVMutableComposition *composition = [AVMutableComposition composition];
    AVMutableCompositionTrack *videoTrack = [composition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    
    NSArray *assetVideoTracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    if (assetVideoTracks.count <= 0)
    {
        // Retry once
        if (asset)
        {
            [asset release];
            asset = nil;
        }
        
        asset = [[AVURLAsset alloc] initWithURL:inputVideoURL options:nil];
        assetVideoTracks = [asset tracksWithMediaType:AVMediaTypeVideo];
        if ([assetVideoTracks count] <= 0)
        {
            if (asset)
            {
                [asset release];
                asset = nil;
            }
            
            NSLog(@"Error reading the transformed video track");
            return NO;
        }
    }
    
    // 3. Insert the tracks in the composition's tracks
    AVAssetTrack *assetVideoTrack = [assetVideoTracks firstObject];
    [videoTrack insertTimeRange:assetVideoTrack.timeRange ofTrack:assetVideoTrack atTime:CMTimeMake(0, 1) error:nil];
    [videoTrack setPreferredTransform:assetVideoTrack.preferredTransform];
    
    // 4. 加特效
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, assetVideoTrack.naturalSize.width, assetVideoTrack.naturalSize.height);
    videoLayer.frame = CGRectMake(0, 0, assetVideoTrack.naturalSize.width, assetVideoTrack.naturalSize.height);
    [parentLayer addSublayer:videoLayer];
    
    VideoThemes *themeCurrent = [[VideoThemes alloc]init];
    if (self.themeCurrentType != kThemeFilterNone && [self.themesDic count] >= _themeCurrentType)
    {
        _themesDic = [[VideoFilterData sharedInstance]getFilterData];
        themeCurrent = [_themesDic objectForKey:[NSNumber numberWithInt:self.themeCurrentType]];
    }
    
    // 动画 特效
    NSMutableArray *animatedLayers = [[NSMutableArray alloc] init];
    if (themeCurrent && [[themeCurrent animationActions] count]>0)
    {
        for (NSNumber *animationAction in [themeCurrent animationActions])
        {
            switch ([animationAction intValue])
            {
            }
        }
        
        if (animatedLayers && [animatedLayers count] > 0)
        {
            for (CALayer *animatedLayer in animatedLayers)
            {
                [parentLayer addSublayer:animatedLayer];
            }
        }
    }
    
    // Make a "pass through video track" video composition.
    AVMutableVideoCompositionInstruction *passThroughInstruction = [AVMutableVideoCompositionInstruction videoCompositionInstruction];
    passThroughInstruction.timeRange = CMTimeRangeMake(kCMTimeZero, [asset duration]);
    
    AVMutableVideoCompositionLayerInstruction *passThroughLayer = [AVMutableVideoCompositionLayerInstruction videoCompositionLayerInstructionWithAssetTrack:assetVideoTrack];
    passThroughInstruction.layerInstructions = [NSArray arrayWithObject:passThroughLayer];
    
    
    AVMutableVideoComposition *videoComposition = [AVMutableVideoComposition videoComposition];
    videoComposition.instructions = [NSArray arrayWithObject:passThroughInstruction];
    videoComposition.animationTool = [AVVideoCompositionCoreAnimationTool videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
    videoComposition.frameDuration = CMTimeMake(1, 30); // 30 fps
    videoComposition.renderSize =  assetVideoTrack.naturalSize;
        
    if (animatedLayers)
    {
        [animatedLayers removeAllObjects];
        [animatedLayers release];
        animatedLayers = nil;
    }
    
    // 5. Music effect
//    AVMutableAudioMix *audioMix = nil;
//    if (themeCurrent && !isStringEmpty(themeCurrent.bgMusicFile))
//    {
//        NSString *fileName = [themeCurrent.bgMusicFile stringByDeletingPathExtension];
//        NSLog(@"%@",fileName);
//        
//        NSString *fileExt = [themeCurrent.bgMusicFile pathExtension];
//        NSLog(@"%@",fileExt);
//        
//        NSURL *bgMusicURL = [[NSBundle mainBundle] URLForResource:fileName withExtension:fileExt];
//        AVURLAsset *assetMusic = [[AVURLAsset alloc] initWithURL:bgMusicURL options:nil];
//        _videoBuilder.commentary = assetMusic;
//        audioMix = [AVMutableAudioMix audioMix];
//        [_videoBuilder addCommentaryTrackToComposition:composition withAudioMix:audioMix];
//        
//        if (assetMusic)
//        {
//            [assetMusic release];
//            assetMusic = nil;
//        }
//    }
    
    // 6. Export to mp4 （Attention: iOS 5.0不支持导出MP4，会crash）
    NSString *mp4Quality = AVAssetExportPresetMediumQuality; //AVAssetExportPresetPassthrough
    NSString *exportPath = exportVideoFile;
    NSURL *exportUrl = [NSURL fileURLWithPath:[self returnFormatString:exportPath]];
    
    _exportSession = [[AVAssetExportSession alloc] initWithAsset:composition presetName:mp4Quality];
    _exportSession.outputURL = exportUrl;
    _exportSession.outputFileType = [[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0 ? AVFileTypeMPEG4 : AVFileTypeQuickTimeMovie;
    
    _exportSession.shouldOptimizeForNetworkUse = YES;
    
//    if (audioMix)
//    {
//        _exportSession.audioMix = audioMix;
//    }
    
    if (videoComposition)
    {
        _exportSession.videoComposition = videoComposition;
    }
    
    // 6.1
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // Progress monitor for effect
        _timerEffect = [NSTimer scheduledTimerWithTimeInterval:0.3f
                                                        target:self
                                                      selector:@selector(retrievingProgressMP4)
                                                      userInfo:nil
                                                       repeats:YES];
    });
    
    
    // 7. Success status
    [_exportSession exportAsynchronouslyWithCompletionHandler:^{
        switch ([_exportSession status])
        {
            case AVAssetExportSessionStatusCompleted:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    // Close timer
                    [_timerEffect invalidate];
                    _timerEffect = nil;
                    
                    NSLog(@"MP4 Successful!");
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(AVAssetExportMP4SessionStatusCompleted:)])
                    {
                        [_delegate performSelector:@selector(AVAssetExportMP4SessionStatusCompleted:) withObject:nil];
                    }
                    
                    NSLog(@"Output Mp4 is %@", exportVideoFile);
                    
                    // Write to photo album
                    //                    [self writeExportedVideoToAssetsLibrary:exportVideoFile];
                });
                
                break;
            }
            case AVAssetExportSessionStatusFailed:
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    // Close timer
                    [_timerEffect invalidate];
                    _timerEffect = nil;
                    
                    if (_delegate && [_delegate respondsToSelector:@selector(AVAssetExportMP4SessionStatusFailed:)])
                    {
                        [_delegate performSelector:@selector(AVAssetExportMP4SessionStatusFailed:) withObject:nil];
                    }
                    
                });
                
                NSLog(@"Export failed: %@", [[_exportSession error] localizedDescription]);
                
                break;
            }
            case AVAssetExportSessionStatusCancelled:
            {
                NSLog(@"Export canceled");
                break;
            }
            case AVAssetExportSessionStatusWaiting:
            {
                NSLog(@"Export Waiting");
                break;
            }
            case AVAssetExportSessionStatusExporting:
            {
                NSLog(@"Export Exporting");
                break;
            }
            default:
                break;
        }
        
        [_exportSession release];
        _exportSession = nil;
        
        if (asset)
        {
            [asset release];
        }
    }];
    
    return YES;
}


- (void)retrievingProgress
{
    if (_delegate && [_delegate respondsToSelector:@selector(retrievingProgressFilter:)])
    {
        [_delegate performSelector:@selector(retrievingProgressFilter:) withObject:[NSNumber numberWithFloat:_movieFile.progress]];
        
        //             NSLog(@"Filter Progress: %f", movieFile.progress);
    }
}

- (void)retrievingProgressMP4
{
    if (_exportSession)
    {
        if (_delegate && [_delegate respondsToSelector:@selector(retrievingProgressMP4:)])
        {
            [_delegate performSelector:@selector(retrievingProgressMP4:) withObject:[NSNumber numberWithFloat:_exportSession.progress]];
            
            //            NSLog(@"Effect Progress: %f", exportSession.progress);
        }
    }
    
}

- (void)applyVideoEffectsToComposition:(AVMutableVideoComposition *)composition size:(CGSize)size{
    // 1 - set up the overlay
    CALayer *overlayLayer = [CALayer layer];
    UIImage *overlayImage  = [UIImage imageNamed:@"video_edit_shuiyin"];
    
    [overlayLayer setContents:(id)[overlayImage CGImage]];
    overlayLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [overlayLayer setMasksToBounds:YES];
    
    // 2 - set up the parent layer
    CALayer *parentLayer = [CALayer layer];
    CALayer *videoLayer = [CALayer layer];
    parentLayer.frame = CGRectMake(0, 0, size.width, size.height);
    videoLayer.frame = CGRectMake(0, 0, size.width, size.height);
    [parentLayer addSublayer:videoLayer];
    [parentLayer addSublayer:overlayLayer];
    
    //*********** For A Special Time
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animation setDuration:0];
    [animation setFromValue:[NSNumber numberWithFloat:1.0]];
    [animation setToValue:[NSNumber numberWithFloat:0.0]];
    [animation setBeginTime:1];
    [animation setRemovedOnCompletion:NO];
    [animation setFillMode:kCAFillModeForwards];
    [overlayLayer addAnimation:animation forKey:@"animateOpacity"];
    
    // 3 - apply magic
    composition.animationTool = [AVVideoCompositionCoreAnimationTool
                                 videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:videoLayer inLayer:parentLayer];
}

- (CGFloat)getVideoDuration:(NSURL*)URL{
    NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                     forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:URL options:opts];
    float second = 0;
    second = urlAsset.duration.value/urlAsset.duration.timescale;
    
    return second;
}

@end
