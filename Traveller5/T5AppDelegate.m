//
//  T5AppDelegate.m
//  Traveller5
//
//  Created by Alex Baca on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "T5AppDelegate.h"

#import "T5ViewController.h"

@implementation T5AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize locationManager = _locationManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.locationManager = [[CLLocationManager alloc] init]; 
    if ( [CLLocationManager locationServicesEnabled] ) {
        self.locationManager.delegate = self; 
        self.locationManager.distanceFilter = 1000; 
        [self.locationManager startUpdatingLocation];
    }
    
    self.viewController = [[T5ViewController alloc] initWithNibName:@"T5ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    double miles = 12.0; double scalingFactor =
    ABS( cos(2 * M_PI * newLocation.coordinate.latitude /360.0) );
    MKCoordinateSpan span;
    span.latitudeDelta = miles/69.0; span.longitudeDelta = miles/( scalingFactor*69.0 );
    MKCoordinateRegion region;
    region.span = span;
    region.center = newLocation.coordinate;
    [self.viewController.mapView setRegion:region animated:YES];
    self.viewController.mapView.showsUserLocation = YES; 
}

@end
