//
//  VideoEffectForFilter.h
//  ZhongRenBang
//
//  Created by 童臣001 on 16/8/4.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoFilterData.h"

//effectPick
typedef enum
{
    //没有选择
    kEffectFilterPickTypeNone,
    //选择滤镜
    kEffectFilterPickTypeFilter,
    //选择mv
    kEffectFilterPickTypeMV,
    //选择贴纸
    kEffectFilterPickTypePaster,
    //选择相框
    kEffectFilterPickTypeFrame,
    //选择文字
    kEffectFilterPickTypeWorld,
    
} EffectFilterPickType;

@interface VideoEffectForFilter : NSObject
{
    ThemesFilterType _themeCurrentType;
    EffectFilterPickType _effectPickType;
}

@property (assign, nonatomic) ThemesFilterType themeCurrentType;
@property (assign, nonatomic) EffectFilterPickType effectPickType;

- (id) initWithDelegate:(id)delegate;


- (void) buildVideoBeautifyFilter:(NSString*)exportVideoFile andInputVideoURL:(NSURL*)inputVideoURL fromSystemCamera:(BOOL)fromSystemCamera;

- (void) clearAll;
- (void) pause;
- (void) resume;
@end
