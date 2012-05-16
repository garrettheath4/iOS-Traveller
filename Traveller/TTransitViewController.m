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
    if (![MFMailComposeViewController canSendMail]) {
        NSString *errorTitle = @"Error";
        NSString *errorString = @"This device is not configured to send email.";
        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:errorTitle message:errorString delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [errorView show]; 
    } 
    else {
        MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc] init];
        mailView.mailComposeDelegate = self;
        [mailView setSubject:@"Test"];
        [mailView setMessageBody:@"This is a test message" isHTML:NO]; [self presentModalViewController:mailView animated:YES];
        }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if (error) {
        NSString *errorTitle = @"Mail Error";
        NSString *errorDescription = [error localizedDescription];
        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:errorTitle message:errorDescription delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [errorView show];
    } else {
        // Add code here to handle the MFMailComposeResult }
        [controller dismissModalViewControllerAnimated:YES]; 
    }
}
@end
