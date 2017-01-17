//
//  FALoggedOutLandingVC.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/13/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FALoggedOutLandingVC.h"
#import <MediaPlayer/MediaPlayer.h>

@interface FALoggedOutLandingVC ()

@property(nonatomic, strong) UILabel *labelOne;
@property(nonatomic, strong) UILabel *labelTwo;
@property(nonatomic, strong) UILabel *labelThree;

@property(nonatomic, strong) UIButton *btnOne;
@property(nonatomic, strong) UIButton *btnTwo;
@property(nonatomic, strong) UIButton *btnThree;

@property(nonatomic, strong) MPMoviePlayerController *moviePlayer;

@end

@implementation FALoggedOutLandingVC

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  self.view.backgroundColor = [UIColor FAAlmostBlackColor];
  self.navBar.hidden = YES;
  [self setupVideosView];
  [self setupLabels];
  [self setupBtns];
}

-(void)viewWillAppear:(BOOL)animated {
  [self.moviePlayer play];
}

- (void)viewDidAppear:(BOOL)animated {
  [self performSelector:@selector(animateLabelsToShowBtns)
             withObject:nil
             afterDelay:1];
}

- (void)setupVideosView {
  NSURL *videoURL =
      [[NSBundle mainBundle] URLForResource:@"bamboo" withExtension:@"mp4"];
  self.moviePlayer =
      [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
  self.moviePlayer.controlStyle = MPMovieControlStyleNone;
  self.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
  self.moviePlayer.view.frame = self.view.frame;
  [self.view insertSubview:self.moviePlayer.view atIndex:0];

  UIView *blackView = [[UIView alloc] initWithFrame:self.view.bounds];
  blackView.backgroundColor =
      [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8];
  [self.view addSubview:blackView];

  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(loopVideo)
             name:MPMoviePlayerPlaybackDidFinishNotification
           object:nil];

  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(loopVideo)
             name:UIApplicationWillEnterForegroundNotification
           object:nil];

  [self.moviePlayer play];
}

- (void)loopVideo {
  [self.moviePlayer play];
}

- (void)viewDidDisappear:(BOOL)animated {
  [self.moviePlayer pause];
}

- (void)setupLabels {
  CGFloat labelOneHeight = 50;
  CGFloat labelTwoHeight = 40;
  CGFloat marginFromCenter = 40;
  CGFloat labelThreeHeight = 100;
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
                                      text:@"Free Culinary School Classes from Around the World, Curated by Professional Chefs"
                                 textColor:[UIColor whiteColor]
                             textAlignment:NSTextAlignmentCenter
                                      font:[UIFont dosisMediumWithSize:18]];
  [self.view addSubview:self.labelThree];
  
  [PKUIManager applyInterpolatingMotionEffectToView:self.labelOne withParallaxLimit:15];
}

- (void)addGlowToLabel:(UILabel *)label {
  label.layer.shadowColor = [UIColor whiteColor].CGColor;
  label.layer.shadowRadius = 6;
  label.layer.shadowOpacity = 0.3;
  label.layer.shadowOffset = CGSizeMake(0, 0);
}

- (void)animateLabelsToShowBtns {
  [UIView animateWithDuration:1
      delay:0
      usingSpringWithDamping:0.8
      initialSpringVelocity:0.1
      options:UIViewAnimationOptionCurveEaseIn
      animations:^{

        self.labelOne.frame = CGRectMake(CGRectGetMinX(self.labelOne.frame),
                                         CGRectGetHeight(self.view.bounds) / 9,
                                         CGRectGetWidth(self.labelOne.bounds),
                                         CGRectGetHeight(self.labelOne.bounds));
        self.labelTwo.frame = CGRectMake(CGRectGetMinX(self.labelTwo.frame),
                                         CGRectGetMaxY(self.labelOne.frame),
                                         CGRectGetWidth(self.labelTwo.bounds),
                                         CGRectGetHeight(self.labelTwo.bounds));
        self.labelThree.frame =
            CGRectMake(CGRectGetMinX(self.labelThree.frame),
                       CGRectGetMaxY(self.labelTwo.frame) + 20,
                       CGRectGetWidth(self.labelThree.bounds),
                       CGRectGetHeight(self.labelThree.bounds));

      }
      completion:^(BOOL finished) {

        [UIView animateWithDuration:0.5
                         animations:^{
                           self.btnOne.alpha = 1;
                         }];

        [UIView animateWithDuration:0.5
            delay:0.4
            options:UIViewAnimationOptionCurveEaseIn
            animations:^{
              self.btnTwo.alpha = 1;
            }
            completion:^(BOOL finished){

            }];

        [UIView animateWithDuration:0.5
            delay:0.8
            options:UIViewAnimationOptionCurveEaseIn
            animations:^{
              self.btnThree.alpha = 1;
            }
            completion:^(BOOL finished){

            }];
      }];
}

- (void)setupBtns {

  CGFloat btnHeight = CGRectGetHeight(self.view.bounds) / 10;

  self.btnOne = [UIButton
      PKtextButtonWithFrame:CGRectMake(
                                0, CGRectGetHeight(self.view.bounds) / 2 + 80,
                                CGRectGetWidth(self.view.bounds), btnHeight)
                      title:@"Sign up"
                       font:[UIFont dosisRegularWithSize:20]
                  tintColor:[UIColor whiteColor]];
  self.btnOne.alpha = 0;
  [self.view addSubview:self.btnOne];
  [self.btnOne addTarget:self
                  action:@selector(btnOnePressed)
        forControlEvents:UIControlEventTouchUpInside];

  self.btnTwo = [UIButton
      PKtextButtonWithFrame:CGRectMake(0, CGRectGetMaxY(self.btnOne.frame),
                                       CGRectGetWidth(self.view.bounds),
                                       btnHeight)
                      title:@"Login"
                       font:[UIFont dosisRegularWithSize:20]
                  tintColor:[UIColor whiteColor]];
  self.btnTwo.alpha = 0;
  [self.view addSubview:self.btnTwo];
  [self.btnTwo addTarget:self
                  action:@selector(btnTwoPressed)
        forControlEvents:UIControlEventTouchUpInside];

  self.btnThree = [UIButton
      PKtextButtonWithFrame:CGRectMake(
                                CGRectGetWidth(self.view.bounds) * 2 / 3,
                                CGRectGetHeight(self.view.bounds) - btnHeight,
                                CGRectGetWidth(self.view.bounds) / 3, btnHeight)
                      title:@"Sneak Peak >"
                       font:[UIFont dosisRegularWithSize:14]
                  tintColor:[UIColor whiteColor]];
  self.btnThree.alpha = 0;
  [self.view addSubview:self.btnThree];
  [self.btnThree addTarget:self
                    action:@selector(btnThreePressed)
          forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnOnePressed {
  [[FARouteManager shared] goToRegistrationSignup];
}

- (void)btnTwoPressed {
  [[FARouteManager shared] goToRegistrationLogin];
}

- (void)btnThreePressed {
  [[FARouteManager shared] goToSneakPeakLandingVC];
}

@end
