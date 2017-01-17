//
//  FAChangeProfileVC.h
//  FlavorsAcademy
//
//  Created by Bibo on 11/17/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FABaseNavVC.h"

@interface FAChangeProfileVC : FABaseNavVC

-(instancetype)initForEmail;
-(instancetype)initForPassword;

@property (nonatomic, strong) UITextField *textFieldOne;
@property (nonatomic, strong) UITextField *textFieldTwo;

@property (nonatomic, strong) UIButton *actionBtn;

@end
