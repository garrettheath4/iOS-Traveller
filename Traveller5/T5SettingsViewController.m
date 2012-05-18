//
//  T5SettingsViewController.m
//  Traveller5
//
//  Created by Alex Baca on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "T5SettingsViewController.h"
#import "T5AppDelegate.h"

@interface T5SettingsViewController ()

@end

@implementation T5SettingsViewController
@synthesize bussSwitch =_bussSwitch;
@synthesize stationSwitch =_stationSwitch;
@synthesize routeSwitch =_routeSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    T5AppDelegate *appDelegate = (T5AppDelegate *) [[UIApplication sharedApplication] delegate]; 
    self.bussSwitch.on = appDelegate.monitorBuss;
    self.stationSwitch.on = appDelegate.monitorStation;
    self.routeSwitch.on = appDelegate.monitorRoute;
}

- (void)viewDidUnload
{
    [self setBussSwitch:nil];
    [self setStationSwitch:nil];
    [self setRouteSwitch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)saved:(id)sender {
    T5AppDelegate *appDelegate = (T5AppDelegate *) [[UIApplication sharedApplication] delegate]; 
    appDelegate.monitorBuss = self.bussSwitch.on;
    appDelegate.monitorStation = self.stationSwitch.on;
    appDelegate.monitorRoute = self.routeSwitch.on;
    [appDelegate refresh];
}
@end
