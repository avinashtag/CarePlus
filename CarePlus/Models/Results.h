//
//  Results.h
//
//  Created by Avinash Tag on 17/05/16
//  Copyright (c) 2016 Rohde & Schwarz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Geometry, OpeningHours;

@interface Results : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double rating;
@property (nonatomic, strong) NSString *resultsIdentifier;
@property (nonatomic, assign) double priceLevel;
@property (nonatomic, strong) NSString *vicinity;
@property (nonatomic, strong) NSString *scope;
@property (nonatomic, strong) Geometry *geometry;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *placeId;
@property (nonatomic, strong) NSArray *photos;
@property (nonatomic, strong) NSString *reference;
@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) OpeningHours *openingHours;
@property (nonatomic, strong) NSString *name;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
