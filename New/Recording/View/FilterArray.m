//
//  FilterArray.m
//  ZhongRenBang
//
//  Created by 童臣001 on 16/6/28.
//  Copyright © 2016年 ZengWei. All rights reserved.
//

#import "FilterArray.h"

@implementation FilterArray

+(NSArray *)creatFilterArray{
    
    NSMutableArray * arr = [NSMutableArray arrayWithCapacity:0];
    
    GPUImageOutput<GPUImageInput> * Filter0 = [[GPUImageRGBFilter alloc] init];
    NSString * title0 = @"RGB";
    [(GPUImageRGBFilter *)Filter0 setRed:0.8];
    [(GPUImageRGBFilter *)Filter0 setGreen:0.3];
    [(GPUImageRGBFilter *)Filter0 setBlue:0.5];
    NSDictionary * dic0 = [NSDictionary dictionaryWithObjectsAndKeys:Filter0,@"filter",title0,@"name", nil];
    [arr addObject:dic0];
    
    GPUImageOutput<GPUImageInput> * Filter1 = [[GPUImageMonochromeFilter alloc] init];
    [(GPUImageMonochromeFilter *)Filter1 setColorRed:0.3 green:0.5 blue:0.8];
    NSString * title1 = @"单色";
    NSDictionary * dic1 = [NSDictionary dictionaryWithObjectsAndKeys:Filter1,@"filter",title1,@"name", nil];
    [arr addObject:dic1];
    
    GPUImageOutput<GPUImageInput> * Filter2 = [[GPUImageSepiaFilter alloc] init];
    NSString * title2 = @"怀旧";
    NSDictionary * dic2 = [NSDictionary dictionaryWithObjectsAndKeys:Filter2,@"filter",title2,@"name", nil];
    [arr addObject:dic2];
    
    GPUImageOutput<GPUImageInput> * Filter3 = [[GPUImageSoftLightBlendFilter alloc] init];
    NSString * title3 = @"柔光";
    NSDictionary * dic3 = [NSDictionary dictionaryWithObjectsAndKeys:Filter3,@"filter",title3,@"name", nil];
    [arr addObject:dic3];
    
    GPUImageOutput<GPUImageInput> * Filter4 = [[GPUImageColorPackingFilter alloc] init];
    NSString * title4 = @"监控";
    NSDictionary * dic4 = [NSDictionary dictionaryWithObjectsAndKeys:Filter4,@"filter",title4,@"name", nil];
    [arr addObject:dic4];
    
    GPUImageOutput<GPUImageInput> * Filter11 = [[GPUImageColorInvertFilter alloc] init];
    NSString * title11 = @"黑白";
    NSDictionary * dic11 = [NSDictionary dictionaryWithObjectsAndKeys:Filter11,@"filter",title11,@"name", nil];
    [arr addObject:dic11];
    
    GPUImageOutput<GPUImageInput> * Filter15 = [[GPUImageSketchFilter alloc] init];
    NSString * title15 = @"素描";
    NSDictionary * dic15 = [NSDictionary dictionaryWithObjectsAndKeys:Filter15,@"filter",title15,@"name", nil];
    [arr addObject:dic15];
    
    GPUImageOutput<GPUImageInput> * Filter16 = [[GPUImageSmoothToonFilter alloc] init];
    NSString * title16 = @"卡通";
    NSDictionary * dic16 = [NSDictionary dictionaryWithObjectsAndKeys:Filter16,@"filter",title16,@"name", nil];
    [arr addObject:dic16];
    
    GPUImageOutput<GPUImageInput> * Filter17 = [[GPUImagePixellateFilter alloc] init];
    NSString * title17 = @"像素化";
    NSDictionary * dic17 = [NSDictionary dictionaryWithObjectsAndKeys:Filter17,@"filter",title17,@"name", nil];
    [arr addObject:dic17];
    
    return arr;
}


@end
