//
//  T5InfoViewController.m
//  Traveller5
//
//  Created by Alex Baca on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "T5InfoViewController.h"

@interface T5InfoViewController ()

@end

@implementation T5InfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)travelerInfoButton:(id)sender {
}

- (IBAction)transitInfoButton:(id)sender {
}

- (IBAction)dispatchInfoButton:(id)sender {
}

- (IBAction)conductPolicy:(id)sender {
}

- (IBAction)passengerGuidelines:(id)sender {
}

- (IBAction)driverGuidelines:(id)sender {
}

- (IBAction)mapButton:(id)sender {
}
@end
