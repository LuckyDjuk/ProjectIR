//
//  InjuryModel.h
//  testingProjectMobileApps
//
//  Created by Sondre T Johannessen on 20.10.14.
//  Copyright (c) 2014 Sondre T Johannessen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InjuryModel : NSObject


@property (strong, nonatomic) NSString* bodyPartName;
@property (strong, nonatomic) NSString* injuryTypeName;
@property (strong, nonatomic) NSNumber* bodyPartID;
@property (strong, nonatomic) NSNumber* injuryTypeID;

-(instancetype)initWithBodyPartID:(NSNumber*)bodyPartID andInjuryTypeID:(NSNumber*)injuryTypeID;

@end
