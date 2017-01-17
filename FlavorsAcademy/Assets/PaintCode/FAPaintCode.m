//
//  FAPaintCode.m
//  FlavorsAcademy
//
//  Created by Alminty on 1/13/16.
//  Copyright (c) 2016 Alminty. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//

#import "FAPaintCode.h"


@implementation FAPaintCode

#pragma mark Cache

static UIImage* _imageOfBackBtn = nil;
static UIImage* _imageOfMenuBtn = nil;
static UIImage* _imageOfDownArrowBlack = nil;
static UIImage* _imageOfUpArrowBlack = nil;
static UIImage* _imageOfPlayBtnEmpty = nil;
static UIImage* _imageOfPlayBtnFilled = nil;
static UIImage* _imageOfCloseBtn = nil;
static UIImage* _imageOfStarEmpty = nil;
static UIImage* _imageOfStarFilled = nil;
static UIImage* _imageOfSearchBtn = nil;
static UIImage* _imageOfLocationBtn = nil;

#pragma mark Initialization

+ (void)initialize
{
}

#pragma mark Drawing Methods

+ (void)drawBackBtn
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];

    //// Rectangle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 41.14, 25.62);
    CGContextRotateCTM(context, 45 * M_PI / 180);

    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 6, 20) cornerRadius: 3];
    [color setFill];
    [rectanglePath fill];

    CGContextRestoreGState(context);


    //// Rectangle 2 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 27, 40.2);
    CGContextRotateCTM(context, -45 * M_PI / 180);

    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 6, 20) cornerRadius: 3];
    [color setFill];
    [rectangle2Path fill];

    CGContextRestoreGState(context);
}

+ (void)drawMenuBtn
{
    //// Color Declarations
    UIColor* color2 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];

    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(30, 28, 20, 6) cornerRadius: 3];
    [color2 setFill];
    [rectanglePath fill];


    //// Rectangle 2 Drawing
    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(30, 39, 20, 6) cornerRadius: 3];
    [color2 setFill];
    [rectangle2Path fill];


    //// Rectangle 3 Drawing
    UIBezierPath* rectangle3Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(30, 50, 20, 6) cornerRadius: 3];
    [color2 setFill];
    [rectangle3Path fill];
}

+ (void)drawDownArrowBlack
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Rectangle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 46.61, 34.15);
    CGContextRotateCTM(context, 45 * M_PI / 180);

    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 6, 15) cornerRadius: 3];
    [UIColor.blackColor setFill];
    [rectanglePath fill];

    CGContextRestoreGState(context);


    //// Rectangle 2 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 29, 38.2);
    CGContextRotateCTM(context, -45 * M_PI / 180);

    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 6, 15) cornerRadius: 3];
    [UIColor.blackColor setFill];
    [rectangle2Path fill];

    CGContextRestoreGState(context);
}

+ (void)drawUpArrowBlack
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Rectangle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 38.8, 32.96);
    CGContextRotateCTM(context, 45 * M_PI / 180);

    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 6, 15) cornerRadius: 3];
    [UIColor.blackColor setFill];
    [rectanglePath fill];

    CGContextRestoreGState(context);


    //// Rectangle 2 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 35, 37.2);
    CGContextRotateCTM(context, -45 * M_PI / 180);

    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 6, 15) cornerRadius: 3];
    [UIColor.blackColor setFill];
    [rectangle2Path fill];

    CGContextRestoreGState(context);
}

+ (void)drawPlayBtnEmpty
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* color3 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* color5 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* color8 = [UIColor colorWithRed: 0.852 green: 0.852 blue: 0.852 alpha: 1];

    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(20, 21, 40, 40)];
    [color8 setFill];
    [ovalPath fill];


    //// Polygon Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 26, 37);
    CGContextRotateCTM(context, -30 * M_PI / 180);

    UIBezierPath* polygonPath = [UIBezierPath bezierPath];
    [polygonPath moveToPoint: CGPointMake(10, 0)];
    [polygonPath addLineToPoint: CGPointMake(18.66, 15)];
    [polygonPath addLineToPoint: CGPointMake(1.34, 15)];
    [polygonPath closePath];
    [color5 setFill];
    [polygonPath fill];
    [color3 setStroke];
    polygonPath.lineWidth = 2;
    [polygonPath stroke];

    CGContextRestoreGState(context);
}

+ (void)drawPlayBtnFilled
{

    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(36, 32, 18, 17)];
    [UIColor.blackColor setStroke];
    ovalPath.lineWidth = 3;
    [ovalPath stroke];


    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: CGRectMake(34, 24, 16, 29)];
    [UIColor.whiteColor setFill];
    [rectanglePath fill];


    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(36.5, 33.5)];
    [bezierPath addLineToPoint: CGPointMake(27.5, 33.5)];
    [bezierPath addLineToPoint: CGPointMake(27.5, 47.5)];
    [bezierPath addLineToPoint: CGPointMake(36.5, 47.5)];
    [bezierPath addLineToPoint: CGPointMake(46.5, 54.5)];
    [bezierPath addLineToPoint: CGPointMake(46.5, 25.5)];
    [bezierPath addLineToPoint: CGPointMake(36.5, 33.5)];
    [bezierPath closePath];
    bezierPath.lineJoinStyle = kCGLineJoinRound;

    [UIColor.blackColor setStroke];
    bezierPath.lineWidth = 3;
    [bezierPath stroke];
}

+ (void)drawCloseBtn
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* color7 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];

    //// Rectangle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 48.8, 27.96);
    CGContextRotateCTM(context, 45 * M_PI / 180);

    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 6, 28) cornerRadius: 3];
    [color7 setFill];
    [rectanglePath fill];

    CGContextRestoreGState(context);


    //// Rectangle 2 Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 29, 32);
    CGContextRotateCTM(context, -45 * M_PI / 180);

    UIBezierPath* rectangle2Path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 6, 28) cornerRadius: 3];
    [color7 setFill];
    [rectangle2Path fill];

    CGContextRestoreGState(context);
}

+ (void)drawStarEmpty
{
    //// Color Declarations
    UIColor* color9 = [UIColor colorWithRed: 0.527 green: 0.527 blue: 0.527 alpha: 1];

    //// Star Drawing
    UIBezierPath* starPath = [UIBezierPath bezierPath];
    [starPath moveToPoint: CGPointMake(40, 25)];
    [starPath addLineToPoint: CGPointMake(45.73, 32.11)];
    [starPath addLineToPoint: CGPointMake(54.27, 35.36)];
    [starPath addLineToPoint: CGPointMake(49.27, 43.01)];
    [starPath addLineToPoint: CGPointMake(48.82, 52.14)];
    [starPath addLineToPoint: CGPointMake(40, 49.75)];
    [starPath addLineToPoint: CGPointMake(31.18, 52.14)];
    [starPath addLineToPoint: CGPointMake(30.73, 43.01)];
    [starPath addLineToPoint: CGPointMake(25.73, 35.36)];
    [starPath addLineToPoint: CGPointMake(34.27, 32.11)];
    [starPath closePath];
    [color9 setStroke];
    starPath.lineWidth = 1;
    [starPath stroke];
}

+ (void)drawStarFilled
{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* gradientColor = [UIColor colorWithRed: 1 green: 0.189 blue: 0.189 alpha: 1];
    UIColor* gradientColor2 = [UIColor colorWithRed: 1 green: 0.336 blue: 0.336 alpha: 1];

    //// Gradient Declarations
    CGFloat gradientLocations[] = {0, 0.7, 1};
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)@[(id)gradientColor2.CGColor, (id)[gradientColor2 blendedColorWithFraction: 0.5 ofColor: gradientColor].CGColor, (id)gradientColor.CGColor], gradientLocations);

    //// Star 2 Drawing
    UIBezierPath* star2Path = [UIBezierPath bezierPath];
    [star2Path moveToPoint: CGPointMake(40, 25)];
    [star2Path addLineToPoint: CGPointMake(45.73, 32.11)];
    [star2Path addLineToPoint: CGPointMake(54.27, 35.36)];
    [star2Path addLineToPoint: CGPointMake(49.27, 43.01)];
    [star2Path addLineToPoint: CGPointMake(48.82, 52.14)];
    [star2Path addLineToPoint: CGPointMake(40, 49.75)];
    [star2Path addLineToPoint: CGPointMake(31.18, 52.14)];
    [star2Path addLineToPoint: CGPointMake(30.73, 43.01)];
    [star2Path addLineToPoint: CGPointMake(25.73, 35.36)];
    [star2Path addLineToPoint: CGPointMake(34.27, 32.11)];
    [star2Path closePath];
    CGContextSaveGState(context);
    [star2Path addClip];
    CGContextDrawLinearGradient(context, gradient, CGPointMake(25.73, 38.57), CGPointMake(54.27, 38.57), 0);
    CGContextRestoreGState(context);


    //// Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

+ (void)drawSearchBtn
{
    //// General Declarations
    CGContextRef context = UIGraphicsGetCurrentContext();

    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];
    UIColor* color2 = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];

    //// Oval Drawing
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(28, 29, 15, 15)];
    [color setStroke];
    ovalPath.lineWidth = 5;
    [ovalPath stroke];


    //// Rectangle Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, 47, 44);
    CGContextRotateCTM(context, 45 * M_PI / 180);

    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, 12.02, 6) cornerRadius: 3];
    [color2 setFill];
    [rectanglePath fill];

    CGContextRestoreGState(context);
}

+ (void)drawLocationBtn
{
    //// Color Declarations
    UIColor* fillColor = [UIColor colorWithRed: 1 green: 1 blue: 1 alpha: 1];

    //// noun_281085_cc.svg Group
    {
        //// Group 2
        {
            //// Oval 2 Drawing
            UIBezierPath* oval2Path = [UIBezierPath bezierPathWithOvalInRect: CGRectMake(38.3, 32.5, 6.4, 5.4)];
            [fillColor setFill];
            [oval2Path fill];


            //// Bezier Drawing
            UIBezierPath* bezierPath = [UIBezierPath bezierPath];
            [bezierPath moveToPoint: CGPointMake(41.5, 24.5)];
            [bezierPath addCurveToPoint: CGPointMake(30.8, 36.24) controlPoint1: CGPointMake(35.59, 24.5) controlPoint2: CGPointMake(30.8, 29.8)];
            [bezierPath addCurveToPoint: CGPointMake(40.63, 52.14) controlPoint1: CGPointMake(30.8, 42.49) controlPoint2: CGPointMake(40.26, 51.73)];
            [bezierPath addCurveToPoint: CGPointMake(41.5, 52.5) controlPoint1: CGPointMake(40.88, 52.38) controlPoint2: CGPointMake(41.19, 52.5)];
            [bezierPath addCurveToPoint: CGPointMake(42.37, 52.14) controlPoint1: CGPointMake(41.81, 52.5) controlPoint2: CGPointMake(42.12, 52.38)];
            [bezierPath addCurveToPoint: CGPointMake(52.2, 36.24) controlPoint1: CGPointMake(42.74, 51.73) controlPoint2: CGPointMake(52.2, 42.49)];
            [bezierPath addCurveToPoint: CGPointMake(41.5, 24.5) controlPoint1: CGPointMake(52.2, 29.8) controlPoint2: CGPointMake(47.41, 24.5)];
            [bezierPath closePath];
            [bezierPath moveToPoint: CGPointMake(41.5, 40.17)];
            [bezierPath addCurveToPoint: CGPointMake(36.15, 35.04) controlPoint1: CGPointMake(38.51, 40.17) controlPoint2: CGPointMake(36.15, 37.84)];
            [bezierPath addCurveToPoint: CGPointMake(41.5, 29.92) controlPoint1: CGPointMake(36.15, 32.24) controlPoint2: CGPointMake(38.58, 29.92)];
            [bezierPath addCurveToPoint: CGPointMake(46.85, 35.04) controlPoint1: CGPointMake(44.42, 29.92) controlPoint2: CGPointMake(46.85, 32.24)];
            [bezierPath addCurveToPoint: CGPointMake(41.5, 40.17) controlPoint1: CGPointMake(46.85, 37.84) controlPoint2: CGPointMake(44.49, 40.17)];
            [bezierPath closePath];
            bezierPath.miterLimit = 4;

            [fillColor setFill];
            [bezierPath fill];
        }
    }
}

+ (void)drawEightsideLoading
{

    //// Polygon Drawing
    UIBezierPath* polygonPath = [UIBezierPath bezierPath];
    [polygonPath moveToPoint: CGPointMake(15.5, 0)];
    [polygonPath addLineToPoint: CGPointMake(26.46, 4.39)];
    [polygonPath addLineToPoint: CGPointMake(31, 15)];
    [polygonPath addLineToPoint: CGPointMake(26.46, 25.61)];
    [polygonPath addLineToPoint: CGPointMake(15.5, 30)];
    [polygonPath addLineToPoint: CGPointMake(4.54, 25.61)];
    [polygonPath addLineToPoint: CGPointMake(0, 15)];
    [polygonPath addLineToPoint: CGPointMake(4.54, 4.39)];
    [polygonPath closePath];
    [UIColor.blackColor setStroke];
    polygonPath.lineWidth = 1;
    [polygonPath stroke];
}

#pragma mark Generated Images

+ (UIImage*)imageOfBackBtn
{
    if (_imageOfBackBtn)
        return _imageOfBackBtn;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 0.0f);
    [FAPaintCode drawBackBtn];

    _imageOfBackBtn = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfBackBtn;
}

+ (UIImage*)imageOfMenuBtn
{
    if (_imageOfMenuBtn)
        return _imageOfMenuBtn;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 0.0f);
    [FAPaintCode drawMenuBtn];

    _imageOfMenuBtn = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfMenuBtn;
}

+ (UIImage*)imageOfDownArrowBlack
{
    if (_imageOfDownArrowBlack)
        return _imageOfDownArrowBlack;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 0.0f);
    [FAPaintCode drawDownArrowBlack];

    _imageOfDownArrowBlack = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfDownArrowBlack;
}

+ (UIImage*)imageOfUpArrowBlack
{
    if (_imageOfUpArrowBlack)
        return _imageOfUpArrowBlack;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 0.0f);
    [FAPaintCode drawUpArrowBlack];

    _imageOfUpArrowBlack = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfUpArrowBlack;
}

+ (UIImage*)imageOfPlayBtnEmpty
{
    if (_imageOfPlayBtnEmpty)
        return _imageOfPlayBtnEmpty;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 0.0f);
    [FAPaintCode drawPlayBtnEmpty];

    _imageOfPlayBtnEmpty = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfPlayBtnEmpty;
}

+ (UIImage*)imageOfPlayBtnFilled
{
    if (_imageOfPlayBtnFilled)
        return _imageOfPlayBtnFilled;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 0.0f);
    [FAPaintCode drawPlayBtnFilled];

    _imageOfPlayBtnFilled = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfPlayBtnFilled;
}

+ (UIImage*)imageOfCloseBtn
{
    if (_imageOfCloseBtn)
        return _imageOfCloseBtn;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 0.0f);
    [FAPaintCode drawCloseBtn];

    _imageOfCloseBtn = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfCloseBtn;
}

+ (UIImage*)imageOfStarEmpty
{
    if (_imageOfStarEmpty)
        return _imageOfStarEmpty;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 0.0f);
    [FAPaintCode drawStarEmpty];

    _imageOfStarEmpty = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfStarEmpty;
}

+ (UIImage*)imageOfStarFilled
{
    if (_imageOfStarFilled)
        return _imageOfStarFilled;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 0.0f);
    [FAPaintCode drawStarFilled];

    _imageOfStarFilled = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfStarFilled;
}

+ (UIImage*)imageOfSearchBtn
{
    if (_imageOfSearchBtn)
        return _imageOfSearchBtn;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 0.0f);
    [FAPaintCode drawSearchBtn];

    _imageOfSearchBtn = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfSearchBtn;
}

+ (UIImage*)imageOfLocationBtn
{
    if (_imageOfLocationBtn)
        return _imageOfLocationBtn;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(80, 80), NO, 0.0f);
    [FAPaintCode drawLocationBtn];

    _imageOfLocationBtn = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return _imageOfLocationBtn;
}

#pragma mark Customization Infrastructure

- (void)setBackBtnTargets: (NSArray*)backBtnTargets
{
    _backBtnTargets = backBtnTargets;

    for (id target in self.backBtnTargets)
        [target performSelector: @selector(setImage:) withObject: FAPaintCode.imageOfBackBtn];
}

- (void)setMenuBtnTargets: (NSArray*)menuBtnTargets
{
    _menuBtnTargets = menuBtnTargets;

    for (id target in self.menuBtnTargets)
        [target performSelector: @selector(setImage:) withObject: FAPaintCode.imageOfMenuBtn];
}

- (void)setDownArrowBlackTargets: (NSArray*)downArrowBlackTargets
{
    _downArrowBlackTargets = downArrowBlackTargets;

    for (id target in self.downArrowBlackTargets)
        [target performSelector: @selector(setImage:) withObject: FAPaintCode.imageOfDownArrowBlack];
}

- (void)setUpArrowBlackTargets: (NSArray*)upArrowBlackTargets
{
    _upArrowBlackTargets = upArrowBlackTargets;

    for (id target in self.upArrowBlackTargets)
        [target performSelector: @selector(setImage:) withObject: FAPaintCode.imageOfUpArrowBlack];
}

- (void)setPlayBtnEmptyTargets: (NSArray*)playBtnEmptyTargets
{
    _playBtnEmptyTargets = playBtnEmptyTargets;

    for (id target in self.playBtnEmptyTargets)
        [target performSelector: @selector(setImage:) withObject: FAPaintCode.imageOfPlayBtnEmpty];
}

- (void)setPlayBtnFilledTargets: (NSArray*)playBtnFilledTargets
{
    _playBtnFilledTargets = playBtnFilledTargets;

    for (id target in self.playBtnFilledTargets)
        [target performSelector: @selector(setImage:) withObject: FAPaintCode.imageOfPlayBtnFilled];
}

- (void)setCloseBtnTargets: (NSArray*)closeBtnTargets
{
    _closeBtnTargets = closeBtnTargets;

    for (id target in self.closeBtnTargets)
        [target performSelector: @selector(setImage:) withObject: FAPaintCode.imageOfCloseBtn];
}

- (void)setStarEmptyTargets: (NSArray*)starEmptyTargets
{
    _starEmptyTargets = starEmptyTargets;

    for (id target in self.starEmptyTargets)
        [target performSelector: @selector(setImage:) withObject: FAPaintCode.imageOfStarEmpty];
}

- (void)setStarFilledTargets: (NSArray*)starFilledTargets
{
    _starFilledTargets = starFilledTargets;

    for (id target in self.starFilledTargets)
        [target performSelector: @selector(setImage:) withObject: FAPaintCode.imageOfStarFilled];
}

- (void)setSearchBtnTargets: (NSArray*)searchBtnTargets
{
    _searchBtnTargets = searchBtnTargets;

    for (id target in self.searchBtnTargets)
        [target performSelector: @selector(setImage:) withObject: FAPaintCode.imageOfSearchBtn];
}

- (void)setLocationBtnTargets: (NSArray*)locationBtnTargets
{
    _locationBtnTargets = locationBtnTargets;

    for (id target in self.locationBtnTargets)
        [target performSelector: @selector(setImage:) withObject: FAPaintCode.imageOfLocationBtn];
}


@end



@implementation UIColor (PaintCodeAdditions)

- (UIColor*)blendedColorWithFraction: (CGFloat)fraction ofColor: (UIColor*)color2
{
    UIColor* color1 = self;

    CGFloat r1 = 0, g1 = 0, b1 = 0, a1 = 0;
    CGFloat r2 = 0, g2 = 0, b2 = 0, a2 = 0;


    [color1 getRed: &r1 green: &g1 blue: &b1 alpha: &a1];
    [color2 getRed: &r2 green: &g2 blue: &b2 alpha: &a2];

    CGFloat r = r1 * (1 - fraction) + r2 * fraction;
    CGFloat g = g1 * (1 - fraction) + g2 * fraction;
    CGFloat b = b1 * (1 - fraction) + b2 * fraction;
    CGFloat a = a1 * (1 - fraction) + a2 * fraction;

    return [UIColor colorWithRed: r green: g blue: b alpha: a];
}

@end
