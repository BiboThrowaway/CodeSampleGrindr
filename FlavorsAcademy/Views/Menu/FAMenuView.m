//
//  FAMenuView.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/15/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAMenuView.h"

@interface FAMenuView ()

@property (nonatomic, readwrite) CGFloat yOrigin;
@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation FAMenuView

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor FAAlmostBlackColor];
    
    self.closeBtn = [UIButton PKimageButtonWithFrame:CGRectMake(frame.size.width-44, 20, 44, 44) image:[FAPaintCode imageOfCloseBtn]];
    [self.closeBtn addTarget:self action:@selector(closeBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtn];
    
    self.yOrigin = 100;
    
    CGFloat btnHeight = 60;
    [self addBtnWithFrame:CGRectMake(20, self.yOrigin, frame.size.width-40, btnHeight) title:@"HOME" font:[UIFont dosisBoldWithSize:15] tintColor:[UIColor whiteColor] action:@selector(homeBtnPressed)];
    [self addBtnWithFrame:CGRectMake(20, self.yOrigin, frame.size.width-40, btnHeight) title:@"FAVORITE VIDEOS" font:[UIFont dosisBoldWithSize:15] tintColor:[UIColor whiteColor] action:@selector(favoritesBtnPressed)];
    [self addBtnWithFrame:CGRectMake(20, self.yOrigin, frame.size.width-40, btnHeight) title:@"ABOUT LET'S CHEF" font:[UIFont dosisBoldWithSize:15] tintColor:[UIColor whiteColor] action:@selector(aboutBtnPressed)];
    [self addBtnWithFrame:CGRectMake(20, self.yOrigin, frame.size.width-40, btnHeight) title:@"SHARE" font:[UIFont dosisBoldWithSize:15] tintColor:[UIColor whiteColor] action:@selector(shareBtnPressed)];
    
    if ([[FAViewModelsManager shared].userVM.provider isEqualToString:@"facebook"]) {
      self.yOrigin = self.yOrigin + 150;
      [self addBtnWithFrame:CGRectMake(20, self.yOrigin, frame.size.width-40, btnHeight) title:@"LOGOUT" font:[UIFont dosisBoldWithSize:15] tintColor:[UIColor whiteColor] action:@selector(logoutBtnPressed)];
    }
    else {
      [self addBtnWithFrame:CGRectMake(20, self.yOrigin, frame.size.width-40, btnHeight) title:@"PROFILE" font:[UIFont dosisBoldWithSize:15] tintColor:[UIColor whiteColor] action:@selector(profileBtnPressed)];
    }
  }
  return self;
}

-(UIButton *)addBtnWithFrame:(CGRect)frame title:(NSString *)title font:(UIFont *)font tintColor:(UIColor *)tintColor action:(SEL) action {
  UIButton *btn = [UIButton PKtextButtonWithFrame:frame title:title font:font tintColor:tintColor];
//  btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
  [self addSubview:btn];
  [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
  
  self.yOrigin = self.yOrigin + frame.size.height;
  
  return btn;
}

-(void)closeBtnPressed {
  [[FARouteManager shared] closeMenu];
}

-(void)favoritesBtnPressed {
  if ([FAViewModelsManager shared].userVM.favoriteVideoIds.count > 0) {
    [[FARouteManager shared] closeMenu];
    FAVideoVM *videoVM = [FAVideoVM new];
    videoVM.displayTitle = @"Favorite Videos";
    videoVM.isRootVC = YES;
    videoVM.isFavorite = YES;
    videoVM.vmLookupKey = @"favorite";
    [[FARouteManager shared] goToVideoPlayerVCWithVM:videoVM];
  }
  else {
    [SVProgressHUD showInfoWithStatus:@"To add videos to your favorite list, just press the star on the right of each video"];
  }
}

-(void)profileBtnPressed {
  [[FARouteManager shared] closeMenu];
  [[FARouteManager shared] goToProfileVC];
}

-(void)logoutBtnPressed {
  [[FAUserManager shared] logout];
}

-(void)homeBtnPressed {
  [[FARouteManager shared] closeMenu];
  [[FARouteManager shared] goToLandingVC];
}

-(void)aboutBtnPressed {
  [[FARouteManager shared] closeMenu];
  [[FARouteManager shared] goToAboutVC];
}

-(void)shareBtnPressed {
  NSString *textToShare = @"Download Let's Chef and get free culinary classes curated by professional chefs!";
  NSURL *myWebsite = [NSURL URLWithString:@"https://itunes.apple.com/us/app/id1068319030?mt=8"];
  
  NSArray *objectsToShare = @[textToShare, myWebsite];
  
  UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:objectsToShare applicationActivities:nil];
  
  [[FARouteManager shared].rootVC presentViewController:activityVC animated:YES completion:nil];
}

@end
