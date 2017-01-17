//
//  FARestaurantCollectionViewCell.h
//  BiboliveAcademy
//
//  Created by Bibo on 1/12/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FARestaurantCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *locationLabel;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *labelBackground;

@end
