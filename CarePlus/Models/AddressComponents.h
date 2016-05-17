//
//  AddressComponents.h
//
//  Created by Avinash Tag on 17/05/16
//  Copyright (c) 2016 Rohde & Schwarz. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface AddressComponents : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *shortName;
@property (nonatomic, strong) NSString *longName;
@property (nonatomic, strong) NSArray *types;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
