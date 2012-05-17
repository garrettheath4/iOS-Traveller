//
//  T5InfoViewController.h
//  Traveller5
//
//  Created by Alex Baca on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface T5InfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *dispatchButton;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;

- (IBAction)pushedDispatch:(id)sender;

- (IBAction)travelerInfoButton:(id)sender;
- (IBAction)transitInfoButton:(id)sender;
- (IBAction)dispatchInfoButton:(id)sender;
- (IBAction)conductPolicy:(id)sender;
- (IBAction)passengerGuidelines:(id)sender;
- (IBAction)driverGuidelines:(id)sender;
- (IBAction)mapButton:(id)sender;
- (IBAction)doneButton:(id)sender;


@end
