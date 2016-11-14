//
//  VideoPlayDetailsMessageHelper.h
//
//  Created by   on 16/8/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VideoPlayDetailsEntity;

@interface VideoPlayDetailsMessageHelper : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *result;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) id list;
@property (nonatomic, assign) id resultMap;
@property (nonatomic, strong) VideoPlayDetailsEntity *entity;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
