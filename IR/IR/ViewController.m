//
//  ViewController.m
//  IR
//
//  Created by Sondre T Johannessen on 28.10.14.
//  Copyright (c) 2014 Sondre T Johannessen. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
{
    NSArray *INJURY_TYPE_IDS;
    NSArray *INJURY_TYPE_NAMES;
    NSArray *BODY_PART_IDS;
    NSArray *BODY_PART_NAMES;;
    NSDictionary *INJURY_ID_WITH_NAMES;
    UIVisualEffectView *visualEffectView;
    NSInteger currentlySelectedPart;
}

@end

@implementation ViewController
@synthesize human;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)]];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    INJURY_TYPE_IDS = @[@1,@2,@3,@4,@5,@6,@7,@8,@999];
    INJURY_TYPE_NAMES = @[@"Contusion", @"Sprain", @"Fracture", @"No injury type matches the number 4, check specification", @"IO Manifest", @"Concussion", @"Dislocation", @"Wound", @"Removed"];
    
    INJURY_ID_WITH_NAMES = [[NSDictionary alloc] initWithObjects:INJURY_TYPE_NAMES forKeys:INJURY_TYPE_IDS];
    
    BODY_PART_IDS = @[@10,@15,@20,@30,@40,@50,@60,@65,@70,@75,@80,@85,@90,@95,@100,@105,@110,@115,@120,@125,@130,@135,@140,@145,@150,@155,@160,@165,@170,@175,@180,@185,@190,@195];
    
    BODY_PART_NAMES = @[@"Head",@"Face",@"Neck",@"Back",@"Thorax",@"Abdomen",@"Right clavicula and AC joint",@"Left clavicula and AC joint",@"Right shoulder",@"Left shoulder", @"Right humerous", @"Left humerous", @"Right elbow",@"Left elbow", @"Right under arm", @"Left under arm", @"Right wrist",@"Left wrist", @"Right hand", @"Left hand", @"Right pelvis",@"Left pelvis",@"Right hip", @"Left hip", @"Right femur", @"Left femur", @"Right knee", @"Left knee", @"Right lower leg", @"Left lower leg",@"Right ankle", @"Left ankle", @"Right foot", @"Left foot"];
    
    human = [HumanModel sharedHuman];
        
    if (self.navigationController.viewControllers[0] == self) {
        [self addMenu];
    }
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
        [self.locationManager startUpdatingHeading];
    }
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
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

-(IBAction)updateCurrentlySelectedPart:(UIButton*)sender
{
    currentlySelectedPart = (NSInteger)sender.tag;    
}

-(IBAction)addInjuryType:(UIButton*)sender
{
    if (sender.tag == 999) {
        NSLog(@"No injury type was selected");
        
        for (NSInteger i=human.injuries.count-1; i > -1; i--) {
            InjuryModel *inj = [human.injuries objectAtIndex:i];
            if (inj.bodyPartID == [NSNumber numberWithInteger:currentlySelectedPart]) {
                [human.injuries removeObject:inj];
            }
        }
        [self buttonPressed:sender forEvent:nil];
    }else{
        InjuryModel *injury = [[InjuryModel alloc] initWithBodyPartID:[NSNumber numberWithInteger:currentlySelectedPart] andInjuryTypeID:[NSNumber numberWithInteger:sender.tag]];
        [human.injuries addObject:injury];
        [self buttonPressed:sender forEvent:nil];
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController *vc = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"personDataSegue"]) {
    }
    else [vc updateCurrentlySelectedPart:sender];
}

- (IBAction)buttonPressed:(id)sender forEvent:(UIEvent *)event
{
    UIView *button = (UIView *)sender;
    CGPoint location = button.center;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 330, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor redColor];
    label.numberOfLines = 1;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.text = [INJURY_ID_WITH_NAMES objectForKey:[NSNumber numberWithInteger:button.tag]];
    [label setCenter:location];
    label.font = [UIFont boldSystemFontOfSize:60];
    label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25);
    [self.view addSubview:label];
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 0;
        label.transform = CGAffineTransformScale(label.transform, 4, 4);
    }completion:^(BOOL finished) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }];
}

-(void)addMenu
{
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    visualEffectView.frame = self.view.bounds;
    
    // Vibrancy effect
    UIVibrancyEffect *vibrancyEffect = [UIVibrancyEffect effectForBlurEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark]];
    UIVisualEffectView *vibrancyEffectView = [[UIVisualEffectView alloc] initWithEffect:vibrancyEffect];
    [vibrancyEffectView setFrame:self.view.bounds];
    
    // Add new injury button
    UIButton *addNewInjuryButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addNewInjuryButton setTitle:@"Add new injury" forState:UIControlStateNormal];
    [addNewInjuryButton.titleLabel setFont:[UIFont systemFontOfSize:55.0f]];
    [addNewInjuryButton sizeToFit];
    [addNewInjuryButton setCenter: self.view.center];
    [addNewInjuryButton addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //Person data button
    UIButton *personDataButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [personDataButton setTitle:@"Person data" forState:UIControlStateNormal];
    [personDataButton.titleLabel setFont:[UIFont systemFontOfSize:55.0f]];
    [personDataButton sizeToFit];
    [personDataButton setCenter: self.view.center];
    personDataButton.frame = CGRectMake(personDataButton.frame.origin.x, personDataButton.frame.origin.y - 100, personDataButton.frame.size.width, personDataButton.frame.size.height);
    [personDataButton addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    //Submit button
    UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [submitButton.titleLabel setFont:[UIFont systemFontOfSize:55.0f]];
    [submitButton sizeToFit];
    [submitButton setCenter: self.view.center];
    submitButton.frame = CGRectMake(submitButton.frame.origin.x, submitButton.frame.origin.y + 100, submitButton.frame.size.width, submitButton.frame.size.height);
    [submitButton addTarget:self action:@selector(menuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [[vibrancyEffectView contentView] addSubview:addNewInjuryButton];
    [[vibrancyEffectView contentView] addSubview:personDataButton];
    [[vibrancyEffectView contentView] addSubview:submitButton];
    
    [[visualEffectView contentView] addSubview:vibrancyEffectView];
    
    [self.view addSubview:visualEffectView];
}

-(void)menuButtonPressed:(UIButton*)sender
{
    if ([sender.titleLabel.text isEqualToString:@"Add new injury"]) {
        [UIView animateWithDuration:0.5f animations:^{
            visualEffectView.alpha = 0.0f;
        }];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Person data"]) {
        [UIView animateWithDuration:0.5f animations:^{
            visualEffectView.alpha = 0.0f;
        }];
        [self performSegueWithIdentifier:@"personDataSegue" sender:self];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Submit"]) {
        [human submitHumanToWebService];
        [human deleteHuman];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    visualEffectView.alpha = 1.0f;
    
    if (human.timeOfAccident == nil) {
        human.timeOfAccident = [[NSDate alloc] init];
        human.timeOfAccident = [NSDate date];
    }
    
    if (human.locationOfAccident == nil) {
        
        human.locationOfAccident = [[CLLocation alloc] init];
        human.locationOfAccident = self.locationManager.location;
    }
}
@end
