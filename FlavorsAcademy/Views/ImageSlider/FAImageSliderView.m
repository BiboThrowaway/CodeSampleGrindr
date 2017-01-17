//
//  FAImageSliderView.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/14/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAImageSliderView.h"

@interface FAImageSliderView() <UIScrollViewDelegate>

@property (nonatomic, readwrite) BOOL userTouchedScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation FAImageSliderView

-(instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray {
  self = [super initWithFrame:frame];
  if (self) {
    
    self.dataArray = dataArray;
    
    UIScrollView *imageScrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    imageScrollView.contentSize = CGSizeMake(frame.size.width * dataArray.count, frame.size.height);
    imageScrollView.pagingEnabled = YES;
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.delegate = self;
    imageScrollView.scrollsToTop = NO;
    [self addSubview:imageScrollView];
    
    for (int i = 0; i < dataArray.count; i++) {
      UIImageView *sliderImage = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];
      sliderImage.contentMode = UIViewContentModeScaleAspectFill;
      sliderImage.clipsToBounds = YES;
      sliderImage.tag = i;
      [imageScrollView addSubview:sliderImage];
      
      UITapGestureRecognizer *tapOnImage = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tappedOnImage:)];
      sliderImage.userInteractionEnabled = YES;
      [sliderImage addGestureRecognizer:tapOnImage];
      
      FAHomeChildren *dataModel = dataArray[i];
      
      [PKNetworkingManager getImageCachedFromURL:dataModel.imageUrl param:nil cacheExpireInSeconds:10000 returned:^(UIImage *responseImage, NSError *error) {
        sliderImage.image = responseImage;
      }];
    }
    
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height - 30, frame.size.width, 20)];
    self.pageControl.numberOfPages = dataArray.count;
    self.pageControl.userInteractionEnabled = NO;
    [self addSubview:self.pageControl];
    
    if (dataArray.count > 1) {
      [self performSelector:@selector(scrollToNextImage:) withObject:imageScrollView afterDelay:5];
    }
  }
  return self;
}

-(void)tappedOnImage:(UITapGestureRecognizer *)sender {
  self.userTouchedScrollView = YES;
  if ([FAViewModelsManager shared].homeVM.isSneakPeak) {
    [[FARouteManager shared] hideToolBar];
    [[FARouteManager shared] popHighestNavVCAnimated:YES];
  }
  else {
    FAHomeChildren *selectedChildren = self.dataArray[sender.view.tag];
    FAVideoVM *videoVM = [FAVideoVM new];
    videoVM.displayTitle = selectedChildren.displayTitle;
    videoVM.childrenArray = selectedChildren.children;
    videoVM.vmLookupKey = selectedChildren.lookupKey;
    [[FARouteManager shared] goToVideoPlayerVCWithVM:videoVM];
  }
}

-(void)scrollToNextImage:(UIScrollView *)sender {
  if (!self.userTouchedScrollView) {
    [sender setContentOffset:CGPointMake([PKUIManager deviceWidth], 0) animated:YES];
  }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
  self.userTouchedScrollView = YES;
  CGFloat pageWidth = scrollView.frame.size.width;
  float fractionalPage = scrollView.contentOffset.x / pageWidth;
  NSInteger page = lround(fractionalPage);
  self.pageControl.currentPage = page;
}


-(void)dealloc {
  NSLog(@"image dealloc");
}


@end
