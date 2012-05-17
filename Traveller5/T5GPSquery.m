//
//  T5GPSquery.m
//  Traveller5
//
//  Created by Garrett Koller on 5/16/12.
//  Copyright (c) 2012 Washington and Lee University. All rights reserved.
//

#import "XPathQuery.h"

#import "T5GPSquery.h"
#import "T5ViewController.h"

@implementation T5GPSquery

@synthesize viewController=_viewController;

@synthesize theURL=_theURL;
@synthesize port=_port;
@synthesize inputStream=_inputStream;
@synthesize outputStream=_outputStream;
@synthesize isConnectedState=_isConnectedState;

@synthesize bytesRead=_bytesRead;
@synthesize responseData=_responseData;
@synthesize hasDataState=_hasDataState;

@synthesize names=_names;
@synthesize descriptions=_descriptions;
@synthesize points=_points;

#pragma mark Instance Methods

- (T5GPSquery *)initWithViewController:(UIViewController *)controller {
    self = [self init];
    if (self) {
        // Custom initialization
        ////////////////////////
        
        // UI Interface
        [self setViewController:(T5ViewController *)controller];
        
        // Connection properties
        [self setTheURL:[NSURL URLWithString:[NSString stringWithString:@"http://travellerapp.dnsdynamic.com"]]];
        if (![self theURL]) {
            NSLog(@"%@ is not a valid URL", theURL);
        }
        [self setPort:58974];
        [self setIsConnectedState:NO];
        
        [self setBytesRead:0];
        [self setResponseData:[NSMutableData data]];
        [self setHasDataState:NO];
        
        [self setNames:[NSMutableData data]];
        [self setDescriptions:[NSMutableData data]];
        [self setPoints:[NSMutableData data]];
    }
    return self;
}

- (BOOL)isConnected {
    return [self isConnectedState];
}

- (void)connect {
    if ([self isConnected]) {
        NSLog(@"Warning: connect: method called on object that is already connected.");
    }
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    CFStreamCreatePairWithSocketToHost(nil, (__bridge CFStringRef)[theURL host], port, &readStream, &writeStream);
    
    NSInputStream *inputStream = (__bridge_transfer NSInputStream *)readStream;
    NSOutputStream *outputStream = (__bridge_transfer NSOutputStream *)writeStream;
    [inputStream setDelegate:self];
    [outputStream setDelegate:self];
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    [outputStream open];
    
    [self setIsConnectedState:YES];
}

- (void)disconnect {
    if (![self isConnected] || ![self inputStream] || ![self outputStream]) {
        NSLog(@"Warning: disconnect: method called on object that is already disconnected.");
    }
    [[self inputStream] close];
    [[self outputStream] close];
    [self setIsConnectedState:NO];
}

- (BOOL)hasData {
    return [self hasDataState];
}

- (void)fetchData {
    
}

- (void)queryService:(NSString *)pointName {    
    assert([self hasData]);
}

-(void)dealloc {
    [self setViewController:nil];
    
    [self setTheURL:nil];
    [self setInputStream:nil];
    [self setOutputStream:nil];
    
    [self setResponseData:nil];
    
    [self setNames:nil];
    [self setDescriptions:nil];
    [self setPoints:nil];
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    
    switch(eventCode) {
        case NSStreamEventHasBytesAvailable:
        {
            if (stream == [self inputStream])
            {
                if(!responseData) {
                    responseData = [NSMutableData data];
                }
                uint8_t buf[1024];
                unsigned int len = 0;
                len = [(NSInputStream *)stream read:buf maxLength:1024];
                if(len) {
                    [responseData appendBytes:(const void *)buf length:len];
                    // bytesRead is an instance variable of type NSNumber.
                    bytesRead += len;
                } else {
                    NSLog(@"no buffer!");
                }
            } else {
                // The event happened in the output stream
                assert(stream == [self outputStream]);
                
                NSString * str = [NSString stringWithFormat:
                                  @"GET *ALL\r\n\r\n"];
                const uint8_t * rawstring = (const uint8_t *)[str UTF8String];
                [[self outputStream] write:rawstring maxLength:strlen(rawstring)];
                [[self outputStream] close];
            }
                break;
        }
        case NSStreamEventEndEncountered:
        {
            NSString *xpathQueryString;
            NSArray *nodes;
            
            // Point of Information Data ////////////////////////////////////////
            
            // Fill the array (an NSMutableArray) of placemark names
            //
            NSMutableArray * tmp_names = [[NSMutableArray alloc] init];
            xpathQueryString = @"//Document/Placemark/name";
            nodes = PerformXMLXPathQuery(responseData, xpathQueryString);
            [self populateArray:tmp_names fromNodes:nodes];
            NSLog(@"names = %@", tmp_names);
            self.names = tmp_names;
            
            // Fill the array (an NSMutableArray) of placemark descriptions
            //
            NSMutableArray * tmp_descriptions = [[NSMutableArray alloc] init];
            xpathQueryString = @"//Document/Placemark/description";
            nodes = PerformXMLXPathQuery(responseData, xpathQueryString);
            [self populateArray:tmp_descriptions fromNodes:nodes];
            NSLog(@"descriptions = %@", tmp_descriptions);
            self.descriptions = tmp_descriptions;
            
            // Fill the array (an NSMutableArray) of point coordinates
            //
            NSMutableArray * tmp_points = [[NSMutableArray alloc] init];
            xpathQueryString = @"//Document/Placemark/Point/coordinates";
            nodes = PerformXMLXPathQuery(responseData, xpathQueryString);
            [self populateArray:tmp_points fromNodes:nodes];
            NSLog(@"points = %@", tmp_points);
            self.points = tmp_points;

            [stream close];
            [stream removeFromRunLoop:[NSRunLoop currentRunLoop]
                              forMode:NSDefaultRunLoopMode];
            stream = nil; // stream is ivar, so reinit it
            break;
            
            [viewController updateMap];
        }
    }
}

// For nodes that contain more than one value we are interested in,
// this method fills an NSMutableArray with the values it finds.
// For example, the forecast returns four days, so there will be
// an array with four day names, an array with four forecast icons,
// and so forth.
//
- (void) populateArray:(NSMutableArray *)array fromNodes:(NSArray*)nodes {
    for ( NSDictionary *node in nodes ) {
        for ( id key in node ) {
            if( [key isEqualToString:@"nodeContent"] ) {
                [array addObject:[node objectForKey:key]];
            }
        }
    }
}

@end


