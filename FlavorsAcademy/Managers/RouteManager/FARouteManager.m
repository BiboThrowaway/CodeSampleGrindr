//
//  FARouteManager.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/13/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FARouteManager.h"
#import "FALoggedInLandingVC.h"
#import "FALoggedOutLandingVC.h"
#import "FAVideoPlayerVC.h"
#import "FARegistrationVC.h"
#import "FAProfileVC.h"
#import "FAChangeProfileVC.h"
#import "FAAboutVC.h"
#import "FAShoppingLandingVC.h"
#import "FAProductWebviewVC.h"
#import "FAAlumniVC.h"
#import "FAJobVC.h"

@interface FARouteManager ()

@property (nonatomic, strong) UINavigationController *navVC;
@property (nonatomic, strong) FAShoppingLandingVC *shoppingVC;
@property (nonatomic, strong) FAProductWebviewVC *webviewVC;
@property (nonatomic, strong) FAAlumniVC *alumniVC;
@property (nonatomic, strong) FAJobVC *jobVC;

@end

@implementation FARouteManager

+ (FARouteManager *)shared {
  static FARouteManager *shared;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    shared = [[[self class] alloc] init];
  });
  return shared;
}

-(void)pushVC:(FABaseNavVC *)vc animated:(BOOL)animated {
  [self.navVC pushViewController:vc animated:animated];
}

-(void)setStartingNavVC:(FABaseNavVC *)vc {
  [self.navVC.view endEditing:YES];
  [self.navVC popToRootViewControllerAnimated:NO];
  if (self.navVC) {
    [self.navVC.view removeFromSuperview];
    [self.navVC removeFromParentViewController];
    self.navVC = nil;
  }
  self.navVC = [[UINavigationController alloc]initWithRootViewController:vc];
  [self.rootVC addChildViewController:self.navVC];
  [self.rootVC.view addSubview:self.navVC.view];
  
  [self.rootVC.view bringSubviewToFront:self.rootVC.toolBar];
}

-(void)popHighestNavVCAnimated:(BOOL)animated {
  [self.navVC popViewControllerAnimated:animated];
}

-(FARootVC *)rootViewController {
  self.rootVC = [FARootVC new];
  
  if (_shoppingVC) {
    [_shoppingVC.view removeFromSuperview];
    [_shoppingVC removeFromParentViewController];
  }
  _shoppingVC = [FAShoppingLandingVC new];
  [self.rootVC addChildViewController:_shoppingVC];
  _shoppingVC.view.frame = CGRectMake([PKUIManager deviceWidth], 0, [PKUIManager deviceWidth], [PKUIManager deviceHeight]);
  [self.rootVC.view addSubview:_shoppingVC.view];
  
  
  if (_alumniVC) {
    [_alumniVC.view removeFromSuperview];
    [_alumniVC removeFromParentViewController];
  }
  _alumniVC = [FAAlumniVC new];
  [self.rootVC addChildViewController:_alumniVC];
  _alumniVC.view.frame = CGRectMake([PKUIManager deviceWidth], 0, [PKUIManager deviceWidth], [PKUIManager deviceHeight]);
  [self.rootVC.view addSubview:_alumniVC.view];
  
  if (_jobVC) {
    [_jobVC.view removeFromSuperview];
    [_jobVC removeFromParentViewController];
  }
  _jobVC = [FAJobVC new];
  [self.rootVC addChildViewController:_jobVC];
  _jobVC.view.frame = CGRectMake([PKUIManager deviceWidth], 0, [PKUIManager deviceWidth], [PKUIManager deviceHeight]);
  [self.rootVC.view addSubview:_jobVC.view];
  return self.rootVC;
}

-(void)showMenu {
  [self.rootVC showMenuView];
}
-(void)closeMenu {
  [self.rootVC closeMenuView];
}

-(void)showSearchView {
  [self.rootVC showSearchView];
}

-(void)closeSearchView:(BOOL)animated {
  [self.rootVC closeSearchView:animated];
}

-(void)showToolBar {
  self.rootVC.toolBar.hidden = NO;
}

-(void)hideToolBar {
  self.rootVC.toolBar.hidden = YES;
}

-(void)goToLandingVC {
  if ([[FAUserManager shared] isCurrentUser]) {
    [self goToLoggedInLandingVC];
  }
  else {
    [self goToLoggedOutLandingVC];
  }
}

-(void)goToLoggedOutLandingVC {
  [self hideToolBar];
  [self setStartingNavVC:[FALoggedOutLandingVC new]];
}

-(void)goToLoggedInLandingVC {
  [self showToolBar];
  if (![self.navVC.topViewController isKindOfClass:[FALoggedInLandingVC class]]) {
    [self setStartingNavVC:[[FALoggedInLandingVC alloc]initWithIsSneakPeak:NO]];
  }
}

-(void)goToSneakPeakLandingVC {
  [self showToolBar];
  [self pushVC:[[FALoggedInLandingVC alloc]initWithIsSneakPeak:YES] animated:YES];
}

-(void)goToVideoPlayerVCWithVM:(FAVideoVM *)videoVM {
  if (videoVM.isRootVC == YES) {
    [self setStartingNavVC:[[FAVideoPlayerVC alloc] initWithVideoVM:videoVM]];
  }
  else {
    [self pushVC:[[FAVideoPlayerVC alloc] initWithVideoVM:videoVM] animated:YES];
  }
}

-(void)goToRegistrationSignup {
  [self pushVC:[[FARegistrationVC alloc]initWithSignup] animated:YES];
}

-(void)goToRegistrationLogin {
  [self pushVC:[[FARegistrationVC alloc]initWithLogin] animated:YES];
}

-(void)goToProfileVC {
  if (![self.navVC.topViewController isKindOfClass:[FAProfileVC class]]) {
    [self setStartingNavVC:[FAProfileVC new]];
  }
}

-(void)goToChangeEmailVC {
  [self pushVC:[[FAChangeProfileVC alloc]initForEmail] animated:YES];
}

-(void)goToChangePasswordVC {
  [self pushVC:[[FAChangeProfileVC alloc]initForPassword] animated:YES];
}

-(void)goToAboutVC {
  [self setStartingNavVC:[FAAboutVC new]];
}

-(void)goToShopVC {
  [self dismissAllToolbarViews];
  _shoppingVC.view.frame = CGRectMake(0, 0, [PKUIManager deviceWidth], [PKUIManager deviceHeight]);
  [self.rootVC.view bringSubviewToFront:_shoppingVC.view];
  [self.rootVC.view bringSubviewToFront:self.rootVC.toolBar];
}

-(void)goToLandingVCFromToolBar {
  [self dismissAllToolbarViews];
}

-(void)goToProductWebviewWithVM:(FAProductVM *)productVM {
  _webviewVC = [[FAProductWebviewVC alloc]initWithProductVM:productVM];
  _webviewVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
  [self.rootVC presentViewController:_webviewVC animated:YES completion:nil];
}

-(void)goToAlumniVC {
  [self dismissAllToolbarViews];
  _alumniVC.view.frame = CGRectMake(0, 0, [PKUIManager deviceWidth], [PKUIManager deviceHeight]);
  [self.rootVC.view bringSubviewToFront:_alumniVC.view];
  [self.rootVC.view bringSubviewToFront:self.rootVC.toolBar];
}

-(void)goToJobVC {
  [self dismissAllToolbarViews];
  _jobVC.view.frame = CGRectMake(0, 0, [PKUIManager deviceWidth], [PKUIManager deviceHeight]);
  [self.rootVC.view bringSubviewToFront:_jobVC.view];
  [self.rootVC.view bringSubviewToFront:self.rootVC.toolBar];
}

-(void)dismissWebview {
  if (_webviewVC) {
    [_webviewVC dismissViewControllerAnimated:YES completion:nil];
    _webviewVC = nil;
  }
}

-(void)dismissAllToolbarViews {
  if (_shoppingVC) {
    _shoppingVC.view.frame = CGRectMake([PKUIManager deviceWidth], 0, [PKUIManager deviceWidth], [PKUIManager deviceHeight]);
  }
  if (_alumniVC) {
    _alumniVC.view.frame = CGRectMake([PKUIManager deviceWidth], 0, [PKUIManager deviceWidth], [PKUIManager deviceHeight]);
  }
  if (_jobVC) {
    _jobVC.view.frame = CGRectMake([PKUIManager deviceWidth], 0, [PKUIManager deviceWidth], [PKUIManager deviceHeight]);
  }
}

@end
