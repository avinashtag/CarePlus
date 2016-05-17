//
//  Results.m
//
//  Created by Avinash Tag on 17/05/16
//  Copyright (c) 2016 Rohde & Schwarz. All rights reserved.
//

#import "Results.h"
#import "Geometry.h"
#import "Photos.h"
#import "OpeningHours.h"


NSString *const kResultsRating = @"rating";
NSString *const kResultsId = @"id";
NSString *const kResultsPriceLevel = @"price_level";
NSString *const kResultsVicinity = @"vicinity";
NSString *const kResultsScope = @"scope";
NSString *const kResultsGeometry = @"geometry";
NSString *const kResultsIcon = @"icon";
NSString *const kResultsPlaceId = @"place_id";
NSString *const kResultsPhotos = @"photos";
NSString *const kResultsReference = @"reference";
NSString *const kResultsTypes = @"types";
NSString *const kResultsOpeningHours = @"opening_hours";
NSString *const kResultsName = @"name";


@interface Results ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Results

@synthesize rating = _rating;
@synthesize resultsIdentifier = _resultsIdentifier;
@synthesize priceLevel = _priceLevel;
@synthesize vicinity = _vicinity;
@synthesize scope = _scope;
@synthesize geometry = _geometry;
@synthesize icon = _icon;
@synthesize placeId = _placeId;
@synthesize photos = _photos;
@synthesize reference = _reference;
@synthesize types = _types;
@synthesize openingHours = _openingHours;
@synthesize name = _name;


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
            self.rating = [[self objectOrNilForKey:kResultsRating fromDictionary:dict] doubleValue];
            self.resultsIdentifier = [self objectOrNilForKey:kResultsId fromDictionary:dict];
            self.priceLevel = [[self objectOrNilForKey:kResultsPriceLevel fromDictionary:dict] doubleValue];
            self.vicinity = [self objectOrNilForKey:kResultsVicinity fromDictionary:dict];
            self.scope = [self objectOrNilForKey:kResultsScope fromDictionary:dict];
            self.geometry = [Geometry modelObjectWithDictionary:[dict objectForKey:kResultsGeometry]];
            self.icon = [self objectOrNilForKey:kResultsIcon fromDictionary:dict];
            self.placeId = [self objectOrNilForKey:kResultsPlaceId fromDictionary:dict];
    NSObject *receivedPhotos = [dict objectForKey:kResultsPhotos];
    NSMutableArray *parsedPhotos = [NSMutableArray array];
    if ([receivedPhotos isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedPhotos) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedPhotos addObject:[Photos modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedPhotos isKindOfClass:[NSDictionary class]]) {
       [parsedPhotos addObject:[Photos modelObjectWithDictionary:(NSDictionary *)receivedPhotos]];
    }

    self.photos = [NSArray arrayWithArray:parsedPhotos];
            self.reference = [self objectOrNilForKey:kResultsReference fromDictionary:dict];
            self.types = [self objectOrNilForKey:kResultsTypes fromDictionary:dict];
            self.openingHours = [OpeningHours modelObjectWithDictionary:[dict objectForKey:kResultsOpeningHours]];
            self.name = [self objectOrNilForKey:kResultsName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.rating] forKey:kResultsRating];
    [mutableDict setValue:self.resultsIdentifier forKey:kResultsId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.priceLevel] forKey:kResultsPriceLevel];
    [mutableDict setValue:self.vicinity forKey:kResultsVicinity];
    [mutableDict setValue:self.scope forKey:kResultsScope];
    [mutableDict setValue:[self.geometry dictionaryRepresentation] forKey:kResultsGeometry];
    [mutableDict setValue:self.icon forKey:kResultsIcon];
    [mutableDict setValue:self.placeId forKey:kResultsPlaceId];
    NSMutableArray *tempArrayForPhotos = [NSMutableArray array];
    for (NSObject *subArrayObject in self.photos) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForPhotos addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForPhotos addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForPhotos] forKey:kResultsPhotos];
    [mutableDict setValue:self.reference forKey:kResultsReference];
    NSMutableArray *tempArrayForTypes = [NSMutableArray array];
    for (NSObject *subArrayObject in self.types) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTypes addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTypes addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTypes] forKey:kResultsTypes];
    [mutableDict setValue:[self.openingHours dictionaryRepresentation] forKey:kResultsOpeningHours];
    [mutableDict setValue:self.name forKey:kResultsName];

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

    self.rating = [aDecoder decodeDoubleForKey:kResultsRating];
    self.resultsIdentifier = [aDecoder decodeObjectForKey:kResultsId];
    self.priceLevel = [aDecoder decodeDoubleForKey:kResultsPriceLevel];
    self.vicinity = [aDecoder decodeObjectForKey:kResultsVicinity];
    self.scope = [aDecoder decodeObjectForKey:kResultsScope];
    self.geometry = [aDecoder decodeObjectForKey:kResultsGeometry];
    self.icon = [aDecoder decodeObjectForKey:kResultsIcon];
    self.placeId = [aDecoder decodeObjectForKey:kResultsPlaceId];
    self.photos = [aDecoder decodeObjectForKey:kResultsPhotos];
    self.reference = [aDecoder decodeObjectForKey:kResultsReference];
    self.types = [aDecoder decodeObjectForKey:kResultsTypes];
    self.openingHours = [aDecoder decodeObjectForKey:kResultsOpeningHours];
    self.name = [aDecoder decodeObjectForKey:kResultsName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_rating forKey:kResultsRating];
    [aCoder encodeObject:_resultsIdentifier forKey:kResultsId];
    [aCoder encodeDouble:_priceLevel forKey:kResultsPriceLevel];
    [aCoder encodeObject:_vicinity forKey:kResultsVicinity];
    [aCoder encodeObject:_scope forKey:kResultsScope];
    [aCoder encodeObject:_geometry forKey:kResultsGeometry];
    [aCoder encodeObject:_icon forKey:kResultsIcon];
    [aCoder encodeObject:_placeId forKey:kResultsPlaceId];
    [aCoder encodeObject:_photos forKey:kResultsPhotos];
    [aCoder encodeObject:_reference forKey:kResultsReference];
    [aCoder encodeObject:_types forKey:kResultsTypes];
    [aCoder encodeObject:_openingHours forKey:kResultsOpeningHours];
    [aCoder encodeObject:_name forKey:kResultsName];
}

- (id)copyWithZone:(NSZone *)zone
{
    Results *copy = [[Results alloc] init];
    
    if (copy) {

        copy.rating = self.rating;
        copy.resultsIdentifier = [self.resultsIdentifier copyWithZone:zone];
        copy.priceLevel = self.priceLevel;
        copy.vicinity = [self.vicinity copyWithZone:zone];
        copy.scope = [self.scope copyWithZone:zone];
        copy.geometry = [self.geometry copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.placeId = [self.placeId copyWithZone:zone];
        copy.photos = [self.photos copyWithZone:zone];
        copy.reference = [self.reference copyWithZone:zone];
        copy.types = [self.types copyWithZone:zone];
        copy.openingHours = [self.openingHours copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
    }
    
    return copy;
}


@end
