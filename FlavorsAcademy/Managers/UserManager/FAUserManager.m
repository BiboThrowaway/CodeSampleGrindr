//
//  FAUserManager.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/13/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAUserManager.h"

static NSString *const userToken = @"fOsgLmTkHaJIP1PZlH9p3epTHR5rkhWMAPbq6pOr";
static NSString *const userBaseUrl = @"https://flavorsacademyusers.firebaseio.com";

@interface FAUserManager () <UIAlertViewDelegate>

@property (nonatomic, strong) Firebase *firebaseRef;

@end

@implementation FAUserManager

+ (FAUserManager *)shared {
  static FAUserManager *shared;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    shared = [[[self class] alloc] init];
  });
  return shared;
}

-(BOOL)isCurrentUser {
  if ([[NSUserDefaults standardUserDefaults] stringForKey:@"CurrentUserUID"]) {
    [FAViewModelsManager shared].userVM.uid = [[NSUserDefaults standardUserDefaults] stringForKey:@"CurrentUserUID"];
  }
  else {
    if ([FAViewModelsManager shared].userVM.uid) {
      [[NSUserDefaults standardUserDefaults] setObject:[FAViewModelsManager shared].userVM.uid forKey:@"CurrentUserUID"];
      [[NSUserDefaults standardUserDefaults] synchronize];
    }
  }
  return [FAViewModelsManager shared].userVM.uid ? YES : NO;
}

-(instancetype)init {
  self = [super init];
  if (self) {
    self.firebaseRef = [[Firebase alloc] initWithUrl:userBaseUrl];
  }
  return self;
}

-(void)loginWithEmail:(NSString *)email password:(NSString *)password callback:(void (^)(id, NSError *))callback {
  [self.firebaseRef authUser:[email lowercaseString] password:password
         withCompletionBlock:^(NSError *error, FAuthData *authData) {
           if (error) {
             callback(nil, error);
           } else {
             [self getUserInfoWithUID:authData.uid callback:^(id responseObject, NSError *error) {
               if (error) {
                 callback(nil, error);
               }
               else {
                 if (responseObject) {
                   [FAViewModelsManager shared].userVM.uid = authData.uid;
                   callback(responseObject, nil);
                 }
                 else {
                   callback(nil, [NSError errorWithDomain:@"" code:500 userInfo:@{NSLocalizedDescriptionKey : @"User does not exist"}]);
                   NSLog(@"user does not exist but is able to login");
                 }
               }
             }];
           }
         }];
}

-(void)signupWithEmail:(NSString *)email password:(NSString *)password callback:(void (^)(id, NSError *))callback {
  [self.firebaseRef createUser:[email lowercaseString] password:password withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
    if (error) {
      callback(nil, error);
    }
    else {
      NSString *uid = result[@"uid"];
      [self.firebaseRef authWithCustomToken:userToken withCompletionBlock:^(NSError *error, FAuthData *authData) {
        if (error) {
          callback(nil, error);
        }
        else {
          NSDictionary *newUser = @{@"provider": @"password",
                                    @"email": email,
                                    @"providerData" : @{@"password":password}
                                    };
          [[[self.firebaseRef childByAppendingPath:@"users"]
            childByAppendingPath:uid] setValue:newUser];
          
          [FAViewModelsManager shared].userVM.email = email;
          [FAViewModelsManager shared].userVM.uid = uid;
          
          callback(newUser, nil);
        }
      }];
    }
  }];
}

-(void)connectWithFacebookFromVC:(FABaseNavVC *)vc {
  FBSDKLoginManager *facebookLogin = [[FBSDKLoginManager alloc] init];
  [facebookLogin logInWithReadPermissions:@[@"email"] fromViewController:vc handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
    if (error) {
      [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    } else if (result.isCancelled) {
      [SVProgressHUD showErrorWithStatus:@"Failed to connect to Facebook"];
    } else {
      NSString *accessToken = [[FBSDKAccessToken currentAccessToken] tokenString];
      [SVProgressHUD showWithStatus:@"Connecting"];
      [self.firebaseRef authWithOAuthProvider:@"facebook" token:accessToken
                          withCompletionBlock:^(NSError *error, FAuthData *authData) {
                            if (error) {
                              [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                            } else {
                              [self getUserInfoWithUID:authData.uid callback:^(id responseObject, NSError *error) {
                                if (error) {
                                  [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                                }
                                else {
                                  if (responseObject) {
                                    //                                    NSLog(@"existing user %@", responseObject);
                                    
                                    [Answers logLoginWithMethod:@"facebook" success:@1 customAttributes:nil];
                                    
                                    [SVProgressHUD dismiss];
                                    [FAViewModelsManager shared].userVM.uid = authData.uid;
                                    [[FARouteManager shared] goToLandingVC];
                                  }
                                  else {
                                    //                                    NSLog(@"new user %@", authData.providerData);
                                    [Answers logSignUpWithMethod:@"facebook" success:@1 customAttributes:nil];
                                    
                                    [self.firebaseRef authWithCustomToken:userToken withCompletionBlock:^(NSError *error, FAuthData *auth) {
                                      
                                      if (error) {
                                        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
                                      }
                                      else {
                                        NSDictionary *newUser = @{
                                                                  @"provider": @"facebook",
                                                                  @"email": authData.providerData[@"email"] ? authData.providerData[@"email"] : @"no_email_from_facebook@email.com",
                                                                  @"providerData" : authData.providerData ? authData.providerData : @[]
                                                                  };
                                        
                                        [[[self.firebaseRef childByAppendingPath:@"users"]
                                          childByAppendingPath:authData.uid] setValue:newUser];
                                        
                                        [SVProgressHUD dismiss];
                                        
                                        [FAViewModelsManager shared].userVM.uid = authData.uid;
                                        [FAViewModelsManager shared].userVM.provider = @"facebook";
                                        [FAViewModelsManager shared].userVM.email = authData.providerData[@"email"];
                                        [[FARouteManager shared] goToLandingVC];
                                      }
                                    }];
                                  }
                                }
                              }];
                            }
                          }];
    }
  }];
}

-(void)resetPasswordWithEmail:(NSString *)email callback:(void (^)(NSError *))callback {
  [self.firebaseRef resetPasswordForUser:email withCompletionBlock:^(NSError *error) {
    if (error) {
      callback(error);
    }
    else {
      callback(nil);
    }
  }];
}

-(void)logout {
  UIAlertView *logoutAlert = [[UIAlertView alloc]initWithTitle:@"Log out" message:@"Are you sure you want to Log out?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Log out", nil];
  [logoutAlert show];
}

-(void)getUserInfoWithUID:(NSString *)uid callback:(void (^)(id responseObject, NSError *error))callback {
  [[FARequestManager shared] getUserDataWithUID:uid callback:^(id responseObject, NSError *error) {
    if (error) {
      callback(nil, error);
    }
    else {
//      NSLog(@"getUserInfoWithUID %@", responseObject);
      [FAViewModelsManager shared].userVM.email = responseObject[@"email"] ? responseObject[@"email"] : @"";
      [FAViewModelsManager shared].userVM.favoriteVideoIds = responseObject[@"favoriteVideoIds"] ? responseObject[@"favoriteVideoIds"] : @[];
      [FAViewModelsManager shared].userVM.provider = responseObject[@"provider"] ? responseObject[@"provider"] : @"";
//      NSLog(@"favoriteVideoIds %@", [FAViewModelsManager responseObject].userVM.favoriteVideoIds);
      
      callback(responseObject, nil);
    }
  }];
}


- (void)addVideoToFavorites:(NSString *)videoId displayTitle:(NSString *)displayTitle callback:(void (^)(id responseObject, NSError *error))callback {
  [self.firebaseRef authWithCustomToken:userToken withCompletionBlock:^(NSError *error, FAuthData *auth) {
    
    if (error) {
      [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }
    else {
      NSMutableArray *tempFavoritesArray = [NSMutableArray new];
      if ([FAViewModelsManager shared].userVM.favoriteVideoIds.count > 0) {
        tempFavoritesArray = [[FAViewModelsManager shared].userVM.favoriteVideoIds mutableCopy];
      }
      
      for (int i = 0; i < tempFavoritesArray.count; i++) {
        
        NSString *favoriteVideoId = tempFavoritesArray[i];
        if ([favoriteVideoId isEqualToString:videoId]) {
          return;
        }
      }
      
      [tempFavoritesArray addObject:videoId ? : @""];
      [FAViewModelsManager shared].userVM.favoriteVideoIds = tempFavoritesArray;
      
      [[[[self.firebaseRef childByAppendingPath:@"users"] childByAppendingPath:[FAViewModelsManager shared].userVM.uid] childByAppendingPath:@"favoriteVideoIds"] setValue:tempFavoritesArray];
    }
  }];
}

- (void)removeVideoFromFavorites:(NSString *)videoId callback:(void (^)(id responseObject, NSError *error))callback {
  [self.firebaseRef authWithCustomToken:userToken withCompletionBlock:^(NSError *error, FAuthData *auth) {
    
    if (error) {
      [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }
    else {
      NSMutableArray *tempFavoritesArray = [NSMutableArray new];
      if ([FAViewModelsManager shared].userVM.favoriteVideoIds.count > 0) {
        tempFavoritesArray = [[FAViewModelsManager shared].userVM.favoriteVideoIds mutableCopy];
        for (int i = 0; i < tempFavoritesArray.count; i++) {
          NSString *favoriteVideoId = tempFavoritesArray[i];
          if ([favoriteVideoId isEqualToString:videoId]) {
            [tempFavoritesArray removeObjectAtIndex:i];
            [FAViewModelsManager shared].userVM.favoriteVideoIds = tempFavoritesArray;
            [[[[self.firebaseRef childByAppendingPath:@"users"] childByAppendingPath:[FAViewModelsManager shared].userVM.uid] childByAppendingPath:@"favoriteVideoIds"] setValue:tempFavoritesArray];
          }
        }
      }
    }
  }];
}

-(void)changeEmailWithCurrentEmail:(NSString *)currentEmail newEmail:(NSString *)newEmail password:(NSString *)password callback:(void (^)(BOOL success, NSError *error))callback {
  [self.firebaseRef changeEmailForUser:currentEmail password:password toNewEmail:newEmail withCompletionBlock:^(NSError *error) {
    if (error) {
      callback (NO, error);
    }
    else {
      [self.firebaseRef authWithCustomToken:userToken withCompletionBlock:^(NSError *error, FAuthData *auth) {
        
        if (error) {
          [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
        else {
          
          [[[[self.firebaseRef childByAppendingPath:@"users"] childByAppendingPath:[FAViewModelsManager shared].userVM.uid] childByAppendingPath:@"email"] setValue:newEmail];
        }
      }];
      
      callback (YES, nil);
    }
  }];
}

-(void)changePasswordWithCurrentEmail:(NSString *)currentEmail currentPassword:(NSString *)currentPassword newPassword:(NSString *)newPassword callback:(void (^)(BOOL success, NSError *error))callback {
  [self.firebaseRef changePasswordForUser:currentEmail fromOld:currentPassword toNew:newPassword withCompletionBlock:^(NSError *error) {
    if (error) {
      callback (NO, error);
    }
    else {
      
      [self.firebaseRef authWithCustomToken:userToken withCompletionBlock:^(NSError *error, FAuthData *auth) {
        
        if (error) {
          [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
        else {
          
          [[[[self.firebaseRef childByAppendingPath:@"users"] childByAppendingPath:[FAViewModelsManager shared].userVM.uid] childByAppendingPath:@"password"] setValue:newPassword];
        }
      }];
      
      callback (YES, nil);
    }
  }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (buttonIndex == 1) {
    [[NSUserDefaults standardUserDefaults]
     setPersistentDomain:[NSDictionary dictionary]
     forName:[[NSBundle mainBundle] bundleIdentifier]];
    [[FAViewModelsManager shared]resetAllVMs];
    [[FARouteManager shared]goToLandingVC];
    
    [self.firebaseRef unauth];
    
    [[FARequestManager shared] getHomePageWithCallback:^(id responseObject, NSError *error) {
      [FAViewModelsManager shared].homeVM = [[FAHomeVM alloc]initWithHomeAPIResponse:responseObject];
    }];
    
    [Answers logCustomEventWithName:@"Logout" customAttributes:nil];
  }
}
@end
