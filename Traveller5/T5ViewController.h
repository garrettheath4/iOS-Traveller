//
//  T5ViewController.h
//  Traveller5
//
//  Created by Alex Baca on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface T5ViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray *stationAnnotations;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapController;

- (IBAction)infoButton:(id)sender;
- (IBAction)alertButton:(id)sender;
- (IBAction)setMap:(id)sender;
- (IBAction)getLocation:(id)sender;
- (void)updateMap;
- (IBAction)getStations:(id)sender;

@end
