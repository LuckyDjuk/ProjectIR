//
//  HumanModel.m
//  testingProjectMobileApps
//
//  Created by Sondre T Johannessen on 20.10.14.
//  Copyright (c) 2014 Sondre T Johannessen. All rights reserved.
//

#import "HumanModel.h"

@implementation HumanModel


-(instancetype)init{
    if ([super init]) {
        self.timeOfAccident = [NSDate date];
        self.locationOfAccident = [[CLLocation alloc] initWithLatitude:10 longitude:10];
        self.injuries = [[NSMutableArray alloc] init];
    }
    
    return self;
}
@end
