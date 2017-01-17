//
//  AppDelegate.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/13/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "AppDelegate.h"
#import "FARouteManager.h"
#import "FAThirdPartyManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  
  [FAThirdPartyManager shared];

  self.window = [PKRoutingManager initializeRootViewController: [[FARouteManager shared] rootViewController]];
  self.window.backgroundColor = [UIColor FAAlmostBlackColor];

  [[FARequestManager shared] getHomePageWithCallback:^(id responseObject, NSError *error) {
        if (error) {
          NSLog(@"%@", error.localizedDescription);
        } else {
          [FAViewModelsManager shared].homeVM = [[FAHomeVM alloc] initWithHomeAPIResponse:responseObject];
        }
      }];

  return [[FBSDKApplicationDelegate sharedInstance] application:application
                                  didFinishLaunchingWithOptions:launchOptions];
}

- (void)checkAppSettings {
  [[FARequestManager shared]
      getHomePageWithCallback:^(id responseObject, NSError *error) {
        if (error) {
          NSLog(@"%@", error.localizedDescription);
        } else {
          [self checkForceUpdateWithResponse:[FAHomeModel modelObjectWithDictionary:responseObject].settings];
        }
      }];
}

- (void)checkForceUpdateWithResponse:(FAHomeSettings *)settings {
  NSString *versionString = [[[NSBundle mainBundle] infoDictionary]
      objectForKey:@"CFBundleShortVersionString"];
  CGFloat currentVersion = [versionString floatValue];
  if (currentVersion + 0.01 < settings.iosMinVersion) {
    UIAlertView *forceUpdateAlert =
        [[UIAlertView alloc] initWithTitle:@"Update"
                                   message:settings.forceupdateMessage
                                  delegate:self
                         cancelButtonTitle:@"Update"
                         otherButtonTitles:nil];
    forceUpdateAlert.tag = 1;
    [forceUpdateAlert show];
  }
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
  [FBSDKAppEvents activateApp];

  [self checkAppSettings];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
  return
      [[FBSDKApplicationDelegate sharedInstance] application:application
                                                     openURL:url
                                           sourceApplication:sourceApplication
                                                  annotation:annotation];
}

- (void)alertView:(UIAlertView *)alertView
    clickedButtonAtIndex:(NSInteger)buttonIndex {
  NSString *iTunesLink =
      @"itms://itunes.apple.com/us/app/apple-store/id1068319030?mt=8";
  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
}
@end
