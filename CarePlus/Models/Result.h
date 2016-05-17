//
//  Result.h
//
//  Created by Avinash Tag on 17/05/16
//  Copyright (c) 2016 Rohde & Schwarz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Geometry;

@interface Result : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *resultIdentifier;
@property (nonatomic, strong) NSArray *addressComponents;
@property (nonatomic, strong) NSString *vicinity;
@property (nonatomic, strong) NSString *formattedAddress;
@property (nonatomic, strong) NSString *internationalPhoneNumber;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *adrAddress;
@property (nonatomic, strong) NSString *scope;
@property (nonatomic, strong) NSString *formattedPhoneNumber;
@property (nonatomic, strong) Geometry *geometry;
@property (nonatomic, strong) NSString *placeId;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *reference;
@property (nonatomic, strong) NSArray *types;
@property (nonatomic, assign) double utcOffset;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *website;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
