//
//  FAVideoVM.h
//  FlavorsAcademy
//
//  Created by Bibo on 11/15/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FAVideoVM : NSObject

@property (nonatomic, strong) NSArray *childrenArray;
@property (nonatomic, strong) NSString *displayTitle;
@property (nonatomic, strong) NSString *videoToPlayImmediatelyId;
@property (nonatomic, strong) NSString *videoCurrentlyPlayingId;
@property (nonatomic, strong) NSString *vmLookupKey;
@property (nonatomic, readwrite) int sectionCurrentlyExpaned;
@property (nonatomic, readwrite) int numberOfChildrenLevels;
@property (nonatomic, readwrite) BOOL isRootVC;
@property (nonatomic, readwrite) BOOL isFavorite;
@property (nonatomic, copy) NSString *searchString;
@end
