//
//  VideoPlayDetailsListcollection.h
//
//  Created by   on 16/8/4
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface VideoPlayDetailsListcollection : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) double listcollectionIdentifier;
@property (nonatomic, strong) NSString *fbUserId;
@property (nonatomic, assign) double serviceId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *sex;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) id user;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
