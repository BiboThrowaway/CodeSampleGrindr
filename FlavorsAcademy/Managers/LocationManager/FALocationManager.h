//
//  FALocationManager.h
//  BiboliveAcademy
//
//  Created by Bibo on 1/24/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface FALocationManager : NSObject <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *userLocation;

+ (FALocationManager *)shared;

- (BOOL)hasUserLatestLocation;

-(void)getLocationManagerPermission;

@end
