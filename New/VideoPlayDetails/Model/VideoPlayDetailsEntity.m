//
//  VideoPlayDetailsEntity.m
//
//  Created by   on 16/8/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "VideoPlayDetailsEntity.h"
#import "VideoPlayDetailsListcollection.h"
#import "VideoPlayDetailsUser.h"


NSString *const kVideoPlayDetailsEntityId = @"id";
NSString *const kVideoPlayDetailsEntityLx = @"lx";
NSString *const kVideoPlayDetailsEntityListcollection = @"listcollection";
NSString *const kVideoPlayDetailsEntityCreatetime = @"createtime";
NSString *const kVideoPlayDetailsEntityVideoname = @"videoname";
NSString *const kVideoPlayDetailsEntityUserid = @"userid";
NSString *const kVideoPlayDetailsEntityVideoimg = @"videoimg";
NSString *const kVideoPlayDetailsEntityUrl = @"url";
NSString *const kVideoPlayDetailsEntityArea = @"area";
NSString *const kVideoPlayDetailsEntityWeizhi = @"weizhi";
NSString *const kVideoPlayDetailsEntityUpdatetime = @"updatetime";
NSString *const kVideoPlayDetailsEntityJl = @"jl";
NSString *const kVideoPlayDetailsEntityCity = @"city";
NSString *const kVideoPlayDetailsEntityJz = @"jz";
NSString *const kVideoPlayDetailsEntityRemark = @"remark";
NSString *const kVideoPlayDetailsEntityTypes = @"types";
NSString *const kVideoPlayDetailsEntityUser = @"user";
NSString *const kVideoPlayDetailsEntityDescribes = @"describes";
NSString *const kVideoPlayDetailsEntityStatus = @"status";


@interface VideoPlayDetailsEntity ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VideoPlayDetailsEntity

@synthesize entityIdentifier = _entityIdentifier;
@synthesize lx = _lx;
@synthesize listcollection = _listcollection;
@synthesize createtime = _createtime;
@synthesize videoname = _videoname;
@synthesize userid = _userid;
@synthesize videoimg = _videoimg;
@synthesize url = _url;
@synthesize area = _area;
@synthesize weizhi = _weizhi;
@synthesize updatetime = _updatetime;
@synthesize jl = _jl;
@synthesize city = _city;
@synthesize jz = _jz;
@synthesize remark = _remark;
@synthesize types = _types;
@synthesize user = _user;
@synthesize describes = _describes;
@synthesize status = _status;


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
            self.entityIdentifier = [[self objectOrNilForKey:kVideoPlayDetailsEntityId fromDictionary:dict] doubleValue];
            self.lx = [[self objectOrNilForKey:kVideoPlayDetailsEntityLx fromDictionary:dict] doubleValue];
    NSObject *receivedVideoPlayDetailsListcollection = [dict objectForKey:kVideoPlayDetailsEntityListcollection];
    NSMutableArray *parsedVideoPlayDetailsListcollection = [NSMutableArray array];
    if ([receivedVideoPlayDetailsListcollection isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedVideoPlayDetailsListcollection) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedVideoPlayDetailsListcollection addObject:[VideoPlayDetailsListcollection modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedVideoPlayDetailsListcollection isKindOfClass:[NSDictionary class]]) {
       [parsedVideoPlayDetailsListcollection addObject:[VideoPlayDetailsListcollection modelObjectWithDictionary:(NSDictionary *)receivedVideoPlayDetailsListcollection]];
    }

    self.listcollection = [NSArray arrayWithArray:parsedVideoPlayDetailsListcollection];
            self.createtime = [self objectOrNilForKey:kVideoPlayDetailsEntityCreatetime fromDictionary:dict];
            self.videoname = [self objectOrNilForKey:kVideoPlayDetailsEntityVideoname fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kVideoPlayDetailsEntityUserid fromDictionary:dict];
            self.videoimg = [self objectOrNilForKey:kVideoPlayDetailsEntityVideoimg fromDictionary:dict];
            self.url = [self objectOrNilForKey:kVideoPlayDetailsEntityUrl fromDictionary:dict];
            self.area = [self objectOrNilForKey:kVideoPlayDetailsEntityArea fromDictionary:dict];
            self.weizhi = [self objectOrNilForKey:kVideoPlayDetailsEntityWeizhi fromDictionary:dict];
            self.updatetime = [self objectOrNilForKey:kVideoPlayDetailsEntityUpdatetime fromDictionary:dict];
            self.jl = [self objectOrNilForKey:kVideoPlayDetailsEntityJl fromDictionary:dict];
            self.city = [self objectOrNilForKey:kVideoPlayDetailsEntityCity fromDictionary:dict];
            self.jz = [[self objectOrNilForKey:kVideoPlayDetailsEntityJz fromDictionary:dict] doubleValue];
            self.remark = [self objectOrNilForKey:kVideoPlayDetailsEntityRemark fromDictionary:dict];
            self.types = [self objectOrNilForKey:kVideoPlayDetailsEntityTypes fromDictionary:dict];
            self.user = [VideoPlayDetailsUser modelObjectWithDictionary:[dict objectForKey:kVideoPlayDetailsEntityUser]];
            self.describes = [self objectOrNilForKey:kVideoPlayDetailsEntityDescribes fromDictionary:dict];
            self.status = [self objectOrNilForKey:kVideoPlayDetailsEntityStatus fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.entityIdentifier] forKey:kVideoPlayDetailsEntityId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lx] forKey:kVideoPlayDetailsEntityLx];
    NSMutableArray *tempArrayForListcollection = [NSMutableArray array];
    for (NSObject *subArrayObject in self.listcollection) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForListcollection addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForListcollection addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForListcollection] forKey:kVideoPlayDetailsEntityListcollection];
    [mutableDict setValue:self.createtime forKey:kVideoPlayDetailsEntityCreatetime];
    [mutableDict setValue:self.videoname forKey:kVideoPlayDetailsEntityVideoname];
    [mutableDict setValue:self.userid forKey:kVideoPlayDetailsEntityUserid];
    [mutableDict setValue:self.videoimg forKey:kVideoPlayDetailsEntityVideoimg];
    [mutableDict setValue:self.url forKey:kVideoPlayDetailsEntityUrl];
    [mutableDict setValue:self.area forKey:kVideoPlayDetailsEntityArea];
    [mutableDict setValue:self.weizhi forKey:kVideoPlayDetailsEntityWeizhi];
    [mutableDict setValue:self.updatetime forKey:kVideoPlayDetailsEntityUpdatetime];
    [mutableDict setValue:self.jl forKey:kVideoPlayDetailsEntityJl];
    [mutableDict setValue:self.city forKey:kVideoPlayDetailsEntityCity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.jz] forKey:kVideoPlayDetailsEntityJz];
    [mutableDict setValue:self.remark forKey:kVideoPlayDetailsEntityRemark];
    [mutableDict setValue:self.types forKey:kVideoPlayDetailsEntityTypes];
    [mutableDict setValue:[self.user dictionaryRepresentation] forKey:kVideoPlayDetailsEntityUser];
    [mutableDict setValue:self.describes forKey:kVideoPlayDetailsEntityDescribes];
    [mutableDict setValue:self.status forKey:kVideoPlayDetailsEntityStatus];

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

    self.entityIdentifier = [aDecoder decodeDoubleForKey:kVideoPlayDetailsEntityId];
    self.lx = [aDecoder decodeDoubleForKey:kVideoPlayDetailsEntityLx];
    self.listcollection = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityListcollection];
    self.createtime = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityCreatetime];
    self.videoname = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityVideoname];
    self.userid = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityUserid];
    self.videoimg = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityVideoimg];
    self.url = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityUrl];
    self.area = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityArea];
    self.weizhi = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityWeizhi];
    self.updatetime = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityUpdatetime];
    self.jl = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityJl];
    self.city = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityCity];
    self.jz = [aDecoder decodeDoubleForKey:kVideoPlayDetailsEntityJz];
    self.remark = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityRemark];
    self.types = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityTypes];
    self.user = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityUser];
    self.describes = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityDescribes];
    self.status = [aDecoder decodeObjectForKey:kVideoPlayDetailsEntityStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_entityIdentifier forKey:kVideoPlayDetailsEntityId];
    [aCoder encodeDouble:_lx forKey:kVideoPlayDetailsEntityLx];
    [aCoder encodeObject:_listcollection forKey:kVideoPlayDetailsEntityListcollection];
    [aCoder encodeObject:_createtime forKey:kVideoPlayDetailsEntityCreatetime];
    [aCoder encodeObject:_videoname forKey:kVideoPlayDetailsEntityVideoname];
    [aCoder encodeObject:_userid forKey:kVideoPlayDetailsEntityUserid];
    [aCoder encodeObject:_videoimg forKey:kVideoPlayDetailsEntityVideoimg];
    [aCoder encodeObject:_url forKey:kVideoPlayDetailsEntityUrl];
    [aCoder encodeObject:_area forKey:kVideoPlayDetailsEntityArea];
    [aCoder encodeObject:_weizhi forKey:kVideoPlayDetailsEntityWeizhi];
    [aCoder encodeObject:_updatetime forKey:kVideoPlayDetailsEntityUpdatetime];
    [aCoder encodeObject:_jl forKey:kVideoPlayDetailsEntityJl];
    [aCoder encodeObject:_city forKey:kVideoPlayDetailsEntityCity];
    [aCoder encodeDouble:_jz forKey:kVideoPlayDetailsEntityJz];
    [aCoder encodeObject:_remark forKey:kVideoPlayDetailsEntityRemark];
    [aCoder encodeObject:_types forKey:kVideoPlayDetailsEntityTypes];
    [aCoder encodeObject:_user forKey:kVideoPlayDetailsEntityUser];
    [aCoder encodeObject:_describes forKey:kVideoPlayDetailsEntityDescribes];
    [aCoder encodeObject:_status forKey:kVideoPlayDetailsEntityStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    VideoPlayDetailsEntity *copy = [[VideoPlayDetailsEntity alloc] init];
    
    if (copy) {

        copy.entityIdentifier = self.entityIdentifier;
        copy.lx = self.lx;
        copy.listcollection = [self.listcollection copyWithZone:zone];
        copy.createtime = [self.createtime copyWithZone:zone];
        copy.videoname = [self.videoname copyWithZone:zone];
        copy.userid = [self.userid copyWithZone:zone];
        copy.videoimg = [self.videoimg copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.area = [self.area copyWithZone:zone];
        copy.weizhi = [self.weizhi copyWithZone:zone];
        copy.updatetime = [self.updatetime copyWithZone:zone];
        copy.jl = [self.jl copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.jz = self.jz;
        copy.remark = [self.remark copyWithZone:zone];
        copy.types = [self.types copyWithZone:zone];
        copy.user = [self.user copyWithZone:zone];
        copy.describes = [self.describes copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
    }
    
    return copy;
}


@end
