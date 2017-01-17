//
//  FARootVC.h
//  FlavorsAcademy
//
//  Created by Bibo on 11/13/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAToolBarView.h"

@interface FARootVC : UIViewController

@property (nonatomic, strong) FAToolBarView *toolBar;

-(void)showMenuView;
-(void)closeMenuView;

-(void)showSearchView;
-(void)closeSearchView:(BOOL)animated;

@end
