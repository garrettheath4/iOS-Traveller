//
//  T5GPSquery.h
//  Traveller5
//
//  Created by Garrett Koller on 5/16/12.
//  Copyright (c) 2012 Washington and Lee University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "T5ViewController.h"

@class T5ViewController;

@interface T5GPSquery : NSObject <NSStreamDelegate> {
    // Parent View Controller
    T5ViewController *viewController;
    
    // Server info for GPS Points of Interest
    NSString *serverAddress;
    UInt32 port;
    
    // Data received from server
    NSInteger bytesRead;
    NSMutableData *responseData;
}

// UI Interface
@property (strong, nonatomic) T5ViewController *viewController;

// Connection properties
@property (weak, nonatomic) NSString *serverAddress;
@property (nonatomic) UInt32 port;
@property (strong, nonatomic) NSInputStream *inputStream;
@property (strong, nonatomic) NSOutputStream *outputStream;
@property (nonatomic) BOOL isConnectedState;

@property (nonatomic) BOOL requestWasSent;
@property (nonatomic) NSInteger bytesRead;
@property (weak, nonatomic) NSMutableData *responseData;
@property (nonatomic) BOOL hasDataState;

// Collected point data
@property (strong, nonatomic) NSMutableArray *names;
@property (strong, nonatomic) NSMutableArray *descriptions;
@property (strong, nonatomic) NSMutableArray *coords;

@property (strong, atomic) NSMutableDictionary *pointNameToCoords;

+ (void)runThread:(id)controller;

- (void)poll;
- (T5GPSquery *)initWithViewController:(UIViewController *)controller;
- (BOOL)isConnected;
- (BOOL)hasData;
- (void)sendMessage:(NSString *)message;
- (CLLocation *)queryService:(NSString *)pointName;

// For testing only
- (void) populateArray:(NSMutableArray *)array fromNodes:(NSArray*)nodes;


@end










