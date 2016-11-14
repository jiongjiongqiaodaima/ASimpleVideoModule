//
//  VideoPlayDetailsUser.m
//
//  Created by   on 16/8/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "VideoPlayDetailsUser.h"


NSString *const kVideoPlayDetailsUserSinaUrl = @"sinaUrl";
NSString *const kVideoPlayDetailsUserTixianPassword = @"tixianPassword";
NSString *const kVideoPlayDetailsUserSinaName = @"sinaName";
NSString *const kVideoPlayDetailsUserDongjiezj = @"dongjiezj";
NSString *const kVideoPlayDetailsUserId = @"id";
NSString *const kVideoPlayDetailsUserVoiceIntroduction = @"voiceIntroduction";
NSString *const kVideoPlayDetailsUserVerifycode = @"verifycode";
NSString *const kVideoPlayDetailsUserIntegral = @"integral";
NSString *const kVideoPlayDetailsUserQrcodephone = @"qrcodephone";
NSString *const kVideoPlayDetailsUserWeizhi = @"weizhi";
NSString *const kVideoPlayDetailsUserDizhi = @"dizhi";
NSString *const kVideoPlayDetailsUserSinaAddress = @"sinaAddress";
NSString *const kVideoPlayDetailsUserIszhima = @"iszhima";
NSString *const kVideoPlayDetailsUserSex = @"sex";
NSString *const kVideoPlayDetailsUserHeadphoto = @"headphoto";
NSString *const kVideoPlayDetailsUserArea = @"area";
NSString *const kVideoPlayDetailsUserIsSina = @"isSina";
NSString *const kVideoPlayDetailsUserName = @"name";
NSString *const kVideoPlayDetailsUserZhima = @"zhima";
NSString *const kVideoPlayDetailsUserIntroduction = @"introduction";
NSString *const kVideoPlayDetailsUserStatus = @"status";
NSString *const kVideoPlayDetailsUserCity = @"city";
NSString *const kVideoPlayDetailsUserCreditrating = @"creditrating";
NSString *const kVideoPlayDetailsUserQianmin = @"qianmin";
NSString *const kVideoPlayDetailsUserZhiye = @"zhiye";
NSString *const kVideoPlayDetailsUserPersonalLabel = @"personalLabel";
NSString *const kVideoPlayDetailsUserReferee = @"referee";
NSString *const kVideoPlayDetailsUserZmCreditRating = @"zmCreditRating";
NSString *const kVideoPlayDetailsUserBalance = @"balance";
NSString *const kVideoPlayDetailsUserDengrutime = @"dengrutime";
NSString *const kVideoPlayDetailsUserIp = @"ip";
NSString *const kVideoPlayDetailsUserPassword = @"password";
NSString *const kVideoPlayDetailsUserConstellation = @"constellation";
NSString *const kVideoPlayDetailsUserPhone = @"phone";
NSString *const kVideoPlayDetailsUserUserid = @"userid";


@interface VideoPlayDetailsUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation VideoPlayDetailsUser

@synthesize sinaUrl = _sinaUrl;
@synthesize tixianPassword = _tixianPassword;
@synthesize sinaName = _sinaName;
@synthesize dongjiezj = _dongjiezj;
@synthesize userIdentifier = _userIdentifier;
@synthesize voiceIntroduction = _voiceIntroduction;
@synthesize verifycode = _verifycode;
@synthesize integral = _integral;
@synthesize qrcodephone = _qrcodephone;
@synthesize weizhi = _weizhi;
@synthesize dizhi = _dizhi;
@synthesize sinaAddress = _sinaAddress;
@synthesize iszhima = _iszhima;
@synthesize sex = _sex;
@synthesize headphoto = _headphoto;
@synthesize area = _area;
@synthesize isSina = _isSina;
@synthesize name = _name;
@synthesize zhima = _zhima;
@synthesize introduction = _introduction;
@synthesize status = _status;
@synthesize city = _city;
@synthesize creditrating = _creditrating;
@synthesize qianmin = _qianmin;
@synthesize zhiye = _zhiye;
@synthesize personalLabel = _personalLabel;
@synthesize referee = _referee;
@synthesize zmCreditRating = _zmCreditRating;
@synthesize balance = _balance;
@synthesize dengrutime = _dengrutime;
@synthesize ip = _ip;
@synthesize password = _password;
@synthesize constellation = _constellation;
@synthesize phone = _phone;
@synthesize userid = _userid;


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
            self.sinaUrl = [self objectOrNilForKey:kVideoPlayDetailsUserSinaUrl fromDictionary:dict];
            self.tixianPassword = [self objectOrNilForKey:kVideoPlayDetailsUserTixianPassword fromDictionary:dict];
            self.sinaName = [self objectOrNilForKey:kVideoPlayDetailsUserSinaName fromDictionary:dict];
            self.dongjiezj = [[self objectOrNilForKey:kVideoPlayDetailsUserDongjiezj fromDictionary:dict] doubleValue];
            self.userIdentifier = [[self objectOrNilForKey:kVideoPlayDetailsUserId fromDictionary:dict] doubleValue];
            self.voiceIntroduction = [self objectOrNilForKey:kVideoPlayDetailsUserVoiceIntroduction fromDictionary:dict];
            self.verifycode = [self objectOrNilForKey:kVideoPlayDetailsUserVerifycode fromDictionary:dict];
            self.integral = [[self objectOrNilForKey:kVideoPlayDetailsUserIntegral fromDictionary:dict] doubleValue];
            self.qrcodephone = [self objectOrNilForKey:kVideoPlayDetailsUserQrcodephone fromDictionary:dict];
            self.weizhi = [self objectOrNilForKey:kVideoPlayDetailsUserWeizhi fromDictionary:dict];
            self.dizhi = [self objectOrNilForKey:kVideoPlayDetailsUserDizhi fromDictionary:dict];
            self.sinaAddress = [self objectOrNilForKey:kVideoPlayDetailsUserSinaAddress fromDictionary:dict];
            self.iszhima = [self objectOrNilForKey:kVideoPlayDetailsUserIszhima fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kVideoPlayDetailsUserSex fromDictionary:dict];
            self.headphoto = [self objectOrNilForKey:kVideoPlayDetailsUserHeadphoto fromDictionary:dict];
            self.area = [self objectOrNilForKey:kVideoPlayDetailsUserArea fromDictionary:dict];
            self.isSina = [self objectOrNilForKey:kVideoPlayDetailsUserIsSina fromDictionary:dict];
            self.name = [self objectOrNilForKey:kVideoPlayDetailsUserName fromDictionary:dict];
            self.zhima = [self objectOrNilForKey:kVideoPlayDetailsUserZhima fromDictionary:dict];
            self.introduction = [self objectOrNilForKey:kVideoPlayDetailsUserIntroduction fromDictionary:dict];
            self.status = [self objectOrNilForKey:kVideoPlayDetailsUserStatus fromDictionary:dict];
            self.city = [self objectOrNilForKey:kVideoPlayDetailsUserCity fromDictionary:dict];
            self.creditrating = [self objectOrNilForKey:kVideoPlayDetailsUserCreditrating fromDictionary:dict];
            self.qianmin = [self objectOrNilForKey:kVideoPlayDetailsUserQianmin fromDictionary:dict];
            self.zhiye = [self objectOrNilForKey:kVideoPlayDetailsUserZhiye fromDictionary:dict];
            self.personalLabel = [self objectOrNilForKey:kVideoPlayDetailsUserPersonalLabel fromDictionary:dict];
            self.referee = [self objectOrNilForKey:kVideoPlayDetailsUserReferee fromDictionary:dict];
            self.zmCreditRating = [self objectOrNilForKey:kVideoPlayDetailsUserZmCreditRating fromDictionary:dict];
            self.balance = [[self objectOrNilForKey:kVideoPlayDetailsUserBalance fromDictionary:dict] doubleValue];
            self.dengrutime = [self objectOrNilForKey:kVideoPlayDetailsUserDengrutime fromDictionary:dict];
            self.ip = [self objectOrNilForKey:kVideoPlayDetailsUserIp fromDictionary:dict];
            self.password = [self objectOrNilForKey:kVideoPlayDetailsUserPassword fromDictionary:dict];
            self.constellation = [self objectOrNilForKey:kVideoPlayDetailsUserConstellation fromDictionary:dict];
            self.phone = [self objectOrNilForKey:kVideoPlayDetailsUserPhone fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kVideoPlayDetailsUserUserid fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.sinaUrl forKey:kVideoPlayDetailsUserSinaUrl];
    [mutableDict setValue:self.tixianPassword forKey:kVideoPlayDetailsUserTixianPassword];
    [mutableDict setValue:self.sinaName forKey:kVideoPlayDetailsUserSinaName];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dongjiezj] forKey:kVideoPlayDetailsUserDongjiezj];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userIdentifier] forKey:kVideoPlayDetailsUserId];
    [mutableDict setValue:self.voiceIntroduction forKey:kVideoPlayDetailsUserVoiceIntroduction];
    [mutableDict setValue:self.verifycode forKey:kVideoPlayDetailsUserVerifycode];
    [mutableDict setValue:[NSNumber numberWithDouble:self.integral] forKey:kVideoPlayDetailsUserIntegral];
    [mutableDict setValue:self.qrcodephone forKey:kVideoPlayDetailsUserQrcodephone];
    [mutableDict setValue:self.weizhi forKey:kVideoPlayDetailsUserWeizhi];
    [mutableDict setValue:self.dizhi forKey:kVideoPlayDetailsUserDizhi];
    [mutableDict setValue:self.sinaAddress forKey:kVideoPlayDetailsUserSinaAddress];
    [mutableDict setValue:self.iszhima forKey:kVideoPlayDetailsUserIszhima];
    [mutableDict setValue:self.sex forKey:kVideoPlayDetailsUserSex];
    [mutableDict setValue:self.headphoto forKey:kVideoPlayDetailsUserHeadphoto];
    [mutableDict setValue:self.area forKey:kVideoPlayDetailsUserArea];
    [mutableDict setValue:self.isSina forKey:kVideoPlayDetailsUserIsSina];
    [mutableDict setValue:self.name forKey:kVideoPlayDetailsUserName];
    [mutableDict setValue:self.zhima forKey:kVideoPlayDetailsUserZhima];
    [mutableDict setValue:self.introduction forKey:kVideoPlayDetailsUserIntroduction];
    [mutableDict setValue:self.status forKey:kVideoPlayDetailsUserStatus];
    [mutableDict setValue:self.city forKey:kVideoPlayDetailsUserCity];
    [mutableDict setValue:self.creditrating forKey:kVideoPlayDetailsUserCreditrating];
    [mutableDict setValue:self.qianmin forKey:kVideoPlayDetailsUserQianmin];
    [mutableDict setValue:self.zhiye forKey:kVideoPlayDetailsUserZhiye];
    [mutableDict setValue:self.personalLabel forKey:kVideoPlayDetailsUserPersonalLabel];
    [mutableDict setValue:self.referee forKey:kVideoPlayDetailsUserReferee];
    [mutableDict setValue:self.zmCreditRating forKey:kVideoPlayDetailsUserZmCreditRating];
    [mutableDict setValue:[NSNumber numberWithDouble:self.balance] forKey:kVideoPlayDetailsUserBalance];
    [mutableDict setValue:self.dengrutime forKey:kVideoPlayDetailsUserDengrutime];
    [mutableDict setValue:self.ip forKey:kVideoPlayDetailsUserIp];
    [mutableDict setValue:self.password forKey:kVideoPlayDetailsUserPassword];
    [mutableDict setValue:self.constellation forKey:kVideoPlayDetailsUserConstellation];
    [mutableDict setValue:self.phone forKey:kVideoPlayDetailsUserPhone];
    [mutableDict setValue:self.userid forKey:kVideoPlayDetailsUserUserid];

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

    self.sinaUrl = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserSinaUrl];
    self.tixianPassword = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserTixianPassword];
    self.sinaName = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserSinaName];
    self.dongjiezj = [aDecoder decodeDoubleForKey:kVideoPlayDetailsUserDongjiezj];
    self.userIdentifier = [aDecoder decodeDoubleForKey:kVideoPlayDetailsUserId];
    self.voiceIntroduction = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserVoiceIntroduction];
    self.verifycode = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserVerifycode];
    self.integral = [aDecoder decodeDoubleForKey:kVideoPlayDetailsUserIntegral];
    self.qrcodephone = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserQrcodephone];
    self.weizhi = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserWeizhi];
    self.dizhi = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserDizhi];
    self.sinaAddress = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserSinaAddress];
    self.iszhima = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserIszhima];
    self.sex = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserSex];
    self.headphoto = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserHeadphoto];
    self.area = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserArea];
    self.isSina = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserIsSina];
    self.name = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserName];
    self.zhima = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserZhima];
    self.introduction = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserIntroduction];
    self.status = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserStatus];
    self.city = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserCity];
    self.creditrating = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserCreditrating];
    self.qianmin = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserQianmin];
    self.zhiye = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserZhiye];
    self.personalLabel = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserPersonalLabel];
    self.referee = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserReferee];
    self.zmCreditRating = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserZmCreditRating];
    self.balance = [aDecoder decodeDoubleForKey:kVideoPlayDetailsUserBalance];
    self.dengrutime = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserDengrutime];
    self.ip = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserIp];
    self.password = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserPassword];
    self.constellation = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserConstellation];
    self.phone = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserPhone];
    self.userid = [aDecoder decodeObjectForKey:kVideoPlayDetailsUserUserid];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_sinaUrl forKey:kVideoPlayDetailsUserSinaUrl];
    [aCoder encodeObject:_tixianPassword forKey:kVideoPlayDetailsUserTixianPassword];
    [aCoder encodeObject:_sinaName forKey:kVideoPlayDetailsUserSinaName];
    [aCoder encodeDouble:_dongjiezj forKey:kVideoPlayDetailsUserDongjiezj];
    [aCoder encodeDouble:_userIdentifier forKey:kVideoPlayDetailsUserId];
    [aCoder encodeObject:_voiceIntroduction forKey:kVideoPlayDetailsUserVoiceIntroduction];
    [aCoder encodeObject:_verifycode forKey:kVideoPlayDetailsUserVerifycode];
    [aCoder encodeDouble:_integral forKey:kVideoPlayDetailsUserIntegral];
    [aCoder encodeObject:_qrcodephone forKey:kVideoPlayDetailsUserQrcodephone];
    [aCoder encodeObject:_weizhi forKey:kVideoPlayDetailsUserWeizhi];
    [aCoder encodeObject:_dizhi forKey:kVideoPlayDetailsUserDizhi];
    [aCoder encodeObject:_sinaAddress forKey:kVideoPlayDetailsUserSinaAddress];
    [aCoder encodeObject:_iszhima forKey:kVideoPlayDetailsUserIszhima];
    [aCoder encodeObject:_sex forKey:kVideoPlayDetailsUserSex];
    [aCoder encodeObject:_headphoto forKey:kVideoPlayDetailsUserHeadphoto];
    [aCoder encodeObject:_area forKey:kVideoPlayDetailsUserArea];
    [aCoder encodeObject:_isSina forKey:kVideoPlayDetailsUserIsSina];
    [aCoder encodeObject:_name forKey:kVideoPlayDetailsUserName];
    [aCoder encodeObject:_zhima forKey:kVideoPlayDetailsUserZhima];
    [aCoder encodeObject:_introduction forKey:kVideoPlayDetailsUserIntroduction];
    [aCoder encodeObject:_status forKey:kVideoPlayDetailsUserStatus];
    [aCoder encodeObject:_city forKey:kVideoPlayDetailsUserCity];
    [aCoder encodeObject:_creditrating forKey:kVideoPlayDetailsUserCreditrating];
    [aCoder encodeObject:_qianmin forKey:kVideoPlayDetailsUserQianmin];
    [aCoder encodeObject:_zhiye forKey:kVideoPlayDetailsUserZhiye];
    [aCoder encodeObject:_personalLabel forKey:kVideoPlayDetailsUserPersonalLabel];
    [aCoder encodeObject:_referee forKey:kVideoPlayDetailsUserReferee];
    [aCoder encodeObject:_zmCreditRating forKey:kVideoPlayDetailsUserZmCreditRating];
    [aCoder encodeDouble:_balance forKey:kVideoPlayDetailsUserBalance];
    [aCoder encodeObject:_dengrutime forKey:kVideoPlayDetailsUserDengrutime];
    [aCoder encodeObject:_ip forKey:kVideoPlayDetailsUserIp];
    [aCoder encodeObject:_password forKey:kVideoPlayDetailsUserPassword];
    [aCoder encodeObject:_constellation forKey:kVideoPlayDetailsUserConstellation];
    [aCoder encodeObject:_phone forKey:kVideoPlayDetailsUserPhone];
    [aCoder encodeObject:_userid forKey:kVideoPlayDetailsUserUserid];
}

- (id)copyWithZone:(NSZone *)zone
{
    VideoPlayDetailsUser *copy = [[VideoPlayDetailsUser alloc] init];
    
    if (copy) {

        copy.sinaUrl = [self.sinaUrl copyWithZone:zone];
        copy.tixianPassword = [self.tixianPassword copyWithZone:zone];
        copy.sinaName = [self.sinaName copyWithZone:zone];
        copy.dongjiezj = self.dongjiezj;
        copy.userIdentifier = self.userIdentifier;
        copy.voiceIntroduction = [self.voiceIntroduction copyWithZone:zone];
        copy.verifycode = [self.verifycode copyWithZone:zone];
        copy.integral = self.integral;
        copy.qrcodephone = [self.qrcodephone copyWithZone:zone];
        copy.weizhi = [self.weizhi copyWithZone:zone];
        copy.dizhi = [self.dizhi copyWithZone:zone];
        copy.sinaAddress = [self.sinaAddress copyWithZone:zone];
        copy.iszhima = [self.iszhima copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.headphoto = [self.headphoto copyWithZone:zone];
        copy.area = [self.area copyWithZone:zone];
        copy.isSina = [self.isSina copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.zhima = [self.zhima copyWithZone:zone];
        copy.introduction = [self.introduction copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.creditrating = [self.creditrating copyWithZone:zone];
        copy.qianmin = [self.qianmin copyWithZone:zone];
        copy.zhiye = [self.zhiye copyWithZone:zone];
        copy.personalLabel = [self.personalLabel copyWithZone:zone];
        copy.referee = [self.referee copyWithZone:zone];
        copy.zmCreditRating = [self.zmCreditRating copyWithZone:zone];
        copy.balance = self.balance;
        copy.dengrutime = [self.dengrutime copyWithZone:zone];
        copy.ip = [self.ip copyWithZone:zone];
        copy.password = [self.password copyWithZone:zone];
        copy.constellation = [self.constellation copyWithZone:zone];
        copy.phone = [self.phone copyWithZone:zone];
        copy.userid = [self.userid copyWithZone:zone];
    }
    
    return copy;
}


@end
