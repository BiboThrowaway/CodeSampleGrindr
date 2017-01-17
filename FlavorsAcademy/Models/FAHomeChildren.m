//
//  FAHomeChildren.m
//
//  Created by Bibo  on 12/17/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FAHomeChildren.h"
#import "FAHomeChildren.h"


NSString *const kFAHomeChildrenLookupKey = @"lookupKey";
NSString *const kFAHomeChildrenDisplayTitle = @"displayTitle";
NSString *const kFAHomeChildrenImageUrl = @"imageUrl";
NSString *const kFAHomeChildrenType = @"type";
NSString *const kFAHomeChildrenChildren = @"children";


@interface FAHomeChildren ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FAHomeChildren

@synthesize lookupKey = _lookupKey;
@synthesize displayTitle = _displayTitle;
@synthesize imageUrl = _imageUrl;
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
            self.lookupKey = [self objectOrNilForKey:kFAHomeChildrenLookupKey fromDictionary:dict];
            self.displayTitle = [self objectOrNilForKey:kFAHomeChildrenDisplayTitle fromDictionary:dict];
            self.imageUrl = [self objectOrNilForKey:kFAHomeChildrenImageUrl fromDictionary:dict];
            self.type = [self objectOrNilForKey:kFAHomeChildrenType fromDictionary:dict];
    NSObject *receivedFAHomeChildren = [dict objectForKey:kFAHomeChildrenChildren];
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
    [mutableDict setValue:self.lookupKey forKey:kFAHomeChildrenLookupKey];
    [mutableDict setValue:self.displayTitle forKey:kFAHomeChildrenDisplayTitle];
    [mutableDict setValue:self.imageUrl forKey:kFAHomeChildrenImageUrl];
    [mutableDict setValue:self.type forKey:kFAHomeChildrenType];
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
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForChildren] forKey:kFAHomeChildrenChildren];

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

    self.lookupKey = [aDecoder decodeObjectForKey:kFAHomeChildrenLookupKey];
    self.displayTitle = [aDecoder decodeObjectForKey:kFAHomeChildrenDisplayTitle];
    self.imageUrl = [aDecoder decodeObjectForKey:kFAHomeChildrenImageUrl];
    self.type = [aDecoder decodeObjectForKey:kFAHomeChildrenType];
    self.children = [aDecoder decodeObjectForKey:kFAHomeChildrenChildren];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_lookupKey forKey:kFAHomeChildrenLookupKey];
    [aCoder encodeObject:_displayTitle forKey:kFAHomeChildrenDisplayTitle];
    [aCoder encodeObject:_imageUrl forKey:kFAHomeChildrenImageUrl];
    [aCoder encodeObject:_type forKey:kFAHomeChildrenType];
    [aCoder encodeObject:_children forKey:kFAHomeChildrenChildren];
}

- (id)copyWithZone:(NSZone *)zone
{
    FAHomeChildren *copy = [[FAHomeChildren alloc] init];
    
    if (copy) {

        copy.lookupKey = [self.lookupKey copyWithZone:zone];
        copy.displayTitle = [self.displayTitle copyWithZone:zone];
        copy.imageUrl = [self.imageUrl copyWithZone:zone];
        copy.type = [self.type copyWithZone:zone];
        copy.children = [self.children copyWithZone:zone];
    }
    
    return copy;
}


@end
