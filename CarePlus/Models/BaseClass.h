//
//  BaseClass.h
//
//  Created by Avinash Tag on 17/05/16
//  Copyright (c) 2016 Rohde & Schwarz. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Result;

@interface BaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *htmlAttributions;
@property (nonatomic, strong) Result *result;
@property (nonatomic, strong) NSString *status;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
