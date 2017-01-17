//
//  FAUserManager.h
//  FlavorsAcademy
//
//  Created by Bibo on 11/13/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FABaseNavVC.h"

@interface FAUserManager : NSObject

+ (FAUserManager *)shared;

- (BOOL)isCurrentUser;

- (void)loginWithEmail:(NSString *)email password:(NSString *)password callback:(void (^)(id responseObject, NSError *error))callback;

- (void)signupWithEmail:(NSString *)email password:(NSString *)password callback:(void (^)(id responseObject, NSError *error))callback;

-(void)connectWithFacebookFromVC:(FABaseNavVC *)vc;

-(void)resetPasswordWithEmail:(NSString *)email callback:(void (^)(NSError *error))callback;

-(void)getUserInfoWithUID:(NSString *)uid callback:(void (^)(id responseObject, NSError *error))callback;

- (void)addVideoToFavorites:(NSString *)videoId displayTitle:(NSString *)displayTitle callback:(void (^)(id responseObject, NSError *error))callback;

- (void)removeVideoFromFavorites:(NSString *)videoId callback:(void (^)(id responseObject, NSError *error))callback;

-(void)changeEmailWithCurrentEmail:(NSString *)currentEmail newEmail:(NSString *)newEmail password:(NSString *)password callback:(void (^)(BOOL success, NSError *error))callback;

-(void)changePasswordWithCurrentEmail:(NSString *)currentEmail currentPassword:(NSString *)currentPassword newPassword:(NSString *)newPassword callback:(void (^)(BOOL success, NSError *error))callback;

-(void)logout;

@end
