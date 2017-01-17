//
//  FAHomeModel.h
//
//  Created by Bibo  on 12/17/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FAHomeSettings;

@interface FAHomeModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) FAHomeSettings *settings;
@property (nonatomic, strong) NSArray *homePage;
@property (nonatomic, strong) NSArray *searchTerms;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
