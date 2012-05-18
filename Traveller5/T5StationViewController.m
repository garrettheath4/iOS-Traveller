//
//  T5StationViewController.m
//  Traveller5
//
//  Created by Alex Baca on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "T5StationViewController.h"

@interface T5StationViewController ()

@end

@implementation T5StationViewController
@synthesize station;
@synthesize route;
@synthesize image;
@synthesize details;
@synthesize indicator1;
@synthesize indicator2;
@synthesize indicator3;

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
    [self setIndicator1:nil];
    [self setIndicator2:nil];
    [self setIndicator3:nil];
    [self setRoute:nil];
    [self setDetails:nil];
    [self setImage:nil];
    [self setStation:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)getDirections:(id)sender {
}

- (IBAction)goBack:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

@end
