//
//  T5BusViewController.m
//  Traveller5
//
//  Created by Alex Baca on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "T5BusViewController.h"

@interface T5BusViewController ()

@end

@implementation T5BusViewController
@synthesize bus;
@synthesize bus2;
@synthesize route;
@synthesize stations;
@synthesize times;
@synthesize image;
@synthesize goBack;
@synthesize refresh;

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
    [self setRoute:nil];
    [self setStations:nil];
    [self setTimes:nil];
    [self setImage:nil];
    [self setGoBack:nil];
    [self setRefresh:nil];
    [self setBus:nil];
    [self setBus2:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
