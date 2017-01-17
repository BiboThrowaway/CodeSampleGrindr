//
//  FAAlumniVC.m
//  BiboliveAcademy
//
//  Created by Bibo on 12/8/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAAlumniVC.h"
#import "FAShoppingCollectionHeader.h"
#import "FARestaurantCollectionViewCell.h"
#import "FACitySelectorView.h"

@interface FAAlumniVC () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UICollectionView *mainCollectionView;
@property (nonatomic, strong) FACitySelectorView *citySelectorView;

@end

@implementation FAAlumniVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  [self setupNavBar];
  [self setupCollectionView];
  [self getData];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showCitySelectorView) name:@"hasUserLocation" object:nil];
}

-(void)setupNavBar {
  self.navBar = [[FANavBar alloc]initForRestaurantPage];
  [self.navBar setTitleWithString:@"AWESOME RESTAURANTS"];
  [self.navBar.rightBtnOne addTarget:self action:@selector(selectCityPressed) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.navBar];
}

-(void)getData {
  PFQuery *query = [PFQuery queryWithClassName:@"Restaurant"];
  [query whereKey:@"isActive" notEqualTo:[NSNumber numberWithBool:NO]];
  [query orderByDescending:@"ordinalValue"];
  [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
    _dataArray = objects;
    [_mainCollectionView reloadData];
  }];
}

-(void)setupCollectionView {
  UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
  layout.minimumInteritemSpacing = 0;
  layout.minimumLineSpacing = 3;
  layout.itemSize = CGSizeMake(self.width, self.width);
  layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
  layout.headerReferenceSize = CGSizeMake(self.width, 100);
  _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.width, self.height-64-50) collectionViewLayout:layout];
  _mainCollectionView.delegate = self;
  _mainCollectionView.dataSource = self;
  _mainCollectionView.backgroundColor = [UIColor whiteColor];
  [_mainCollectionView registerClass:[FARestaurantCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
  [_mainCollectionView registerClass:[FAShoppingCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
  _mainCollectionView.scrollsToTop = NO;
  [self.view addSubview:_mainCollectionView];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  FARestaurantCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

  PFObject *object = _dataArray[indexPath.item];
  cell.imageView.image = nil;
  [cell.imageView setImageWithURL:[NSURL URLWithString:object[@"imageUrl"]]];
  NSString *titleString = [[NSString stringWithFormat:@"%@",object[@"displayTitle"]] uppercaseString];
  
  cell.titleLabel.text = titleString;
  cell.locationLabel.text = [[NSString stringWithFormat:@"%@, %@", object[@"city"], object[@"state"]] uppercaseString];
  cell.descriptionLabel.text = [[NSString stringWithFormat:@"%@", object[@"whyRecommend"]] uppercaseString];
  
  CGFloat margin = 80;
  CGFloat heightOfTitle = [PKUIManager getHeightForString:titleString font:cell.titleLabel.font restrictedWidth:self.width-margin*2];
  cell.titleLabel.frame = CGRectMake(margin, 20, self.width-margin*2, heightOfTitle);
  CGFloat heightOfLocation = 50;
  cell.locationLabel.frame = CGRectMake(margin, CGRectGetMaxY(cell.titleLabel.frame), self.width-margin*2, heightOfLocation);
  cell.labelBackground.frame = CGRectMake(70, 0, self.width-140, CGRectGetMaxY(cell.locationLabel.frame)+10);
  
  
  return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return _dataArray.count;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  FAShoppingCollectionHeader *reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
  reuseView.titleLabel.text = @"Here are some of the restaurants we have been or heard of that serves extraordinary food, if there is a place you recommend please email us at hello@letschef.com";
  return reuseView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  FAProductVM *productVM = [FAProductVM new];
  PFObject *object = _dataArray[indexPath.item];
  NSString *websiteUrl;
  if (object[@"websiteUrl"] && [NSString stringWithFormat:@"%@",object[@"websiteUrl"]].length) {
    websiteUrl = object[@"websiteUrl"];
  }
  else {
    websiteUrl = object[@"yelpUrl"];
  }
  productVM.prductUrl = websiteUrl;
  productVM.displayTitle = object[@"displayTitle"];
  
  [[FARouteManager shared]goToProductWebviewWithVM:productVM];
}

-(void)selectCityPressed {
  if ([FALocationManager shared].hasUserLatestLocation) {
    if (self.citySelectorView) {
      [self removeCitySelectorViewAnimated:YES];
    }
    else {
      [self showCitySelectorView];
    }
  }
  else {
    [[[UIAlertView alloc]initWithTitle:@"Location Permission" message:@"Do you allow us to have permission to your location while using Let's Chef?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Don't Allow", @"Allow", nil] show];
  }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
  if (!buttonIndex) {
    // does not allow
  }
  else {
    // allow
    [[FALocationManager shared]getLocationManagerPermission];
  }
}

-(void)showCitySelectorView {
  if (self.citySelectorView) {
    [self removeCitySelectorViewAnimated:NO];
  }
  self.citySelectorView = [[FACitySelectorView alloc]initWithFrame:CGRectMake(0, 64, self.width, self.height-64-50)];
  self.citySelectorView.alpha = 0;
  [self.view addSubview:self.citySelectorView];
  
  [UIView animateWithDuration:0.2 animations:^{
    self.citySelectorView.alpha = 1;
  }];
  
  [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.3 options:UIViewAnimationOptionAllowUserInteraction animations:^{
    self.citySelectorView.contentView.frame = CGRectMake(self.width/3, 0, self.width/1.5, self.height-64-50);
  } completion:^(BOOL finished) {
    
  }];
}

-(void)removeCitySelectorViewAnimated:(BOOL)animated {
  if (animated) {
    [UIView animateWithDuration:0.4 animations:^{
      self.citySelectorView.contentView.frame = CGRectMake(self.width, 0, self.width/1.5, self.height-64-50);
    } completion:^(BOOL finished) {
      [UIView animateWithDuration:0.2 animations:^{
        self.citySelectorView.alpha = 0;
      } completion:^(BOOL finished) {
        [self.citySelectorView removeFromSuperview];
        self.citySelectorView = nil;
      }];
    }];
  }
  else {
    [self.citySelectorView removeFromSuperview];
    self.citySelectorView = nil;
  }
}
@end
