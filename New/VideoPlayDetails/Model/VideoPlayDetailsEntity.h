//
//  VideoPlayDetailsEntity.h
//
//  Created by   on 16/8/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VideoPlayDetailsUser;

@interface VideoPlayDetailsEntity : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double entityIdentifier;
@property (nonatomic, assign) double lx;
@property (nonatomic, strong) NSArray *listcollection;
@property (nonatomic, strong) NSString *createtime;
@property (nonatomic, strong) NSString *videoname;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *videoimg;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *weizhi;
@property (nonatomic, strong) NSString *updatetime;
@property (nonatomic, assign) id jl;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) double jz;
@property (nonatomic, assign) id remark;
@property (nonatomic, assign) id types;
@property (nonatomic, strong) VideoPlayDetailsUser *user;
@property (nonatomic, strong) NSString *describes;
@property (nonatomic, strong) NSString *status;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
