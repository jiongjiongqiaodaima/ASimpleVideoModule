//
//  VideoThemesData.h
//  VideoBeautify
//
//  Created by Johnny Xu(徐景周) on 8/11/14.
//  Copyright (c) 2014 Future Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoThemes.h"

// Effects
typedef enum
{
    kAnimationNone = 0,
    kAnimationFireworks,
    kAnimationSnow,
    kAnimationSnow2,
    kAnimationHeart,
    kAnimationRing,
    kAnimationStar,
    kAnimationMoveDot,
    kAnimationSky,
    kAnimationMeteor,
    kAnimationRain,
    kAnimationFlower,
    kAnimationFire,
    kAnimationSmoke,
    kAnimationSpark,
    kAnimationSteam,
    kAnimationVideoBorder,
    kAnimationBirthday,
    kAnimationBlackWhiteDot,
    kAnimationScrollScreen,
    kAnimationSpotlight,
    kAnimationScrollLine,
    kAnimationRipple,
    kAnimationImage,
    kAnimationImageArray,
    kAnimationVideoFrame,
    kAnimationTextStar,
    kAnimationTextSparkle,
    kAnimationTextScroll,
    kAnimationTextGradient,
    kAnimationFlashScreen,
    kAnimationPhotoLinearScroll,
    KAnimationPhotoCentringShow,
    kAnimationPhotoDrop,
    kAnimationPhotoParabola,
    kAnimationPhotoFlare,
    kAnimationPhotoEmitter,
    kAnimationPhotoExplode,
    kAnimationPhotoExplodeDrop,
    kAnimationPhotoCloud,
    kAnimationPhotoSpin360,
    kAnimationPhotoCarousel,
    kAnimationPhotoParallax,
    
} AnimationActionType;

// Themes
typedef enum
{
    // 无
    kThemeNone = 0,
    
    // 心情
    KThemeOldFilm,
    
    // 怀旧
    kThemeStarshine,
    
    // 老电影
    kThemeSky,
    
    // Nice day
    kThemeRomantic,

    // 星空
    kThemeFlower,
    
    // 时尚
    kThemeNiceDay,
    
    // 生日
    kThemeClassic,
    
    // Custom
    kThemeCustom,
    
} ThemesType;




@interface VideoThemesData : NSObject
{
    
}

+ (VideoThemesData *) sharedInstance;
- (NSMutableDictionary*) getNewThemeDic;
- (NSMutableDictionary*) getThemesData;
- (VideoThemes*) getThemeByType:(ThemesType)themeType;

- (NSString *)myTypeName:(ThemesType)type;


- (NSMutableDictionary*) getThemeFilter:(BOOL)fromSystemCamera;


- (NSArray*) getRandomAnimation;
- (NSArray*) getAnimationByIndex:(int)index;
- (NSString*) getVideoBorderByIndex:(int)index;

//- (GPUImageOutput<GPUImageInput> *) createThemeFilter:(ThemesType)themeType fromSystemCamera:(BOOL)fromSystemCamera;

@end
