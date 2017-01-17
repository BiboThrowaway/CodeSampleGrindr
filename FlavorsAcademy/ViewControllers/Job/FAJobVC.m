//
//  FAJobVC.m
//  BiboliveAcademy
//
//  Created by Bibo on 12/8/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAJobVC.h"

@interface FAJobVC ()

@end

@implementation FAJobVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  [self setupNavBar];
  [self setupView];
}

-(void)setupNavBar {
  self.navBar = [[FANavBar alloc]initWithFrame:CGRectMake(0, 0, self.width, 64)];
  [self.navBar setTitleWithString:@"Event"];
  [self.view addSubview:self.navBar];
}

-(void)setupView {
  UILabel *labelOne = [UILabel PKOneLineLabelWithFrame:CGRectMake(0, 100, self.width, 100) text:@"Coming Soon!" textColor:[UIColor FAAlmostBlackColor] textAlignment:NSTextAlignmentCenter font:[UIFont dosisExtraBoldWithSize:20]];
  [self.view addSubview:labelOne];
  
  UILabel *labelTwo = [UILabel PKMultiLineLabelWithCustomLineHeight:5 withFrame:CGRectMake(30, 200, self.width-60, 200) text:@"This section will be for chefs around the world hosting events such as in person cooking class, meetups, farm and market tour and etc. If you are interested in hosting such event in your city, please contact us at events@letschef.com" textColor:[UIColor FAAlmostBlackColor] textAlignment:NSTextAlignmentCenter font:[UIFont dosisMediumWithSize:16]];
  [self.view addSubview:labelTwo];
}

@end
