//
//  FAHomeCategoryView.h
//  FlavorsAcademy
//
//  Created by Bibo on 11/14/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAHomeCategoryView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

-(instancetype)initWithFrame:(CGRect)frame dataModel:(FAHomeHomePage *)dataModel;

@end
