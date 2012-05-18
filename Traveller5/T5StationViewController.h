//
//  T5StationViewController.h
//  Traveller5
//
//  Created by Alex Baca on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T5StationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *station;
@property (weak, nonatomic) IBOutlet UILabel *route;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UITextView *details;

@property (weak, nonatomic) IBOutlet UIImageView *indicator1;
@property (weak, nonatomic) IBOutlet UIImageView *indicator2;
@property (weak, nonatomic) IBOutlet UIImageView *indicator3;

- (IBAction)getDirections:(id)sender;
- (IBAction)goBack:(id)sender;
@end
