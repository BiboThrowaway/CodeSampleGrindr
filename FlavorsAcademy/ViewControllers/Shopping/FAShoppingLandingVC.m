//
//  FAShoppingLandingVC.m
//  BiboliveAcademy
//
//  Created by Bibo on 12/3/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAShoppingLandingVC.h"
#import "FAShoppingCollectionViewCell.h"
#import "FAShoppingCollectionHeader.h"

@interface FAShoppingLandingVC () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UICollectionView *mainCollectionView;

@end

@implementation FAShoppingLandingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  self.view.backgroundColor = [UIColor whiteColor];
  
  [self setupNavBar];
  [self setupCollectionView];
  
  [self getData];
}

-(void)getData {
  PFQuery *query = [PFQuery queryWithClassName:@"ShopItem"];
  [query whereKey:@"isActive" notEqualTo:[NSNumber numberWithBool:NO]];
  [query orderByDescending:@"ordinalValue"];
  [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
    _dataArray = objects;
    [_mainCollectionView reloadData];
  }];
}

-(void)setupNavBar {
  self.navBar = [[FANavBar alloc]initWithFrame:CGRectMake(0, 0, self.width, 64)];
  [self.navBar setTitleWithString:@"Shop"];
  [self.view addSubview:self.navBar];
}

-(void)setupCollectionView {
  UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
  layout.minimumInteritemSpacing = 5;
  layout.minimumLineSpacing = 0;
  layout.itemSize = CGSizeMake(self.width/2-15, self.width/2-15);
  layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
  layout.headerReferenceSize = CGSizeMake(self.width, 150);
  _mainCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, self.width, self.height-64-50) collectionViewLayout:layout];
  _mainCollectionView.delegate = self;
  _mainCollectionView.dataSource = self;
  _mainCollectionView.backgroundColor = [UIColor whiteColor];
  [_mainCollectionView registerClass:[FAShoppingCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
  [_mainCollectionView registerClass:[FAShoppingCollectionHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
  _mainCollectionView.scrollsToTop = NO;
  [self.view addSubview:_mainCollectionView];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  FAShoppingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

  PFObject *object = _dataArray[indexPath.item];
  cell.imageView.image = nil;
  [cell.imageView setImageWithURL:[NSURL URLWithString:object[@"imageUrl"]]];
  cell.titleLabel.text = object[@"displayTitle"];
  
  return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return _dataArray.count;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  FAShoppingCollectionHeader *reuseView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
  reuseView.titleLabel.text = @"All items are affliate links to Amazon so we can continue to provide better quality and more personalized free culinary classes to everyone. All items are tested in our office to ensure high quality and reasonable pricing!";
  return reuseView;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  FAProductVM *productVM = [FAProductVM new];
  PFObject *object = _dataArray[indexPath.item];
  NSString *websiteUrl = object[@"websiteUrl"];
  if ([websiteUrl containsString:@"amazon"]) {
    websiteUrl = [NSString stringWithFormat:@"%@?tag=combocombo-20",object[@"websiteUrl"]];
  }
  productVM.prductUrl = websiteUrl;
  productVM.displayTitle = object[@"displayTitle"];
  
  [[FARouteManager shared]goToProductWebviewWithVM:productVM];
}

@end
