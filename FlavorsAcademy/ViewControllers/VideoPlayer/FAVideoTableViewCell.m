//
//  FAVideoTableViewCell.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/16/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAVideoTableViewCell.h"

@implementation FAVideoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    self.videoIndicatorImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12, 0, 40, 40)];
    [self addSubview:self.videoIndicatorImageView];
    
    self.videoTitleLabel = [UILabel PKMultiLineLabelWithFrame:CGRectMake(40, 0, [PKUIManager deviceWidth]-80, 40) text:@"" textColor:[UIColor FAAlmostBlackColor] textAlignment:NSTextAlignmentLeft font:[UIFont dosisMediumWithSize:14]];
    [self addSubview:self.videoTitleLabel];
    
    self.favoriteBtn = [UIButton PKimageButtonWithFrame:CGRectMake([PKUIManager deviceWidth]-40, 0, 40, 40) image:nil];
    [self addSubview:self.favoriteBtn];
  }
  return self;
}

@end
