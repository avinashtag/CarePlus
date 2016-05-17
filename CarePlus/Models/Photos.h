//
//  Photos.h
//
//  Created by Avinash Tag on 17/05/16
//  Copyright (c) 2016 Rohde & Schwarz. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Photos : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *htmlAttributions;
@property (nonatomic, assign) double width;
@property (nonatomic, assign) double height;
@property (nonatomic, strong) NSString *photoReference;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
