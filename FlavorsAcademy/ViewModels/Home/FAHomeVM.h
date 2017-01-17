//
//  FAHomeVM.h
//  FlavorsAcademy
//
//  Created by Bibo on 11/14/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAHomeModel.h"

@interface FAHomeVM : NSObject

-(instancetype)initWithHomeAPIResponse:(NSDictionary *)response;

@property (nonatomic, strong) FAHomeModel *baseResponse;
@property (nonatomic, readwrite) BOOL isSneakPeak;

@end
