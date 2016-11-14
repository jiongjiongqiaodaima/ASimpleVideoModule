//
//  VideoThemesData.m
//  VideoBeautify
//
//  Created by Johnny Xu(徐景周) on 8/11/14.
//  Copyright (c) 2014 Future Studio. All rights reserved.
//


#import "VideoFilterData.h"

@interface VideoFilterData()
{
    NSMutableDictionary *_themesDic;
    
    NSMutableDictionary *_filterFromOthers;
    NSMutableDictionary *_filterFromSystemCamera;
}

@property (retain, nonatomic) NSMutableDictionary *themesDic;
@property (retain, nonatomic) NSMutableDictionary *filterFromOthers;
@property (retain, nonatomic) NSMutableDictionary *filterFromSystemCamera;

@end


@implementation VideoFilterData

@synthesize themesDic = _themesDic;
@synthesize filterFromOthers = _filterFromOthers;
@synthesize filterFromSystemCamera = _filterFromSystemCamera;

#pragma mark - Singleton  单例
+ (VideoFilterData *) sharedInstance
{
    static VideoFilterData *singleton = nil;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        singleton = [[VideoFilterData alloc] init];
    });
    
    return singleton;
}

#pragma mark - Life cycle  生命周期
- (id)init
{
    if (self = [super init])
    {
        // Only run once
        [self initThemesData];
        
        NSMutableDictionary *filterOthers = [[self initThemeFilter:FALSE] autorelease];
        self.filterFromOthers = filterOthers;
        
        NSMutableDictionary *filterSystemCamera = [[self initThemeFilter:TRUE] autorelease];
        self.filterFromSystemCamera = filterSystemCamera;
    }
    
    return self;
}

- (void)dealloc
{
    [self clearAll];
    
    [super dealloc];
}

//清空所有
- (void) clearAll
{
    if (self.filterFromOthers && [self.filterFromOthers count]>0)
    {
        [self.filterFromOthers removeAllObjects];
        self.filterFromOthers = nil;
    }
    
    if (self.filterFromSystemCamera && [self.filterFromSystemCamera count]>0)
    {
        for (GPUImageOutput<GPUImageInput> *filter in self.filterFromOthers)
        {
            [filter removeAllTargets];
            [filter release];
        }
        [self.filterFromSystemCamera removeAllObjects];
        self.filterFromSystemCamera = nil;
    }
    
    if (self.themesDic && [self.themesDic count]>0)
    {
        [self.themesDic removeAllObjects];
        self.themesDic = nil;
    }
}
#pragma mark - Common function  普通方法
- (NSString*) getWeekdayFromDate:(NSDate*)date
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* components = nil; //[[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    components = [calendar components:unitFlags fromDate:date];
    NSUInteger weekday = [components weekday];
    
    NSString *result = nil;
    switch (weekday)
    {
        case 1:
        {
            result = @"Sunday";
            break;
        }
        case 2:
        {
            result = @"Monday";
            break;
        }
        case 3:
        {
            result = @"Tuesday";
            break;
        }
        case 4:
        {
            result = @"Wednesday";
            break;
        }
        case 5:
        {
            result = @"Thursday";
            break;
        }
        case 6:
        {
            result = @"Friday";
            break;
        }
        case 7:
        {
            result = @"Saturday";
            break;
        }
        default:
            break;
    }
    
    [calendar release];
    
    return result;
}

- (NSString*) getStringFromDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    
    return strDate;
}
#pragma mark - Init themes -------------------------------------------------------------
#pragma mark - 默认
- (VideoThemes*) createFilterNone
{
    VideoThemes *theme = [[[VideoThemes alloc] init] autorelease];
    theme.ID = kThemeFilterNone;
    theme.thumbImageName = @"MVWithNothing";
    theme.name = @"默认";
    theme.textStar = nil;
    theme.textSparkle = nil;
    theme.bgMusicFile = nil;
    theme.imageFile = nil;
    theme.animationActions = nil;
    return theme;
}
#pragma mark - 黑白
- (VideoThemes*) createFilterBlackAndWhite
{
    VideoThemes *themeBlackAndWhite = [[[VideoThemes alloc] init] autorelease];
    themeBlackAndWhite.ID = kThemeFilterMood;
    themeBlackAndWhite.thumbImageName = @"filter_BlackAndWhite";
    themeBlackAndWhite.name = @"黑白";
    themeBlackAndWhite.textStar = nil;
    themeBlackAndWhite.textSparkle = nil;
    themeBlackAndWhite.bgMusicFile = nil;
    themeBlackAndWhite.imageFile = nil;
    themeBlackAndWhite.animationActions = nil;
    return themeBlackAndWhite;
}
#pragma mark - 甜蜜
- (VideoThemes *) createFilterRomantic
{
    VideoThemes *themeRomantic = [[[VideoThemes alloc] init] autorelease];
    themeRomantic.ID = kThemeFilterNostalgia;
    themeRomantic.thumbImageName = @"filter_themeNostalgia";
    themeRomantic.name = @"甜蜜";
    themeRomantic.textStar = nil;
    themeRomantic.textSparkle = nil;
    themeRomantic.bgMusicFile = nil;
    themeRomantic.imageFile = nil;
    themeRomantic.animationActions = nil;

    return themeRomantic;
}
#pragma mark - 老电影
- (VideoThemes*) createFilterOldFilm
{
    VideoThemes *theme = [[[VideoThemes alloc] init] autorelease];
    theme.ID = kThemeFilterOldFilm;
    theme.thumbImageName = @"themeOldFilm";
    theme.name = @"老电影";
    theme.textStar = nil;
    theme.textSparkle = nil;
    theme.bgMusicFile = nil;
    theme.imageFile = nil;
    theme.animationActions = nil;

    return theme;
}
#pragma mark - nice day
- (VideoThemes*) createFilterNiceDay
{
    VideoThemes *theme = [[[VideoThemes alloc] init] autorelease];
    theme.ID = kThemeFilterNiceDay;
    theme.thumbImageName = @"themeNiceDay";
    theme.name = @"Nice day";
    theme.textStar = nil;
    theme.textSparkle = nil;
    theme.textGradient =nil;
    theme.bgMusicFile = nil;
    theme.imageFile = nil;
    theme.scrollText = nil;
    theme.animationActions = nil;
    return theme;
}
#pragma mark - Sky
- (VideoThemes*) createFilterSky
{
    VideoThemes *theme = [[[VideoThemes alloc] init] autorelease];
    theme.ID = kThemeFilterSky;
    theme.thumbImageName = @"themeSky";
    theme.name = @"星空";
    theme.textStar = nil;
    theme.textSparkle = nil;
    theme.bgMusicFile = nil;
    theme.imageFile = nil;
    theme.animationActions = nil;

    return theme;
}
#pragma mark - Fashion
- (VideoThemes*) createFilterFashion
{
    VideoThemes *themeFashion = [[[VideoThemes alloc] init] autorelease];
    themeFashion.ID = kThemeFilterFashion;
    themeFashion.thumbImageName = @"themeFashion";
    themeFashion.name = @"时尚";
    themeFashion.textStar = nil;
    themeFashion.textSparkle = nil;
    themeFashion.bgMusicFile = nil;
    themeFashion.imageFile = nil;
    themeFashion.animationActions = nil;

    return themeFashion;
}
#pragma mark - 生日
- (VideoThemes*) createFilterBirthday
{
    VideoThemes *themeStarshine = [[[VideoThemes alloc] init] autorelease];
    themeStarshine.ID = kThemeFilterBirthday;
    themeStarshine.thumbImageName = @"themeBirthday";
    themeStarshine.name = @"生日";
    themeStarshine.textStar = nil;
    themeStarshine.textSparkle = nil;
    themeStarshine.bgMusicFile = nil;
    themeStarshine.imageFile = nil;
    themeStarshine.animationActions = nil;

    return themeStarshine;
}
#pragma mark --没什么用
- (VideoThemes*) createThemeHeartbeat
{
    VideoThemes *themeHeartbeat = [[[VideoThemes alloc] init] autorelease];
    themeHeartbeat.ID = kThemeFilterHeartbeat;
    themeHeartbeat.thumbImageName = @"themeHeartbeat";
    themeHeartbeat.name = @"Heart";
    themeHeartbeat.textStar = nil;
    themeHeartbeat.textSparkle = nil;
    themeHeartbeat.bgMusicFile = nil;
    themeHeartbeat.imageFile = nil;
    themeHeartbeat.animationActions = nil;

    return themeHeartbeat;
}

#warning themes
- (void) initThemesData
{
    self.themesDic = [NSMutableDictionary dictionaryWithCapacity:15];
    
    VideoThemes *theme = nil;
    for (int i = kThemeFilterNone; i <= kThemeFilterBirthday; ++i)
    {
        switch (i)
        {
            case kThemeFilterNone:    // 0. 无
            {
                theme = [self createFilterNone];
                break;
            }
            case kThemeFilterMood:
            {
                theme = [self createFilterBlackAndWhite];// 黑白
                break;
            }
            case kThemeFilterNostalgia:
            {
                theme = [self createFilterRomantic];// 甜蜜
                break;
            }
            case kThemeFilterOldFilm:
            {
                theme = [self createFilterOldFilm];// 老电影
                break;
            }
            case kThemeFilterNiceDay:
            {
                theme = [self createFilterNiceDay];// Nice day
                break;
            }
            case kThemeFilterSky:
            {
                theme = [self createFilterSky];// 星空
                break;
            }
            case kThemeFilterFashion:
            {
                theme = [self createFilterFashion];// 时尚
                break;
            }
            case kThemeFilterBirthday:
            {
                theme = [self createFilterBirthday];// 生日
                break;
            }
            default:
                break;
        }
        
        if (i == kThemeFilterNone)
        {
            [self.themesDic setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeFilterNone]];
        }
        else
        {
            [self.themesDic setObject:theme forKey:[NSNumber numberWithInt:i]];
        }
    }
}
#pragma mark =====================滤镜制作
#pragma mark - 黑白GPUImageLookupFilter.h
- (GPUImageOutput<GPUImageInput> *) createFilterForMood:(BOOL)fromSystemCamera
{
    GPULookupFilterEx *lookupFilter = [[GPULookupFilterEx alloc] initWithName:@"milk" isWhiteAndBlack:YES];
    return lookupFilter;
}

#pragma mark - 浪漫
- (GPUImageOutput<GPUImageInput> *) createFilterForRomantic:(BOOL)fromSystemCamera
{
    //色温 普通
    GPUImageWhiteBalanceFilter *filterNostalgia = [[[GPUImageWhiteBalanceFilter alloc] init]autorelease];
    filterNostalgia.tint = 0.0;
    return filterNostalgia;
}

#pragma mark - 老电影
- (GPUImageOutput<GPUImageInput> *) createFilterForOldFilm:(BOOL)fromSystemCamera
{
    // 褐色 怀旧滤镜
    GPUImageOutput<GPUImageInput> *filterOldFilm = [[[GPUImageSepiaFilter alloc] init]autorelease];
    return filterOldFilm;
}

#pragma mark - NiceDay
- (GPUImageOutput<GPUImageInput> *) createFilterForNiceDay:(BOOL)fromSystemCamera
{
    // 色温 最高值
    GPULookupFilterEx *lookupFilter = [[GPULookupFilterEx alloc] initWithName:@"smoky" isWhiteAndBlack:YES];
    return lookupFilter;
}

#pragma mark - 星空
- (GPUImageOutput<GPUImageInput> *) createFilterForSky:(BOOL)fromSystemCamera
{
    GPUImageExposureFilter *transformFilter = [[[GPUImageExposureFilter alloc]init]autorelease];
    transformFilter.exposure = 1.5;
    return transformFilter;
}

#pragma mark - 时尚
- (GPUImageOutput<GPUImageInput> *) createFilterForFashion:(BOOL)fromSystemCamera
{
    // Filter
    GPUImageSaturationFilter *filterFashion = [[[GPUImageSaturationFilter alloc] init]autorelease];
    filterFashion.saturation = 1.5;
    return filterFashion;
}

#pragma mark - 生日
- (GPUImageOutput<GPUImageInput> *) createFilterForBirthday:(BOOL)fromSystemCamera
{
    // Filter
    GPUImageOutput<GPUImageInput> *filterBirthday = [[[GPUImageFilterGroup alloc] init]autorelease];
    CGFloat rotationAngle = 0;
    GPUImageTransformFilter *transformFilter = [[GPUImageTransformFilter alloc] init];
    [(GPUImageTransformFilter *)transformFilter setAffineTransform:CGAffineTransformMakeRotation(rotationAngle)];
    [(GPUImageTransformFilter *)transformFilter setIgnoreAspectRatio:YES];
    [(GPUImageFilterGroup *)filterBirthday addFilter:transformFilter];
    //b饱和度
    GPUImageSaturationFilter *sepiaFilter = [[GPUImageSaturationFilter alloc] init];
    sepiaFilter.saturation = 1.2;
    [(GPUImageFilterGroup *)filterBirthday addFilter:sepiaFilter];
    
    [transformFilter addTarget:sepiaFilter];
    
    //锐化
    GPUImageSharpenFilter *filter = [[GPUImageSharpenFilter alloc]init];
    filter.sharpness = 2 ;
    [(GPUImageFilterGroup *)filterBirthday addFilter:filter];
    [transformFilter addTarget:filter];
    
    [(GPUImageFilterGroup *)filterBirthday setInitialFilters:[NSArray arrayWithObject:transformFilter]];
    [(GPUImageFilterGroup *)filterBirthday setTerminalFilter:sepiaFilter];

    
    [transformFilter release];
    transformFilter = nil;
    [sepiaFilter release];
    sepiaFilter = nil;
    [filter release];
    filter = nil;
    
    return filterBirthday;
}

#pragma mark - 心动
- (GPUImageOutput<GPUImageInput> *) createFilterHeartbeat:(BOOL)fromSystemCamera
{
    // Filter
    GPUImageOutput<GPUImageInput> *filterHeartbeat = [[GPUImageFilterGroup alloc] init];
    
    CGFloat rotationAngle = 0;

    GPUImageTransformFilter *transformFilter = [[GPUImageTransformFilter alloc] init];
    [(GPUImageTransformFilter *)transformFilter setAffineTransform:CGAffineTransformMakeRotation(rotationAngle)];
    [(GPUImageTransformFilter *)transformFilter setIgnoreAspectRatio:YES];
    [(GPUImageFilterGroup *)filterHeartbeat addFilter:transformFilter];
    
    GPUImageBorderFilter *borderFilter = [[GPUImageBorderFilter alloc] init];
    NSString *borderImageName = @"border_10";
    ((GPUImageBorderFilter*)borderFilter).borderImage = [UIImage imageNamed:borderImageName];
    [(GPUImageFilterGroup *)filterHeartbeat addFilter:borderFilter];
    
    [transformFilter addTarget:borderFilter];
    
    [(GPUImageFilterGroup *)filterHeartbeat setInitialFilters:[NSArray arrayWithObject:transformFilter]];
    [(GPUImageFilterGroup *)filterHeartbeat setTerminalFilter:borderFilter];
    
    [transformFilter release];
    transformFilter = nil;
    [borderFilter release];
    borderFilter = nil;
    
    return filterHeartbeat;
}
#pragma mark - filters -------------------------------------------------------------
- (NSMutableDictionary*) initThemeFilter:(BOOL)fromSystemCamera
{
    NSMutableDictionary *themesFilter = [NSMutableDictionary dictionaryWithCapacity:15];
    
    for (int i = kThemeFilterNone; i < self.themesDic.count; ++i)
    {
        switch (i)
        {
            case kThemeFilterNone:
            {
                [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeFilterNone]];
                break;
            }
            case kThemeFilterMood:
            {
                // 黑白
                GPUImageOutput<GPUImageInput> *filterMood = [self createFilterForMood:fromSystemCamera];
                if (filterMood == nil)
                {
                    [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeFilterMood]];
                }
                else
                {
                    [themesFilter setObject:filterMood forKey:[NSNumber numberWithInt:kThemeFilterMood]];
                }
                break;
            }
            case kThemeFilterNostalgia:
            {
                //  浪漫
                GPUImageOutput<GPUImageInput> *filterNostalgia = [self createFilterForRomantic:fromSystemCamera];
                if (filterNostalgia == nil)
                {
                    [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeFilterNostalgia]];
                }
                else
                {
                    [themesFilter setObject:filterNostalgia forKey:[NSNumber numberWithInt:kThemeFilterNostalgia]];
                }
                break;
            }
            case kThemeFilterOldFilm:
            {
                // 老电影
                GPUImageOutput<GPUImageInput> *filterOldFilm = [self createFilterForOldFilm:fromSystemCamera];
                if (filterOldFilm == nil)
                {
                    [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeFilterOldFilm]];
                }
                else
                {
                    [themesFilter setObject:filterOldFilm forKey:[NSNumber numberWithInt:kThemeFilterOldFilm]];
                }
                break;
            }
            case kThemeFilterNiceDay:
            {
                // Nice day
                GPUImageOutput<GPUImageInput> *filterNiceDay = [self createFilterForNiceDay:fromSystemCamera];
                if (filterNiceDay == nil)
                {
                    [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeFilterNiceDay]];
                }
                else
                {
                    [themesFilter setObject:filterNiceDay forKey:[NSNumber numberWithInt:kThemeFilterNiceDay]];
                }
                break;
            }
            case kThemeFilterSky:
            {
                // 星空
                GPUImageOutput<GPUImageInput> *filterSky = [self createFilterForSky:fromSystemCamera];
                if (filterSky == nil)
                {
                    [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeFilterSky]];
                }
                else
                {
                    [themesFilter setObject:filterSky forKey:[NSNumber numberWithInt:kThemeFilterSky]];
                }
                break;
            }
            case kThemeFilterFashion:
            {
                // 时尚
                GPUImageOutput<GPUImageInput> *filterFashion = [self createFilterForFashion:fromSystemCamera];
                if (filterFashion == nil)
                {
                    [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeFilterFashion]];
                }
                else
                {
                    [themesFilter setObject:filterFashion forKey:[NSNumber numberWithInt:kThemeFilterFashion]];
                }
                break;
            }
            case kThemeFilterBirthday:
            {
                // 生日
                GPUImageOutput<GPUImageInput> *filterBirthday = [self createFilterForBirthday:fromSystemCamera];
                if (filterBirthday == nil)
                {
                    [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeFilterBirthday]];
                }
                else
                {
                    [themesFilter setObject:filterBirthday forKey:[NSNumber numberWithInt:kThemeFilterBirthday]];
                }
                break;
            }
                       default:
                break;
        }
    }
    return [themesFilter retain];
}

- (GPUImageOutput<GPUImageInput> *) createThemeFilter:(ThemesFilterType)themeType fromSystemCamera:(BOOL)fromSystemCamera
{
    GPUImageOutput<GPUImageInput> *filter = nil;
    switch (themeType)
    {
        case kThemeFilterNone:
        {
            break;
        }
        case kThemeFilterMood:
        {
            filter = [self createFilterForMood:fromSystemCamera];
            break;
        }
        case kThemeFilterNostalgia:
        {
            filter = [self createFilterForRomantic:fromSystemCamera];
            break;
        }
        case kThemeFilterOldFilm:
        {
            filter = [self createFilterForOldFilm:fromSystemCamera];
            break;
        }
        case kThemeFilterNiceDay:
        {
            filter = [self createFilterForNiceDay:fromSystemCamera];
            break;
        }
        case kThemeFilterSky:
        {
            filter = [self createFilterForSky:fromSystemCamera];
            break;
        }
        case kThemeFilterFashion:
        {
            filter = [self createFilterForFashion:fromSystemCamera];
            break;
        }
        case kThemeFilterBirthday:
        {
            filter = [self createFilterForBirthday:fromSystemCamera];
            break;
        }
            default:
            break;
    }
    
    return filter;
}

- (NSMutableDictionary*) getThemeFilter:(BOOL)fromSystemCamera
{
    if (fromSystemCamera)
    {
        return self.filterFromSystemCamera;
    }
    else
    {
        return self.filterFromOthers;
    }
}

- (NSMutableDictionary*) getFilterData
{
    return self.themesDic;
}

- (NSString *)myName:(ThemesFilterType)type{
    
    NSString *str = nil;
    switch (type) {
        case kThemeFilterNone:{
            str = @"kThemeFilterNone";
            break;
        }
        case kThemeFilterMood:{
            str = @"kThemeFilterMood";
            break;
        }
        case kThemeFilterNostalgia:{
            str = @"kThemeFilterNostalgia";
            break;
        }
        case kThemeFilterOldFilm:{
            str = @"kThemeFilterOldFilm";
            break;
        }
        case kThemeFilterNiceDay:{
            str = @"kThemeFilterNiceDay";
            break;
        }
        case kThemeFilterSky:{
            str = @"kThemeFilterSky";
            break;
        }
        case kThemeFilterFashion:{
            str = @"kThemeFilterFashion";
            break;
        }
        case kThemeFilterBirthday:{
            str = @"kThemeFilterBirthday";
            break;
        }

        default:
            break;
    }
    return str;
}




@end
