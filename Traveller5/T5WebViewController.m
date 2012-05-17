//
//  T5WebViewController.m
//  Prototype
//
//  Created by Alex Baca on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "T5WebViewController.h"

@interface T5WebViewController ()

@end

@implementation T5WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithURL:(NSURL *)url andTitle:(NSString *)string { 
    if( self = [super init] ) {
        theURL = url; 
        theTitle = string;
    }
    return self; 
}
-(id)initWithURL:(NSURL *)url {
    return [self initWithURL:url andTitle:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    webTitle.title = theTitle;
    NSURLRequest *requestObject = [NSURLRequest requestWithURL:theURL]; 
    [webView loadRequest:requestObject];
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

- (IBAction) done:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    webView.delegate = nil;
    [webView stopLoading]; 
}

- (void)webViewDidStartLoad:(UIWebView *)wv {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)wv {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)wv didFailLoadWithError:(NSError *)error { [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    NSString *errorString = [error localizedDescription];
    NSString *errorTitle = [NSString stringWithFormat:@"Error (%d)", error.code];
    UIAlertView *errorView = [[UIAlertView alloc] initWithTitle:errorTitle message:errorString delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil]; 
    [errorView show];
}

- (void)didPresentAlertView:(UIAlertView *)alertView {
    [self dismissModalViewControllerAnimated:YES]; 
}

@end
