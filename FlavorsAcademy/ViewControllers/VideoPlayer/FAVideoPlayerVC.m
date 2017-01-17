//
//  FAVideoPlayerVC.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/15/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAVideoPlayerVC.h"
#import "FAVideoTableViewHeaderView.h"
#import "FAVideoTableViewCell.h"
#import <AVFoundation/AVFoundation.h>
#import "FAVideoParser.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MPMoviePlayerViewController+FullScreenFix.h"

@interface FAVideoPlayerVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FAVideoVM *videoVM;
@property (nonatomic, strong) MPMoviePlayerViewController *movieController;
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSIndexPath *lastPlayingIndexPath;
@property (nonatomic, strong) NSMutableDictionary *videoDataDict;
@property (nonatomic, strong) NSMutableDictionary *categoryVideoDataDict;
@property (nonatomic, strong) NSMutableArray *lookupKeysArray;
@property (nonatomic, strong) DGActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) PKYoutubeVideoView *youtubePlayerView;

@end

@implementation FAVideoPlayerVC
@synthesize lookupKeysArray;
@synthesize activityIndicatorView;

-(instancetype)initWithVideoVM:(FAVideoVM *)videoVM {
  self = [super init];
  if (self) {
    self.videoVM = videoVM;
  }
  return self;
}

-(void)viewWillDisappear:(BOOL)animated {
  [self pauseVideo];
}

-(void)dealloc {
  if (self.movieController) {
    [self.movieController.moviePlayer pause];
    [self.movieController.view removeFromSuperview];
    [self.movieController removeFromParentViewController];
    self.movieController = nil;
  }
  
  if (_youtubePlayerView) {
    [_youtubePlayerView removeFromSuperview];
    _youtubePlayerView = nil;
  }
}

-(void)viewDidLoad {
  [super viewDidLoad];
  
  [Answers logContentViewWithName:@"videoVC" contentType:self.videoVM.displayTitle contentId:@"" customAttributes:nil];
  
  self.lastPlayingIndexPath = [NSIndexPath indexPathForRow:999 inSection:999];
  
  self.view.backgroundColor = [UIColor whiteColor];
  /* 
   getDataFromParse must go after getAllLookupKeys
   */
  [self setupNavBar];
  [self getAllLookupKeys];
  [self setupIndicatorView];
  [self getDataFromParse];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideo) name:@"playVideo" object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pauseVideo) name:@"pauseVideo" object:nil];
}

-(void)getAllLookupKeys {
  int numberOfChildrenLevels = 0;
  lookupKeysArray = [NSMutableArray new];
  [lookupKeysArray addObject:_videoVM.vmLookupKey];
  if (_videoVM.childrenArray.count > 0) {
    numberOfChildrenLevels++;
    FAHomeChildren *tempSectionModel = _videoVM.childrenArray[0];
    if (tempSectionModel.children.count > 0) {
      numberOfChildrenLevels++;
    }
    for (int a = 0; a < _videoVM.childrenArray.count; a++) {
      FAHomeChildren *sectionsModel = _videoVM.childrenArray[a];
      [lookupKeysArray addObject:sectionsModel.lookupKey];
      if (sectionsModel.children.count > 0) {
        NSArray *subsectionArray = sectionsModel.children;
        for (int b = 0; b < subsectionArray.count; b++) {
          FAHomeChildren *subsectionsModel = subsectionArray[b];
          [lookupKeysArray addObject:subsectionsModel.lookupKey];
        }
      }
    }
  }
  _videoVM.numberOfChildrenLevels = numberOfChildrenLevels;
}

-(void)setupIndicatorView {
  activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeCookieTerminator tintColor:[UIColor FALightGray] size:40.0f];
  activityIndicatorView.frame = CGRectMake(self.width/2-50, self.height/2-50, 100.0f, 100.0f);
  [self.view addSubview:activityIndicatorView];
  [activityIndicatorView startAnimating];
}

-(void)getDataFromParse {
  PFQuery *query = [PFQuery queryWithClassName:@"Video"];
  if (self.videoVM.isFavorite) {
    [query whereKey:@"videoId" containedIn:[FAViewModelsManager shared].userVM.favoriteVideoIds];
  }
  else if (self.videoVM.searchString.length > 0) {
    [query whereKey:@"keywords" matchesRegex:self.videoVM.searchString modifiers:@"i"];
  }
  else {
    [query whereKey:@"categoryLookups" containedIn:lookupKeysArray];
  }
  [query whereKey:@"isActive" notEqualTo:[NSNumber numberWithBool:NO]];
  [query orderByDescending:@"ordinalValue"];
  [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
    [self setupViewWithVideoObjects:objects];
  }];
}

-(void)setupViewWithVideoObjects:(NSArray *)objects {
  self.videoDataDict = [NSMutableDictionary dictionary];
  
  for (int a = 0; a < lookupKeysArray.count; a++) {
    NSString *lookupKey = lookupKeysArray[a];
    NSMutableArray *tempArray = [NSMutableArray new];
    for (PFObject *object in objects) {
      NSArray *categoryLookupsArray = object[@"categoryLookups"];
      if ([categoryLookupsArray containsObject:lookupKey]) {
        [tempArray addObject:object];
      }
    }
    
    if (tempArray.count > 0) {
      [self.videoDataDict setObject:tempArray forKey:lookupKey];
    }
  }
  
  self.categoryVideoDataDict = [NSMutableDictionary new];
  
  for (int b = 0 ; b < self.videoVM.childrenArray.count; b++) {
    NSMutableArray *tempArray = [NSMutableArray new];
    FAHomeChildren *sectionModel = self.videoVM.childrenArray[b];
    if (sectionModel.children.count > 0) {
      NSArray *subsectionArray = sectionModel.children;
      for (int c = 0; c < subsectionArray.count; c++) {
        FAHomeChildren *subsectionModel = subsectionArray[c];
        [tempArray addObject:subsectionModel];
        [tempArray addObjectsFromArray:self.videoDataDict[subsectionModel.lookupKey]];
      }
    }
    
    if (_videoVM.numberOfChildrenLevels == 1) {
      [tempArray addObject:sectionModel];
      [tempArray addObjectsFromArray:self.videoDataDict[sectionModel.lookupKey]];
    }
    [self.categoryVideoDataDict setObject:tempArray forKey:sectionModel.lookupKey];
  }
  
  if (_videoVM.numberOfChildrenLevels == 0) {
    NSMutableArray *tempArray = [NSMutableArray new];
    [tempArray addObjectsFromArray:self.videoDataDict[self.videoVM.vmLookupKey]];
    [self.categoryVideoDataDict setObject:tempArray forKey:self.videoVM.vmLookupKey];
  }
  
  if (_videoVM.isFavorite || _videoVM.searchString.length > 0) {
    NSMutableArray *tempArray = [NSMutableArray new];
    [tempArray addObjectsFromArray:objects];
    [self.categoryVideoDataDict setObject:tempArray forKey:self.videoVM.vmLookupKey];
  }
  
  [activityIndicatorView stopAnimating];
  [activityIndicatorView removeFromSuperview];
  
  [self setupTableView];
  
  if (objects.count == 0 && _videoVM.searchString.length > 0) {
//    [SVProgressHUD showErrorWithStatus:@"0 Results"];
//    [[FARouteManager shared]popHighestNavVCAnimated:YES];
    UILabel *noResultLabel = [UILabel PKMultiLineLabelWithCustomLineHeight:5 withFrame:CGRectMake(30, 100, self.width-60, 60) text:[NSString stringWithFormat:@"No results found for %@",_videoVM.searchString] textColor:[UIColor FAAlmostBlackColor] textAlignment:NSTextAlignmentCenter font:[UIFont dosisMediumWithSize:14]];
    [self.view addSubview:noResultLabel];
  }
  else {
    [Answers logCustomEventWithName:@"no_result_for_key" customAttributes:@{@"key":_videoVM.displayTitle}];
  }
}

-(void)setupNavBar {
  if (self.videoVM.isRootVC == YES) {
    self.navBar = [[FANavBar alloc]initWithMenuBtnOnly];
  }
  else {
    self.navBar = [[FANavBar alloc]initWithBackAndMenuBtns];
  }
  [self.view addSubview:self.navBar];
  
  [self.navBar setTitleWithString:self.videoVM.displayTitle];
}

-(void)setupTableView {
  self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.navBar.bounds), self.width, self.height - CGRectGetHeight(self.navBar.bounds) - 50) style:UITableViewStylePlain];
  self.mainTableView.delegate = self;
  self.mainTableView.dataSource = self;
  [self.mainTableView registerClass:[FAVideoTableViewCell class] forCellReuseIdentifier:@"cell"];
  [self.mainTableView registerClass:[FAVideoTableViewHeaderView class] forHeaderFooterViewReuseIdentifier:@"header"];
  self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.mainTableView.backgroundColor = [UIColor whiteColor];
  self.mainTableView.scrollsToTop = NO;
  [self.view addSubview:self.mainTableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  if (self.videoVM.numberOfChildrenLevels > 0) {
    return self.videoVM.childrenArray.count;
  }
  else {
    return 1;
  }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.videoVM.numberOfChildrenLevels > 0) {
    FAHomeChildren *childrenModel = self.videoVM.childrenArray[section];
      NSArray *videoArray = self.categoryVideoDataDict[childrenModel.lookupKey];
      return videoArray.count;
  }
  else {
    NSArray *videoArray = self.categoryVideoDataDict[self.videoVM.vmLookupKey];
    return videoArray.count;
  }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  if (self.videoVM.numberOfChildrenLevels > 1) {
    return 40;
  }
  else {
    return 0;
  }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 40;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  FAVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  [cell.favoriteBtn addTarget:self action:@selector(favoriteBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
  cell.videoTitleLabel.font = [UIFont dosisMediumWithSize:14];
  NSString *lookupKey;
  
  if (self.videoVM.numberOfChildrenLevels > 0) {
    FAHomeChildren *childModel = self.videoVM.childrenArray[indexPath.section];
    lookupKey = childModel.lookupKey;
  }
  else {
    lookupKey = self.videoVM.vmLookupKey;
  }
  
  NSArray *cellDataArray = (lookupKey.length > 0) ? self.categoryVideoDataDict[lookupKey] : @[];
  if ([cellDataArray[indexPath.item] isKindOfClass:[PFObject class]]) {
    PFObject *object = cellDataArray[indexPath.item];
    cell.videoTitleLabel.frame = CGRectMake(60, 0, [PKUIManager deviceWidth]-100, 40);
    cell.videoTitleLabel.text = object[@"displayTitle"];
    cell.videoIndicatorImageView.image = [FAPaintCode imageOfPlayBtnEmpty];
    
    if (indexPath.section == self.lastPlayingIndexPath.section && indexPath.row == self.lastPlayingIndexPath.row) {
      cell.videoIndicatorImageView.image = [FAPaintCode imageOfPlayBtnFilled];
    }
    
    if ([self isVideoIdAFavorite:object[@"videoId"]]) {
      [cell.favoriteBtn setImage:[FAPaintCode imageOfStarFilled] forState:UIControlStateNormal];
    }
    else {
      [cell.favoriteBtn setImage:[FAPaintCode imageOfStarEmpty] forState:UIControlStateNormal];
    }
  }
  else {
    FAHomeChildren *subsectionModel = cellDataArray[indexPath.item];
    cell.videoTitleLabel.text = subsectionModel.displayTitle;
    cell.videoTitleLabel.frame = CGRectMake(20, 0, [PKUIManager deviceWidth]-80, 40);
    cell.videoTitleLabel.font = [UIFont dosisBoldWithSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.videoIndicatorImageView.image = nil;
    [cell.favoriteBtn setImage:nil forState:UIControlStateNormal];
  }
  return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  FAVideoTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
  headerView.tag = section;
  if (self.videoVM.numberOfChildrenLevels > 1) {
    FAHomeChildren *childModel = self.videoVM.childrenArray[section];
    headerView.textHeaderLabel.text = childModel.displayTitle;
  }
  else {
    headerView.textHeaderLabel.text = @"";
  }
  return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
  NSString *lookupKey;
  if (self.videoVM.numberOfChildrenLevels > 0) {
    FAHomeChildren *childModel = self.videoVM.childrenArray[indexPath.section];
    lookupKey = childModel.lookupKey;
  }
  else {
    lookupKey = self.videoVM.vmLookupKey;
  }
  NSArray *cellDataArray = self.categoryVideoDataDict[lookupKey];
    if ([cellDataArray[indexPath.item] isKindOfClass:[PFObject class]]) {
      PFObject *object = cellDataArray[indexPath.item];
      [self playVideoWithId:object[@"videoId"] ? object[@"videoId"] : @"" indexPath:indexPath];
      
      FAVideoTableViewCell *lastCell = [tableView cellForRowAtIndexPath:self.lastPlayingIndexPath];
      lastCell.videoIndicatorImageView.image = [FAPaintCode imageOfPlayBtnEmpty];
      
      self.lastPlayingIndexPath = indexPath;
      
      FAVideoTableViewCell *currentCell = [tableView cellForRowAtIndexPath:self.lastPlayingIndexPath];
      currentCell.videoIndicatorImageView.image = [FAPaintCode imageOfPlayBtnFilled];
    }
}

-(void)playVideoWithId:(NSString *)videoId indexPath:(NSIndexPath *)indexPath {
  self.videoVM.videoCurrentlyPlayingId = videoId;
  CGFloat videoViewHeight = self.width*0.565;
  
  if ([FAViewModelsManager shared].homeVM.baseResponse.settings.useWebview)
  {
    if (_youtubePlayerView) {
      [_youtubePlayerView removeFromSuperview];
      _youtubePlayerView = nil;
    }
    _youtubePlayerView = [[PKYoutubeVideoView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.navBar.bounds), self.width, videoViewHeight)];
    [self.view addSubview:_youtubePlayerView];
    _youtubePlayerView.alpha = 0;
    [_youtubePlayerView playVideoWithId:videoId];
  }
  else {
    NSString *youTubeString = [NSString stringWithFormat:@"https://www.youtube.com/watch?v=%@",videoId];
    NSDictionary *videos = [FAVideoParser h264videosWithYoutubeURL:[NSURL URLWithString:youTubeString]];
    NSString *urlString = [NSString stringWithFormat:@"%@", [videos objectForKey:@"medium"]];
    
    if (self.movieController) {
      [self.movieController.view removeFromSuperview];
      [self.movieController removeFromParentViewController];
      self.movieController = nil;
    }
    
    self.movieController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:urlString]];
    [self addChildViewController:self.movieController];
    self.movieController.view.frame = CGRectMake(0, CGRectGetHeight(self.navBar.bounds), self.width, self.width*0.565);
    [self.view addSubview:self.movieController.view];
    
    self.movieController.moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    [self.movieController.moviePlayer play];
    
    self.movieController.view.alpha = 0;
  }
  
  [UIView animateWithDuration:1.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseIn animations:^{
    self.mainTableView.frame = CGRectMake(0, CGRectGetHeight(self.navBar.bounds)+videoViewHeight, self.width, self.height-videoViewHeight-50-CGRectGetHeight(self.navBar.bounds));
    [self.mainTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
  } completion:^(BOOL finished) {
    
  }];
  
  [UIView animateWithDuration:0.3 delay:0.7 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
    
    self.movieController.view.alpha = 1;
    _youtubePlayerView.alpha = 1;
    
  } completion:^(BOOL finished) {
    
  }];
  
  [Answers logCustomEventWithName:@"playVideo" customAttributes:@{@"videoId":videoId}];
}

-(void)playVideo {
  if (self.movieController.moviePlayer) {
    [self.movieController.moviePlayer play];
  }
  
  if (_youtubePlayerView) {
    [_youtubePlayerView.videoWebView stringByEvaluatingJavaScriptFromString:@"ytplayer.playVideo()"];
  }
}

-(void)pauseVideo {
  if (self.movieController.moviePlayer) {
    [self.movieController.moviePlayer pause];
  }
  
  if (_youtubePlayerView) {
    [_youtubePlayerView.videoWebView stringByEvaluatingJavaScriptFromString:@"ytplayer.pauseVideo()"];
  }
}


-(BOOL)isVideoIdAFavorite:(NSString *)videoId {
  if ([FAViewModelsManager shared].userVM.favoriteVideoIds.count > 0) {
    for (int i = 0; i < [FAViewModelsManager shared].userVM.favoriteVideoIds.count; i++) {
      NSString *favoritesVideoId = [FAViewModelsManager shared].userVM.favoriteVideoIds[i];
      if ([favoritesVideoId isEqualToString:videoId]) {
        return YES;
      }
    }
  }
  return NO;
}

-(void)favoriteBtnPressed:(UIButton *)sender {
  CGPoint rootViewPoint = [sender.superview convertPoint:sender.center toView:self.mainTableView];
  NSIndexPath *indexPath = [self.mainTableView indexPathForRowAtPoint:rootViewPoint];
  
  NSString *videoId;
  NSString *displayTitle;
  

  NSString *lookupKey;
  if (self.videoVM.numberOfChildrenLevels > 0) {
    FAHomeChildren *childModel = self.videoVM.childrenArray[indexPath.section];
    lookupKey = childModel.lookupKey;
  }
  else {
    lookupKey = self.videoVM.vmLookupKey;
  }
  NSArray *cellDataArray = self.categoryVideoDataDict[lookupKey];
  if ([cellDataArray[indexPath.item] isKindOfClass:[PFObject class]]) {
    PFObject *object = cellDataArray[indexPath.item];
    videoId = object[@"videoId"];
    displayTitle = object[@"displayTitle"];
  }
  
  BOOL isFavorite = NO;
  FAVideoTableViewCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
  for (int i = 0; i < [FAViewModelsManager shared].userVM.favoriteVideoIds.count; i++) {
    NSString *favoriteId = [FAViewModelsManager shared].userVM.favoriteVideoIds[i];
    if ([favoriteId isEqualToString:videoId]) {
      isFavorite = YES;
    }
  }
  
  if (isFavorite) {
    [cell.favoriteBtn setImage:[FAPaintCode imageOfStarEmpty] forState:UIControlStateNormal];
    [[FAUserManager shared] removeVideoFromFavorites:videoId callback:^(id responseObject, NSError *error) {
      
    }];
  }
  else {
    [cell.favoriteBtn setImage:[FAPaintCode imageOfStarFilled] forState:UIControlStateNormal];
    [[FAUserManager shared] addVideoToFavorites:videoId displayTitle:displayTitle callback:^(id responseObject, NSError *error) {
      
    }];
  }
}

@end
