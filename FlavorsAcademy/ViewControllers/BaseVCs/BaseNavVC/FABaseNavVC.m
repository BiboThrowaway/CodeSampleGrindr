//
//  FABaseNavVC.m
//  FlavorsAcademy
//
//  Created by Bibo on 11/13/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import "FABaseNavVC.h"

@interface FABaseNavVC ()

@end

@implementation FABaseNavVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  self.view.backgroundColor = [UIColor FASuperLightGray];
  
//  [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//  self.navigationController.navigationBar.shadowImage = [UIImage new];
//  self.navigationController.navigationBar.translucent = YES;
//  self.navigationController.view.backgroundColor = [UIColor clearColor];
//  self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
  self.navigationController.navigationBar.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
