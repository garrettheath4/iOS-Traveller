//
//  T5InfoViewController.m
//  Traveller5
//
//  Created by Alex Baca on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "T5InfoViewController.h"
#import "T5WebViewController.h"

@interface T5InfoViewController ()

@end

@implementation T5InfoViewController
@synthesize dispatchButton;
@synthesize resultLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)pushedDispatch:(id)sender {
    if (![MFMailComposeViewController canSendMail]) {
        NSString *errorTitle = @"Error";
        NSString *errorString = @"This device is not configured to send email.";
        UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:errorTitle message:errorString delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [errorView show]; 
    } 
    else {
        MFMailComposeViewController *mailView = [[MFMailComposeViewController alloc] init];
        mailView.mailComposeDelegate = self;
        NSArray *recipients = [[NSArray alloc] initWithObjects:@"Traveller@wlu.edu", nil];
        [mailView setToRecipients:recipients];
        [mailView setSubject:@"Traveller Dispatch Request"];
        [mailView setMessageBody:@"Request Details (Location, Phone Number, Time Requested):" isHTML:NO]; 
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setDispatchButton:nil];
    [self setResultLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)travelerInfoButton:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.wlu.edu/x30365.xml"]; 
    T5WebViewController *webViewController = [[T5WebViewController alloc] initWithURL:url andTitle:@"Traveller"]; 
    [self presentModalViewController:webViewController animated:YES];
}

- (IBAction)transitInfoButton:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.wlu.edu/x30376.xml"]; 
    T5WebViewController *webViewController = [[T5WebViewController alloc] initWithURL:url andTitle:@"Traveller Transit"]; 
    [self presentModalViewController:webViewController animated:YES];
}

- (IBAction)dispatchInfoButton:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.wlu.edu/x30367.xml"]; 
    T5WebViewController *webViewController = [[T5WebViewController alloc] initWithURL:url andTitle:@"Traveller Dispatch"]; 
    [self presentModalViewController:webViewController animated:YES];
}

- (IBAction)conductPolicy:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.wlu.edu/x38133.xml"]; 
    T5WebViewController *webViewController = [[T5WebViewController alloc] initWithURL:url andTitle:@"Conduct Policy"]; 
    [self presentModalViewController:webViewController animated:YES];
}

- (IBAction)passengerGuidelines:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.wlu.edu/x30538.xml"]; 
    T5WebViewController *webViewController = [[T5WebViewController alloc] initWithURL:url andTitle:@"Passenger Guidelines"]; 
    [self presentModalViewController:webViewController animated:YES];
}

- (IBAction)driverGuidelines:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.wlu.edu/x30375.xml"]; 
    T5WebViewController *webViewController = [[T5WebViewController alloc] initWithURL:url andTitle:@"Driver Guidelines"]; 
    [self presentModalViewController:webViewController animated:YES];
}

- (IBAction)mapButton:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://www.wlu.edu/Documents/traveller/Traveller-Map-2010-1.pdf"]; 
    T5WebViewController *webViewController = [[T5WebViewController alloc] initWithURL:url andTitle:@"Traveller Map"]; 
    [self presentModalViewController:webViewController animated:YES];
}

- (IBAction)doneButton:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}
@end
