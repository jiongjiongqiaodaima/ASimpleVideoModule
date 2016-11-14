//
//  VideoPlayDetailsBaseClass.h
//
//  Created by   on 16/8/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VideoPlayDetailsMessageHelper;

@interface VideoPlayDetailsBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) id citys;
@property (nonatomic, assign) id status;
@property (nonatomic, assign) id videoname;
@property (nonatomic, assign) id userid;
@property (nonatomic, assign) id lat2;
@property (nonatomic, assign) id url;
@property (nonatomic, assign) id area;
@property (nonatomic, assign) id type;
@property (nonatomic, assign) id videoimg;
@property (nonatomic, assign) double myvideoId;
@property (nonatomic, strong) NSString *myvideo;
@property (nonatomic, assign) id longt2;
@property (nonatomic, assign) id city;
@property (nonatomic, assign) id jz;
@property (nonatomic, assign) id remark;
@property (nonatomic, assign) id weizhi;
@property (nonatomic, assign) double pageNo;
@property (nonatomic, assign) id describes;
@property (nonatomic, strong) VideoPlayDetailsMessageHelper *messageHelper;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
