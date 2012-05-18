//
//  T5ViewController.m
//  Traveller5
//
//  Created by Alex Baca on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "T5ViewController.h"
#import "T5InfoViewController.h"
#import "T5WebViewController.h"
#import "T5SimpleAnnotation.h"
#import "T5SettingsViewController.h"
#import "T5AppDelegate.h"
#import "T5GPSquery.h"

@interface T5ViewController ()

@end

@implementation T5ViewController
@synthesize mapView;
@synthesize stationAnnotations = _stationAnnotations;
@synthesize busAnnotations = _busAnnotations;
@synthesize mapController;
@synthesize routeRedLine = _routeRedLine;
@synthesize routeRedLineView = _routeRedLineView;
@synthesize routeBlueLine = _routeBlueLine;
@synthesize routeBlueLineView = _routeBlueLineView;


- (IBAction)getLocation:(id)sender {
    double miles = 12.0; 
    double scalingFactor = ABS( cos(2 * M_PI * self.mapView.userLocation.coordinate.latitude /360.0) );
    MKCoordinateSpan span;
    span.latitudeDelta = miles/3000.0; 
    span.longitudeDelta = miles/( scalingFactor*3000.0 );
    MKCoordinateRegion region;
    region.span = span;
    region.center = self.mapView.userLocation.coordinate;
    [self.mapView setRegion:region animated:YES];

}

- (IBAction)setMap:(id)sender {
    switch (((UISegmentedControl *) sender).selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
            
        default:
            break;
    }
}

- (void)updateMap{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadRedRoute];
    [self loadBlueRoute];
    
    T5GPSquery *query = [[T5GPSquery alloc] initWithViewController:self];
                
    T5SimpleAnnotation *annotation1 = [[T5SimpleAnnotation alloc] init];
    CLLocationCoordinate2D coord = {37.786947, -79.444657};
    annotation1.coordinate = coord;
    annotation1.title = @"Freshman Quad";
    annotation1.subtitle = @"Transfer Station";
    annotation1.route = 0;
    
    T5SimpleAnnotation *annotation2 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.789894;
    coord.longitude = -79.444601;
    annotation2.coordinate = coord;
    annotation2.title = @"Woods Creek";
    annotation2.subtitle = @"Blue City Route";
    annotation2.route = 1;
    
    T5SimpleAnnotation *annotation3 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.7913974;
    coord.longitude = -79.443952;
    annotation3.coordinate = coord;
    annotation3.title = @"Law School";
    annotation3.subtitle = @"Blue City Route";
    annotation3.route = 1;
    
    T5SimpleAnnotation *annotation4 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.795019;
    coord.longitude = -79.447874;
    annotation4.coordinate = coord;
    annotation4.title = @"Pavilion";
    annotation4.subtitle = @"Blue City Route";
    annotation4.route = 1;
    
    T5SimpleAnnotation *annotation5 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.800523;
    coord.longitude = -79.459938;
    annotation5.coordinate = coord;
    annotation5.title = @"Log Cabins";
    annotation5.subtitle = @"Blue City Route";
    annotation5.route = 1;
    
    T5SimpleAnnotation *annotation6 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.789909;
    coord.longitude = -79.446516;
    annotation6.coordinate = coord;
    annotation6.title = @"Sorority Houses";
    annotation6.subtitle = @"Blue City Route";
    annotation6.route = 1;
    
    T5SimpleAnnotation *annotation7 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.784792;
    coord.longitude = -79.443794;
    annotation7.coordinate = coord;
    annotation7.title = @"Palms";
    annotation7.subtitle = @"Blue City Route";
    annotation7.route = 1;
    
    T5SimpleAnnotation *annotation8 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.784033;
    coord.longitude = -79.444608;
    annotation8.coordinate = coord;
    annotation8.title = @"Salernos";
    annotation8.subtitle = @"Blue City Route";
    annotation8.route = 1;
    
    T5SimpleAnnotation *annotation9 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.781502;
    coord.longitude = -79.447353;
    annotation9.coordinate = coord;
    annotation9.title = @"White St.";
    annotation9.subtitle = @"Blue City Route";
    annotation9.route = 1;
    
    T5SimpleAnnotation *annotation10 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.782032;
    coord.longitude = -79.439457;
    annotation10.coordinate = coord;
    annotation10.title = @"Davidson Park East";
    annotation10.subtitle = @"Transfer Station";
    
    T5SimpleAnnotation *annotation11 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.783848;
    coord.longitude = -79.44009;
    annotation11.coordinate = coord;
    annotation11.title = @"Davidson Park West";
    annotation11.subtitle = @"Transfer Station";
    annotation11.route = 0;
    
    T5SimpleAnnotation *annotation12 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.786426;
    coord.longitude = -79.441817;
    annotation12.coordinate = coord;
    annotation12.title = @"Red Square";
    annotation12.subtitle = @"Transfer Station";
    annotation12.route = 0;
    
    T5SimpleAnnotation *annotation13 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.784675;
    coord.longitude = -79.439172;
    annotation13.coordinate = coord;
    annotation13.title = @"Tucker and Henry St.";
    annotation13.subtitle = @"Red Country Route";
    annotation13.route = 2;
    
    T5SimpleAnnotation *annotation14 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.788675;
    coord.longitude = -79.437303;
    annotation14.coordinate = coord;
    annotation14.title = @"Diamond St.";
    annotation14.subtitle = @"Red Country Route";
    annotation14.route = 2;
    
    T5SimpleAnnotation *annotation15 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.789398;
    coord.longitude = -79.430592;
    annotation15.coordinate = coord;
    annotation15.title = @"Hook Lane";
    annotation15.subtitle = @"Red Country Route";
    annotation15.route = 2;
    
    T5SimpleAnnotation *annotation16 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.803638;
    coord.longitude = -79.430318;
    annotation16.coordinate = coord;
    annotation16.title = @"Top of Windfall Hill";
    annotation16.subtitle = @"Red Country Route";
    annotation16.route = 2;
    
    T5SimpleAnnotation *annotation17 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.802899;
    coord.longitude = -79.428052;
    annotation17.coordinate = coord;
    annotation17.title = @"Bottom of Windfall Hill";
    annotation17.subtitle = @"Red Country Route";
    annotation17.route = 2;
    
    T5SimpleAnnotation *annotation18 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.801146;
    coord.longitude = -79.427684;
    annotation18.coordinate = coord;
    annotation18.title = @"Top of Kappa Hill";
    annotation18.subtitle = @"Red Country Route";
    annotation18.route = 2;
    
    T5SimpleAnnotation *annotation19 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.802009;
    coord.longitude = -79.428789;
    annotation19.coordinate = coord;
    annotation19.title = @"Bottom of Kappa Hill";
    annotation19.subtitle = @"Red Country Route";
    annotation19.route = 2;
    
    T5SimpleAnnotation *annotation20 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.797128;
    coord.longitude = -79.431549;
    annotation20.coordinate = coord;
    annotation20.title = @"Greenhouses";
    annotation20.subtitle = @"Red Country Route";
    annotation20.route = 2;
    
    T5SimpleAnnotation *annotation21 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.794517;
    coord.longitude = -79.431367;
    annotation21.coordinate = coord;
    annotation21.title = @"County Seat";
    annotation21.subtitle = @"Red Country Route";
    annotation21.route = 2;
    
    T5SimpleAnnotation *annotation22 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.794618;
    coord.longitude = -79.433684;
    annotation22.coordinate = coord;
    annotation22.title = @"Pole Houses";
    annotation22.subtitle = @"Red Country Route";
    annotation22.route = 2;
    
    T5SimpleAnnotation *annotation23 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.791144;
    coord.longitude = -79.452586;
    annotation23.coordinate = coord;
    annotation23.title = @"Bordon Commons";
    annotation23.subtitle = @"Blue City Route";
    annotation23.route = 1;
    
    T5SimpleAnnotation *annotation24 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.785408;
    coord.longitude = -79.440178;
    annotation24.coordinate = coord;
    annotation24.title = @"Henry and Randolph St.";
    annotation24.subtitle = @"Red Country Route";
    annotation24.route = 2;
    
    T5SimpleAnnotation *busAnnotation1 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.792104;
    coord.longitude = -79.450362;
    busAnnotation1.coordinate = coord;
    busAnnotation1.title = @"Traveller Bus #1";
    busAnnotation1.subtitle = @"";
    
    T5SimpleAnnotation *busAnnotation2 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.791757;
    coord.longitude = -79.449998;
    busAnnotation2.coordinate = coord;
    busAnnotation2.title = @"Traveller Bus #2";
    busAnnotation2.subtitle = @"";
    
    T5SimpleAnnotation *busAnnotation3 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.791583;
    coord.longitude = -79.448922;
    busAnnotation3.coordinate = coord;
    busAnnotation3.title = @"Traveller Bus #3";
    busAnnotation3.subtitle = @"";
    
    T5SimpleAnnotation *busAnnotation4 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.792037;
    coord.longitude = -79.450014;
    busAnnotation4.coordinate = coord;
    busAnnotation4.title = @"Traveller Bus #4";
    busAnnotation4.subtitle = @"";
    
    
    self.stationAnnotations = [[NSArray alloc] initWithObjects:annotation1, annotation2, annotation3, annotation4, annotation5, annotation6, annotation7, annotation8, annotation9, annotation10, annotation11, annotation12, annotation13, annotation14, annotation15, annotation16, annotation17, annotation18, annotation19, annotation20, annotation21, annotation22, annotation23, annotation24, nil];
    
    self.busAnnotations = [[NSArray alloc] initWithObjects:busAnnotation1, busAnnotation2, busAnnotation3, busAnnotation4, nil];
    
    T5AppDelegate *appDelegate = (T5AppDelegate *) [[UIApplication sharedApplication] delegate]; 
    if (appDelegate.monitorBuss){
        [self.mapView addAnnotations:self.busAnnotations];

    }
    else{
        [self.mapView removeAnnotations:self.busAnnotations];
    }
    if (appDelegate.monitorStation) {
        [self.mapView addAnnotations:self.stationAnnotations];
    }
    else{
        [self.mapView removeAnnotations:self.stationAnnotations];
    }
    if (appDelegate.monitorRoute){
        [self.mapView addOverlay:self.routeRedLine];
        [self.mapView addOverlay:self.routeBlueLine];
    }
    else{
        [self.mapView removeOverlay:self.routeRedLine];
        [self.mapView removeOverlay:self.routeBlueLine];
    }
    
    [self.mapView setVisibleMapRect:_routeRedRect];
    [self.mapView setVisibleMapRect:_routeBlueRect];
}

-(void) loadRedRoute
{
	NSString* filePath = [[NSBundle mainBundle] pathForResource:@"RedRoute" ofType:@"csv"];
	NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
	NSArray* pointStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	    
	// while we create the route points, we will also be calculating the bounding box of our route
	// so we can easily zoom in on it. 
	MKMapPoint northEastPoint; 
	MKMapPoint southWestPoint; 
	
	// create a c array of points. 
	MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * pointStrings.count);
    
	for(int idx = 0; idx < pointStrings.count; idx++)
	{        
		// break the string down even further to latitude and longitude fields. 
		NSString* currentPointString = [pointStrings objectAtIndex:idx];
		NSArray* latLonArr = [currentPointString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        
		CLLocationDegrees latitude  = [[latLonArr objectAtIndex:0] doubleValue];
		CLLocationDegrees longitude = [[latLonArr objectAtIndex:1] doubleValue];
        
		// create our coordinate and add it to the correct spot in the array 
		CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
                
		MKMapPoint point = MKMapPointForCoordinate(coordinate);
        
		
		//
		// adjust the bounding box
		//
		
		// if it is the first point, just use them, since we have nothing to compare to yet. 
        if (idx == 0) {
			northEastPoint = point;
			southWestPoint = point;
		}
		else 
		{
			if (point.x > northEastPoint.x) 
				northEastPoint.x = point.x;
			if(point.y > northEastPoint.y)
				northEastPoint.y = point.y;
			if (point.x < southWestPoint.x) 
				southWestPoint.x = point.x;
			if (point.y < southWestPoint.y) 
				southWestPoint.y = point.y;
		}        
		pointArr[idx] = point;
    }
	
	// create the polyline based on the array of points. 
	self.routeRedLine = [MKPolyline polylineWithPoints:pointArr count:pointStrings.count];
    
	_routeRedRect = MKMapRectMake(southWestPoint.x, southWestPoint.y, northEastPoint.x - southWestPoint.x, northEastPoint.y - southWestPoint.y);
    
	// clear the memory allocated earlier for the points
	free(pointArr);
	
}

-(void) loadBlueRoute
{
	NSString* filePath = [[NSBundle mainBundle] pathForResource:@"BlueRoute" ofType:@"csv"];
	NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
	NSArray* pointStrings = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
	// while we create the route points, we will also be calculating the bounding box of our route
	// so we can easily zoom in on it. 
	MKMapPoint northEastPoint; 
	MKMapPoint southWestPoint; 
	
	// create a c array of points. 
	MKMapPoint* pointArr = malloc(sizeof(CLLocationCoordinate2D) * pointStrings.count);
    
	for(int idx = 0; idx < pointStrings.count; idx++)
	{        
		// break the string down even further to latitude and longitude fields. 
		NSString* currentPointString = [pointStrings objectAtIndex:idx];
		NSArray* latLonArr = [currentPointString componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@","]];
        
		CLLocationDegrees latitude  = [[latLonArr objectAtIndex:0] doubleValue];
		CLLocationDegrees longitude = [[latLonArr objectAtIndex:1] doubleValue];
        
		// create our coordinate and add it to the correct spot in the array 
		CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        
		MKMapPoint point = MKMapPointForCoordinate(coordinate);
        
		
		//
		// adjust the bounding box
		//
		
		// if it is the first point, just use them, since we have nothing to compare to yet. 
        if (idx == 0) {
			northEastPoint = point;
			southWestPoint = point;
		}
		else 
		{
			if (point.x > northEastPoint.x) 
				northEastPoint.x = point.x;
			if(point.y > northEastPoint.y)
				northEastPoint.y = point.y;
			if (point.x < southWestPoint.x) 
				southWestPoint.x = point.x;
			if (point.y < southWestPoint.y) 
				southWestPoint.y = point.y;
		}        
		pointArr[idx] = point;
    }
	
	// create the polyline based on the array of points. 
	self.routeBlueLine = [MKPolyline polylineWithPoints:pointArr count:pointStrings.count];
    
	_routeBlueRect = MKMapRectMake(southWestPoint.x, southWestPoint.y, northEastPoint.x - southWestPoint.x, northEastPoint.y - southWestPoint.y);
    
	// clear the memory allocated earlier for the points
	free(pointArr);
	
}

- (IBAction)pageCurl:(id)sender {
    T5SettingsViewController *settingsView = [[T5SettingsViewController alloc] init];
    settingsView.modalTransitionStyle = UIModalTransitionStylePartialCurl;
    [self presentModalViewController:settingsView animated:YES];
    
}

- (void)refresh {
    T5AppDelegate *appDelegate = (T5AppDelegate *) [[UIApplication sharedApplication] delegate]; 
    if (appDelegate.monitorBuss){
        [self.mapView addAnnotations:self.busAnnotations];
        
    }
    else{
        [self.mapView removeAnnotations:self.busAnnotations];
    }
    if (appDelegate.monitorStation) {
        [self.mapView addAnnotations:self.stationAnnotations];
    }
    else{
        [self.mapView removeAnnotations:self.stationAnnotations];
    }
    if (appDelegate.monitorRoute){
        [self.mapView addOverlay:self.routeRedLine];
        [self.mapView addOverlay:self.routeBlueLine];
    }
    else{
        [self.mapView removeOverlay:self.routeRedLine];
        [self.mapView removeOverlay:self.routeBlueLine];
    }
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
	MKOverlayView* overlayView = nil;
	
	if(overlay == self.routeRedLine)
	{
		//if we have not yet created an overlay view for this overlay, create it now. 
		if(nil == self.routeRedLineView)
		{
			self.routeRedLineView = [[MKPolylineView alloc] initWithPolyline:self.routeRedLine];
			self.routeRedLineView.fillColor = [UIColor redColor];
			self.routeRedLineView.strokeColor = [UIColor redColor];
			self.routeRedLineView.lineWidth = 4;
		}
		
		overlayView = self.routeRedLineView;
		
	}
    
    if(overlay == self.routeBlueLine)
	{
		//if we have not yet created an overlay view for this overlay, create it now. 
		if(nil == self.routeBlueLineView)
		{
			self.routeBlueLineView = [[MKPolylineView alloc] initWithPolyline:self.routeBlueLine];
			self.routeBlueLineView.fillColor = [UIColor blueColor];
			self.routeBlueLineView.strokeColor = [UIColor blueColor];
			self.routeBlueLineView.lineWidth = 4;
		}
		
		overlayView = self.routeBlueLineView;
		
	}
	
	return overlayView;
	
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setMapController:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)infoButton:(id)sender {
    T5InfoViewController *infoView = [[T5InfoViewController alloc] init];
    infoView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:infoView animated:YES];
}

- (IBAction)alertButton:(id)sender {
    NSURL *url = [NSURL URLWithString:@"http://twitter.com/#!/WLUtraveller"];
    T5WebViewController *webViewController = [[T5WebViewController alloc] initWithURL:url andTitle:@"Traveller Notifications"]; 
    [self presentModalViewController:webViewController animated:YES];
}

-(MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if (annotation != self.mapView.userLocation && !([annotation.title isEqualToString:@"Traveller Bus #1"] || [annotation.title isEqualToString:@"Traveller Bus #2"] || [annotation.title isEqualToString:@"Traveller Bus #3"] || [annotation.title isEqualToString:@"Traveller Bus #4"])){
        MKPinAnnotationView *MyPin=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
        
        if ([annotation.subtitle isEqualToString:@"Transfer Station"]) {
            MyPin.pinColor = MKPinAnnotationColorPurple;
        }
        else if([annotation.subtitle isEqualToString:@"Blue City Route"]){
            MyPin.pinColor = MKPinAnnotationColorGreen;
        }
        else {
            MyPin.pinColor = MKPinAnnotationColorRed;
        }
    
        UIButton *advertButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [advertButton addTarget:self action:@selector(button:) forControlEvents:UIControlEventTouchUpInside];
    
        MyPin.rightCalloutAccessoryView = advertButton;
        MyPin.draggable = NO;
        MyPin.highlighted = YES;
        MyPin.animatesDrop=TRUE;
        MyPin.canShowCallout = YES;
        return MyPin;
    }
    else if (([annotation.title isEqualToString:@"Traveller Bus #1"] || [annotation.title isEqualToString:@"Traveller Bus #2"] || [annotation.title isEqualToString:@"Traveller Bus #3"] || [annotation.title isEqualToString:@"Traveller Bus #4"])){
        MKAnnotationView *MyAnnotation = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"current"];
        MyAnnotation.enabled = YES;
        MyAnnotation.draggable = NO;
        MyAnnotation.highlighted = YES;
        MyAnnotation.canShowCallout = YES;
        UIImage *Image = [UIImage imageNamed:@"BusOrig.png"];
        MyAnnotation.image = Image;
        return MyAnnotation;
    }
    else{ 
        return nil;
    }
}

-(void)button:(id)sender {
    T5StationViewController *annotationView = [[T5StationViewController alloc] init];
    annotationView.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:annotationView animated:YES];
}


@end
