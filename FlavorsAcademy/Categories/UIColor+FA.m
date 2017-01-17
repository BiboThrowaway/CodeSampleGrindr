//
//  UIColor+FA.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/13/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "UIColor+FA.h"

@implementation UIColor (FA)

+(UIColor *)FAAlmostBlackColor {
  return [UIColor colorFromHexString:@"#323232"];
}

+(UIColor *)FAYellowColor  {
  return [UIColor colorFromHexString:@"#FFCB65"];
}

+(UIColor *)FADarkYellowColor  {
  return [UIColor colorFromHexString:@"#FBAA0C"];
}

+(UIColor *)FASuperLightGray {
  return [UIColor colorFromHexString:@"#FAFAFA"];
}

+(UIColor *)FALightGray {
  return [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
}

+(UIColor *)FAOrangeColor {
  return [UIColor colorFromHexString:@"#FF4400"];
}

+(UIColor *)FAGreenColor {
  return [UIColor colorFromHexString:@"#3E9C12"];
}

@end
