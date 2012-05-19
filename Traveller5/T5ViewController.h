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
#import "T5GPSquery.h"

@class T5GPSquery;

@interface T5ViewController : UIViewController <MKMapViewDelegate>{
    
	// the map view
	MKMapView* _mapView;
	
	// the data representing the route points. 
	MKPolyline* _routeRedLine;
	
    
	// the view we create for the line on the map
	MKPolylineView* _routeRedLineView;
	
	// the rect that bounds the loaded points
	MKMapRect _routeRedRect;
    
    // the data representing the route points. 
	MKPolyline* _routeBlueLine;
	
    
	// the view we create for the line on the map
	MKPolylineView* _routeBlueLineView;
	
	// the rect that bounds the loaded points
	MKMapRect _routeBlueRect;
}

@property (nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray *stationAnnotations;
@property (strong, nonatomic) NSArray *busAnnotations;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mapController;
@property (nonatomic, retain) MKPolyline *routeRedLine;
@property (nonatomic, retain) MKPolylineView *routeRedLineView;
@property (nonatomic, retain) MKPolyline *routeBlueLine;
@property (nonatomic, retain) MKPolylineView *routeBlueLineView;


- (IBAction)infoButton:(id)sender;
- (IBAction)alertButton:(id)sender;
- (IBAction)setMap:(id)sender;
- (IBAction)getLocation:(id)sender;
- (void)updateMap:(T5GPSquery *)query;
- (void)loadRedRoute;
- (void)loadBlueRoute;
- (IBAction)pageCurl:(id)sender;
- (void)refresh;


@end
