//
//  T5GPSquery.h
//  Traveller5
//
//  Created by Garrett Koller on 5/16/12.
//  Copyright (c) 2012 Washington and Lee University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T5ViewController.h"

@interface T5GPSquery : NSObject <NSStreamDelegate> {
    // Parent View Controller
    T5ViewController *viewController;
    
    // Server info for GPS Points of Interest
    NSURL *theURL;
    NSInteger port;
    
    // Data received from server
    NSMutableData *responseData;
    NSInteger *bytesRead;
}

@property (nonatomic) NSInteger *bytesRead;

// Forecast conditions
@property (weak, nonatomic) NSMutableArray *names;
@property (weak, nonatomic) NSMutableArray *descriptions;
@property (weak, nonatomic) NSMutableArray *points;

- (void)queryService:(NSString *)city withParent:(UIViewController *)controller;

@end
