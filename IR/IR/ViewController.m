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
    NSArray *BODY_PART_NAMES;
    
    NSInteger currentlySelectedPart;
}

@end



@implementation ViewController
@synthesize human;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addGestureRecognizer:[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)]];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    INJURY_TYPE_IDS = @[@1,@2,@3,@4,@5,@6,@7,@8];
    INJURY_TYPE_NAMES = @[@"Contusion", @"Sprain", @"Fracture", @"No injury type matches the number 4, check specification", @"IO Manifest", @"Concussion", @"Dislocation", @"Wound"];
    
    BODY_PART_IDS = @[@10,@15,@20,@30,@40,@50,@60,@65,@70,@75,@80,@85,@90,@95,@100,@105,@110,@115,@120,@125,@130,@135,@140,@145,@150,@155,@160,@165,@170,@175,@180,@185,@190,@195];
    
    BODY_PART_NAMES = @[@"Head",@"Face",@"Neck",@"Back",@"Thorax",@"Abdomen",@"Right clavicula and AC joint",@"Left clavicula and AC joint",@"Right shoulder",@"Left shoulder", @"Right humerous", @"Left humerous", @"Right elbow",@"Left elbow", @"Right under arm", @"Left under arm", @"Right wrist",@"Left wrist", @"Right hand", @"Left hand", @"Right pelvis",@"Left pelvis",@"Right hip", @"Left hip", @"Right femur", @"Left femur", @"Right knee", @"Left knee", @"Right lower leg", @"Left lower leg",@"Right ankle", @"Left ankle", @"Right foot", @"Left foot"];
    
   // NSLog(@"%lu, %lu", (unsigned long)BODY_PART_NAMES.count, (unsigned long)BODY_PART_IDS.count);
    human = [[HumanModel alloc] init];
    /*visualEffectView.frame = self.view.bounds;
    
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100 , 100, 100)];
    btn.titleLabel.text = @"Test";
    
    [visualEffectView.contentView addSubview:btn];
    
    [self.view addSubview:visualEffectView];*/
    
    
    
    human = [HumanModel sharedHuman];
    
    human.fName = @"Sondre T";
    human.lName = @"Johannessen";
    human.address = @"Wollongong";
    human.countryOfResidence = @"Norway";
    human.phoneNumber = @"+47 94 84 07 95";
    
    
    // Initialize date components with date values
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setYear:1990];
    [dateComponents setMonth:11];
    [dateComponents setDay:11];
    
    
    NSCalendar *calendar = [[NSCalendar alloc]  initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    human.dateOfBirth = [calendar dateFromComponents:dateComponents];
    
    /*
     for (int i = 0; i<BODY_PART_NAMES.count; i++) {
     InjuryModel *injury = [[InjuryModel alloc] initWithBodyPartID:BODY_PART_IDS[i] andInjuryTypeID:INJURY_TYPE_IDS[i % 8]];
     
     injury.bodyPartName = BODY_PART_NAMES[i];
     injury.injuryTypeName = INJURY_TYPE_NAMES[i %8];
     
     [human.injuries addObject:injury];
     }*/
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)handleSwipe:(UISwipeGestureRecognizer*)swipe
{
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        //NSLog(@"Swiped direction right.");
        
        [self.navigationController popViewControllerAnimated:YES];
   // NSLog(@"Currently selected part updated to: %ld", (long)currentlySelectedPart);
    }
}

-(IBAction)updateCurrentlySelectedPart:(UIButton*)sender
{
    currentlySelectedPart = (NSInteger)sender.tag;
    
    NSLog(@"Currently selected part updated to: %ld", (long)currentlySelectedPart);

}

-(IBAction)addInjuryType:(UIButton*)sender
{
    if (sender.tag == 999) {
        NSLog(@"No injury type was selected");
    }
    else{
        InjuryModel *injury = [[InjuryModel alloc] initWithBodyPartID:[NSNumber numberWithInteger:currentlySelectedPart] andInjuryTypeID:[NSNumber numberWithInteger:sender.tag]];
        
        [human.injuries addObject:injury];
        [self.navigationController popToRootViewControllerAnimated:YES];
        
       // NSLog(@"%@", human.injuries);
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController *vc = segue.destinationViewController;
    
    [vc updateCurrentlySelectedPart:sender];
}

- (IBAction)buttonPressed:(id)sender forEvent:(UIEvent *)event
{
    UIView *button = (UIView *)sender;
    UITouch *touch = [[event touchesForView:button] anyObject];
    CGPoint location = [touch locationInView:button];
    NSLog(@"Location in button: %f, %f", location.x, location.y);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 30, 300, 50)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.text = @"Test";
    [label setCenter:location];
    label.font = [UIFont boldSystemFontOfSize:60];
    label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25);
    [self.view addSubview:label];
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 0;
        label.transform = CGAffineTransformScale(label.transform, 4, 4);
    }completion:^(BOOL finished) {
        
    }];
}

@end
