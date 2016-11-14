//
//  VideoThemesData.m
//  VideoBeautify
//
//  Created by Johnny Xu(徐景周) on 8/11/14.
//  Copyright (c) 2014 Future Studio. All rights reserved.
//

#import "VideoThemesData.h"
#import "GPUImage.h"
#import "DeviceHardware.h"
@interface VideoThemesData()
{
    NSMutableDictionary *_themesDic;
    NSMutableDictionary *_newThemeDic;
    NSMutableDictionary *_filterFromOthers;
    NSMutableDictionary *_filterFromSystemCamera;
}

@property (retain, nonatomic) NSMutableDictionary *themesDic;
@property (retain, nonatomic) NSMutableDictionary *newThemeDic;
@property (retain, nonatomic) NSMutableDictionary *filterFromOthers;
@property (retain, nonatomic) NSMutableDictionary *filterFromSystemCamera;


@end


@implementation VideoThemesData

@synthesize newThemeDic = _newThemeDic;
@synthesize themesDic = _themesDic;
@synthesize filterFromOthers = _filterFromOthers;
@synthesize filterFromSystemCamera = _filterFromSystemCamera;

#pragma mark - Singleton
+ (VideoThemesData *) sharedInstance
{
    static VideoThemesData *singleton = nil;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        singleton = [[VideoThemesData alloc] init];
    });
    
    return singleton;
}

#pragma mark - Life cycle
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
    
    if (self.newThemeDic && [self.newThemeDic count] > 0) {
        [self.newThemeDic removeAllObjects];
        self.newThemeDic = nil;
    }
}

#pragma mark - Common function
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

-(NSString*) getStringFromDate:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    [dateFormatter release];
    
    return strDate;
}

#pragma mark - Init themes
//默认
- (VideoThemes*) createThemeNone
{
    VideoThemes *theme = [[VideoThemes alloc] init];
    theme.ID = kThemeNone;
    theme.thumbImageName = @"MVWithNothing";
    theme.name = @"无";
    theme.textStar = nil;
    theme.textSparkle = nil;
    theme.bgMusicFile = nil;
    theme.imageFile = nil;
    
    theme.animationActions = nil;
    
    return theme;
}
//摩登时代
- (VideoThemes*) createThemeOldFilm
{
    VideoThemes *theme = [[VideoThemes alloc] init];
    theme.ID = KThemeOldFilm;
    theme.thumbImageName = @"MV摩登时代";
    theme.name = @"摩登时代";
    theme.textStar = nil;
    theme.textSparkle = @"MODEL!!!";
    theme.bgMusicFile = @"Oh My Juliet.mp3";
    theme.imageFile = nil;
    
    // Animation effects
    NSArray *aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationFlashScreen], [NSNumber numberWithInt:kAnimationTextSparkle],nil];
    theme.animationActions = [NSArray arrayWithArray:aniActions];
    return theme;
}
//百老汇
- (VideoThemes*) createThemeStarshine
{
    VideoThemes *themeStarshine = [[VideoThemes alloc] init];
    themeStarshine.ID = kThemeStarshine;
    themeStarshine.thumbImageName = @"MV百老汇";
    themeStarshine.name = @"百老汇";
    themeStarshine.textStar = nil;
    themeStarshine.textSparkle = @"Broadway";
    themeStarshine.bgMusicFile = @"Bye Bye Sunday.mp3";
    themeStarshine.imageFile = nil;
    
    // Animation effects
    NSArray *aniNostalgia = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationScrollScreen],[NSNumber numberWithInt:kAnimationFlower], nil];
    themeStarshine.animationActions = [NSArray arrayWithArray:aniNostalgia];
    return themeStarshine;
}
//迷幻
- (VideoThemes*) createThemeSky
{
    VideoThemes *theme = [[VideoThemes alloc] init];
    theme.ID = kThemeSky;
    theme.thumbImageName = @"MV迷幻";
    theme.name = @"迷幻";
    theme.textStar = nil;
    theme.textSparkle = nil;
    theme.bgMusicFile = @"A Little Kiss.mp3";
    theme.imageFile = nil;
    
    // Animation effects
    NSArray *aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationSky], [NSNumber numberWithInt:kAnimationMeteor], nil];
    theme.animationActions = [NSArray arrayWithArray:aniActions];
    
    return theme;
}
//情书
- (VideoThemes*) createThemeRomantic
{
    VideoThemes *themeRomantic = [[VideoThemes alloc] init];
    themeRomantic.ID = kThemeRomantic;
    themeRomantic.thumbImageName = @"MV情书";
    themeRomantic.name = @"情书";
    themeRomantic.textStar = nil;
    themeRomantic.textSparkle = nil;
    themeRomantic.bgMusicFile = @"Jazz Club.mp3";
    themeRomantic.imageFile = nil;
    
    // Animation effects
    NSArray *aniRomantic = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationStar],nil];
    themeRomantic.animationActions = [NSArray arrayWithArray:aniRomantic];
    
    return themeRomantic;
}
//星光游乐园
- (VideoThemes*) createThemeFlower
{
    VideoThemes *theme = [[VideoThemes alloc] init];
    theme.ID = kThemeFlower;
    theme.thumbImageName = @"MV星光游乐园";
    theme.name = @"星光游乐园";
    theme.textStar = nil;
    theme.textSparkle = nil;
    theme.bgMusicFile = @"Lost In Manhattan.mp3";
    theme.imageFile = nil;
    theme.textGradient = @"nice!";
    
    NSMutableArray *imagesArray = [[NSMutableArray alloc] init];
    for (int i = 1; i<4; i++)
    {
        NSString *imageName = [NSString stringWithFormat:@"ani_%d.png",i];
        UIImage *image = [UIImage imageNamed:imageName];
        [imagesArray addObject:(id)image.CGImage];
    }
    theme.animationImages = imagesArray;
    
    [imagesArray release];
    
    NSArray *frameTimesArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:4], nil];
    theme.keyFrameTimes = frameTimesArray;
    
    // Animation effects
    NSArray *aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationFlower], [NSNumber numberWithInt:kAnimationImageArray], [NSNumber numberWithInt:kAnimationVideoFrame], [NSNumber numberWithInt:kAnimationTextGradient],nil];
    theme.animationActions = [NSArray arrayWithArray:aniActions];
    
    return theme;
}
//OneDay
- (VideoThemes*) createThemeNiceDay
{
    VideoThemes *theme = [[VideoThemes alloc] init];
    theme.ID = kThemeNiceDay;
    theme.thumbImageName = @"MVoneday";
    theme.name = @"oneday";
    theme.textStar = nil;
    theme.textSparkle = nil;
    theme.textGradient = @"Nice Day!";
    theme.bgMusicFile = @"Swing Dance.mp3";
    theme.imageFile = nil;
    theme.scrollText = nil;
    
    // Filter
    //    theme.filter = [self createFilterNiceDay:fromSystemCamera];
    
    // Animation effects
    NSArray *aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationSpotlight], [NSNumber numberWithInt:kAnimationTextGradient], [NSNumber numberWithInt:kAnimationRipple], nil];
    theme.animationActions = [NSArray arrayWithArray:aniActions];

    
    return theme;
}
//MVSHOW@2x
- (VideoThemes*) createThemeClassic
{
    VideoThemes *themeClassic = [[VideoThemes alloc] init];
    themeClassic.ID = kThemeClassic;
    themeClassic.thumbImageName = @"MVSHOW";
    themeClassic.name = @"SHOW";
    themeClassic.textStar = nil;
    themeClassic.textSparkle = nil;
    themeClassic.bgMusicFile = @"Swing Dance Two.mp3";
    themeClassic.imageFile = nil;
    
    // Scroll text
    NSMutableArray *scrollText = [[NSMutableArray alloc] init];
    [scrollText addObject:(id)[self getStringFromDate:[NSDate date]]];
    [scrollText addObject:(id)[self getWeekdayFromDate:[NSDate date]]];
    [scrollText addObject:(id)@"It's a beautiful day!"];
    themeClassic.scrollText = scrollText;
    
    [scrollText release];
    
    // Filter
    //    theme.filter = [self createFilterOldFilm:fromSystemCamera];
    
    // Animation effects
    NSArray *aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationScrollScreen], [NSNumber numberWithInt:kAnimationTextScroll], [NSNumber numberWithInt:kAnimationBlackWhiteDot], [NSNumber numberWithInt:kAnimationScrollLine], [NSNumber numberWithInt:kAnimationFlashScreen], nil];
    themeClassic.animationActions = [NSArray arrayWithArray:aniActions];
    return themeClassic;
}

- (VideoThemes *)createThemeCustom{
    VideoThemes *themeCustom = [[VideoThemes alloc]init];
    themeCustom.ID = kThemeCustom;
    
    return themeCustom;
}

#pragma  mark --创建data
- (void) initThemesData
{
    self.themesDic = [NSMutableDictionary dictionaryWithCapacity:15];
    
    VideoThemes *theme = nil;
    for (int i = kThemeNone; i <= kThemeClassic; ++i)
    {
        switch (i)
        {
            case kThemeNone:
            {
                // 0. 无
                theme = [self createThemeNone];
                break;
            }
            case KThemeOldFilm:
            {
                // 摩登时代
                theme = [self createThemeOldFilm];
                break;
            }
            case kThemeStarshine:
            {
                // 百老汇
                theme = [self createThemeStarshine];
                break;
            }
            case kThemeSky:
            {
                // 迷幻
                theme = [self createThemeSky];
                break;
            }
            case kThemeRomantic:
            {
                // 情书
                theme = [self createThemeRomantic];
                break;
            }
            case kThemeFlower:
            {
                // 星光游乐园
                theme = [self createThemeFlower];
                break;
            }
            case kThemeNiceDay:
            {
                // OneDay
                theme = [self createThemeNiceDay];
                break;
            }
            case kThemeClassic:
            {
                // MVSHOW
                theme = [self createThemeClassic];
                break;
            }
            default:
                break;
        }
        
        if (i == kThemeNone)
        {
            [self.themesDic setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeNone]];
        }
        else
        {
            [self.themesDic setObject:theme forKey:[NSNumber numberWithInt:i]];
        }
    }
}
#pragma  mark -创建滤镜
//摩登时代
- (GPUImageOutput<GPUImageInput> *) createFilterMood:(BOOL)fromSystemCamera
{
    // Filter
    GPUImageOutput<GPUImageInput> *filterMood = [[[GPUImageFilterGroup alloc] init]autorelease];
    
    CGFloat rotationAngle = 0;
//    if (fromSystemCamera)
//    {
//        rotationAngle = M_PI_2;
//    }
    GPUImageTransformFilter *transformFilter = [[GPUImageTransformFilter alloc] init];
    [(GPUImageTransformFilter *)transformFilter setAffineTransform:CGAffineTransformMakeRotation(rotationAngle)];
    [(GPUImageTransformFilter *)transformFilter setIgnoreAspectRatio:YES];
    [(GPUImageFilterGroup *)filterMood addFilter:transformFilter];
    
    GPUImageBorderFilter *borderFilter = [[GPUImageBorderFilter alloc] init];
    NSString *borderImageName = @"border_25";
    ((GPUImageBorderFilter*)borderFilter).borderImage = [UIImage imageNamed:borderImageName];
    [(GPUImageFilterGroup *)filterMood addFilter:borderFilter];
    
    
    GPULookupFilterEx *lookupFilter = [[GPULookupFilterEx alloc] initWithName:@"milk" isWhiteAndBlack:YES];
    [(GPUImageFilterGroup *)filterMood addFilter:lookupFilter];
    
    
    [lookupFilter addTarget:borderFilter];
    [transformFilter addTarget:lookupFilter];
    
    
    [(GPUImageFilterGroup *)filterMood setInitialFilters:[NSArray arrayWithObject:transformFilter]];
    [(GPUImageFilterGroup *)filterMood setTerminalFilter:borderFilter];
    
    [transformFilter release];
    transformFilter = nil;
    [lookupFilter release];
    lookupFilter = nil;
    [borderFilter release];
    borderFilter = nil;
    
    return filterMood;
}
//
- (GPUImageOutput<GPUImageInput> *) createFilterFlower:(BOOL)fromSystemCamera
{
    // Filter
    GPUImageOutput<GPUImageInput> *filterNostalgia = [[[GPUImageFilterGroup alloc] init]autorelease];
    
    CGFloat rotationAngle = 0;
//    if (fromSystemCamera)
//    {
//        rotationAngle = M_PI_2;
//    }
    GPUImageTransformFilter *transformFilter = [[GPUImageTransformFilter alloc] init];
    [(GPUImageTransformFilter *)transformFilter setAffineTransform:CGAffineTransformMakeRotation(rotationAngle)];
    [(GPUImageTransformFilter *)transformFilter setIgnoreAspectRatio:YES];
    [(GPUImageFilterGroup *)filterNostalgia addFilter:transformFilter];
    
    GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
    [(GPUImageFilterGroup *)filterNostalgia addFilter:sepiaFilter];
    
    GPUImageVignetteFilter *vignetteFilter = [[GPUImageVignetteFilter alloc] init];
    [(GPUImageVignetteFilter *)vignetteFilter setVignetteEnd:0.7];
    [(GPUImageFilterGroup *)filterNostalgia addFilter:vignetteFilter];
    
    GPUImageBorderFilter *borderFilter = [[GPUImageBorderFilter alloc] init];
    NSString *borderImageName = @"border_14";
    ((GPUImageBorderFilter*)borderFilter).borderImage = [UIImage imageNamed:borderImageName];
    [(GPUImageFilterGroup *)filterNostalgia addFilter:borderFilter];
    
    [vignetteFilter addTarget:borderFilter];
    [sepiaFilter addTarget:vignetteFilter];
    [transformFilter addTarget:sepiaFilter];
    
    [(GPUImageFilterGroup *)filterNostalgia setInitialFilters:[NSArray arrayWithObject:transformFilter]];
    [(GPUImageFilterGroup *)filterNostalgia setTerminalFilter:borderFilter];
    
    [transformFilter release];
    transformFilter = nil;
    [sepiaFilter release];
    sepiaFilter = nil;
    [vignetteFilter release];
    vignetteFilter = nil;
    [borderFilter release];
    borderFilter = nil;
    
    return filterNostalgia;
}
//摩登时代
- (GPUImageOutput<GPUImageInput> *) createFilterOldFilm:(BOOL)fromSystemCamera
{
    // Filter
    GPUImageOutput<GPUImageInput> *filterOldFilm = [[[GPUImageFilterGroup alloc] init] autorelease];
    
    CGFloat rotationAngle = 0;
//    if (fromSystemCamera)
//    {
//        rotationAngle = M_PI_2;
//    }
    // If this is from system camera, it will rotate 90c
    GPUImageTransformFilter *transformFilter = [[GPUImageTransformFilter alloc] init];
    [(GPUImageTransformFilter *)transformFilter setAffineTransform:CGAffineTransformMakeRotation(rotationAngle)];
    [(GPUImageTransformFilter *)transformFilter setIgnoreAspectRatio:YES];
    [(GPUImageFilterGroup *)filterOldFilm addFilter:transformFilter];
    
    GPUImageBorderFilter *borderFilter = [[GPUImageBorderFilter alloc] init];
    NSString *borderImageName = @"border_22";
    ((GPUImageBorderFilter*)borderFilter).borderImage = [UIImage imageNamed:borderImageName];
    [(GPUImageFilterGroup *)filterOldFilm addFilter:borderFilter];
    
    GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
    [(GPUImageFilterGroup *)filterOldFilm addFilter:sepiaFilter];
    
    GPUImageEmbossFilter *embossFilter = [[GPUImageEmbossFilter alloc] init];
    [(GPUImageEmbossFilter *)embossFilter setIntensity:0.2];
    [(GPUImageFilterGroup *)filterOldFilm addFilter:embossFilter];
    
    [sepiaFilter addTarget:borderFilter];
    [embossFilter addTarget:sepiaFilter];
    [transformFilter addTarget:embossFilter];
    
    [(GPUImageFilterGroup *)filterOldFilm setInitialFilters:[NSArray arrayWithObject:transformFilter]];
    [(GPUImageFilterGroup *)filterOldFilm setTerminalFilter:borderFilter];
    
    [transformFilter release];
    transformFilter = nil;
    [embossFilter release];
    embossFilter = nil;
    [sepiaFilter release];
    sepiaFilter = nil;
    [borderFilter release];
    borderFilter = nil;
    
    return filterOldFilm;
}
//oneday
- (GPUImageOutput<GPUImageInput> *) createFilterNiceDay:(BOOL)fromSystemCamera
{
    // Filter
    GPUImageTransformFilter *transformFilter = nil;
    if (fromSystemCamera)
    {
        // If this is from system camera, it will rotate 90c
        transformFilter = [[[GPUImageTransformFilter alloc] init] autorelease];
        [(GPUImageTransformFilter *)transformFilter setAffineTransform:CGAffineTransformMakeRotation(0)];
        [(GPUImageTransformFilter *)transformFilter setIgnoreAspectRatio:YES];
    }
    
    return transformFilter;
}
//sky
- (GPUImageOutput<GPUImageInput> *) createFilterSky:(BOOL)fromSystemCamera
{
    // Filter
    GPUImageOutput<GPUImageInput> *filterMood = [[[GPUImageFilterGroup alloc] init] autorelease];
    
    CGFloat rotationAngle = 0;
    //    if (fromSystemCamera)
    //    {
    //        rotationAngle = M_PI_2;
    //    }
    GPUImageTransformFilter *transformFilter = [[GPUImageTransformFilter alloc] init];
    [(GPUImageTransformFilter *)transformFilter setAffineTransform:CGAffineTransformMakeRotation(rotationAngle)];
    [(GPUImageTransformFilter *)transformFilter setIgnoreAspectRatio:YES];
    [(GPUImageFilterGroup *)filterMood addFilter:transformFilter];
    
    GPULookupFilterEx *lookupFilter = [[GPULookupFilterEx alloc] initWithName:@"smoky" isWhiteAndBlack:YES];
    [(GPUImageFilterGroup *)filterMood addFilter:lookupFilter];
    
    [transformFilter addTarget:lookupFilter];
    
    [(GPUImageFilterGroup *)filterMood setInitialFilters:[NSArray arrayWithObject:transformFilter]];
    [(GPUImageFilterGroup *)filterMood setTerminalFilter:lookupFilter];
    
    [transformFilter release];
    transformFilter = nil;
    [lookupFilter release];
    lookupFilter = nil;
    return filterMood;
}

//fashion
- (GPUImageOutput<GPUImageInput> *) createFilterFashion:(BOOL)fromSystemCamera
{
    // Filter
    GPUImageSaturationFilter *filterFashion = [[[GPUImageSaturationFilter alloc] init] autorelease];
    filterFashion.saturation = 2;
    return filterFashion;
}
//生日
- (GPUImageOutput<GPUImageInput> *) createFilterBirthday:(BOOL)fromSystemCamera
{
    // Filter
    GPUImageOutput<GPUImageInput> *filterBirthday = [[[GPUImageFilterGroup alloc] init] autorelease];
    
    CGFloat rotationAngle = 0;
//    if (fromSystemCamera)
//    {
//        rotationAngle = M_PI_2;
//    }
    // If this is from system camera, it will rotate 90c
    GPUImageTransformFilter *transformFilter = [[GPUImageTransformFilter alloc] init];
    [(GPUImageTransformFilter *)transformFilter setAffineTransform:CGAffineTransformMakeRotation(rotationAngle)];
    [(GPUImageTransformFilter *)transformFilter setIgnoreAspectRatio:YES];
    [(GPUImageFilterGroup *)filterBirthday addFilter:transformFilter];
    
    GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
    [(GPUImageFilterGroup *)filterBirthday addFilter:sepiaFilter];
    [transformFilter addTarget:sepiaFilter];
    
    
    [(GPUImageFilterGroup *)filterBirthday setInitialFilters:[NSArray arrayWithObject:transformFilter]];
    [(GPUImageFilterGroup *)filterBirthday setTerminalFilter:sepiaFilter];
    
    [transformFilter release];
    transformFilter = nil;
    [sepiaFilter release];
    sepiaFilter = nil;
    
    return filterBirthday;

}

#pragma  mark ---创建滤镜
- (NSMutableDictionary*) initThemeFilter:(BOOL)fromSystemCamera
{
    NSMutableDictionary *themesFilter = [NSMutableDictionary dictionaryWithCapacity:15];
    
    for (int i = kThemeNone; i < self.themesDic.count; ++i)
    {
        switch (i)
        {
            case kThemeNone:
            {
                [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeNone]];
                break;
            }
            case KThemeOldFilm:
            {
                // 心情
                GPUImageOutput<GPUImageInput> *filterMood = [self createFilterMood:fromSystemCamera];
                if (filterMood == nil)
                {
                    [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:KThemeOldFilm]];
                }
                else
                {
                    [themesFilter setObject:filterMood forKey:[NSNumber numberWithInt:KThemeOldFilm]];
                }
                
                break;
            }
            case kThemeStarshine:
            {
                // 怀旧
                GPUImageOutput<GPUImageInput> *filterNostalgia = [self createFilterFlower:fromSystemCamera];
                if (filterNostalgia == nil)
                {
                    [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeStarshine]];
                }
                else
                {
                    [themesFilter setObject:filterNostalgia forKey:[NSNumber numberWithInt:kThemeStarshine]];
                }

                break;
            }
            case kThemeSky:
            {
                // 老电影
                GPUImageOutput<GPUImageInput> *filterOldFilm = [self createFilterOldFilm:fromSystemCamera];
                if (filterOldFilm == nil)
                {
                    [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeSky]];
                }
                else
                {
                    [themesFilter setObject:filterOldFilm forKey:[NSNumber numberWithInt:kThemeSky]];
                }

                break;
            }
            case kThemeRomantic:
            {
                // Nice day
                GPUImageOutput<GPUImageInput> *filterNiceDay = [self createFilterNiceDay:fromSystemCamera];
                if (filterNiceDay == nil)
                {
                    [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeRomantic]];
                }
                else
                {
                    [themesFilter setObject:filterNiceDay forKey:[NSNumber numberWithInt:kThemeRomantic]];
                }
                
                break;
            }
            case kThemeFlower:
            {
                // 星空
                GPUImageOutput<GPUImageInput> *filterSky = [self createFilterSky:fromSystemCamera];
                if (filterSky == nil)
                {
                    [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeFlower]];
                }
                else
                {
                    [themesFilter setObject:filterSky forKey:[NSNumber numberWithInt:kThemeFlower]];
                }
                
                break;
            }
            case kThemeNiceDay:
            {
                // 时尚
                GPUImageOutput<GPUImageInput> *filterFashion = [self createFilterFashion:fromSystemCamera];
                if (filterFashion == nil)
                {
                    [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeNiceDay]];
                }
                else
                {
                    [themesFilter setObject:filterFashion forKey:[NSNumber numberWithInt:kThemeNiceDay]];
                }
                
                break;
            }
            case kThemeClassic:
            {
                // 生日
                GPUImageOutput<GPUImageInput> *filterBirthday = [self createFilterBirthday:fromSystemCamera];
                if (filterBirthday == nil)
                {
                    [themesFilter setObject:[NSNull null] forKey:[NSNumber numberWithInt:kThemeClassic]];
                }
                else
                {
                    [themesFilter setObject:filterBirthday forKey:[NSNumber numberWithInt:kThemeClassic]];
                }

                break;
            }
            default:
                break;
        }
    }

    return [themesFilter retain];
}

- (GPUImageOutput<GPUImageInput> *) createThemeFilter:(ThemesType)themeType fromSystemCamera:(BOOL)fromSystemCamera
{
    GPUImageOutput<GPUImageInput> *filter = nil;
    switch (themeType)
    {
        case kThemeNone:
        {
            break;
        }
        case KThemeOldFilm:
        {
            filter = [self createFilterMood:fromSystemCamera];
            break;
        }
        case kThemeStarshine:
        {
            filter = [self createFilterFlower:fromSystemCamera];
            break;
        }
        case kThemeSky:
        {
            filter = [self createFilterOldFilm:fromSystemCamera];
            break;
        }
        case kThemeRomantic:
        {
            filter = [self createFilterNiceDay:fromSystemCamera];
            break;
        }
        case kThemeFlower:
        {
            filter = [self createFilterSky:fromSystemCamera];
            break;
        }
        case kThemeNiceDay:
        {
            filter = [self createFilterFashion:fromSystemCamera];
            break;
        }
        case kThemeClassic:
        {
            filter = [self createFilterBirthday:fromSystemCamera];
            break;
        }
            default:
            break;
    }
    
    return filter;
}

- (NSMutableDictionary*) getThemeFilter:(BOOL)fromSystemCamera{
    if (fromSystemCamera)
    {
        return self.filterFromSystemCamera;
    }
    else
    {
        return self.filterFromOthers;
    }
}

- (NSMutableDictionary*) getThemesData{
    return self.themesDic;
}

#pragma mark -new
- (NSString*) getVideoBorderByIndex:(int)index
{
    NSString *videoBorder = nil;
    if (index >= 0 && index <= 10)
    {
        videoBorder = [NSString stringWithFormat:@"border_%i", index];
    }
    
    return videoBorder;
}

- (VideoThemes*) getThemeByType:(ThemesType)themeType
{
    if (self.themesDic && [self.themesDic count]>0)
    {
        VideoThemes* theme = [self.themesDic objectForKey:[NSNumber numberWithInt:themeType]];
        if (theme && ((NSNull*)theme != [NSNull null]))
        {
            return theme;
        }
    }
    
    return nil;
}

- (NSArray*) getRandomAnimation
{
    // Animation effects
    NSArray *aniActions = [self getAnimationByIndex:(arc4random() % 8)];
    return aniActions;
}

- (NSArray*) getAnimationByIndex:(int)index
{
    // Animation effects
    NSArray *aniActions = nil;
    switch (index)
    {
        case 0:
        {
            aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationVideoBorder], [NSNumber numberWithInt:kAnimationPhotoParallax], [NSNumber numberWithInt:kAnimationTextStar], [NSNumber numberWithInt:kAnimationTextScroll], [NSNumber numberWithInt:kAnimationTextGradient], [NSNumber numberWithInt:kAnimationTextSparkle], nil];
            
            break;
        }
        case 1:
        {
            aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationVideoBorder], [NSNumber numberWithInt:kAnimationPhotoCloud], [NSNumber numberWithInt:KAnimationPhotoCentringShow], [NSNumber numberWithInt:kAnimationTextStar], [NSNumber numberWithInt:kAnimationTextScroll], [NSNumber numberWithInt:kAnimationTextGradient], [NSNumber numberWithInt:kAnimationTextSparkle], nil];
            
            break;
        }
        case 2:
        {
            aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationVideoBorder], [NSNumber numberWithInt:kAnimationPhotoExplodeDrop], [NSNumber numberWithInt:KAnimationPhotoCentringShow], [NSNumber numberWithInt:kAnimationTextStar], [NSNumber numberWithInt:kAnimationTextScroll], [NSNumber numberWithInt:kAnimationTextGradient], [NSNumber numberWithInt:kAnimationTextSparkle], nil];
            
            break;
        }
        case 3:
        {
            aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationVideoBorder], [NSNumber numberWithInt:kAnimationPhotoExplode], [NSNumber numberWithInt:kAnimationPhotoSpin360], [NSNumber numberWithInt:kAnimationTextStar],  [NSNumber numberWithInt:kAnimationTextScroll], [NSNumber numberWithInt:kAnimationTextGradient], [NSNumber numberWithInt:kAnimationTextSparkle], nil];
            
            break;
        }
        case 4:
        {
            aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationVideoBorder], [NSNumber numberWithInt:kAnimationPhotoEmitter], [NSNumber numberWithInt:kAnimationTextStar], [NSNumber numberWithInt:kAnimationTextScroll], [NSNumber numberWithInt:kAnimationTextGradient], [NSNumber numberWithInt:kAnimationTextSparkle], nil];
            
            break;
        }
        case 5:
        {
            aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationVideoBorder], [NSNumber numberWithInt:kAnimationPhotoFlare], [NSNumber numberWithInt:kAnimationSky], [NSNumber numberWithInt:kAnimationTextStar], [NSNumber numberWithInt:kAnimationTextScroll], [NSNumber numberWithInt:kAnimationTextGradient], [NSNumber numberWithInt:kAnimationTextSparkle], nil];
            
            break;
        }
        case 6:
        {
            aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationVideoBorder], [NSNumber numberWithInt:kAnimationPhotoParabola], [NSNumber numberWithInt:kAnimationMoveDot], [NSNumber numberWithInt:kAnimationTextStar], [NSNumber numberWithInt:kAnimationTextScroll], [NSNumber numberWithInt:kAnimationTextGradient], [NSNumber numberWithInt:kAnimationTextSparkle], nil];
            
            break;
        }
        case 7:
        {
            aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationVideoBorder], [NSNumber numberWithInt:kAnimationMeteor], [NSNumber numberWithInt:kAnimationPhotoDrop], [NSNumber numberWithInt:kAnimationTextStar], [NSNumber numberWithInt:kAnimationTextScroll], [NSNumber numberWithInt:kAnimationTextGradient], [NSNumber numberWithInt:kAnimationTextSparkle], nil];
            
            break;
        }
        case 8:
        {
            if (([DeviceHardware specificPlatform] <= DeviceHardwareGeneralPlatform_iPhone_4S) || ([DeviceHardware specificPlatform] == DeviceHardwareGeneralPlatform_iPad_2) || ([DeviceHardware specificPlatform] == DeviceHardwareGeneralPlatform_iPad))
            {
                aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationVideoBorder], [NSNumber numberWithInt:kAnimationPhotoFlare], [NSNumber numberWithInt:KAnimationPhotoCentringShow], [NSNumber numberWithInt:kAnimationTextStar], [NSNumber numberWithInt:kAnimationTextScroll], [NSNumber numberWithInt:kAnimationTextGradient], [NSNumber numberWithInt:kAnimationTextSparkle], nil];
            }
            else
            {
                aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationVideoBorder], [NSNumber numberWithInt:kAnimationPhotoLinearScroll], [NSNumber numberWithInt:KAnimationPhotoCentringShow], [NSNumber numberWithInt:kAnimationTextStar], [NSNumber numberWithInt:kAnimationTextScroll], [NSNumber numberWithInt:kAnimationTextGradient], [NSNumber numberWithInt:kAnimationTextSparkle], nil];
            }
            break;
        }
        default:
        {
            aniActions = [NSArray arrayWithObjects:[NSNumber numberWithInt:kAnimationVideoBorder], [NSNumber numberWithInt:kAnimationSky], [NSNumber numberWithInt:kAnimationTextStar], [NSNumber numberWithInt:kAnimationTextScroll], [NSNumber numberWithInt:kAnimationTextGradient], [NSNumber numberWithInt:kAnimationTextSparkle], nil];
            
            break;
        }
    }
    
    return aniActions;
}

- (NSMutableDictionary*) getNewThemeDic{
    return self.newThemeDic;
}

- (NSString *)myTypeName:(ThemesType)type{
    NSString *str = nil;
    switch (type) {
        case kThemeNone:{
            str = @"kThemeNone";
            break;
        }
        case KThemeOldFilm:{
            str = @"KThemeOldFilm";
            break;
        }
        case kThemeStarshine:{
            str = @"kThemeStarshine";
            break;
        }
        case kThemeSky:{
            str = @"kThemeSky";
            break;
        }
        case kThemeRomantic:{
            str = @"kThemeRomantic";
            break;
        }
        case kThemeFlower:{
            str = @"kThemeFlower";
            break;
        }
        case kThemeNiceDay:{
            str = @"kThemeNiceDay";
            break;
        }
        case kThemeClassic:{
            str = @"kThemeClassic";
            break;
        }
        case kThemeCustom:{
            str = @"kThemeCustom";
            break;
        }
            
        default:
            break;
    }
    return str;
}


@end
