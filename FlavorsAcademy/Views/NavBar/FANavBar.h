//
//  FANavBar.h
//  FlavorsAcademy
//
//  Created by Bibo on 11/14/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FANavBar : UIView

@property (nonatomic, strong) UIButton *menuBtn;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIButton *searchBtn;
@property (nonatomic, strong) UIButton *centerBtn;
@property (nonatomic, strong) UIButton *rightBtnOne;
@property (nonatomic, strong) UIButton *rightBtnTwo;

-(instancetype)initWithBackBtnOnly;
-(instancetype)initWithBackBtnForWebview;
-(instancetype)initWithMenuBtnOnly;
-(instancetype)initWithMenuAndSearchBtns;
-(instancetype)initWithBackAndMenuBtns;
-(instancetype)initForRestaurantPage;

-(void)setTitleWithString:(NSString *)title;

@end