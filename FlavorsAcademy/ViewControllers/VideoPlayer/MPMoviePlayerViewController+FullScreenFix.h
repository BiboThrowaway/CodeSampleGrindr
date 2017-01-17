//
//  MPMoviePlayerViewController+FullScreenFix.h
//  BiboliveAcademy
//
//  Created by Bibo on 12/10/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

@interface MPMoviePlayerViewController (FullScreenFix)

- (void)viewDidDisappear:(BOOL)animated;
- (void)viewWillDisappear:(BOOL)animated;

@end
