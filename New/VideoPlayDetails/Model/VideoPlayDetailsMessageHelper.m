//
//  VideoPlayDetailsMessageHelper.m
//
//  Created by   on 16/8/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "VideoPlayDetailsMessageHelper.h"
#import "VideoPlayDetailsEntity.h"


NSString *const kVideoPlayDetailsMessageHelperResult = @"result";
NSString *const kVideoPlayDetailsMessageHelperMessage = @"message";
NSString *const kVideoPlayDetailsMessageHelperList = @"list";
NSString *const kVideoPlayDetailsMessageHelperResultMap = @"resultMap";
NSString *const kVideoPlayDetailsMessageHelperEntity = @"entity";


@interface VideoPlayDetailsMessageHelper ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VideoPlayDetailsMessageHelper

@synthesize result = _result;
@synthesize message = _message;
@synthesize list = _list;
@synthesize resultMap = _resultMap;
@synthesize entity = _entity;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.result = [self objectOrNilForKey:kVideoPlayDetailsMessageHelperResult fromDictionary:dict];
            self.message = [self objectOrNilForKey:kVideoPlayDetailsMessageHelperMessage fromDictionary:dict];
            self.list = [self objectOrNilForKey:kVideoPlayDetailsMessageHelperList fromDictionary:dict];
            self.resultMap = [self objectOrNilForKey:kVideoPlayDetailsMessageHelperResultMap fromDictionary:dict];
            self.entity = [VideoPlayDetailsEntity modelObjectWithDictionary:[dict objectForKey:kVideoPlayDetailsMessageHelperEntity]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.result forKey:kVideoPlayDetailsMessageHelperResult];
    [mutableDict setValue:self.message forKey:kVideoPlayDetailsMessageHelperMessage];
    [mutableDict setValue:self.list forKey:kVideoPlayDetailsMessageHelperList];
    [mutableDict setValue:self.resultMap forKey:kVideoPlayDetailsMessageHelperResultMap];
    [mutableDict setValue:[self.entity dictionaryRepresentation] forKey:kVideoPlayDetailsMessageHelperEntity];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.result = [aDecoder decodeObjectForKey:kVideoPlayDetailsMessageHelperResult];
    self.message = [aDecoder decodeObjectForKey:kVideoPlayDetailsMessageHelperMessage];
    self.list = [aDecoder decodeObjectForKey:kVideoPlayDetailsMessageHelperList];
    self.resultMap = [aDecoder decodeObjectForKey:kVideoPlayDetailsMessageHelperResultMap];
    self.entity = [aDecoder decodeObjectForKey:kVideoPlayDetailsMessageHelperEntity];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_result forKey:kVideoPlayDetailsMessageHelperResult];
    [aCoder encodeObject:_message forKey:kVideoPlayDetailsMessageHelperMessage];
    [aCoder encodeObject:_list forKey:kVideoPlayDetailsMessageHelperList];
    [aCoder encodeObject:_resultMap forKey:kVideoPlayDetailsMessageHelperResultMap];
    [aCoder encodeObject:_entity forKey:kVideoPlayDetailsMessageHelperEntity];
}

- (id)copyWithZone:(NSZone *)zone
{
    VideoPlayDetailsMessageHelper *copy = [[VideoPlayDetailsMessageHelper alloc] init];
    
    if (copy) {

        copy.result = [self.result copyWithZone:zone];
        copy.message = [self.message copyWithZone:zone];
        copy.list = [self.list copyWithZone:zone];
        copy.resultMap = [self.resultMap copyWithZone:zone];
        copy.entity = [self.entity copyWithZone:zone];
    }
    
    return copy;
}


@end
