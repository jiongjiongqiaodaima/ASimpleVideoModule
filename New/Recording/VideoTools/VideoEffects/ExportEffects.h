//
//  ExportEffects
//  FunCrop
//
//  Created by Johnny Xu(徐景周) on 5/30/15.
//  Copyright (c) 2015 Future Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "VideoThemesData.h"

#define TrackIDCustom 1

typedef NS_ENUM(NSInteger, TransitionType)
{
    kTransitionTypeNone = 0,
    kTransitionTypePushHorizontalSpinFromRight = 1,
    kTransitionTypePushHorizontalFromRight,
    kTransitionTypePushHorizontalFromLeft,
    kTransitionTypePushVerticalFromBottom,
    kTransitionTypePushVerticalFromTop,
    kTransitionTypeCrossFade,
};

typedef NSString *(^JZOutputFilenameBlock)();
typedef void (^JZFinishVideoBlock)(BOOL success, id result);
typedef void (^JZExportProgressBlock)(NSNumber *percentage);


typedef void (^JZExportProgressBlockNew)(NSNumber *percentage, NSString *title);

@interface ExportEffects : NSObject

@property (copy, nonatomic) JZFinishVideoBlock finishVideoBlock;
@property (copy, nonatomic) JZExportProgressBlock exportProgressBlock;
@property (nonatomic, copy) JZExportProgressBlockNew exportProgressNewBlock;
@property (copy, nonatomic) JZOutputFilenameBlock filenameBlock;

@property (nonatomic, strong) NSMutableArray *gifArray;
@property (nonatomic, assign) ThemesType themeCurrentType;

+ (ExportEffects *)sharedInstance;

- (void)addEffectToVideo:(NSString *)videoFilePath withAudioFilePath:(NSString *)audioFilePath;
- (void)writeExportedVideoToAssetsLibrary:(NSString *)outputPath;

- (void)addEffectToVideo:(NSMutableArray *)assets;

@end
