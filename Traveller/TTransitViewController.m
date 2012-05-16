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
@synthesize resultLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setRequestButton:nil];
    [self setResultLabel:nil];
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
        [mailView setMessageBody:@"This is a test message" isHTML:NO]; 
        [self presentModalViewController:mailView animated:YES];
        }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    if (error) {
        NSString *errorTitle = @"Mail Error";
        NSString *errorDescription = [error localizedDescription];
        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:errorTitle message:errorDescription delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [errorView show];
    } else {
        NSString *string;
        switch (result) {
            case MFMailComposeResultSent:
                string = @"Mail sent.";
                break;
            case MFMailComposeResultSaved:
                string = @"Mail saved."; 
                break;
            case MFMailComposeResultCancelled:
                string = @"Mail cancelled.";
                break;
            case MFMailComposeResultFailed:
                string = @"Mail failed.";
                break;
            default:
                string = @"Unknown"; break;
        }
        self.resultLabel.text = string;
        [controller dismissModalViewControllerAnimated:YES]; 
    }
}
@end
