//
//  BaseClass.m
//
//  Created by Avinash Tag on 17/05/16
//  Copyright (c) 2016 Rohde & Schwarz. All rights reserved.
//

#import "BaseClass.h"
#import "Results.h"


NSString *const kBaseClassStatus = @"status";
NSString *const kBaseClassResults = @"results";
NSString *const kBaseClassNextPageToken = @"next_page_token";
NSString *const kBaseClassHtmlAttributions = @"html_attributions";


@interface BaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseClass

@synthesize status = _status;
@synthesize results = _results;
@synthesize nextPageToken = _nextPageToken;
@synthesize htmlAttributions = _htmlAttributions;


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
            self.status = [self objectOrNilForKey:kBaseClassStatus fromDictionary:dict];
    NSObject *receivedResults = [dict objectForKey:kBaseClassResults];
    NSMutableArray *parsedResults = [NSMutableArray array];
    if ([receivedResults isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedResults) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedResults addObject:[Results modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedResults isKindOfClass:[NSDictionary class]]) {
       [parsedResults addObject:[Results modelObjectWithDictionary:(NSDictionary *)receivedResults]];
    }

    self.results = [NSArray arrayWithArray:parsedResults];
            self.nextPageToken = [self objectOrNilForKey:kBaseClassNextPageToken fromDictionary:dict];
            self.htmlAttributions = [self objectOrNilForKey:kBaseClassHtmlAttributions fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.status forKey:kBaseClassStatus];
    NSMutableArray *tempArrayForResults = [NSMutableArray array];
    for (NSObject *subArrayObject in self.results) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForResults addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForResults addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForResults] forKey:kBaseClassResults];
    [mutableDict setValue:self.nextPageToken forKey:kBaseClassNextPageToken];
    NSMutableArray *tempArrayForHtmlAttributions = [NSMutableArray array];
    for (NSObject *subArrayObject in self.htmlAttributions) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHtmlAttributions addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHtmlAttributions addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHtmlAttributions] forKey:kBaseClassHtmlAttributions];

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

    self.status = [aDecoder decodeObjectForKey:kBaseClassStatus];
    self.results = [aDecoder decodeObjectForKey:kBaseClassResults];
    self.nextPageToken = [aDecoder decodeObjectForKey:kBaseClassNextPageToken];
    self.htmlAttributions = [aDecoder decodeObjectForKey:kBaseClassHtmlAttributions];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_status forKey:kBaseClassStatus];
    [aCoder encodeObject:_results forKey:kBaseClassResults];
    [aCoder encodeObject:_nextPageToken forKey:kBaseClassNextPageToken];
    [aCoder encodeObject:_htmlAttributions forKey:kBaseClassHtmlAttributions];
}

- (id)copyWithZone:(NSZone *)zone
{
    BaseClass *copy = [[BaseClass alloc] init];
    
    if (copy) {

        copy.status = [self.status copyWithZone:zone];
        copy.results = [self.results copyWithZone:zone];
        copy.nextPageToken = [self.nextPageToken copyWithZone:zone];
        copy.htmlAttributions = [self.htmlAttributions copyWithZone:zone];
    }
    
    return copy;
}


@end
