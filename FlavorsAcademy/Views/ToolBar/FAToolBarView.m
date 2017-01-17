//
//  FAToolBarView.m
//  BiboliveAcademy
//
//  Created by Bibo on 12/3/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAToolBarView.h"

@interface FAToolBarView()

@property (nonatomic, strong) NSMutableArray *btnsArray;
@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation FAToolBarView

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
    _btnsArray = [NSMutableArray new];
    
    _indicatorView = [[UIView alloc]init];
    _indicatorView.layer.cornerRadius = 2;
    _indicatorView.backgroundColor = [UIColor FADarkYellowColor];
    [self addSubview:_indicatorView];
    
    [self tabbarBtnWithTag:0 title:@"LEARN" action:@selector(learnPressed:)];
    [self tabbarBtnWithTag:1 title:@"SHOP" action:@selector(shopPresssed:)];
//    [self tabbarBtnWithTag:2 title:@"RESTAURANTS" action:@selector(restaurantPresssed:)];
//    [self tabbarBtnWithTag:3 title:@"EVENT" action:@selector(jobPresssed:)];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
    line.backgroundColor = [UIColor FALightGray];
    [self addSubview:line];
  }
  return self;
}

-(UIButton *)tabbarBtnWithTag:(NSInteger)tag title:(NSString *)title action:(SEL)action {
  UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  NSInteger numberOfBtns = 2;
  btn.frame = CGRectMake(tag*(self.frame.size.width/numberOfBtns), 0, self.frame.size.width/numberOfBtns, self.frame.size.height);
  [btn setTitle:title forState:UIControlStateNormal];
  [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
  btn.titleLabel.font = [UIFont dosisBoldWithSize:14];
  btn.tintColor = [UIColor lightGrayColor];
  btn.titleLabel.numberOfLines = 0;
  btn.titleLabel.textAlignment = NSTextAlignmentCenter;
  [self addSubview:btn];
  
  [_btnsArray addObject:btn];
  
  if (tag == 0) {
    [self setSelectedBtn:btn];
  }
  
  return btn;
}

-(void)learnPressed:(UIButton *)btn {
  if ([FAViewModelsManager shared].homeVM.isSneakPeak) {
    [[FARouteManager shared] hideToolBar];
    [[FARouteManager shared] popHighestNavVCAnimated:YES];
  }
  else {
    [self setSelectedBtn:btn];
    [[FARouteManager shared]goToLandingVCFromToolBar];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"playVideo" object:nil];
  }
}

-(void)shopPresssed:(UIButton *)btn {
  if ([FAViewModelsManager shared].homeVM.isSneakPeak) {
    [[FARouteManager shared] hideToolBar];
    [[FARouteManager shared] popHighestNavVCAnimated:YES];
  }
  else
  {
    [self setSelectedBtn:btn];
    [[FARouteManager shared]goToShopVC];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pauseVideo" object:nil];
  }
}

-(void)restaurantPresssed:(UIButton *)btn {
  if ([FAViewModelsManager shared].homeVM.isSneakPeak) {
    [[FARouteManager shared] hideToolBar];
    [[FARouteManager shared] popHighestNavVCAnimated:YES];
  }
  else
  {
    [self setSelectedBtn:btn];
    [[FARouteManager shared] goToAlumniVC];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pauseVideo" object:nil];
  }
}

-(void)jobPresssed:(UIButton *)btn {
  if ([FAViewModelsManager shared].homeVM.isSneakPeak) {
    [[FARouteManager shared] hideToolBar];
    [[FARouteManager shared] popHighestNavVCAnimated:YES];
  }
  else
  {
    [self setSelectedBtn:btn];
    [[FARouteManager shared] goToJobVC];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pauseVideo" object:nil];
  }
}

-(void)selectHome {
  [self setSelectedBtn:_btnsArray[0]];
}

-(void)setSelectedBtn:(UIButton *)btn {
  
  for (UIButton *allBtn in _btnsArray) {
    allBtn.tintColor = [UIColor lightGrayColor];
  }
  
  btn.tintColor = [UIColor FAAlmostBlackColor];
  CGFloat widthOfText = [PKUIManager getWidthForString:btn.titleLabel.text font:btn.titleLabel.font restrictedHeight:btn.frame.size.height] + 20;
  
  [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
    _indicatorView.frame = CGRectMake(btn.frame.origin.x + btn.frame.size.width/2 - widthOfText/2, self.frame.size.height-5, widthOfText, 4);
  } completion:^(BOOL finished) {
    
  }];
}

@end
