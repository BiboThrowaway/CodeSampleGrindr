//
//  FAHomeSettings.h
//
//  Created by Bibo  on 12/17/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FAHomeSettings : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *forceupdateMessage;
@property (nonatomic, assign) double iosMinVersion;
@property (nonatomic, assign) BOOL useWebview;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
