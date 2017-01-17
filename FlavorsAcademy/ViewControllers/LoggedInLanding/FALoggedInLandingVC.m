//
//  FALoggedInLandingVC.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/13/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FALoggedInLandingVC.h"
#import "FAImageSliderView.h"
#import "FAHomeCategoryView.h"

@interface FALoggedInLandingVC () <UIScrollViewDelegate>

@property (nonatomic, readwrite) BOOL isSneakPeak;
@property (nonatomic, readwrite) CGFloat yOrigin;
@property (nonatomic, strong) FAHomeModel *homePageModel;
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong) DGActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) CBStoreHouseRefreshControl *storeHouseRefreshControl;

@end

@implementation FALoggedInLandingVC

@synthesize yOrigin;
@synthesize activityIndicatorView;

- (instancetype)initWithIsSneakPeak:(BOOL)isSneakPeak {
  self = [super init];
  if (self) {
    _isSneakPeak = isSneakPeak;
    [FAViewModelsManager shared].homeVM.isSneakPeak = isSneakPeak;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor FASuperLightGray];
  
  [self setupNavBar];
  [self setupActivityIndicator];
  [self setupVMObserver];
}

-(void)backBtnPressed {
  [[FARouteManager shared] hideToolBar];
}

-(void)setupNavBar {
  if (_isSneakPeak) {
    self.navBar = [[FANavBar alloc]initWithBackBtnOnly];
    [self.navBar.backBtn addTarget:self action:@selector(backBtnPressed) forControlEvents:UIControlEventTouchUpInside];
  }
  else {
    self.navBar = [[FANavBar alloc]initWithMenuAndSearchBtns];
  }
  
  [self.view addSubview:self.navBar];
  [self.navBar setTitleWithString:@"LET'S CHEF ACADEMY"];
  
  [PKUIManager applyInterpolatingMotionEffectToView:self.navBar.centerBtn withParallaxLimit:10];
}

-(void)setupActivityIndicator {
  activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeCookieTerminator tintColor:[UIColor FALightGray] size:40.0f];
  activityIndicatorView.frame = CGRectMake(self.width/2-50, self.height/2-50, 100.0f, 100.0f);
  [self.view addSubview:activityIndicatorView];
  [activityIndicatorView startAnimating];
}

-(void)removeActivityIndicator {
  if (activityIndicatorView) {
    [activityIndicatorView stopAnimating];
    [activityIndicatorView removeFromSuperview];
    activityIndicatorView = nil;
  }
}

-(void)setupVMObserver {
  
  @weakify(self)
  [RACObserve([FAViewModelsManager shared], homeVM) subscribeNext:^(id x) {
    @strongify(self)
    if ([FAViewModelsManager shared].homeVM.baseResponse) {
      self.homePageModel = [FAViewModelsManager shared].homeVM.baseResponse;
      [self setupContents];
      [self removeActivityIndicator];
    }
    else {
      // Loading data
    }
  }];
}

-(void)setupContents {
  yOrigin = 0;
  
  if (_backgroundScrollView) {
    [_backgroundScrollView removeFromSuperview];
    _backgroundScrollView = nil;
  }
  
  _backgroundScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.navBar.bounds), self.width, self.height - CGRectGetHeight(self.navBar.bounds) - 50)];
  _backgroundScrollView.delegate = self;
  _backgroundScrollView.scrollsToTop = NO;
  [self.view addSubview:_backgroundScrollView];
  
  _storeHouseRefreshControl = [CBStoreHouseRefreshControl attachToScrollView:_backgroundScrollView target:self refreshAction:@selector(refreshTriggered:) plist:@"eightsides" color:[UIColor lightGrayColor] lineWidth:2 dropHeight:80 scale:1 horizontalRandomness:150 reverseLoadingAnimation:YES internalAnimationFactor:0.7];
  
  NSArray *contentsArray = self.homePageModel.homePage;
  for (FAHomeHomePage *contentModel in contentsArray) {
    if ([contentModel.type isEqualToString:@"slider"]) {
      [self setupSliderWithArray:contentModel.children];
    }
    if ([contentModel.type isEqualToString:@"category"]) {
      [self setupCategoryViewWithModel:contentModel height:130];
    }
    if ([contentModel.type isEqualToString:@"category_curriculum"]) {
//      [self setupCategoryViewWithDict:contentDict height:160];
      [self setupCategoryViewWithModel:contentModel height:130];
    }
  }
  
  _backgroundScrollView.contentSize = CGSizeMake(self.width, yOrigin);
}

-(void)refreshTriggered:(CBStoreHouseRefreshControl *)sender {
  [[FARequestManager shared] getHomePageWithCallback:^(id responseObject, NSError *error) {
    if (error) {
      NSLog(@"%@", error.localizedDescription);
    }
    else {
      [_backgroundScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
      [self.storeHouseRefreshControl finishingLoading];
      [self performSelector:@selector(reloadScrollView:) withObject:responseObject afterDelay:0.4];
    }
  }];
}

-(void)reloadScrollView:(NSDictionary *)responseObject {
  [FAViewModelsManager shared].homeVM = [[FAHomeVM alloc]initWithHomeAPIResponse:responseObject];
}

-(void)setupSliderWithArray:(NSArray *)childrensArray {
  CGFloat imageScrollHeightToWidthRatio = 0.5;
  FAImageSliderView *imageSliderView = [[FAImageSliderView alloc]initWithFrame:CGRectMake(0, yOrigin, self.width, self.width * imageScrollHeightToWidthRatio) dataArray:childrensArray];
  [_backgroundScrollView addSubview:imageSliderView];
  
  yOrigin = yOrigin + CGRectGetHeight(imageSliderView.bounds);
}

-(void)setupCategoryViewWithModel:(FAHomeHomePage *)dataModel height:(CGFloat)height {
  FAHomeCategoryView *categoryView = [[FAHomeCategoryView alloc]initWithFrame:CGRectMake(0, yOrigin, self.width, height) dataModel:dataModel];
  [_backgroundScrollView addSubview:categoryView];
  
  yOrigin = yOrigin + CGRectGetHeight(categoryView.bounds);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  [self.storeHouseRefreshControl scrollViewDidScroll];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  [self.storeHouseRefreshControl scrollViewDidEndDragging];
}

@end
