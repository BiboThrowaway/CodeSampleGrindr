//
//  FAViewModelsManager.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/14/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAViewModelsManager.h"

@implementation FAViewModelsManager


//format data model

+ (FAViewModelsManager *)shared {
  static FAViewModelsManager *shared;
  
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
      [self initializeAllVMs];
    }
    return self;
}

-(void)initializeAllVMs {
  self.homeVM = [FAHomeVM new];
  self.videoVM = [FAVideoVM new];
  self.userVM = [FAUserVM new];
}

-(void)resetAllVMs {
  [self initializeAllVMs];
}

@end
