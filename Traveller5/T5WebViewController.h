//
//  T5WebViewController.h
//  Prototype
//
//  Created by Alex Baca on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T5WebViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate> { 
    NSURL *theURL;
    NSString *theTitle;
    IBOutlet UIWebView *webView; 
    IBOutlet UINavigationItem *webTitle;
}
- (id)initWithURL:(NSURL *)url;
- (id)initWithURL:(NSURL *)url andTitle:(NSString *)string; 
- (IBAction) done:(id)sender;

@end
