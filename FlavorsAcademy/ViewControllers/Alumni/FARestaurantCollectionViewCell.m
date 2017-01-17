//
//  FARestaurantCollectionViewCell.m
//  BiboliveAcademy
//
//  Created by Bibo on 1/12/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "FARestaurantCollectionViewCell.h"

@implementation FARestaurantCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    [self addSubview:_imageView];
    
    UIView *imageOverlay = [[UIView alloc]initWithFrame:self.bounds];
    imageOverlay.backgroundColor = [UIColor colorWithRed:62.0/255.0 green:39.0/255.0 blue:19.0/255.0 alpha:0.4];
    [self addSubview:imageOverlay];
    
    _labelBackground = [[UIView alloc]initWithFrame:CGRectZero];
    _labelBackground.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    [self addSubview:_labelBackground];
    
    _titleLabel = [UILabel PKMultiLineLabelWithFrame:CGRectZero text:@"" textColor:[UIColor FAYellowColor] textAlignment:NSTextAlignmentCenter font:[UIFont dosisBoldWithSize:30]];
    [self addSubview:_titleLabel];
    
    _descriptionLabel = [UILabel PKMultiLineLabelWithFrame:CGRectMake(30, frame.size.height-80, frame.size.width-60, 80) text:@"" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter font:[UIFont dosisLightWithSize:14]];
    [self addSubview:_descriptionLabel];
    
    _locationLabel = [UILabel PKMultiLineLabelWithFrame:CGRectZero text:@"" textColor:[UIColor FAYellowColor] textAlignment:NSTextAlignmentCenter font:[UIFont dosisLightWithSize:14]];
    [self addSubview:_locationLabel];
  }
  return self;
}

@end
