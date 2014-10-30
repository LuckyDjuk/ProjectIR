//
//  PersonDataViewController.m
//  IR
//
//  Created by Sondre T Johannessen on 30.10.14.
//  Copyright (c) 2014 Sondre T Johannessen. All rights reserved.
//

#import "PersonDataViewController.h"

@interface PersonDataViewController ()
{
    UIVisualEffectView *visualEffectView;
}

@end

@implementation PersonDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)]];
    
    //http://stackoverflow.com/questions/5306240/iphone-dismiss-keyboard-when-touching-outside-of-textfield
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    self.visualEffectView.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleSwipe:(UISwipeGestureRecognizer*)swipe
{
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)addMenu
{
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    visualEffectView.frame = self.view.bounds;
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100 , 100, 100)];
    btn.titleLabel.text = @"Test";
    
    // Vibrancy effect
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:self.view.bounds];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.font = [UIFont systemFontOfSize:15];
    textField.placeholder = @"enter text";
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.delegate = self;
    [self.view addSubview:textField];
    
    // Add label to the vibrancy view
    [[vibrancyEffectView contentView] addSubview:textField];
    
    // Add the vibrancy view to the blur view
    [[visualEffectView contentView] addSubview:vibrancyEffectView];
    
    [self.view addSubview:visualEffectView];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSInteger nextTag = textField.tag +1;
    
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
    }
    
    HumanModel *human = [HumanModel sharedHuman];
    
    human.fName = self.fNameLabel.text;
    human.lName = self.lNameLabel.text;
    human.address = self.addressLabel.text;
    human.phoneNumber = self.phoneNumberLabel.text;
    human.countryOfResidence = self.countryOfResidenceLabel.text;
    human.dateOfBirth = self.dateOfBirthLabel.text;
    
    return NO; // We do not want UITextField to insert line-breaks
}

-(void)dismissKeyboard {
    [self.fNameLabel resignFirstResponder];
    [self.lNameLabel resignFirstResponder];
    [self.addressLabel resignFirstResponder];
    [self.phoneNumberLabel resignFirstResponder];
    [self.countryOfResidenceLabel resignFirstResponder];
    [self.dateOfBirthLabel resignFirstResponder];
}

-(void)viewWillAppear:(BOOL)animated
{
    HumanModel *human = [HumanModel sharedHuman];
    if (human.injuries.count > 0) {
        self.numberOfInjuriesLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)human.injuries.count];
    }
    else self.numberOfInjuriesLabel.text = @"0";
    
    if (human.fName != nil) {
        self.fNameLabel.text = human.fName;
    }
    if (human.lName != nil) {
        self.lNameLabel.text = human.lName;
    }
    if (human.address != nil) {
        self.addressLabel.text = human.address;
    }
    if (human.phoneNumber != nil) {
        self.phoneNumberLabel.text = human.phoneNumber;
    }
    if (human.countryOfResidence != nil) {
        self.countryOfResidenceLabel.text = human.countryOfResidence;
    }
    if (human.dateOfBirth != nil) {
        self.dateOfBirthLabel.text = human.dateOfBirth;
    }
}
@end
