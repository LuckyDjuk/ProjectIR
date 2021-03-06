//
//  ViewController.h
//  IR
//
//  Created by Sondre T Johannessen on 28.10.14.
//  Copyright (c) 2014 Sondre T Johannessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HumanModel.h"
#import "Constants.h"

@interface ViewController : UIViewController <UIGestureRecognizerDelegate, CLLocationManagerDelegate>


@property (strong, nonatomic) HumanModel* human;
@property (strong, nonatomic) CLLocationManager* locationManager;

-(void)handleSwipe:(UIGestureRecognizer*)swipe;

-(IBAction)updateCurrentlySelectedPart:(UIButton*)sender;
-(IBAction)addInjuryType:(id)sender;
-(void)addMenu;


@end



