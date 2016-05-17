//
//  BaseClass.m
//
//  Created by Avinash Tag on 17/05/16
//  Copyright (c) 2016 Rohde & Schwarz. All rights reserved.
//

#import "BaseClass.h"
#import "Result.h"


NSString *const kBaseClassHtmlAttributions = @"html_attributions";
NSString *const kBaseClassResult = @"result";
NSString *const kBaseClassStatus = @"status";


@interface BaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation BaseClass

@synthesize htmlAttributions = _htmlAttributions;
@synthesize result = _result;
@synthesize status = _status;


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
            self.htmlAttributions = [self objectOrNilForKey:kBaseClassHtmlAttributions fromDictionary:dict];
            self.result = [Result modelObjectWithDictionary:[dict objectForKey:kBaseClassResult]];
            self.status = [self objectOrNilForKey:kBaseClassStatus fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
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
    [mutableDict setValue:[self.result dictionaryRepresentation] forKey:kBaseClassResult];
    [mutableDict setValue:self.status forKey:kBaseClassStatus];

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

    self.htmlAttributions = [aDecoder decodeObjectForKey:kBaseClassHtmlAttributions];
    self.result = [aDecoder decodeObjectForKey:kBaseClassResult];
    self.status = [aDecoder decodeObjectForKey:kBaseClassStatus];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_htmlAttributions forKey:kBaseClassHtmlAttributions];
    [aCoder encodeObject:_result forKey:kBaseClassResult];
    [aCoder encodeObject:_status forKey:kBaseClassStatus];
}

- (id)copyWithZone:(NSZone *)zone
{
    BaseClass *copy = [[BaseClass alloc] init];
    
    if (copy) {

        copy.htmlAttributions = [self.htmlAttributions copyWithZone:zone];
        copy.result = [self.result copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
    }
    
    return copy;
}


@end
