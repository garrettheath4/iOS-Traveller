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

@interface T5ViewController ()

@end

@implementation T5ViewController
@synthesize mapView = _mapView;
@synthesize stationAnnotations = _stationAnnotations;
@synthesize mapController;
@synthesize stationBool = _stationBool;
@synthesize stationButton;
@synthesize routeLine = _routeLine;
@synthesize routeLineView = _routeLineView;


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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadRoute];
    
    if (nil != self.routeLine) {
		[self.mapView addOverlay:self.routeLine];
	}
    
    [self.mapView setVisibleMapRect:_routeRect];
    
    self.stationBool = YES;
        
    T5SimpleAnnotation *annotation1 = [[T5SimpleAnnotation alloc] init];
    CLLocationCoordinate2D coord = {37.786947, -79.444657};
    annotation1.coordinate = coord;
    annotation1.title = @"Freshman Quad";
    annotation1.subtitle = @"";
    
    T5SimpleAnnotation *annotation2 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.789894;
    coord.longitude = -79.444601;
    annotation2.coordinate = coord;
    annotation2.title = @"Woods Creek";
    annotation2.subtitle = @"";
    
    T5SimpleAnnotation *annotation3 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.7913974;
    coord.longitude = -79.443952;
    annotation3.coordinate = coord;
    annotation3.title = @"Law School";
    annotation3.subtitle = @"";
    
    T5SimpleAnnotation *annotation4 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.795019;
    coord.longitude = -79.447874;
    annotation4.coordinate = coord;
    annotation4.title = @"Pavilion";
    annotation4.subtitle = @"";
    
    T5SimpleAnnotation *annotation5 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.800523;
    coord.longitude = -79.459938;
    annotation5.coordinate = coord;
    annotation5.title = @"Log Cabins";
    annotation5.subtitle = @"";
    
    T5SimpleAnnotation *annotation6 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.789909;
    coord.longitude = -79.446516;
    annotation6.coordinate = coord;
    annotation6.title = @"Sorority Houses";
    annotation6.subtitle = @"";
    
    T5SimpleAnnotation *annotation7 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.784792;
    coord.longitude = -79.443794;
    annotation7.coordinate = coord;
    annotation7.title = @"Palms";
    annotation7.subtitle = @"";
    
    T5SimpleAnnotation *annotation8 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.784033;
    coord.longitude = -79.444608;
    annotation8.coordinate = coord;
    annotation8.title = @"Salernos";
    annotation8.subtitle = @"";
    
    T5SimpleAnnotation *annotation9 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.781539;
    coord.longitude = -79.440165;
    annotation9.coordinate = coord;
    annotation9.title = @"White St.";
    annotation9.subtitle = @"";
    
    T5SimpleAnnotation *annotation10 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.782032;
    coord.longitude = -79.439457;
    annotation10.coordinate = coord;
    annotation10.title = @"Davidson Park East";
    annotation10.subtitle = @"";
    
    T5SimpleAnnotation *annotation11 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.783848;
    coord.longitude = -79.44009;
    annotation11.coordinate = coord;
    annotation11.title = @"Davidson Park West";
    annotation11.subtitle = @"";
    
    T5SimpleAnnotation *annotation12 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.786426;
    coord.longitude = -79.441817;
    annotation12.coordinate = coord;
    annotation12.title = @"Red Square";
    annotation12.subtitle = @"";
    
    T5SimpleAnnotation *annotation13 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.784675;
    coord.longitude = -79.439172;
    annotation13.coordinate = coord;
    annotation13.title = @"Tucker and Henry St.";
    annotation13.subtitle = @"";
    
    T5SimpleAnnotation *annotation14 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.788675;
    coord.longitude = -79.437303;
    annotation14.coordinate = coord;
    annotation14.title = @"Diamond St.";
    annotation14.subtitle = @"";
    
    T5SimpleAnnotation *annotation15 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.789398;
    coord.longitude = -79.430592;
    annotation15.coordinate = coord;
    annotation15.title = @"Hook Lane";
    annotation15.subtitle = @"";
    
    T5SimpleAnnotation *annotation16 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.803638;
    coord.longitude = -79.430318;
    annotation16.coordinate = coord;
    annotation16.title = @"Top of Windfall Hill";
    annotation16.subtitle = @"";
    
    T5SimpleAnnotation *annotation17 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.802899;
    coord.longitude = -79.428052;
    annotation17.coordinate = coord;
    annotation17.title = @"Bottom of Windfall Hill";
    annotation17.subtitle = @"";
    
    T5SimpleAnnotation *annotation18 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.801146;
    coord.longitude = -79.427684;
    annotation18.coordinate = coord;
    annotation18.title = @"Top of Kappa Hill";
    annotation18.subtitle = @"";
    
    T5SimpleAnnotation *annotation19 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.802009;
    coord.longitude = -79.428789;
    annotation19.coordinate = coord;
    annotation19.title = @"Bottom of Kappa Hill";
    annotation19.subtitle = @"";
    
    T5SimpleAnnotation *annotation20 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.797128;
    coord.longitude = -79.431549;
    annotation20.coordinate = coord;
    annotation20.title = @"Greenhouses";
    annotation20.subtitle = @"";
    
    T5SimpleAnnotation *annotation21 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.794517;
    coord.longitude = -79.431367;
    annotation21.coordinate = coord;
    annotation21.title = @"County Seat";
    annotation21.subtitle = @"";
    
    T5SimpleAnnotation *annotation22 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.794618;
    coord.longitude = -79.433684;
    annotation22.coordinate = coord;
    annotation22.title = @"Pole Houses";
    annotation22.subtitle = @"";
    
    T5SimpleAnnotation *annotation23 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.791144;
    coord.longitude = -79.452586;
    annotation23.coordinate = coord;
    annotation23.title = @"Bordon Commons";
    annotation23.subtitle = @"";
    
    T5SimpleAnnotation *annotation24 = [[T5SimpleAnnotation alloc] init];
    coord.latitude = 37.785408;
    coord.longitude = -79.440178;
    annotation24.coordinate = coord;
    annotation24.title = @"Henry and Randolph St.";
    annotation24.subtitle = @"";
    
    self.stationAnnotations = [[NSArray alloc] initWithObjects:annotation1, annotation2, annotation3, annotation4, annotation5, annotation6, annotation7, annotation8, annotation9, annotation10, annotation11, annotation12, annotation13, annotation14, annotation15, annotation16, annotation17, annotation18, annotation19, annotation20, annotation21, annotation22, annotation23, annotation24, nil];
    [self.mapView addAnnotations:self.stationAnnotations];
}

-(void) loadRoute
{
	NSString* filePath = [[NSBundle mainBundle] pathForResource:@"route" ofType:@"csv"];
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
	self.routeLine = [MKPolyline polylineWithPoints:pointArr count:pointStrings.count];
    
	_routeRect = MKMapRectMake(southWestPoint.x, southWestPoint.y, northEastPoint.x - southWestPoint.x, northEastPoint.y - southWestPoint.y);
    
	// clear the memory allocated earlier for the points
	free(pointArr);
	
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay
{
	MKOverlayView* overlayView = nil;
	
	if(overlay == self.routeLine)
	{
		//if we have not yet created an overlay view for this overlay, create it now. 
		if(nil == self.routeLineView)
		{
			self.routeLineView = [[MKPolylineView alloc] initWithPolyline:self.routeLine];
			self.routeLineView.fillColor = [UIColor redColor];
			self.routeLineView.strokeColor = [UIColor redColor];
			self.routeLineView.lineWidth = 3;
		}
		
		overlayView = self.routeLineView;
		
	}
	
	return overlayView;
	
}

- (void)viewDidUnload
{
    [self setMapView:nil];
    [self setMapController:nil];
    [self setStationButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)infoButton:(id)sender {
    T5InfoViewController *infoView = [[T5InfoViewController alloc] init];
    [self presentModalViewController:infoView animated:YES];
}

- (IBAction)alertButton:(id)sender {
        NSURL *url = [NSURL URLWithString:@"http://twitter.com/#!/WLUtraveller"]; 
        T5WebViewController *webViewController = [[T5WebViewController alloc] initWithURL:url andTitle:@"Traveller Notifications"]; 
        [self presentModalViewController:webViewController animated:YES];
}

- (void) updateMap
{
    
}

- (IBAction)getStations:(id)sender {
    if (self.stationBool){
        [self.mapView removeAnnotations:self.stationAnnotations];
        self.stationBool = NO;
    }
    else{
        [self.mapView addAnnotations:self.stationAnnotations];
        self.stationBool = YES;
    }
}
     
@end
