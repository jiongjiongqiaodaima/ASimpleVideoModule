//
//  VideoFilterData.h
//  ZhongRenBang
//
//  Created by 童臣001 on 16/8/3.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoThemes.h"

// Effects
typedef enum
{
    kAnimationFilterFilterNone = 0,
    kAnimationFilterFireworks,
    kAnimationFilterSnow,
    kAnimationFilterSnow2,
    kAnimationFilterHeart,
    kAnimationFilterRing,
    kAnimationFilterStar,
    kAnimationFilterMoveDot,
    kAnimationFilterSky,
    kAnimationFilterMeteor,
    kAnimationFilterRain,
    kAnimationFilterFlower,
    kAnimationFilterFire,
    kAnimationFilterSmoke,
    kAnimationFilterSpark,
    kAnimationFilterSteam,
    kAnimationFilterBirthday,
    kAnimationFilterBlackWhiteDot,
    kAnimationFilterScrollScreen,
    kAnimationFilterSpotlight,
    kAnimationFilterScrollLine,
    kAnimationFilterRipple,
    kAnimationFilterImage,
    kAnimationFilterImageArray,
    kAnimationFilterVideoFrame,
    kAnimationFilterTextStar,
    kAnimationFilterTextSparkle,
    kAnimationFilterTextScroll,
    kAnimationFilterTextGradient,
    kAnimationFilterFlashScreen,
    
} AnimationActionFilterType;

// Themes
typedef enum
{
    // 无
    kThemeFilterNone = 0,
    
    // 心情
    kThemeFilterMood,
    
    // 怀旧
    kThemeFilterNostalgia,
    
    // 老电影
    kThemeFilterOldFilm,
    
    // Nice day
    kThemeFilterNiceDay,
    
    // 星空
    kThemeFilterSky,
    
    // 时尚
    kThemeFilterFashion,
    
    // 生日
    kThemeFilterBirthday,
    
    // 心动
    kThemeFilterHeartbeat,
    
} ThemesFilterType;

@interface VideoFilterData : NSObject
{
    
}

+ (VideoFilterData *) sharedInstance;

- (NSMutableDictionary*) getFilterData;
- (NSMutableDictionary*) getThemeFilter:(BOOL)fromSystemCamera;
- (NSString *)myName:(ThemesFilterType)type;

@end
