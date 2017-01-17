//
//  FASearchView.m
//  Chefrica
//
//  Created by Bibo on 12/2/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FASearchView.h"

@interface FASearchView() <UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UIView *initialSearchView;

@end

@implementation FASearchView

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    
    self.backgroundColor = [UIColor whiteColor];
    [self setupNavbar];
    [self setupView];
    
  }
  return self;
}

-(void)setupNavbar {
  FANavBar *navBar = [[FANavBar alloc]initWithBackBtnOnly];
  [navBar setTitleWithString:@"SEARCH"];
  [self addSubview:navBar];
  
  [navBar.backBtn addTarget:self action:@selector(backBtnPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setupView {
  self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, [PKUIManager deviceWidth], 40)];
  self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
  self.searchBar.delegate = self;
  [self addSubview:self.searchBar];
  
  [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{ NSFontAttributeName: [UIFont dosisMediumWithSize:15],}];
  
  [self.searchBar becomeFirstResponder];
  
  [self setupInitialSearchView];
}

-(void)setupInitialSearchView {
  _initialSearchView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, [PKUIManager deviceWidth], [PKUIManager deviceHeight]-64)];
  [self addSubview:_initialSearchView];
  
  UILabel *title = [UILabel PKOneLineLabelWithFrame:CGRectMake(20, 40, 300, 60) text:@"Popular search terms:" textColor:[UIColor FAAlmostBlackColor] textAlignment:NSTextAlignmentLeft font:[UIFont dosisExtraBoldWithSize:16]];
  [_initialSearchView addSubview:title];
  
  for (int i = 0; i < [FAViewModelsManager shared].homeVM.baseResponse.searchTerms.count; i++) {
    [self setupSuggestSearchButtonWithTitle:[FAViewModelsManager shared].homeVM.baseResponse.searchTerms[i] tag:i];
  }
}

-(void)setupSuggestSearchButtonWithTitle:(NSString *)title tag:(NSInteger)tag {
  UIButton *suggestSearchBtn = [UIButton PKtextButtonWithFrame:CGRectMake(20, 100+tag*40, 300, 40) title:title font:[UIFont dosisMediumWithSize:14] tintColor:[UIColor blueColor]];
  suggestSearchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
  suggestSearchBtn.tag = tag;
  [_initialSearchView addSubview:suggestSearchBtn];
  [suggestSearchBtn addTarget:self action:@selector(suggestSearchBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)suggestSearchBtnPressed:(UIButton *)btn {
  self.searchBar.text = [FAViewModelsManager shared].homeVM.baseResponse.searchTerms[btn.tag];
  [self searchBarSearchButtonClicked:self.searchBar];
}

-(void)backBtnPressed {
  [[FARouteManager shared]closeSearchView:YES];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
  
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
  
  if (searchBar.text.length > 0) {
    [[FARouteManager shared] closeSearchView:NO];

    FAVideoVM *videoVM = [FAVideoVM new];
    videoVM.displayTitle = [NSString stringWithFormat:@"SEARCH - %@",searchBar.text];
    videoVM.searchString = searchBar.text;
    videoVM.vmLookupKey = @"search";
    [[FARouteManager shared]goToVideoPlayerVCWithVM:videoVM];
  }
}

@end
