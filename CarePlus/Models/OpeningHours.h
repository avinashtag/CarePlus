//
//  OpeningHours.h
//
//  Created by Avinash Tag on 17/05/16
//  Copyright (c) 2016 Rohde & Schwarz. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OpeningHours : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *weekdayText;
@property (nonatomic, assign) BOOL openNow;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
