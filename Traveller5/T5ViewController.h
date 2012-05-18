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
#import "T5SettingsViewController.h"

@interface T5ViewController : UIViewController <MKMapViewDelegate, T5SettingsViewControllerDelegate>{
    
	// the map view
	MKMapView* _mapView;
	
	// the data representing the route points. 
	MKPolyline* _routeLine;
	
    
	// the view we create for the line on the map
	MKPolylineView* _routeLineView;
	
	// the rect that bounds the loaded points
	MKMapRect _routeRect;
}

@property (nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray *stationAnnotations;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapController;
@property (nonatomic, retain) MKPolyline *routeLine;
@property (nonatomic, retain) MKPolylineView *routeLineView;


- (IBAction)infoButton:(id)sender;
- (IBAction)alertButton:(id)sender;
- (IBAction)setMap:(id)sender;
- (IBAction)getLocation:(id)sender;
- (void)updateMap;
- (void) loadRoute;
- (IBAction)pageCurl:(id)sender;


@end
