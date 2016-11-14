//
//  VideoPlayDetailsBaseClass.m
//
//  Created by   on 16/8/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "VideoPlayDetailsBaseClass.h"
#import "VideoPlayDetailsMessageHelper.h"


NSString *const kVideoPlayDetailsBaseClassCitys = @"citys";
NSString *const kVideoPlayDetailsBaseClassStatus = @"status";
NSString *const kVideoPlayDetailsBaseClassVideoname = @"videoname";
NSString *const kVideoPlayDetailsBaseClassUserid = @"userid";
NSString *const kVideoPlayDetailsBaseClassLat2 = @"lat2";
NSString *const kVideoPlayDetailsBaseClassUrl = @"url";
NSString *const kVideoPlayDetailsBaseClassArea = @"area";
NSString *const kVideoPlayDetailsBaseClassType = @"type";
NSString *const kVideoPlayDetailsBaseClassVideoimg = @"videoimg";
NSString *const kVideoPlayDetailsBaseClassMyvideoId = @"myvideoId";
NSString *const kVideoPlayDetailsBaseClassMyvideo = @"myvideo";
NSString *const kVideoPlayDetailsBaseClassLongt2 = @"longt2";
NSString *const kVideoPlayDetailsBaseClassCity = @"city";
NSString *const kVideoPlayDetailsBaseClassJz = @"jz";
NSString *const kVideoPlayDetailsBaseClassRemark = @"remark";
NSString *const kVideoPlayDetailsBaseClassWeizhi = @"weizhi";
NSString *const kVideoPlayDetailsBaseClassPageNo = @"pageNo";
NSString *const kVideoPlayDetailsBaseClassDescribes = @"describes";
NSString *const kVideoPlayDetailsBaseClassMessageHelper = @"messageHelper";


@interface VideoPlayDetailsBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VideoPlayDetailsBaseClass

@synthesize citys = _citys;
@synthesize status = _status;
@synthesize videoname = _videoname;
@synthesize userid = _userid;
@synthesize lat2 = _lat2;
@synthesize url = _url;
@synthesize area = _area;
@synthesize type = _type;
@synthesize videoimg = _videoimg;
@synthesize myvideoId = _myvideoId;
@synthesize myvideo = _myvideo;
@synthesize longt2 = _longt2;
@synthesize city = _city;
@synthesize jz = _jz;
@synthesize remark = _remark;
@synthesize weizhi = _weizhi;
@synthesize pageNo = _pageNo;
@synthesize describes = _describes;
@synthesize messageHelper = _messageHelper;


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
            self.citys = [self objectOrNilForKey:kVideoPlayDetailsBaseClassCitys fromDictionary:dict];
            self.status = [self objectOrNilForKey:kVideoPlayDetailsBaseClassStatus fromDictionary:dict];
            self.videoname = [self objectOrNilForKey:kVideoPlayDetailsBaseClassVideoname fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kVideoPlayDetailsBaseClassUserid fromDictionary:dict];
            self.lat2 = [self objectOrNilForKey:kVideoPlayDetailsBaseClassLat2 fromDictionary:dict];
            self.url = [self objectOrNilForKey:kVideoPlayDetailsBaseClassUrl fromDictionary:dict];
            self.area = [self objectOrNilForKey:kVideoPlayDetailsBaseClassArea fromDictionary:dict];
            self.type = [self objectOrNilForKey:kVideoPlayDetailsBaseClassType fromDictionary:dict];
            self.videoimg = [self objectOrNilForKey:kVideoPlayDetailsBaseClassVideoimg fromDictionary:dict];
            self.myvideoId = [[self objectOrNilForKey:kVideoPlayDetailsBaseClassMyvideoId fromDictionary:dict] doubleValue];
            self.myvideo = [self objectOrNilForKey:kVideoPlayDetailsBaseClassMyvideo fromDictionary:dict];
            self.longt2 = [self objectOrNilForKey:kVideoPlayDetailsBaseClassLongt2 fromDictionary:dict];
            self.city = [self objectOrNilForKey:kVideoPlayDetailsBaseClassCity fromDictionary:dict];
            self.jz = [self objectOrNilForKey:kVideoPlayDetailsBaseClassJz fromDictionary:dict];
            self.remark = [self objectOrNilForKey:kVideoPlayDetailsBaseClassRemark fromDictionary:dict];
            self.weizhi = [self objectOrNilForKey:kVideoPlayDetailsBaseClassWeizhi fromDictionary:dict];
            self.pageNo = [[self objectOrNilForKey:kVideoPlayDetailsBaseClassPageNo fromDictionary:dict] doubleValue];
            self.describes = [self objectOrNilForKey:kVideoPlayDetailsBaseClassDescribes fromDictionary:dict];
            self.messageHelper = [VideoPlayDetailsMessageHelper modelObjectWithDictionary:[dict objectForKey:kVideoPlayDetailsBaseClassMessageHelper]];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.citys forKey:kVideoPlayDetailsBaseClassCitys];
    [mutableDict setValue:self.status forKey:kVideoPlayDetailsBaseClassStatus];
    [mutableDict setValue:self.videoname forKey:kVideoPlayDetailsBaseClassVideoname];
    [mutableDict setValue:self.userid forKey:kVideoPlayDetailsBaseClassUserid];
    [mutableDict setValue:self.lat2 forKey:kVideoPlayDetailsBaseClassLat2];
    [mutableDict setValue:self.url forKey:kVideoPlayDetailsBaseClassUrl];
    [mutableDict setValue:self.area forKey:kVideoPlayDetailsBaseClassArea];
    [mutableDict setValue:self.type forKey:kVideoPlayDetailsBaseClassType];
    [mutableDict setValue:self.videoimg forKey:kVideoPlayDetailsBaseClassVideoimg];
    [mutableDict setValue:[NSNumber numberWithDouble:self.myvideoId] forKey:kVideoPlayDetailsBaseClassMyvideoId];
    [mutableDict setValue:self.myvideo forKey:kVideoPlayDetailsBaseClassMyvideo];
    [mutableDict setValue:self.longt2 forKey:kVideoPlayDetailsBaseClassLongt2];
    [mutableDict setValue:self.city forKey:kVideoPlayDetailsBaseClassCity];
    [mutableDict setValue:self.jz forKey:kVideoPlayDetailsBaseClassJz];
    [mutableDict setValue:self.remark forKey:kVideoPlayDetailsBaseClassRemark];
    [mutableDict setValue:self.weizhi forKey:kVideoPlayDetailsBaseClassWeizhi];
    [mutableDict setValue:[NSNumber numberWithDouble:self.pageNo] forKey:kVideoPlayDetailsBaseClassPageNo];
    [mutableDict setValue:self.describes forKey:kVideoPlayDetailsBaseClassDescribes];
    [mutableDict setValue:[self.messageHelper dictionaryRepresentation] forKey:kVideoPlayDetailsBaseClassMessageHelper];

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

    self.citys = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassCitys];
    self.status = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassStatus];
    self.videoname = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassVideoname];
    self.userid = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassUserid];
    self.lat2 = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassLat2];
    self.url = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassUrl];
    self.area = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassArea];
    self.type = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassType];
    self.videoimg = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassVideoimg];
    self.myvideoId = [aDecoder decodeDoubleForKey:kVideoPlayDetailsBaseClassMyvideoId];
    self.myvideo = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassMyvideo];
    self.longt2 = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassLongt2];
    self.city = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassCity];
    self.jz = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassJz];
    self.remark = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassRemark];
    self.weizhi = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassWeizhi];
    self.pageNo = [aDecoder decodeDoubleForKey:kVideoPlayDetailsBaseClassPageNo];
    self.describes = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassDescribes];
    self.messageHelper = [aDecoder decodeObjectForKey:kVideoPlayDetailsBaseClassMessageHelper];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_citys forKey:kVideoPlayDetailsBaseClassCitys];
    [aCoder encodeObject:_status forKey:kVideoPlayDetailsBaseClassStatus];
    [aCoder encodeObject:_videoname forKey:kVideoPlayDetailsBaseClassVideoname];
    [aCoder encodeObject:_userid forKey:kVideoPlayDetailsBaseClassUserid];
    [aCoder encodeObject:_lat2 forKey:kVideoPlayDetailsBaseClassLat2];
    [aCoder encodeObject:_url forKey:kVideoPlayDetailsBaseClassUrl];
    [aCoder encodeObject:_area forKey:kVideoPlayDetailsBaseClassArea];
    [aCoder encodeObject:_type forKey:kVideoPlayDetailsBaseClassType];
    [aCoder encodeObject:_videoimg forKey:kVideoPlayDetailsBaseClassVideoimg];
    [aCoder encodeDouble:_myvideoId forKey:kVideoPlayDetailsBaseClassMyvideoId];
    [aCoder encodeObject:_myvideo forKey:kVideoPlayDetailsBaseClassMyvideo];
    [aCoder encodeObject:_longt2 forKey:kVideoPlayDetailsBaseClassLongt2];
    [aCoder encodeObject:_city forKey:kVideoPlayDetailsBaseClassCity];
    [aCoder encodeObject:_jz forKey:kVideoPlayDetailsBaseClassJz];
    [aCoder encodeObject:_remark forKey:kVideoPlayDetailsBaseClassRemark];
    [aCoder encodeObject:_weizhi forKey:kVideoPlayDetailsBaseClassWeizhi];
    [aCoder encodeDouble:_pageNo forKey:kVideoPlayDetailsBaseClassPageNo];
    [aCoder encodeObject:_describes forKey:kVideoPlayDetailsBaseClassDescribes];
    [aCoder encodeObject:_messageHelper forKey:kVideoPlayDetailsBaseClassMessageHelper];
}

- (id)copyWithZone:(NSZone *)zone
{
    VideoPlayDetailsBaseClass *copy = [[VideoPlayDetailsBaseClass alloc] init];
    
    if (copy) {

        copy.citys = [self.citys copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
        copy.videoname = [self.videoname copyWithZone:zone];
        copy.userid = [self.userid copyWithZone:zone];
        copy.lat2 = [self.lat2 copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.area = [self.area copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.videoimg = [self.videoimg copyWithZone:zone];
        copy.myvideoId = self.myvideoId;
        copy.myvideo = [self.myvideo copyWithZone:zone];
        copy.longt2 = [self.longt2 copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.jz = [self.jz copyWithZone:zone];
        copy.remark = [self.remark copyWithZone:zone];
        copy.weizhi = [self.weizhi copyWithZone:zone];
        copy.pageNo = self.pageNo;
        copy.describes = [self.describes copyWithZone:zone];
        copy.messageHelper = [self.messageHelper copyWithZone:zone];
    }
    
    return copy;
}


@end
