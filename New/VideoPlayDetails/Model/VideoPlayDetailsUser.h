//
//  VideoPlayDetailsUser.h
//
//  Created by   on 16/8/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VideoPlayDetailsUser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *sinaUrl;
@property (nonatomic, assign) id tixianPassword;
@property (nonatomic, strong) NSString *sinaName;
@property (nonatomic, assign) double dongjiezj;
@property (nonatomic, assign) double userIdentifier;
@property (nonatomic, assign) id voiceIntroduction;
@property (nonatomic, strong) NSString *verifycode;
@property (nonatomic, assign) double integral;
@property (nonatomic, assign) id qrcodephone;
@property (nonatomic, strong) NSString *weizhi;
@property (nonatomic, strong) NSString *dizhi;
@property (nonatomic, strong) NSString *sinaAddress;
@property (nonatomic, strong) NSString *iszhima;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *headphoto;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *isSina;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) id zhima;
@property (nonatomic, assign) id introduction;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *creditrating;
@property (nonatomic, assign) id qianmin;
@property (nonatomic, assign) id zhiye;
@property (nonatomic, assign) id personalLabel;
@property (nonatomic, assign) id referee;
@property (nonatomic, assign) id zmCreditRating;
@property (nonatomic, assign) double balance;
@property (nonatomic, strong) NSString *dengrutime;
@property (nonatomic, strong) NSString *ip;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, assign) id constellation;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *userid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
