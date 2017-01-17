//
//  FAShoppingCollectionHeader.m
//  BiboliveAcademy
//
//  Created by Bibo on 12/3/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FAShoppingCollectionHeader.h"

@implementation FAShoppingCollectionHeader

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.titleLabel = [UILabel PKMultiLineLabelWithCustomLineHeight:5 withFrame:CGRectMake(20, 0, frame.size.width-40, frame.size.height) text:@"" textColor:[UIColor FAAlmostBlackColor] textAlignment:NSTextAlignmentCenter font:[UIFont dosisMediumWithSize:14]];
    [self addSubview:self.titleLabel];
  }
  return self;
}

@end
