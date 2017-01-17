//
//  FAProductWebviewVC.h
//  BiboliveAcademy
//
//  Created by Bibo on 12/3/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAProductWebviewVC : FABaseNavVC

@property (nonatomic, strong) UINavigationController *webBrowserNavigationController;

-(instancetype)initWithProductVM:(FAProductVM *)productVM;

@end
