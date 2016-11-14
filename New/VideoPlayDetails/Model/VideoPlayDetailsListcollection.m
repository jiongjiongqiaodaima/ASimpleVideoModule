//
//  VideoPlayDetailsListcollection.m
//
//  Created by   on 16/8/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "VideoPlayDetailsListcollection.h"


NSString *const kVideoPlayDetailsListcollectionImgUrl = @"imgUrl";
NSString *const kVideoPlayDetailsListcollectionContent = @"content";
NSString *const kVideoPlayDetailsListcollectionUserId = @"userId";
NSString *const kVideoPlayDetailsListcollectionId = @"id";
NSString *const kVideoPlayDetailsListcollectionFbUserId = @"fbUserId";
NSString *const kVideoPlayDetailsListcollectionServiceId = @"serviceId";
NSString *const kVideoPlayDetailsListcollectionType = @"type";
NSString *const kVideoPlayDetailsListcollectionSex = @"sex";
NSString *const kVideoPlayDetailsListcollectionName = @"name";
NSString *const kVideoPlayDetailsListcollectionUser = @"user";


@interface VideoPlayDetailsListcollection ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VideoPlayDetailsListcollection

@synthesize imgUrl = _imgUrl;
@synthesize content = _content;
@synthesize userId = _userId;
@synthesize listcollectionIdentifier = _listcollectionIdentifier;
@synthesize fbUserId = _fbUserId;
@synthesize serviceId = _serviceId;
@synthesize type = _type;
@synthesize sex = _sex;
@synthesize name = _name;
@synthesize user = _user;


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
            self.imgUrl = [self objectOrNilForKey:kVideoPlayDetailsListcollectionImgUrl fromDictionary:dict];
            self.content = [self objectOrNilForKey:kVideoPlayDetailsListcollectionContent fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kVideoPlayDetailsListcollectionUserId fromDictionary:dict];
            self.listcollectionIdentifier = [[self objectOrNilForKey:kVideoPlayDetailsListcollectionId fromDictionary:dict] doubleValue];
            self.fbUserId = [self objectOrNilForKey:kVideoPlayDetailsListcollectionFbUserId fromDictionary:dict];
            self.serviceId = [[self objectOrNilForKey:kVideoPlayDetailsListcollectionServiceId fromDictionary:dict] doubleValue];
            self.type = [self objectOrNilForKey:kVideoPlayDetailsListcollectionType fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kVideoPlayDetailsListcollectionSex fromDictionary:dict];
            self.name = [self objectOrNilForKey:kVideoPlayDetailsListcollectionName fromDictionary:dict];
            self.user = [self objectOrNilForKey:kVideoPlayDetailsListcollectionUser fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.imgUrl forKey:kVideoPlayDetailsListcollectionImgUrl];
    [mutableDict setValue:self.content forKey:kVideoPlayDetailsListcollectionContent];
    [mutableDict setValue:self.userId forKey:kVideoPlayDetailsListcollectionUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.listcollectionIdentifier] forKey:kVideoPlayDetailsListcollectionId];
    [mutableDict setValue:self.fbUserId forKey:kVideoPlayDetailsListcollectionFbUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.serviceId] forKey:kVideoPlayDetailsListcollectionServiceId];
    [mutableDict setValue:self.type forKey:kVideoPlayDetailsListcollectionType];
    [mutableDict setValue:self.sex forKey:kVideoPlayDetailsListcollectionSex];
    [mutableDict setValue:self.name forKey:kVideoPlayDetailsListcollectionName];
    [mutableDict setValue:self.user forKey:kVideoPlayDetailsListcollectionUser];

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

    self.imgUrl = [aDecoder decodeObjectForKey:kVideoPlayDetailsListcollectionImgUrl];
    self.content = [aDecoder decodeObjectForKey:kVideoPlayDetailsListcollectionContent];
    self.userId = [aDecoder decodeObjectForKey:kVideoPlayDetailsListcollectionUserId];
    self.listcollectionIdentifier = [aDecoder decodeDoubleForKey:kVideoPlayDetailsListcollectionId];
    self.fbUserId = [aDecoder decodeObjectForKey:kVideoPlayDetailsListcollectionFbUserId];
    self.serviceId = [aDecoder decodeDoubleForKey:kVideoPlayDetailsListcollectionServiceId];
    self.type = [aDecoder decodeObjectForKey:kVideoPlayDetailsListcollectionType];
    self.sex = [aDecoder decodeObjectForKey:kVideoPlayDetailsListcollectionSex];
    self.name = [aDecoder decodeObjectForKey:kVideoPlayDetailsListcollectionName];
    self.user = [aDecoder decodeObjectForKey:kVideoPlayDetailsListcollectionUser];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_imgUrl forKey:kVideoPlayDetailsListcollectionImgUrl];
    [aCoder encodeObject:_content forKey:kVideoPlayDetailsListcollectionContent];
    [aCoder encodeObject:_userId forKey:kVideoPlayDetailsListcollectionUserId];
    [aCoder encodeDouble:_listcollectionIdentifier forKey:kVideoPlayDetailsListcollectionId];
    [aCoder encodeObject:_fbUserId forKey:kVideoPlayDetailsListcollectionFbUserId];
    [aCoder encodeDouble:_serviceId forKey:kVideoPlayDetailsListcollectionServiceId];
    [aCoder encodeObject:_type forKey:kVideoPlayDetailsListcollectionType];
    [aCoder encodeObject:_sex forKey:kVideoPlayDetailsListcollectionSex];
    [aCoder encodeObject:_name forKey:kVideoPlayDetailsListcollectionName];
    [aCoder encodeObject:_user forKey:kVideoPlayDetailsListcollectionUser];
}

- (id)copyWithZone:(NSZone *)zone
{
    VideoPlayDetailsListcollection *copy = [[VideoPlayDetailsListcollection alloc] init];
    
    if (copy) {

        copy.imgUrl = [self.imgUrl copyWithZone:zone];
        copy.content = [self.content copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.listcollectionIdentifier = self.listcollectionIdentifier;
        copy.fbUserId = [self.fbUserId copyWithZone:zone];
        copy.serviceId = self.serviceId;
        copy.type = [self.type copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.user = [self.user copyWithZone:zone];
    }
    
    return copy;
}


@end
