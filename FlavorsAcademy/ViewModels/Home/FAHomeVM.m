//
//  FAHomeVM.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/14/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAHomeVM.h"

@implementation FAHomeVM

-(instancetype)initWithHomeAPIResponse:(NSDictionary *)response {
  self = [super init];
  if (self) {
    self.baseResponse = [FAHomeModel modelObjectWithDictionary:response];
  }
  return self;
}

@end
