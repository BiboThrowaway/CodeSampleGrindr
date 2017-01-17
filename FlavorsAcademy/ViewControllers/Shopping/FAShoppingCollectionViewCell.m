//
//  FAShoppingCollectionViewCell.m
//  BiboliveAcademy
//
//  Created by Bibo on 12/3/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAShoppingCollectionViewCell.h"

@implementation FAShoppingCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-60)];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.clipsToBounds = YES;
    [self addSubview:_imageView];
    
    _titleLabel = [UILabel PKMultiLineLabelWithFrame:CGRectMake(5, frame.size.height-60, frame.size.width-10, 60) text:@"Icosahedron geometric pendant, Polished Brass" textColor:[UIColor FAAlmostBlackColor] textAlignment:NSTextAlignmentCenter font:[UIFont dosisRegularWithSize:14]];
    [self addSubview:_titleLabel];
  }
  return self;
}

@end
