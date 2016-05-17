//
//  Photos.m
//
//  Created by Avinash Tag on 17/05/16
//  Copyright (c) 2016 Rohde & Schwarz. All rights reserved.
//

#import "Photos.h"


NSString *const kPhotosHtmlAttributions = @"html_attributions";
NSString *const kPhotosWidth = @"width";
NSString *const kPhotosHeight = @"height";
NSString *const kPhotosPhotoReference = @"photo_reference";


@interface Photos ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Photos

@synthesize htmlAttributions = _htmlAttributions;
@synthesize width = _width;
@synthesize height = _height;
@synthesize photoReference = _photoReference;


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
            self.htmlAttributions = [self objectOrNilForKey:kPhotosHtmlAttributions fromDictionary:dict];
            self.width = [[self objectOrNilForKey:kPhotosWidth fromDictionary:dict] doubleValue];
            self.height = [[self objectOrNilForKey:kPhotosHeight fromDictionary:dict] doubleValue];
            self.photoReference = [self objectOrNilForKey:kPhotosPhotoReference fromDictionary:dict];

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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHtmlAttributions] forKey:kPhotosHtmlAttributions];
    [mutableDict setValue:[NSNumber numberWithDouble:self.width] forKey:kPhotosWidth];
    [mutableDict setValue:[NSNumber numberWithDouble:self.height] forKey:kPhotosHeight];
    [mutableDict setValue:self.photoReference forKey:kPhotosPhotoReference];

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

    self.htmlAttributions = [aDecoder decodeObjectForKey:kPhotosHtmlAttributions];
    self.width = [aDecoder decodeDoubleForKey:kPhotosWidth];
    self.height = [aDecoder decodeDoubleForKey:kPhotosHeight];
    self.photoReference = [aDecoder decodeObjectForKey:kPhotosPhotoReference];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_htmlAttributions forKey:kPhotosHtmlAttributions];
    [aCoder encodeDouble:_width forKey:kPhotosWidth];
    [aCoder encodeDouble:_height forKey:kPhotosHeight];
    [aCoder encodeObject:_photoReference forKey:kPhotosPhotoReference];
}

- (id)copyWithZone:(NSZone *)zone
{
    Photos *copy = [[Photos alloc] init];
    
    if (copy) {

        copy.htmlAttributions = [self.htmlAttributions copyWithZone:zone];
        copy.width = self.width;
        copy.height = self.height;
        copy.photoReference = [self.photoReference copyWithZone:zone];
    }
    
    return copy;
}


@end
