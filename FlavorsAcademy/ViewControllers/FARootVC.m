//
//  FARootVC.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/13/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FARootVC.h"
#import "FAMenuView.h"
#import "FASearchView.h"

@interface FARootVC ()

@property (nonatomic, strong) FAMenuView *menuView;
@property (nonatomic, strong) FASearchView *searchView;

@end

@implementation FARootVC

-(UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  _toolBar = [[FAToolBarView alloc]initWithFrame:CGRectMake(0, self.height-50, self.width, 50)];
  [self.view addSubview:_toolBar];
  
  [[FARouteManager shared] goToLandingVC];
  if ([[FAUserManager shared] isCurrentUser]) {
    [[FAUserManager shared] getUserInfoWithUID:[FAViewModelsManager shared].userVM.uid callback:^(id responseObject, NSError *error) {
      [CrashlyticsKit setUserEmail:responseObject[@"email"]];
    }];
  }
  else {
    [CrashlyticsKit setUserEmail:@"new@user.com"];
  }
  
  [self.view bringSubviewToFront:_toolBar];
}

-(void)showMenuView {
  if (self.menuView) {
    [self.menuView removeFromSuperview];
    self.menuView = nil;
  }
  self.menuView = [[FAMenuView alloc]initWithFrame:self.view.bounds];
  self.menuView.alpha = 0;
  [self.view addSubview:self.menuView];
  
  [UIView animateWithDuration:0.3 animations:^{
    self.menuView.alpha = 1;
  }];
}

-(void)closeMenuView {
  if (self.menuView) {
    [UIView animateWithDuration:0.3 animations:^{
      self.menuView.alpha = 0;
    }completion:^(BOOL finished) {
      [self.menuView removeFromSuperview];
      self.menuView = nil;
    }];
  }
}

-(void)showSearchView {
  if (self.searchView) {
    [self.searchView removeFromSuperview];
    self.searchView = nil;
  }
  self.searchView = [[FASearchView alloc]initWithFrame:self.view.bounds];
  self.searchView.alpha = 0;
  [self.view addSubview:self.searchView];
  
  [UIView animateWithDuration:0.3 animations:^{
    self.searchView.alpha = 1;
  }];
}

-(void)closeSearchView:(BOOL)animated {
  if (self.searchView) {
    if (animated) {
      [UIView animateWithDuration:0.3 animations:^{
        self.searchView.alpha = 0;
      }completion:^(BOOL finished) {
        [self.searchView removeFromSuperview];
        self.searchView = nil;
      }];
    }
    else {
      [self.searchView removeFromSuperview];
      self.searchView = nil;
    }
  }
}

@end
