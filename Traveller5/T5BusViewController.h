//
//  T5BusViewController.h
//  Traveller5
//
//  Created by Alex Baca on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface T5BusViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *bus;
@property (weak, nonatomic) IBOutlet UINavigationBar *bus2;

@property (weak, nonatomic) IBOutlet UILabel *route;
@property (weak, nonatomic) IBOutlet UITextView *stations;
@property (weak, nonatomic) IBOutlet UITextView *times;

@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBack;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;

@end
