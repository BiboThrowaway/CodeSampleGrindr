//
//  FARegistrationVC.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/16/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FARegistrationVC.h"

@interface FARegistrationVC () <UIAlertViewDelegate>
{
  UIView *indicatorView;
}

@property (nonatomic, strong) UIView *whiteBackgroundView;
@property (nonatomic, strong) UITextField *emailTextField;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *forgotPasswordBtn;
@property (nonatomic, strong) UIButton *connectWithFacebookBtn;
@property (nonatomic, readwrite) NSInteger selectedIndex;
@property (nonatomic, readwrite) BOOL alreadyHaveAccount;

@end

@implementation FARegistrationVC

-(instancetype)initWithSignup {
  self = [self init];
  if (self) {
    self.selectedIndex = 0;
  }
  return self;
}

-(instancetype)initWithLogin {
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

-(void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  [self setupNavBar];
  [self setupContent];
}

-(void)setupNavBar {
  
  self.whiteBackgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
  self.whiteBackgroundView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:self.whiteBackgroundView];
  
  self.navBar = [[FANavBar alloc]initWithBackBtnOnly];
  [self.view addSubview:self.navBar];
  
  [self.navBar setTitleWithString:@""];
}

-(void)setupContent {
  UIButton *signupBtn = [UIButton PKtextButtonWithFrame:CGRectMake(self.width/4, 20, self.width/4, 44) title:@"SIGN UP" font:[UIFont dosisBoldWithSize:16] tintColor:[UIColor whiteColor]];
  signupBtn.tag = 0;
  [self.view addSubview:signupBtn];
  
  UIButton *loginBtn = [UIButton PKtextButtonWithFrame:CGRectMake(self.width/2, 20, self.width/4, 44) title:@"LOGIN" font:[UIFont dosisBoldWithSize:16] tintColor:[UIColor whiteColor]];
  loginBtn.tag = 1;
  [self.view addSubview:loginBtn];
  
  [loginBtn addTarget:self action:@selector(segmentBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
  [signupBtn addTarget:self action:@selector(segmentBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
  
  indicatorView = [[UIView alloc]initWithFrame:CGRectMake(self.width/4 + (self.selectedIndex * self.width/4)+20, 60, self.width/4-40, 3)];
  indicatorView.backgroundColor = [UIColor whiteColor];
  [self.view addSubview:indicatorView];
  
  self.emailTextField = [UITextField PKTextFieldWithFrame:CGRectMake(50, 80, self.width-100, 40) placeHolderText:@"Email" tintColor:[UIColor FAAlmostBlackColor] textBorderStyle:UITextBorderStyleNone font:[UIFont dosisRegularWithSize:16]];
  self.emailTextField.layer.borderWidth = 1;
  self.emailTextField.layer.borderColor = [UIColor grayColor].CGColor;
  UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
  [self.emailTextField setLeftViewMode:UITextFieldViewModeAlways];
  [self.emailTextField setLeftView:spacerView];
  self.emailTextField.keyboardType = UIKeyboardTypeEmailAddress;
  self.emailTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
  self.emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
  [self.whiteBackgroundView addSubview:self.emailTextField];
  
  self.passwordTextField = [UITextField PKTextFieldWithFrame:CGRectMake(50, CGRectGetMaxY(self.emailTextField.frame) + 10, self.width-100, 40) placeHolderText:@"Password" tintColor:[UIColor FAAlmostBlackColor] textBorderStyle:UITextBorderStyleNone font:[UIFont dosisRegularWithSize:16]];
  self.passwordTextField.layer.borderWidth = 1;
  self.passwordTextField.layer.borderColor = [UIColor grayColor].CGColor;
  UIView *passwordTextFieldspacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
  [self.passwordTextField setLeftViewMode:UITextFieldViewModeAlways];
  [self.passwordTextField setLeftView:passwordTextFieldspacerView];
  [self.passwordTextField setSecureTextEntry:YES];
  [self.whiteBackgroundView  addSubview:self.passwordTextField];
  
  self.registerBtn = [UIButton PKtextButtonWithFrame:CGRectMake(50, CGRectGetMaxY(self.passwordTextField.frame)+20, self.width-100, 40) title:self.selectedIndex == 0 ? @"Sign up with Email" : @"Login with Email" font:[UIFont dosisRegularWithSize:16] tintColor:[UIColor FAAlmostBlackColor]];
  self.registerBtn.layer.cornerRadius = 20;
  self.registerBtn.layer.borderWidth = 1;
  self.registerBtn.layer.borderColor = [UIColor FAAlmostBlackColor].CGColor;
  [self.whiteBackgroundView  addSubview:self.registerBtn];
  
  [self.registerBtn addTarget:self action:@selector(registerBtnPressed) forControlEvents:UIControlEventTouchUpInside];
  
  UILabel *orLabel = [UILabel PKOneLineLabelWithFrame:CGRectMake(0, CGRectGetMaxY(self.registerBtn.frame)+5, self.width, 30) text:@"or" textColor:[UIColor FAAlmostBlackColor] textAlignment:NSTextAlignmentCenter font:[UIFont dosisRegularWithSize:16]];
  [self.whiteBackgroundView  addSubview:orLabel];
  
  self.connectWithFacebookBtn = [UIButton PKtextButtonWithFrame:CGRectMake(50, CGRectGetMaxY(orLabel.frame)+10, self.width-100, 40) title:self.selectedIndex == 0 ? @"Connect with Facebook" : @"Login with Facebook" font:[UIFont dosisRegularWithSize:16] tintColor:[UIColor whiteColor]];
  [self.whiteBackgroundView  addSubview:self.connectWithFacebookBtn];
  self.connectWithFacebookBtn.layer.cornerRadius = 20;
  self.connectWithFacebookBtn.backgroundColor = [UIColor colorFromHexString:@"#3b5998"];
  [self.connectWithFacebookBtn addTarget:self action:@selector(facebookBtnPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)segmentBtnPressed:(UIButton *)sender {
  self.selectedIndex = sender.tag;
  
  [self toggleSegment];
}

-(void)toggleSegment {
  indicatorView.frame = CGRectMake(self.width/4 + (self.selectedIndex * self.width/4)+20, 60, self.width/4-40, 3);
  
  [UIView animateWithDuration:0.3 animations:^{
    self.whiteBackgroundView.alpha = 0;
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.3 animations:^{
      self.whiteBackgroundView.alpha = 1;
    } completion:^(BOOL finished) {
      
    }];
  }];
  
  [self.registerBtn setTitle:self.selectedIndex == 0 ? @"Sign up with Email" : @"Login with Email" forState:UIControlStateNormal];
  
}

-(void)registerBtnPressed {
  if (![PKUtilitiesManager isValidEmail:self.emailTextField.text]) {
    [SVProgressHUD showErrorWithStatus:@"Please enter a valid email"];
  }
  else if (![PKUtilitiesManager isValidPassword:self.passwordTextField.text]) {
    [SVProgressHUD showErrorWithStatus:@"Please enter a password"];
  }
  else {
    if (self.selectedIndex == 0) {
      [self signup];
    }
    else {
      [self login];
    }
  }
}


-(void)login {
  if (self.alreadyHaveAccount == NO) {
    [SVProgressHUD showWithStatus:@"Logging in"];
  }
  [[FAUserManager shared] loginWithEmail:self.emailTextField.text password:self.passwordTextField.text callback:^(id responseObject, NSError *error) {
    self.alreadyHaveAccount = NO;
    if (error) {
      [Answers logLoginWithMethod:@"password" success:@0 customAttributes:nil];
      
      if (error.code == -8) {
        // Email does not exist
        [SVProgressHUD showErrorWithStatus:@"Invalid Email or Password"];
      }
      else if (error.code == -6) {
        // Wrong password
        [SVProgressHUD dismiss];
        
        UIAlertView *resetPasswordAlert = [[UIAlertView alloc]initWithTitle:@"Invalid Email or Password Combination" message:@"Would you like to reset your password?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Reset Password", nil];
        resetPasswordAlert.tag = 0;
        [resetPasswordAlert show];
      }
      else {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
      }
      
      
    }
    else {
      [Answers logLoginWithMethod:@"password" success:@1 customAttributes:nil];
      
      [SVProgressHUD dismiss];
      [[FARouteManager shared] goToLandingVC];
    }
  }];
}

-(void)signup {
  [SVProgressHUD showWithStatus:@"Creating account"];
  [[FAUserManager shared] signupWithEmail:self.emailTextField.text password:self.passwordTextField.text callback:^(id responseObject, NSError *error) {
    if (error) {
      
      [Answers logSignUpWithMethod:@"password" success:@0 customAttributes:nil];
//      NSLog(@"%@", error);
      
      if (error.code == -9) {
        [SVProgressHUD showWithStatus:@"You already have an account with this email, logging you in"];
        self.alreadyHaveAccount = YES;
        self.selectedIndex = 0;
        [self toggleSegment];
        [self login];
      }
      else {
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
      }
    }
    else {
      
      [Answers logSignUpWithMethod:@"password" success:@1 customAttributes:nil];
      [SVProgressHUD dismiss];
      [[FARouteManager shared] goToLandingVC];
    }
  }];
}

-(void)facebookBtnPressed {
  [[FAUserManager shared] connectWithFacebookFromVC:self];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (alertView.tag == 0) {
    if (buttonIndex == 1) {
      UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Reset Password" message:@"Please enter your email" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Reset", nil];
      av.tag = 1;
      av.alertViewStyle = UIAlertViewStylePlainTextInput;
      [av textFieldAtIndex:0].text = self.emailTextField.text;
      [av show];
    }
  }
  else {
    if (buttonIndex == 1) {
      UITextField *alertTextField = [alertView textFieldAtIndex:0];
      if ([PKUtilitiesManager isValidEmail:alertTextField.text]) {
        [SVProgressHUD showWithStatus:@"Resetting password"];
        [[FAUserManager shared] resetPasswordWithEmail:alertTextField.text callback:^(NSError *error) {
          if (error) {
            [SVProgressHUD showErrorWithStatus:@"Unable to reset password"];
          }
          else {
            [SVProgressHUD showSuccessWithStatus:@"Please check your email for password reset instruction"];
          }
        }];
      }
      else {
        [SVProgressHUD showErrorWithStatus:@"Please enter a valid Email"];
      }
    }
  }
}
@end
