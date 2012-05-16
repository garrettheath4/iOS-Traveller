//
//  TTransitViewController.m
//  Traveller
//
//  Created by Garrett Koller on 5/14/12.
//  Copyright (c) 2012 Washington and Lee University. All rights reserved.
//

#import "TTransitViewController.h"

@interface TTransitViewController ()

@end

@implementation TTransitViewController
@synthesize requestButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setRequestButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)pushedRequest:(id)sender {
}
@end
