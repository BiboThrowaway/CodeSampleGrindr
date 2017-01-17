//
//  FAUserVM.h
//  FlavorsAcademy
//
//  Created by Bibo on 11/16/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAUserVM : NSObject

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSArray *favoriteVideoIds;
@property (nonatomic, strong) NSString *provider;

@end
