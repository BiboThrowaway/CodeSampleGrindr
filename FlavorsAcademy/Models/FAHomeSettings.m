//
//  FAHomeSettings.m
//
//  Created by Bibo  on 12/17/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FAHomeSettings.h"


NSString *const kFAHomeSettingsForceupdateMessage = @"forceupdateMessage";
NSString *const kFAHomeSettingsIosMinVersion = @"ios_min_version";
NSString *const kFAHomeSettingsUseWebview = @"useWebview";


@interface FAHomeSettings ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FAHomeSettings

@synthesize forceupdateMessage = _forceupdateMessage;
@synthesize iosMinVersion = _iosMinVersion;
@synthesize useWebview = _useWebview;


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
            self.forceupdateMessage = [self objectOrNilForKey:kFAHomeSettingsForceupdateMessage fromDictionary:dict];
            self.iosMinVersion = [[self objectOrNilForKey:kFAHomeSettingsIosMinVersion fromDictionary:dict] doubleValue];
            self.useWebview = [[self objectOrNilForKey:kFAHomeSettingsUseWebview fromDictionary:dict] boolValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.forceupdateMessage forKey:kFAHomeSettingsForceupdateMessage];
    [mutableDict setValue:[NSNumber numberWithDouble:self.iosMinVersion] forKey:kFAHomeSettingsIosMinVersion];
    [mutableDict setValue:[NSNumber numberWithBool:self.useWebview] forKey:kFAHomeSettingsUseWebview];

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

    self.forceupdateMessage = [aDecoder decodeObjectForKey:kFAHomeSettingsForceupdateMessage];
    self.iosMinVersion = [aDecoder decodeDoubleForKey:kFAHomeSettingsIosMinVersion];
    self.useWebview = [aDecoder decodeBoolForKey:kFAHomeSettingsUseWebview];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_forceupdateMessage forKey:kFAHomeSettingsForceupdateMessage];
    [aCoder encodeDouble:_iosMinVersion forKey:kFAHomeSettingsIosMinVersion];
    [aCoder encodeBool:_useWebview forKey:kFAHomeSettingsUseWebview];
}

- (id)copyWithZone:(NSZone *)zone
{
    FAHomeSettings *copy = [[FAHomeSettings alloc] init];
    
    if (copy) {

        copy.forceupdateMessage = [self.forceupdateMessage copyWithZone:zone];
        copy.iosMinVersion = self.iosMinVersion;
        copy.useWebview = self.useWebview;
    }
    
    return copy;
}


@end
