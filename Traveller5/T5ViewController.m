//
//  T5ViewController.m
//  Traveller5
//
//  Created by Alex Baca on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "T5ViewController.h"
#import "T5InfoViewController.h"
#import "T5WebViewController.h"

@interface T5ViewController ()

@end

@implementation T5ViewController
@synthesize mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)infoButton:(id)sender {
    T5InfoViewController *infoView = [[T5InfoViewController alloc] init];
    [self presentModalViewController:infoView animated:YES];
}

- (IBAction)alertButton:(id)sender {
        NSURL *url = [NSURL URLWithString:@"http://twitter.com/#!/WLUtraveller"]; 
        T5WebViewController *webViewController = [[T5WebViewController alloc] initWithURL:url andTitle:@"Traveller Notifications"]; 
        [self presentModalViewController:webViewController animated:YES];
}
     
@end
