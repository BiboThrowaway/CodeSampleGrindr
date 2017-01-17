//
//  FAProductWebviewVC.m
//  BiboliveAcademy
//
//  Created by Bibo on 12/3/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAProductWebviewVC.h"
#import "FAProductVM.h"
#import <KINWebBrowserViewController.h>

@interface FAProductWebviewVC ()

@property (nonatomic, strong) FAProductVM *productVM;

@end

@implementation FAProductWebviewVC

-(instancetype)initWithProductVM:(FAProductVM *)productVM {
  self = [super init];
  if (self) {
    _productVM = productVM;
  }
  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  [self setupNavbar];
  [self setupWebview];
}

-(void)setupNavbar {
  self.navBar = [[FANavBar alloc]initWithBackBtnForWebview];
  [self.navBar setTitleWithString:_productVM.displayTitle];
  [self.view addSubview:self.navBar];
  
  [self.navBar.backBtn addTarget:self action:@selector(backBtnPressed) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setupWebview {
  _webBrowserNavigationController = [KINWebBrowserViewController navigationControllerWithWebBrowser];
  [self addChildViewController:_webBrowserNavigationController];
  _webBrowserNavigationController.view.frame = CGRectMake(0, 64, self.width, self.height-64);
  [self.view addSubview:_webBrowserNavigationController.view];
  _webBrowserNavigationController.navigationBar.hidden = YES;
  
  KINWebBrowserViewController *webBrowser = [_webBrowserNavigationController rootWebBrowser];
  webBrowser.showsURLInNavigationBar = NO;
  webBrowser.showsPageTitleInNavigationBar = NO;
  webBrowser.tintColor = [UIColor FAAlmostBlackColor];
  webBrowser.barTintColor = [UIColor whiteColor];
  [webBrowser loadURLString:_productVM.prductUrl];
}

-(void)backBtnPressed {
  [_webBrowserNavigationController.view removeFromSuperview];
  [_webBrowserNavigationController removeFromParentViewController];
  _webBrowserNavigationController = nil;
  
  [[FARouteManager shared] dismissWebview];
}

-(UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

@end
