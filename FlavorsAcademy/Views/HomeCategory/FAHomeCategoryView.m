//
//  FAHomeCategoryView.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/14/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAHomeCategoryView.h"

@interface FAHomeCategoryView ()

@property (nonatomic, strong) FAHomeHomePage *dataModel;

@end

@implementation FAHomeCategoryView

-(instancetype)initWithFrame:(CGRect)frame dataModel:(FAHomeHomePage *)dataModel {
  self = [super initWithFrame:frame];
  if (self) {
    
    self.dataModel = dataModel;
    
//    NSLog(@"dataDict %@", self.dataDict);
    
    CGFloat titleLabelHeight = 45;
    
    UIScrollView *backgroundScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    backgroundScrollView.showsHorizontalScrollIndicator = NO;
    backgroundScrollView.scrollsToTop = NO;
    [self addSubview:backgroundScrollView];
    
    _titleLabel = [UILabel PKOneLineLabelWithFrame:CGRectMake(15, 0, frame.size.width-15, titleLabelHeight+5) text:dataModel.displayTitle textColor:[UIColor FAAlmostBlackColor] textAlignment:NSTextAlignmentLeft font:[UIFont dosisBoldWithSize:16]];
    [self addSubview:_titleLabel];
    
    if ([dataModel.type isEqualToString:@"category_curriculum"]) {
      _titleLabel.font = [UIFont dosisExtraBoldWithSize:18];
    }
    
    if ([dataModel.lookupKey isEqualToString:@"category_culinary_art"]) {
      _titleLabel.textColor = [UIColor FAOrangeColor];
    }
    
    if ([dataModel.lookupKey isEqualToString:@"category_pastry_baking_arts"]) {
      _titleLabel.textColor = [UIColor FADarkYellowColor];
    }
    
    if ([dataModel.lookupKey isEqualToString:@"category_restaurant_management"]) {
      _titleLabel.textColor = [UIColor FAGreenColor];
    }
    
    CGFloat xOrigin = 15;
    
    NSArray *childrenArray = dataModel.children;
    for (int i = 0; i < childrenArray.count; i++) {
      FAHomeChildren *childrenModel = childrenArray[i];
      UIFont *titleFont = [UIFont dosisMediumWithSize:16];
      NSString *titleString = childrenModel.displayTitle;
      
      UIButton *btn;
      CGFloat btnWidth;
      
      if (childrenModel.imageUrl) {
        btnWidth = (CGRectGetHeight(backgroundScrollView.bounds)-30-titleLabelHeight)*2;
        btn = [UIButton PKimageButtonWithFrame:CGRectMake(xOrigin, titleLabelHeight + 5, btnWidth, CGRectGetHeight(backgroundScrollView.bounds)-30 - titleLabelHeight) image:[UIImage new]];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:btn.bounds];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [btn addSubview:imageView];
        [PKNetworkingManager getImageCachedFromURL:childrenModel.imageUrl param:nil cacheExpireInSeconds:10000 returned:^(UIImage *responseImage, NSError *error) {
          imageView.image = responseImage;
        }];
      }
      else {
        btnWidth = [PKUIManager getWidthForString:titleString font:titleFont restrictedHeight:CGRectGetHeight(backgroundScrollView.bounds)-30] + 50;
        btn = [UIButton PKtextButtonWithFrame:CGRectMake(xOrigin, titleLabelHeight + 5, btnWidth, CGRectGetHeight(backgroundScrollView.bounds)-30 - titleLabelHeight) title:titleString font:titleFont tintColor:[UIColor FAAlmostBlackColor]];
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
      }
      
      btn.backgroundColor = [UIColor whiteColor];
//      btn.layer.shadowColor = [UIColor blackColor].CGColor;
//      btn.layer.shadowOffset = CGSizeMake(2, 1);
//      btn.layer.shadowOpacity = 0.1;
//      btn.layer.shadowRadius = 1;
      btn.layer.borderColor = [UIColor FALightGray].CGColor;
      btn.layer.borderWidth = 1;
      btn.clipsToBounds = YES;
      btn.layer.cornerRadius = 5;
      [backgroundScrollView addSubview:btn];
      
      btn.tag = i;
      [btn addTarget:self action:@selector(categoryBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
      
      xOrigin = xOrigin + btnWidth + 15;
      
//      if ([childrenDict[@"lookupKey"] isEqualToString:@"year_one"]) {
//        btn.tintColor = [UIColor blueColor];
//      }
//      
//      if ([childrenDict[@"lookupKey"] isEqualToString:@"year_two"]) {
//        btn.tintColor = [UIColor brownColor];
//      }
//      
//      if ([childrenDict[@"lookupKey"] isEqualToString:@"year_three"]) {
//        btn.tintColor = [UIColor purpleColor];
//      }
//      
//      if ([childrenDict[@"lookupKey"] isEqualToString:@"year_four"]) {
//        btn.tintColor = [UIColor greenColor];
//      }
    }
    
    backgroundScrollView.contentSize = CGSizeMake(xOrigin, CGRectGetHeight(backgroundScrollView.bounds));
    
    UIView *underline = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-1, [PKUIManager deviceWidth], 1)];
    underline.backgroundColor = [UIColor FALightGray];
    [self addSubview:underline];
  }
  return self;
}

-(void)categoryBtnPressed:(UIButton *)sender {
  
  NSArray *childrenArray = self.dataModel.children;
  
  if ([FAViewModelsManager shared].homeVM.isSneakPeak) {
    [[FARouteManager shared] hideToolBar];
    [[FARouteManager shared] popHighestNavVCAnimated:YES];
  }
  else {
    FAHomeChildren *selectedChildren = childrenArray[sender.tag];
    FAVideoVM *videoVM = [FAVideoVM new];
    videoVM.displayTitle = [NSString stringWithFormat:@"%@ - %@",self.dataModel.displayTitle, selectedChildren.displayTitle];
    if ([self.dataModel.lookupKey isEqualToString:@"category_keyword"]) {
      videoVM.displayTitle = selectedChildren.displayTitle;
    }
    videoVM.childrenArray = selectedChildren.children;
    videoVM.vmLookupKey = selectedChildren.lookupKey;
    [[FARouteManager shared] goToVideoPlayerVCWithVM:videoVM];
  }
}

@end
