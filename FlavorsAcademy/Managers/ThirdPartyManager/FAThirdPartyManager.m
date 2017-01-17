//
//  FAThirdPartyManager.m
//  BiboliveAcademy
//
//  Created by Bibo on 2/14/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "FAThirdPartyManager.h"

static NSString *const parseId = @"Gridr Demo Not Able To Run";
static NSString *const parseKey = @"Gridr Demo Not Able To Run";

@implementation FAThirdPartyManager

+ (FAThirdPartyManager *)shared {
  static FAThirdPartyManager *shared;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    shared = [[[self class] alloc] init];
  });
  return shared;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    
    [self setSVProgressViewStyles];
    [self setupFabric];
    [self setupParse];
    
  }
  return self;
}


- (void)setSVProgressViewStyles {
  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
  [SVProgressHUD setFont:[UIFont dosisRegularWithSize:14]];
  [SVProgressHUD setBackgroundColor:[UIColor FAAlmostBlackColor]];
  [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
}

-(void)setupFabric {
  [[Fabric sharedSDK] setDebug:NO];
  [Fabric with:@[ [Crashlytics class] ]];
}

-(void)setupParse {
  [Parse setApplicationId:parseId
                clientKey:parseKey];
}

@end
