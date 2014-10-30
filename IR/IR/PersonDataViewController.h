//
//  PersonDataViewController.h
//  IR
//
//  Created by Sondre T Johannessen on 30.10.14.
//  Copyright (c) 2014 Sondre T Johannessen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HumanModel.h"
@interface PersonDataViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *fNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *lNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *addressLabel;
@property (weak, nonatomic) IBOutlet UITextField *countryOfResidenceLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthLabel;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *visualEffectView;
@property (weak, nonatomic) IBOutlet UIVisualEffectView *nestedVisualEffectView;
@property (weak, nonatomic) IBOutlet UILabel *numberOfInjuriesLabel;

-(void)dismissKeyboard;

@end
