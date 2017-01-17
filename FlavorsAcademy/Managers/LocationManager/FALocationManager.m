//
//  FALocationManager.m
//  BiboliveAcademy
//
//  Created by Bibo on 1/24/16.
//  Copyright © 2016 Alminty. All rights reserved.
//

#import "FALocationManager.h"

@implementation FALocationManager

+ (FALocationManager *)shared {
  static FALocationManager *shared;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    shared = [[[self class] alloc] init];
  });
  return shared;
}

- (instancetype)init
{
  self = [super init];
  if (self) {

  }
  return self;
}

- (BOOL)hasUserLatestLocation {
  return self.userLocation != nil;
}

-(void)getLocationManagerPermission {
  
  if (!self.locationManager) {
    self.locationManager = [CLLocationManager new];
    [self.locationManager requestWhenInUseAuthorization];
    self.locationManager.delegate = self;
  }
  [self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
  CLLocation *lastLocation = [locations lastObject];
  if (lastLocation) {
    PFGeoPoint *geopoint = [PFGeoPoint geoPointWithLocation:lastLocation];
    NSLog(@"last location %f %f", geopoint.latitude, geopoint.longitude);
    self.userLocation = lastLocation;
    [self.locationManager stopUpdatingLocation];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hasUserLocation" object:nil];
  }
}

@end
