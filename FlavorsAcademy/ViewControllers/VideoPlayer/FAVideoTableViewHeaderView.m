//
//  FAVideoTableViewHeaderView.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/16/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAVideoTableViewHeaderView.h"

@implementation FAVideoTableViewHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithReuseIdentifier:reuseIdentifier];
  if (self) {
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.textHeaderLabel = [UILabel PKMultiLineLabelWithFrame:CGRectMake(15, 0, [PKUIManager deviceWidth]-15, 40) text:@"" textColor:[UIColor FAAlmostBlackColor] textAlignment:NSTextAlignmentLeft font:[UIFont dosisExtraBoldWithSize:14]];
    [self.contentView addSubview:self.textHeaderLabel];
    
    UIView *underline = [[UIView alloc]initWithFrame:CGRectMake(0, 39, [PKUIManager deviceWidth], 1)];
    underline.backgroundColor = [UIColor FASuperLightGray];
    [self addSubview:underline];
//    self.expandMarkImageView = [[UIImageView alloc]initWithFrame:CGRectMake([PKUIManager deviceWidth]-40, 0, 40, 40)];
//    [self.contentView addSubview:self.expandMarkImageView];
  }
  return self;
}

@end
