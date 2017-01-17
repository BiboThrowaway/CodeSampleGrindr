//
//  FANavBar.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/14/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FANavBar.h"

@implementation FANavBar


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
      
      self.backgroundColor = [UIColor FAAlmostBlackColor];
      
      [self setupCenterBtn];
    }
    return self;
}

-(instancetype)initWithBackBtnForWebview {
  self = [self initWithFrame:CGRectMake(0, 0, [PKUIManager deviceWidth], 64)];
  if (self) {
    [self addBackBtnForWebviewWithFrame:CGRectMake(0, 20, 44, 44)];
  }
  return self;
}

-(instancetype)initWithBackBtnOnly {
  self = [self initWithFrame:CGRectMake(0, 0, [PKUIManager deviceWidth], 64)];
  if (self) {
    [self addBackBtnWithFrame:CGRectMake(0, 20, 44, 44)];
  }
  return self;
}
-(instancetype)initWithMenuBtnOnly {
  self = [self initWithFrame:CGRectMake(0, 0, [PKUIManager deviceWidth], 64)];
  if (self) {
    [self addMenuBtnWithFrame:CGRectMake([PKUIManager deviceWidth]-44, 20, 44, 44)];
  }
  return self;
}

-(instancetype)initWithMenuAndSearchBtns {
  self = [self initWithFrame:CGRectMake(0, 0, [PKUIManager deviceWidth], 64)];
  if (self) {
    [self addSearchBtnWithFrame:CGRectMake(0, 20, 44, 44)];
    [self addMenuBtnWithFrame:CGRectMake([PKUIManager deviceWidth]-44, 20, 44, 44)];
  }
  return self;
}

-(instancetype)initWithBackAndMenuBtns {
  self = [self initWithFrame:CGRectMake(0, 0, [PKUIManager deviceWidth], 64)];
  if (self) {
    [self addBackBtnWithFrame:CGRectMake(0, 20, 44, 44)];
    [self addMenuBtnWithFrame:CGRectMake([PKUIManager deviceWidth]-44, 20, 44, 44)];
  }
  return self;
}

-(instancetype)initForRestaurantPage {
  self = [self initWithFrame:CGRectMake(0, 0, [PKUIManager deviceWidth], 64)];
  if (self) {
    [self addFilterBtnWithFrame:CGRectMake([PKUIManager deviceWidth]-44, 20, 44, 44)];
  }
  return self;
}

-(void)addSearchBtnWithFrame:(CGRect)frame {
  self.searchBtn = [UIButton PKimageButtonWithFrame:frame image:[FAPaintCode imageOfSearchBtn]];
  [self addSubview:self.searchBtn];
  [self.searchBtn addTarget:self action:@selector(searchBtnPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addBackBtnWithFrame:(CGRect)frame {
  self.backBtn = [UIButton PKimageButtonWithFrame:frame image:[FAPaintCode imageOfBackBtn]];
  [self addSubview:self.backBtn];
  [self.backBtn addTarget:self action:@selector(backBtnPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addBackBtnForWebviewWithFrame:(CGRect)frame {
  self.backBtn = [UIButton PKimageButtonWithFrame:frame image:[FAPaintCode imageOfBackBtn]];
  [self addSubview:self.backBtn];
}

-(void)addMenuBtnWithFrame:(CGRect)frame {
  self.menuBtn = [UIButton PKimageButtonWithFrame:frame image:[FAPaintCode imageOfMenuBtn]];
  [self addSubview:self.menuBtn];
  [self.menuBtn addTarget:self action:@selector(menuBtnPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)addFilterBtnWithFrame:(CGRect)frame {
  self.rightBtnOne = [UIButton PKimageButtonWithFrame:frame image:[FAPaintCode imageOfLocationBtn]];
  [self addSubview:self.rightBtnOne];
}

-(void)setupCenterBtn {
  self.centerBtn = [UIButton PKtextButtonWithFrame:CGRectMake(44, 20, [PKUIManager deviceWidth]-44*2, 44) title:@"" font:[UIFont dosisExtraBoldWithSize:16] tintColor:[UIColor FAYellowColor]];
  self.centerBtn.titleLabel.numberOfLines = 2;
  self.centerBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
  self.centerBtn.titleLabel.adjustsFontSizeToFitWidth = YES;
  self.centerBtn.userInteractionEnabled = NO;
  [self addSubview:self.centerBtn];
}

-(void)setTitleWithString:(NSString *)title {
  NSString *formattedTitle = [title stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
  [UIView setAnimationsEnabled:NO];
  [self.centerBtn setTitle:[formattedTitle uppercaseString] forState:UIControlStateNormal];
  [UIView setAnimationsEnabled:YES];
}

-(void)backBtnPressed {
  [[FARouteManager shared]popHighestNavVCAnimated:YES];
}

-(void)menuBtnPressed {
  [[FARouteManager shared]showMenu];
}

-(void)searchBtnPressed {
  [[FARouteManager shared]showSearchView];
}

@end
