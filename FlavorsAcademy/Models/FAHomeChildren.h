//
//  FAHomeChildren.h
//
//  Created by Bibo  on 12/17/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FAHomeChildren : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *lookupKey;
@property (nonatomic, strong) NSString *displayTitle;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray *children;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
