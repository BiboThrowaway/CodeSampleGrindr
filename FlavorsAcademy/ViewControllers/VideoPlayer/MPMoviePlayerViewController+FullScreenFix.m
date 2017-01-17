//
//  MPMoviePlayerViewController+FullScreenFix.m
//  BiboliveAcademy
//
//  Created by Bibo on 12/10/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "MPMoviePlayerViewController+FullScreenFix.h"

@implementation MPMoviePlayerViewController (FullScreenFix)


-(void)viewDidDisappear:(BOOL)animated
{
  [super viewDidDisappear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
  [super viewWillDisappear:animated];
}

@end
