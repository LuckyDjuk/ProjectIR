//
//  HumanModel.h
//  testingProjectMobileApps
//
//  Created by Sondre T Johannessen on 20.10.14.
//  Copyright (c) 2014 Sondre T Johannessen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "InjuryModel.h"

@interface HumanModel : NSObject

@property (strong, nonatomic) NSString* fName;
@property (strong, nonatomic) NSString* lName;
@property (strong, nonatomic) NSString* address;
@property (strong, nonatomic) NSString* phoneNumber;
@property (strong, nonatomic) NSString* countryOfResidence;
@property (strong, nonatomic) NSDate* dateOfBirth;
@property (strong, nonatomic) NSDate* timeOfAccident;
@property (strong, nonatomic) CLLocation* locationOfAccident;
@property (strong, nonatomic) NSMutableArray* injuries;


-(instancetype)init;


@end
