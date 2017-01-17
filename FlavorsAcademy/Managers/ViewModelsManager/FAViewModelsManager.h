//
//  FAViewModelsManager.h
//  FlavorsAcademy
//
//  Created by Bibo on 11/14/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAHomeVM.h"
#import "FAVideoVM.h"
#import "FAUserVM.h"
#import "FAProductVM.h"

@interface FAViewModelsManager : NSObject

+ (FAViewModelsManager *)shared;

-(void)resetAllVMs;

@property (nonatomic, strong) FAHomeVM *homeVM;
@property (nonatomic, strong) FAVideoVM *videoVM;
@property (nonatomic, strong) FAUserVM *userVM;

@end
