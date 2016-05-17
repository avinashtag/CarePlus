//
//  OpeningHours.m
//
//  Created by Avinash Tag on 17/05/16
//  Copyright (c) 2016 Rohde & Schwarz. All rights reserved.
//

#import "OpeningHours.h"


NSString *const kOpeningHoursWeekdayText = @"weekday_text";
NSString *const kOpeningHoursOpenNow = @"open_now";


@interface OpeningHours ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation OpeningHours

@synthesize weekdayText = _weekdayText;
@synthesize openNow = _openNow;


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
            self.weekdayText = [self objectOrNilForKey:kOpeningHoursWeekdayText fromDictionary:dict];
            self.openNow = [[self objectOrNilForKey:kOpeningHoursOpenNow fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    NSMutableArray *tempArrayForWeekdayText = [NSMutableArray array];
    for (NSObject *subArrayObject in self.weekdayText) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForWeekdayText addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForWeekdayText addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForWeekdayText] forKey:kOpeningHoursWeekdayText];
    [mutableDict setValue:[NSNumber numberWithBool:self.openNow] forKey:kOpeningHoursOpenNow];

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

    self.weekdayText = [aDecoder decodeObjectForKey:kOpeningHoursWeekdayText];
    self.openNow = [aDecoder decodeBoolForKey:kOpeningHoursOpenNow];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_weekdayText forKey:kOpeningHoursWeekdayText];
    [aCoder encodeBool:_openNow forKey:kOpeningHoursOpenNow];
}

- (id)copyWithZone:(NSZone *)zone
{
    OpeningHours *copy = [[OpeningHours alloc] init];
    
    if (copy) {

        copy.weekdayText = [self.weekdayText copyWithZone:zone];
        copy.openNow = self.openNow;
    }
    
    return copy;
}


@end
