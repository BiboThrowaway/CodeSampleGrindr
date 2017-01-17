//
//  FAHomeHomePage.m
//
//  Created by Bibo  on 12/17/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FAHomeHomePage.h"
#import "FAHomeChildren.h"


NSString *const kFAHomeHomePageLookupKey = @"lookupKey";
NSString *const kFAHomeHomePageDisplayTitle = @"displayTitle";
NSString *const kFAHomeHomePageType = @"type";
NSString *const kFAHomeHomePageChildren = @"children";


@interface FAHomeHomePage ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FAHomeHomePage

@synthesize lookupKey = _lookupKey;
@synthesize displayTitle = _displayTitle;
@synthesize type = _type;
@synthesize children = _children;


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
            self.lookupKey = [self objectOrNilForKey:kFAHomeHomePageLookupKey fromDictionary:dict];
            self.displayTitle = [self objectOrNilForKey:kFAHomeHomePageDisplayTitle fromDictionary:dict];
            self.type = [self objectOrNilForKey:kFAHomeHomePageType fromDictionary:dict];
    NSObject *receivedFAHomeChildren = [dict objectForKey:kFAHomeHomePageChildren];
    NSMutableArray *parsedFAHomeChildren = [NSMutableArray array];
    if ([receivedFAHomeChildren isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFAHomeChildren) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFAHomeChildren addObject:[FAHomeChildren modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFAHomeChildren isKindOfClass:[NSDictionary class]]) {
       [parsedFAHomeChildren addObject:[FAHomeChildren modelObjectWithDictionary:(NSDictionary *)receivedFAHomeChildren]];
    }

    self.children = [NSArray arrayWithArray:parsedFAHomeChildren];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.lookupKey forKey:kFAHomeHomePageLookupKey];
    [mutableDict setValue:self.displayTitle forKey:kFAHomeHomePageDisplayTitle];
    [mutableDict setValue:self.type forKey:kFAHomeHomePageType];
    NSMutableArray *tempArrayForChildren = [NSMutableArray array];
    for (NSObject *subArrayObject in self.children) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForChildren addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForChildren addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForChildren] forKey:kFAHomeHomePageChildren];

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

    self.lookupKey = [aDecoder decodeObjectForKey:kFAHomeHomePageLookupKey];
    self.displayTitle = [aDecoder decodeObjectForKey:kFAHomeHomePageDisplayTitle];
    self.type = [aDecoder decodeObjectForKey:kFAHomeHomePageType];
    self.children = [aDecoder decodeObjectForKey:kFAHomeHomePageChildren];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_lookupKey forKey:kFAHomeHomePageLookupKey];
    [aCoder encodeObject:_displayTitle forKey:kFAHomeHomePageDisplayTitle];
    [aCoder encodeObject:_type forKey:kFAHomeHomePageType];
    [aCoder encodeObject:_children forKey:kFAHomeHomePageChildren];
}

- (id)copyWithZone:(NSZone *)zone
{
    FAHomeHomePage *copy = [[FAHomeHomePage alloc] init];
    
    if (copy) {

        copy.lookupKey = [self.lookupKey copyWithZone:zone];
        copy.displayTitle = [self.displayTitle copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.children = [self.children copyWithZone:zone];
    }
    
    return copy;
}


@end
