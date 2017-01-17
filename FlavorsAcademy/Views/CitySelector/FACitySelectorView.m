//
//  FACitySelectorView.m
//  BiboliveAcademy
//
//  Created by Bibo on 1/13/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "FACitySelectorView.h"

@implementation FACitySelectorView

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurredView = [[UIVisualEffectView alloc]initWithEffect:effect];
    blurredView.frame = self.bounds;
    [self addSubview:blurredView];
    
    self.contentView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width/1.5, self.frame.size.height)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentView];
  }
  return self;
}

@end
