//
//  FAHomeModel.m
//
//  Created by Bibo  on 12/17/15
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "FAHomeModel.h"
#import "FAHomeSettings.h"
#import "FAHomeHomePage.h"


NSString *const kFAHomeModelSettings = @"settings";
NSString *const kFAHomeModelHomePage = @"homePage";
NSString *const kFAHomeModelSearchTerms = @"search_terms";


@interface FAHomeModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FAHomeModel

@synthesize settings = _settings;
@synthesize homePage = _homePage;
@synthesize searchTerms = _searchTerms;


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
            self.settings = [FAHomeSettings modelObjectWithDictionary:[dict objectForKey:kFAHomeModelSettings]];
    NSObject *receivedFAHomeHomePage = [dict objectForKey:kFAHomeModelHomePage];
    NSMutableArray *parsedFAHomeHomePage = [NSMutableArray array];
    if ([receivedFAHomeHomePage isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedFAHomeHomePage) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedFAHomeHomePage addObject:[FAHomeHomePage modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedFAHomeHomePage isKindOfClass:[NSDictionary class]]) {
       [parsedFAHomeHomePage addObject:[FAHomeHomePage modelObjectWithDictionary:(NSDictionary *)receivedFAHomeHomePage]];
    }

    self.homePage = [NSArray arrayWithArray:parsedFAHomeHomePage];
            self.searchTerms = [self objectOrNilForKey:kFAHomeModelSearchTerms fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.settings dictionaryRepresentation] forKey:kFAHomeModelSettings];
    NSMutableArray *tempArrayForHomePage = [NSMutableArray array];
    for (NSObject *subArrayObject in self.homePage) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForHomePage addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForHomePage addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForHomePage] forKey:kFAHomeModelHomePage];
    NSMutableArray *tempArrayForSearchTerms = [NSMutableArray array];
    for (NSObject *subArrayObject in self.searchTerms) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForSearchTerms addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForSearchTerms addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForSearchTerms] forKey:kFAHomeModelSearchTerms];

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

    self.settings = [aDecoder decodeObjectForKey:kFAHomeModelSettings];
    self.homePage = [aDecoder decodeObjectForKey:kFAHomeModelHomePage];
    self.searchTerms = [aDecoder decodeObjectForKey:kFAHomeModelSearchTerms];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_settings forKey:kFAHomeModelSettings];
    [aCoder encodeObject:_homePage forKey:kFAHomeModelHomePage];
    [aCoder encodeObject:_searchTerms forKey:kFAHomeModelSearchTerms];
}

- (id)copyWithZone:(NSZone *)zone
{
    FAHomeModel *copy = [[FAHomeModel alloc] init];
    
    if (copy) {

        copy.settings = [self.settings copyWithZone:zone];
        copy.homePage = [self.homePage copyWithZone:zone];
        copy.searchTerms = [self.searchTerms copyWithZone:zone];
    }
    
    return copy;
}


@end
