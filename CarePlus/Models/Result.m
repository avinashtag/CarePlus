//
//  Result.m
//
//  Created by Avinash Tag on 17/05/16
//  Copyright (c) 2016 Rohde & Schwarz. All rights reserved.
//

#import "Result.h"
#import "AddressComponents.h"
#import "Geometry.h"


NSString *const kResultId = @"id";
NSString *const kResultAddressComponents = @"address_components";
NSString *const kResultVicinity = @"vicinity";
NSString *const kResultFormattedAddress = @"formatted_address";
NSString *const kResultInternationalPhoneNumber = @"international_phone_number";
NSString *const kResultUrl = @"url";
NSString *const kResultAdrAddress = @"adr_address";
NSString *const kResultScope = @"scope";
NSString *const kResultFormattedPhoneNumber = @"formatted_phone_number";
NSString *const kResultGeometry = @"geometry";
NSString *const kResultPlaceId = @"place_id";
NSString *const kResultIcon = @"icon";
NSString *const kResultReference = @"reference";
NSString *const kResultTypes = @"types";
NSString *const kResultUtcOffset = @"utc_offset";
NSString *const kResultName = @"name";
NSString *const kResultWebsite = @"website";


@interface Result ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Result

@synthesize resultIdentifier = _resultIdentifier;
@synthesize addressComponents = _addressComponents;
@synthesize vicinity = _vicinity;
@synthesize formattedAddress = _formattedAddress;
@synthesize internationalPhoneNumber = _internationalPhoneNumber;
@synthesize url = _url;
@synthesize adrAddress = _adrAddress;
@synthesize scope = _scope;
@synthesize formattedPhoneNumber = _formattedPhoneNumber;
@synthesize geometry = _geometry;
@synthesize placeId = _placeId;
@synthesize icon = _icon;
@synthesize reference = _reference;
@synthesize types = _types;
@synthesize utcOffset = _utcOffset;
@synthesize name = _name;
@synthesize website = _website;


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
            self.resultIdentifier = [self objectOrNilForKey:kResultId fromDictionary:dict];
    NSObject *receivedAddressComponents = [dict objectForKey:kResultAddressComponents];
    NSMutableArray *parsedAddressComponents = [NSMutableArray array];
    if ([receivedAddressComponents isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedAddressComponents) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedAddressComponents addObject:[AddressComponents modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedAddressComponents isKindOfClass:[NSDictionary class]]) {
       [parsedAddressComponents addObject:[AddressComponents modelObjectWithDictionary:(NSDictionary *)receivedAddressComponents]];
    }

    self.addressComponents = [NSArray arrayWithArray:parsedAddressComponents];
            self.vicinity = [self objectOrNilForKey:kResultVicinity fromDictionary:dict];
            self.formattedAddress = [self objectOrNilForKey:kResultFormattedAddress fromDictionary:dict];
            self.internationalPhoneNumber = [self objectOrNilForKey:kResultInternationalPhoneNumber fromDictionary:dict];
            self.url = [self objectOrNilForKey:kResultUrl fromDictionary:dict];
            self.adrAddress = [self objectOrNilForKey:kResultAdrAddress fromDictionary:dict];
            self.scope = [self objectOrNilForKey:kResultScope fromDictionary:dict];
            self.formattedPhoneNumber = [[self objectOrNilForKey:kResultFormattedPhoneNumber fromDictionary:dict] stringByReplacingOccurrencesOfString:@" " withString:@""];
            self.geometry = [Geometry modelObjectWithDictionary:[dict objectForKey:kResultGeometry]];
            self.placeId = [self objectOrNilForKey:kResultPlaceId fromDictionary:dict];
            self.icon = [self objectOrNilForKey:kResultIcon fromDictionary:dict];
            self.reference = [self objectOrNilForKey:kResultReference fromDictionary:dict];
            self.types = [self objectOrNilForKey:kResultTypes fromDictionary:dict];
            self.utcOffset = [[self objectOrNilForKey:kResultUtcOffset fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kResultName fromDictionary:dict];
            self.website = [self objectOrNilForKey:kResultWebsite fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.resultIdentifier forKey:kResultId];
    NSMutableArray *tempArrayForAddressComponents = [NSMutableArray array];
    for (NSObject *subArrayObject in self.addressComponents) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForAddressComponents addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForAddressComponents addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForAddressComponents] forKey:kResultAddressComponents];
    [mutableDict setValue:self.vicinity forKey:kResultVicinity];
    [mutableDict setValue:self.formattedAddress forKey:kResultFormattedAddress];
    [mutableDict setValue:self.internationalPhoneNumber forKey:kResultInternationalPhoneNumber];
    [mutableDict setValue:self.url forKey:kResultUrl];
    [mutableDict setValue:self.adrAddress forKey:kResultAdrAddress];
    [mutableDict setValue:self.scope forKey:kResultScope];
    [mutableDict setValue:self.formattedPhoneNumber forKey:kResultFormattedPhoneNumber];
    [mutableDict setValue:[self.geometry dictionaryRepresentation] forKey:kResultGeometry];
    [mutableDict setValue:self.placeId forKey:kResultPlaceId];
    [mutableDict setValue:self.icon forKey:kResultIcon];
    [mutableDict setValue:self.reference forKey:kResultReference];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTypes] forKey:kResultTypes];
    [mutableDict setValue:[NSNumber numberWithDouble:self.utcOffset] forKey:kResultUtcOffset];
    [mutableDict setValue:self.name forKey:kResultName];
    [mutableDict setValue:self.website forKey:kResultWebsite];

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

    self.resultIdentifier = [aDecoder decodeObjectForKey:kResultId];
    self.addressComponents = [aDecoder decodeObjectForKey:kResultAddressComponents];
    self.vicinity = [aDecoder decodeObjectForKey:kResultVicinity];
    self.formattedAddress = [aDecoder decodeObjectForKey:kResultFormattedAddress];
    self.internationalPhoneNumber = [aDecoder decodeObjectForKey:kResultInternationalPhoneNumber];
    self.url = [aDecoder decodeObjectForKey:kResultUrl];
    self.adrAddress = [aDecoder decodeObjectForKey:kResultAdrAddress];
    self.scope = [aDecoder decodeObjectForKey:kResultScope];
    self.formattedPhoneNumber = [aDecoder decodeObjectForKey:kResultFormattedPhoneNumber];
    self.geometry = [aDecoder decodeObjectForKey:kResultGeometry];
    self.placeId = [aDecoder decodeObjectForKey:kResultPlaceId];
    self.icon = [aDecoder decodeObjectForKey:kResultIcon];
    self.reference = [aDecoder decodeObjectForKey:kResultReference];
    self.types = [aDecoder decodeObjectForKey:kResultTypes];
    self.utcOffset = [aDecoder decodeDoubleForKey:kResultUtcOffset];
    self.name = [aDecoder decodeObjectForKey:kResultName];
    self.website = [aDecoder decodeObjectForKey:kResultWebsite];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_resultIdentifier forKey:kResultId];
    [aCoder encodeObject:_addressComponents forKey:kResultAddressComponents];
    [aCoder encodeObject:_vicinity forKey:kResultVicinity];
    [aCoder encodeObject:_formattedAddress forKey:kResultFormattedAddress];
    [aCoder encodeObject:_internationalPhoneNumber forKey:kResultInternationalPhoneNumber];
    [aCoder encodeObject:_url forKey:kResultUrl];
    [aCoder encodeObject:_adrAddress forKey:kResultAdrAddress];
    [aCoder encodeObject:_scope forKey:kResultScope];
    [aCoder encodeObject:_formattedPhoneNumber forKey:kResultFormattedPhoneNumber];
    [aCoder encodeObject:_geometry forKey:kResultGeometry];
    [aCoder encodeObject:_placeId forKey:kResultPlaceId];
    [aCoder encodeObject:_icon forKey:kResultIcon];
    [aCoder encodeObject:_reference forKey:kResultReference];
    [aCoder encodeObject:_types forKey:kResultTypes];
    [aCoder encodeDouble:_utcOffset forKey:kResultUtcOffset];
    [aCoder encodeObject:_name forKey:kResultName];
    [aCoder encodeObject:_website forKey:kResultWebsite];
}

- (id)copyWithZone:(NSZone *)zone
{
    Result *copy = [[Result alloc] init];
    
    if (copy) {

        copy.resultIdentifier = [self.resultIdentifier copyWithZone:zone];
        copy.addressComponents = [self.addressComponents copyWithZone:zone];
        copy.vicinity = [self.vicinity copyWithZone:zone];
        copy.formattedAddress = [self.formattedAddress copyWithZone:zone];
        copy.internationalPhoneNumber = [self.internationalPhoneNumber copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.adrAddress = [self.adrAddress copyWithZone:zone];
        copy.scope = [self.scope copyWithZone:zone];
        copy.formattedPhoneNumber = [self.formattedPhoneNumber copyWithZone:zone];
        copy.geometry = [self.geometry copyWithZone:zone];
        copy.placeId = [self.placeId copyWithZone:zone];
        copy.icon = [self.icon copyWithZone:zone];
        copy.reference = [self.reference copyWithZone:zone];
        copy.types = [self.types copyWithZone:zone];
        copy.utcOffset = self.utcOffset;
        copy.name = [self.name copyWithZone:zone];
        copy.website = [self.website copyWithZone:zone];
    }
    
    return copy;
}


@end
