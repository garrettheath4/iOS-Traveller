//
//  T3DispatchViewController.m
//  Prototype
//
//  Created by Alex Baca on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "T3DispatchViewController.h"

@interface T3DispatchViewController ()

@end

@implementation T3DispatchViewController
@synthesize goButton;
@synthesize resultLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setGoButton:nil];
    [self setResultLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)pushedGo:(id)sender {
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
