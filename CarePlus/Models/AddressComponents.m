//
//  AddressComponents.m
//
//  Created by Avinash Tag on 17/05/16
//  Copyright (c) 2016 Rohde & Schwarz. All rights reserved.
//

#import "AddressComponents.h"


NSString *const kAddressComponentsShortName = @"short_name";
NSString *const kAddressComponentsLongName = @"long_name";
NSString *const kAddressComponentsTypes = @"types";


@interface AddressComponents ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation AddressComponents

@synthesize shortName = _shortName;
@synthesize longName = _longName;
@synthesize types = _types;


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
            self.shortName = [self objectOrNilForKey:kAddressComponentsShortName fromDictionary:dict];
            self.longName = [self objectOrNilForKey:kAddressComponentsLongName fromDictionary:dict];
            self.types = [self objectOrNilForKey:kAddressComponentsTypes fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.shortName forKey:kAddressComponentsShortName];
    [mutableDict setValue:self.longName forKey:kAddressComponentsLongName];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTypes] forKey:kAddressComponentsTypes];

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

    self.shortName = [aDecoder decodeObjectForKey:kAddressComponentsShortName];
    self.longName = [aDecoder decodeObjectForKey:kAddressComponentsLongName];
    self.types = [aDecoder decodeObjectForKey:kAddressComponentsTypes];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_shortName forKey:kAddressComponentsShortName];
    [aCoder encodeObject:_longName forKey:kAddressComponentsLongName];
    [aCoder encodeObject:_types forKey:kAddressComponentsTypes];
}

- (id)copyWithZone:(NSZone *)zone
{
    AddressComponents *copy = [[AddressComponents alloc] init];
    
    if (copy) {

        copy.shortName = [self.shortName copyWithZone:zone];
        copy.longName = [self.longName copyWithZone:zone];
        copy.types = [self.types copyWithZone:zone];
    }
    
    return copy;
}


@end
