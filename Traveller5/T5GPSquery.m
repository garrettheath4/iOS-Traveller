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

@synthesize bytesRead=_bytesRead;

@synthesize names=_names;
@synthesize descriptions=_descriptions;
@synthesize points=_points;

#pragma mark Instance Methods

- (void)queryService:(NSString *)pointName withParent:(UIViewController *)controller {
    viewController = (T5ViewController *)controller;
    responseData = [NSMutableData data];
    
    NSString *urlStr = [NSString stringWithString:@"http://travellerapp.dnsdynamic.com"];
    theURL = [NSURL URLWithString:urlStr];
    if (!theURL) {
        NSLog(@"%@ is not a valid URL", theURL);
        return;
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
}

-(void)dealloc {
    [self setNames:nil];
    [self setDescriptions:nil];
    [self setPoints:nil];
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    
    switch(eventCode) {
        case NSStreamEventHasBytesAvailable:
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


// Retrieves the content of an XML node, such as the temperature, wind,
// or humidity in the weather report.
//
- (NSString *)fetchContent:(NSArray *)nodes {
    NSString *result = @"";
    for ( NSDictionary *node in nodes ) {
        for ( id key in node ) {
            if( [key isEqualToString:@"nodeContent"] ) {
                result = [node objectForKey:key];
            }
        }
    }
    return result;
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
