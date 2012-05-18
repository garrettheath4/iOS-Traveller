//
//  T5SettingsViewController.h
//  Traveller5
//
//  Created by Alex Baca on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class T5SettingsViewController;

@protocol T5SettingsViewControllerDelegate
- (void)SettingsViewControllerDidFinish:(T5SettingsViewController *)controller;
@end

@interface T5SettingsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *bussSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *stationSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *routeSwitch;


- (IBAction)saved:(id)sender;

@end
