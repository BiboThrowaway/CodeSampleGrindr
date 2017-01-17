//
//  FARequestManager.h
//  FlavorsAcademy
//
//  Created by Bibo on 11/14/15.
//  Copyright © 2015 Alminty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FARequestManager : NSObject

#pragma mark Home

+ (FARequestManager *)shared;

- (void)getHomePageWithCallback:(void (^)(id responseObject, NSError *error))callback;

-(void)getUserDataWithUID:(NSString *)uid callback:(void (^)(id responseObject, NSError *error))callback;

-(void)searchVideoWithText:(NSString *)searchText callback:(void (^)(id responseObject, NSError *error))callback;

@end
