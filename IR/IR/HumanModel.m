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
        self.locationOfAccident = nil;
        self.timeOfAccident = nil;
        self.injuries = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+(instancetype)sharedHuman
{
    static HumanModel *sharedHuman = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHuman = [[self alloc] init];
    });
    return sharedHuman;
}

-(void)submitHumanToWebService
{
    if (self.isNetworkAvailable) {
        
        NSString *bodyPartIdSubmitString;
        NSString *injuryTypeIdSubmitString;
    
        for (InjuryModel *injury in self.injuries) {
            injuryTypeIdSubmitString = [injuryTypeIdSubmitString stringByAppendingString:[NSString stringWithFormat:@"%@l-" , injury.injuryTypeID]];
        
        
            if ([bodyPartIdSubmitString containsString:[NSString stringWithFormat:@"%@",injury.bodyPartID]]) {
                bodyPartIdSubmitString = [bodyPartIdSubmitString stringByAppendingString:[NSString stringWithFormat:@"%@l-" , injury.bodyPartName]];
            }
                                    
        
        }
    
        NSURL *url = [NSURL URLWithString:@"http://ws1.zyberia.no/SkiiWs/SkiiService.svc/AddinjuryType"];
        NSMutableURLRequest *rq = [NSMutableURLRequest requestWithURL:url];
        [rq setHTTPMethod:@"POST"];
    
        NSData *jsonData = [[NSString stringWithFormat:@"{\"IDateReport\":\"2012-04-30\",\"F_DataInjury\":\"2012-01-01\",\"F_TimeInjury\":\"2012-01-01\",\"F_ISportTypeID\":\"1\",\"F_EquipmentID\": \"2\",\"F_IBindingsSettingID\":\"1\",\"F_IInjuryTypeID\":\"%1$@\",\"F_PID\":\"03\",\"F_BodyPartID\":\"%2$@\",\"F_PFirstName\":\"%3$@\",\"F_PLastName\":\"%4$@\",\"F_PBirthday\":\"%5$@\",\"F_PMobile\":\"%6$@\",\"F_PCResident\":\"4\",\"F_SevereIDs\":\"0102\",\"F_Psex\":\"male\"}",injuryTypeIdSubmitString, bodyPartIdSubmitString, self.fName, self.lName, self.dateOfBirth, self.phoneNumber  ] dataUsingEncoding:NSUTF8StringEncoding];
        [rq setHTTPBody:jsonData];
    
        [rq setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
            [NSURLConnection sendAsynchronousRequest:rq queue:queue completionHandler:^(NSURLResponse *rsp, NSData *data, NSError *error) {
        
                NSLog(@"Submitted data!");
        
    
                if ([data length] >0 && error == nil)
                {
                    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Server response" message:[NSString
                                                                                                    stringWithFormat:@"%@",     dataString] delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
                    [alert show];
                }
                else if ([data length] == 0 && error == nil)
                {
                    NSLog(@"Nothing was downloaded.");
                }
                else if (error != nil){
                    NSLog(@"Error = %@", error);
                }
        
            }];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No internet connection!" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
            [alert show];
        }
    
}

-(void)deleteHuman
{
    self.fName = nil;
    self.lName = nil;
    self.dateOfBirth = nil;
    self.countryOfResidence = nil;
    self.address = nil;
    self.phoneNumber = nil;
    self.timeOfAccident = nil;
    self.locationOfAccident = nil;
    self.injuries = [[NSMutableArray alloc] init];
}

//http://stackoverflow.com/questions/8812459/easiest-way-to-detect-internet-connection-on-ios

-(BOOL)isNetworkAvailable
{
    char *hostname;
    struct hostent *hostinfo;
    hostname = "google.com";
    hostinfo = gethostbyname (hostname);
    if (hostinfo == NULL){
        NSLog(@"-> no connection!\n");
        return NO;
    }
    else{
        NSLog(@"-> connection established!\n");
        return YES;
    }
}

@end
