//
//  FAAboutVC.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/19/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAAboutVC.h"
#import <MediaPlayer/MediaPlayer.h>

@interface FAAboutVC ()

@property(nonatomic, strong) UILabel *labelOne;
@property(nonatomic, strong) UILabel *labelTwo;
@property(nonatomic, strong) UILabel *labelThree;

@property(nonatomic, strong) UIButton *btnOne;

@property(nonatomic, strong) MPMoviePlayerController *moviePlayer;

@end

@implementation FAAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  [Answers logContentViewWithName:@"aboutVC" contentType:@"" contentId:@"" customAttributes:nil];
  
  [self setupNavBar];
  [self setupContents];
}

-(void)setupNavBar {
  
  self.navBar = [[FANavBar alloc]initWithMenuBtnOnly];
  [self.view addSubview:self.navBar];
  [self.navBar setTitleWithString:@"About"];
}

-(void)setupContents {
  [self setupVideosView];
  [self setupLabels];
}

- (void)setupVideosView {
  NSURL *videoURL =
  [[NSBundle mainBundle] URLForResource:@"bamboo" withExtension:@"mp4"];
  self.moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
  self.moviePlayer.controlStyle = MPMovieControlStyleNone;
  self.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
  self.moviePlayer.view.frame = CGRectMake(0, 64, self.width, self.height-64);
  [self.view insertSubview:self.moviePlayer.view atIndex:0];
  
  UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.width, self.height-64)];
  blackView.backgroundColor =
  [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8];
  [self.view addSubview:blackView];
  
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(loopVideo)
   name:MPMoviePlayerPlaybackDidFinishNotification
   object:self.moviePlayer];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loopVideo) name:UIApplicationWillEnterForegroundNotification object:self.moviePlayer];
  
  [self.moviePlayer play];
}

- (void)setupLabels {
  CGFloat labelOneHeight = 50;
  CGFloat labelTwoHeight = 40;
  CGFloat marginFromCenter = 40;
  CGFloat labelThreeHeight = 160;
  CGFloat labelThreeWidth = 280;
  
  self.labelOne = [UILabel
                   PKOneLineLabelWithFrame:CGRectMake(0,
                                                      CGRectGetHeight(self.view.bounds) / 2 -
                                                      labelOneHeight - labelTwoHeight -
                                                      marginFromCenter,
                                                      CGRectGetWidth(self.view.bounds),
                                                      labelOneHeight)
                   text:@"LET'S CHEF"
                   textColor:[UIColor FAYellowColor]
                   textAlignment:NSTextAlignmentCenter
                   font:[UIFont dosisExtraBoldWithSize:40]];
  [self.view addSubview:self.labelOne];
  [self addGlowToLabel:self.labelOne];
  
  self.labelTwo = [UILabel
                   PKOneLineLabelWithFrame:CGRectMake(0, CGRectGetMaxY(self.labelOne.frame),
                                                      CGRectGetWidth(self.view.bounds),
                                                      labelTwoHeight)
                   text:@"ACADEMY"
                   textColor:[UIColor FAYellowColor]
                   textAlignment:NSTextAlignmentCenter
                   font:[UIFont dosisExtraBoldWithSize:30]];
  [self.view addSubview:self.labelTwo];
  [self addGlowToLabel:self.labelTwo];
  
  self.labelThree = [UILabel
                     PKMultiLineLabelWithCustomLineHeight:
                     3 withFrame:CGRectMake(CGRectGetWidth(self.view.bounds) / 2 -
                                            labelThreeWidth / 2,
                                            CGRectGetMaxY(self.labelTwo.frame) +
                                            marginFromCenter * 2,
                                            labelThreeWidth, labelThreeHeight)
                     text:@"Free Culinary School Classes from Around the World, Curated by Professional Chefs\n\n\nContact us: hello@letschef.com"
                     textColor:[UIColor whiteColor]
                     textAlignment:NSTextAlignmentCenter
                     font:[UIFont dosisMediumWithSize:18]];
  [self.view addSubview:self.labelThree];
}

- (void)addGlowToLabel:(UILabel *)label {
  label.layer.shadowColor = [UIColor whiteColor].CGColor;
  label.layer.shadowRadius = 6;
  label.layer.shadowOpacity = 0.3;
  label.layer.shadowOffset = CGSizeMake(0, 0);
}

- (void)loopVideo {
  [self.moviePlayer play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
