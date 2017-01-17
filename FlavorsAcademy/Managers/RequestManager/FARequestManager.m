//
//  FARequestManager.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/14/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FARequestManager.h"

static NSString *const userToken = @"fOsgLmTkHaJIP1PZlH9p3epTHR5rkhWMAPbq6pOr";
static NSString *const userBaseUrl = @"https://flavorsacademyusers.firebaseio.com";
static NSString *const dataToken = @"wPKAs8wboOdgUTgERLSAX5xbx4rEdmgHIEE5aPBM";
static NSString *const dataBaseUrl = @"https://flavors-academy.firebaseio.com";

@implementation FARequestManager

+ (FARequestManager *)shared {
  static FARequestManager *shared;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    shared = [[[self class] alloc] init];
  });
  return shared;
}

#pragma mark Home
- (void)getHomePageWithCallback:(void (^)(id responseObject, NSError *error))callback {
  [PKNetworkingManager
   getJsonCachelessFromURL:[NSString stringWithFormat:@"%@/.json?auth=%@",dataBaseUrl, dataToken]
   param:nil
   returned:^(id responseObject, NSError *error) {
     if (error) {
       callback(nil, error);
     } else {
       callback(responseObject, nil);
     }
   }];
}

-(void)getUserDataWithUID:(NSString *)uid callback:(void (^)(id responseObject, NSError *error))callback {
  NSString *url = [NSString stringWithFormat:@"%@/users/%@.json?auth=%@",userBaseUrl,uid,userToken];
  [PKNetworkingManager getJsonCachelessFromURL:url param:nil returned:^(id responseObject, NSError *error) {
    if (error) {
      callback(nil, error);
    }
    else {
      callback(responseObject, nil);
    }
  }];
}

-(void)searchVideoWithText:(NSString *)searchText callback:(void (^)(id, NSError *))callback {
  PFQuery *query = [PFQuery queryWithClassName:@"Video"];
  [query whereKey:@"keywords" matchesRegex:searchText modifiers:@"i"];
  [query whereKey:@"isActive" notEqualTo:[NSNumber numberWithBool:NO]];
  [query orderByDescending:@"ordinalValue"];
  [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
    if (error) {
      callback(nil, error);
    }
    else {
      callback(objects, nil);
    }
  }];
}

@end
