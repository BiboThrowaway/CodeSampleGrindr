//
//  FAProfileVC.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/17/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAProfileVC.h"

@interface FAProfileVC ()
{
  UIButton *changeEmailBtn;
}
@end

@implementation FAProfileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  [Answers logContentViewWithName:@"profileVC" contentType:@"viewProfile" contentId:@"" customAttributes:nil];
  
  [self setupNavBar];
  [self setupContents];
}

-(void)setupNavBar {
  
  self.navBar = [[FANavBar alloc]initWithMenuBtnOnly];
  [self.view addSubview:self.navBar];
  [self.navBar setTitleWithString:@"Profile"];
}

-(void)setupContents {

  changeEmailBtn = [UIButton PKtextButtonWithFrame:CGRectMake(0, 64+50, self.width, 40) title:[NSString stringWithFormat:@"Change Email: %@",[FAViewModelsManager shared].userVM.email] font:[UIFont dosisRegularWithSize:16] tintColor:[UIColor FAAlmostBlackColor]];
  [changeEmailBtn addTarget:self action:@selector(changeEmailBtnPressed) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:changeEmailBtn];
  
  [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(emailChanged) name:@"EmailChanged" object:nil];
  
  UIButton *changePasswordBtn = [UIButton PKtextButtonWithFrame:CGRectMake(0, 64 + 50 + 50, self.width, 40) title:@"Change Password" font:[UIFont dosisRegularWithSize:16] tintColor:[UIColor FAAlmostBlackColor]];
  [changePasswordBtn addTarget:self action:@selector(changePasswordBtnPressed) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:changePasswordBtn];
  
  UIButton *logoutBtn = [UIButton PKtextButtonWithFrame:CGRectMake(0, 64 + 50 + 50 + 50, self.width, 40) title:@"Logout" font:[UIFont dosisRegularWithSize:16] tintColor:[UIColor FAAlmostBlackColor]];
  [logoutBtn addTarget:self action:@selector(logoutBtnPressed) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:logoutBtn];
}

-(void)changeEmailBtnPressed {
  [[FARouteManager shared]goToChangeEmailVC];
}

-(void)changePasswordBtnPressed {
  [[FARouteManager shared]goToChangePasswordVC];
}

-(void)logoutBtnPressed {
  [[FAUserManager shared] logout];
}

-(void)emailChanged {
  [changeEmailBtn setTitle:[NSString stringWithFormat:@"Change Email: %@",[FAViewModelsManager shared].userVM.email] forState:UIControlStateNormal];
}

@end
