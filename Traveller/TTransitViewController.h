//
//  TTransitViewController.h
//  Traveller
//
//  Created by Garrett Koller on 5/14/12.
//  Copyright (c) 2012 Washington and Lee University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTransitViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *requestButton;

- (IBAction)pushedRequest:(id)sender;

@end
