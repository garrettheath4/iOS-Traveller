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
@synthesize mapView;
@synthesize stationAnnotations = _stationAnnotations;


- (IBAction)getLocation:(id)sender {
    double miles = 12.0; 
    double scalingFactor = ABS( cos(2 * M_PI * mapView.userLocation.coordinate.latitude /360.0) );
    MKCoordinateSpan span;
    span.latitudeDelta = miles/350.0; 
    span.longitudeDelta = miles/( scalingFactor*350.0 );
    MKCoordinateRegion region;
    region.span = span;
    region.center = mapView.userLocation.coordinate;
    [self.mapView setRegion:region animated:YES];

}

- (IBAction)setMap:(id)sender {
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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

- (void)viewDidUnload
{
    [self setMapView:nil];
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

- (IBAction)stationButton:(id)sender{
    
}

- (void) updateMap
{
    ;
}

- (IBAction)getStations:(id)sender {
}
     
@end
