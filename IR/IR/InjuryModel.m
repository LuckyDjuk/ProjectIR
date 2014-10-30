//
//  InjuryModel.m
//  testingProjectMobileApps
//
//  Created by Sondre T Johannessen on 20.10.14.
//  Copyright (c) 2014 Sondre T Johannessen. All rights reserved.
//

#import "InjuryModel.h"

@implementation InjuryModel

-(instancetype)initWithBodyPartID:(NSNumber *)bodyPartID andInjuryTypeID:(NSNumber *)injuryTypeID
{
    if ([super init]) {
        self.bodyPartID = bodyPartID;
        self.injuryTypeID = injuryTypeID;
        self.injuryTypeName = @"Not set";
        self.bodyPartName = @"Not set";
    }
    return self;
}

@end
