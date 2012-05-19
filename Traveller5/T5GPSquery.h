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
@property (weak, nonatomic) NSMutableArray *names;
@property (weak, nonatomic) NSMutableArray *descriptions;
@property (weak, nonatomic) NSMutableArray *coords;

@property (strong, nonatomic) NSMutableDictionary *pointNameToCoords;

- (T5GPSquery *)initWithViewController:(UIViewController *)controller;
- (BOOL)isConnected;
- (BOOL)hasData;
- (void)sendMessage:(NSString *)message;
- (void)fetchData;
- (void)queryService:(NSString *)pointName;
- (void) populateArray:(NSMutableArray *)array fromNodes:(NSArray*)nodes;


@end
