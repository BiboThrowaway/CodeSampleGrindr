//
//  FAChangeProfileVC.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/17/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAChangeProfileVC.h"

@interface FAChangeProfileVC ()

@property (nonatomic, readwrite) NSInteger selectedIndex;

@end

@implementation FAChangeProfileVC


-(instancetype)initForEmail {
  self = [self init];
  if (self) {
    self.selectedIndex = 0;
  }
  return self;
}

-(instancetype)initForPassword {
  self = [self init];
  if (self) {
    self.selectedIndex = 1;
  }
  return self;
}

-(instancetype)init {
  self = [super init];
  if (self) {
    
  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  [Answers logContentViewWithName:@"profileVC" contentType:@"changeProfile" contentId:@"" customAttributes:nil];
  
  self.textFieldOne = [self textFieldWithFrame:CGRectMake(50, 64+50, self.width-100, 40) placeHolderText:@"Current Password"];
  [self.textFieldOne setSecureTextEntry:YES];
  
  self.textFieldTwo = [self textFieldWithFrame:CGRectMake(50, 64+100, self.width-100, 40) placeHolderText:(self.selectedIndex == 0) ? @"New Email" : @"New Password"];
  [self.textFieldTwo setSecureTextEntry:(self.selectedIndex == 0) ? NO : YES];
  
  self.actionBtn = [UIButton PKtextButtonWithFrame:CGRectMake(0, 64+150, self.width, 40) title:(self.selectedIndex == 0) ? @"Change Email" : @"Change Password" font:[UIFont dosisMediumWithSize:16] tintColor:[UIColor redColor]];
  [self.actionBtn addTarget:self action:@selector(actionBtnPressed) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.actionBtn];
  
  [self setupNavBar];
}

-(void)setupNavBar {
  
  self.navBar = [[FANavBar alloc]initWithBackAndMenuBtns];
  [self.view addSubview:self.navBar];
  [self.navBar setTitleWithString:(self.selectedIndex == 0) ? @"Change Email" : @"Change Password"];
}

-(UITextField *)textFieldWithFrame:(CGRect)frame placeHolderText:(NSString *)placeHolderText {
  UITextField *textField = [UITextField PKTextFieldWithFrame:frame placeHolderText:placeHolderText tintColor:[UIColor FAAlmostBlackColor] textBorderStyle:UITextBorderStyleNone font:[UIFont dosisRegularWithSize:16]];
  textField.layer.borderWidth = 1;
  textField.layer.borderColor = [UIColor grayColor].CGColor;
  UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
  [textField setLeftViewMode:UITextFieldViewModeAlways];
  [textField setLeftView:spacerView];
  textField.keyboardType = UIKeyboardTypeEmailAddress;
  textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  textField.autocorrectionType = UITextAutocorrectionTypeNo;
  [self.view addSubview:textField];

  return textField;
}

-(void)actionBtnPressed {
  if (self.selectedIndex == 0) {
    
    if (![PKUtilitiesManager isValidEmail:self.textFieldTwo.text]) {
      [SVProgressHUD showErrorWithStatus:@"Please enter a valid Email"];
    }
    else if (![PKUtilitiesManager isValidPassword:self.textFieldOne.text]) {
      [SVProgressHUD showErrorWithStatus:@"Please enter a Password"];
    }
    else {
      [SVProgressHUD showWithStatus:@"Changing Email"];
      [[FAUserManager shared] changeEmailWithCurrentEmail:[FAViewModelsManager shared].userVM.email newEmail:self.textFieldTwo.text password:self.textFieldOne.text callback:^(BOOL success, NSError *error) {
        if (error) {
          [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
        else {
          [FAViewModelsManager shared].userVM.email = self.textFieldTwo.text;
          [SVProgressHUD showSuccessWithStatus:@"Email Changed"];
          [[NSNotificationCenter defaultCenter] postNotificationName:@"EmailChanged" object:nil];
          
          [[FARouteManager shared] popHighestNavVCAnimated:YES];
//          self.textFieldOne.text = @"";
//          self.textFieldTwo.text = @"";
          
          
        }
      }];
    }
  }
  else {
    
    if (![PKUtilitiesManager isValidPassword:self.textFieldTwo.text]) {
      [SVProgressHUD showErrorWithStatus:@"Please enter a Password"];
    }
    else if (![PKUtilitiesManager isValidPassword:self.textFieldOne.text]) {
      [SVProgressHUD showErrorWithStatus:@"Please enter a Password"];
    }
    else {
      [SVProgressHUD showWithStatus:@"Changing Password"];
      [[FAUserManager shared] changePasswordWithCurrentEmail:[FAViewModelsManager shared].userVM.email currentPassword:self.textFieldOne.text newPassword:self.textFieldTwo.text callback:^(BOOL success, NSError *error) {
        if (error) {
          [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
        else {
          [SVProgressHUD showSuccessWithStatus:@"Password Changed"];
//          self.textFieldOne.text = @"";
//          self.textFieldTwo.text = @"";
          [[FARouteManager shared] popHighestNavVCAnimated:YES];
        }
      }];
    }
  }
}

@end
