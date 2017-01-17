//
//  FARouteManager.h
//  FlavorsAcademy
//
//  Created by Bibo on 11/13/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FARootVC.h"
#import "FAVideoVM.h"
#import "FAProductVM.h"

@interface FARouteManager : NSObject

@property (nonatomic, strong) FARootVC *rootVC;
-(FARootVC *)rootViewController;

+ (FARouteManager *)shared;

-(void)popHighestNavVCAnimated:(BOOL)animated;

-(void)showMenu;
-(void)closeMenu;
-(void)showSearchView;
-(void)closeSearchView:(BOOL)animated;
-(void)hideToolBar;
-(void)showToolBar;

-(void)goToLandingVC;
-(void)goToSneakPeakLandingVC;
-(void)goToVideoPlayerVCWithVM:(FAVideoVM *)videoVM;
-(void)goToRegistrationSignup;
-(void)goToRegistrationLogin;
-(void)goToProfileVC;
-(void)goToChangeEmailVC;
-(void)goToChangePasswordVC;
-(void)goToAboutVC;
-(void)goToShopVC;
-(void)goToLandingVCFromToolBar;
-(void)goToAlumniVC;
-(void)goToJobVC;
-(void)goToProductWebviewWithVM:(FAProductVM *)productVM;
-(void)dismissWebview;
@end
