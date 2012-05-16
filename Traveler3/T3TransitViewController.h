//
//  T3TransitViewController.h
//  Prototype
//
//  Created by Alex Baca on 5/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface T3TransitViewController : UIViewController <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
- (IBAction)pushedGo:(id)sender;

@end
