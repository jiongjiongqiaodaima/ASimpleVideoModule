//
//  LocalVideoEditViewController.h
//  ZhongRenBang
//
//  Created by 童臣001 on 16/6/28.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPUImage.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import "MBProgressHUD+MJ.h"

@interface LocalVideoEditViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic ,copy) NSString * pathToMovie;
@property (nonatomic ,copy) NSURL * videoUrl;
@property (nonatomic, assign) BOOL systemOrNot;
@end
