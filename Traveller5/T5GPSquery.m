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

@synthesize serverAddress=_serverAddress;
@synthesize port=_port;
@synthesize inputStream=_inputStream;
@synthesize outputStream=_outputStream;
@synthesize isConnectedState=_isConnectedState;

@synthesize requestWasSent=_requestWasSent;
@synthesize bytesRead=_bytesRead;
@synthesize responseData=_responseData;
@synthesize hasDataState=_hasDataState;

@synthesize names=_names;
@synthesize descriptions=_descriptions;
@synthesize points=_points;

const BOOL DEBUG_XML = NO;

#pragma mark Instance Methods

- (T5GPSquery *)initWithViewController:(UIViewController *)controller {
    self = [self init];
    if (self) {
        // Custom initialization
        ////////////////////////
        
        // UI Interface
        [self setViewController:(T5ViewController *)controller];
        
        // Connection properties
        [self setServerAddress:[NSString stringWithString:@"travellerapp.dnsdynamic.com"]];
        [self setPort:(UInt32)58974];
        [self setIsConnectedState:NO];
        
        [self setRequestWasSent:NO];
        [self setBytesRead:0];
        [self setResponseData:[NSMutableData data]];
        [self setHasDataState:NO];
        
        [self setNames:[NSMutableData data]];
        [self setDescriptions:[NSMutableData data]];
        [self setPoints:[NSMutableData data]];
    } else {
        assert(NO);
    }
    [self connect];
    return self;
}

-(void) incrementBytesRead:(NSInteger)increment {
    [self setBytesRead:([self bytesRead] + increment)];
}

- (BOOL)isConnected {
    return [self isConnectedState];
}

- (void)connect {
    if ([self isConnected]) {
        NSLog(@"Warning: connect: method called on object that is already connected.");
    }
    
    CFStringRef serverAddressRef = (__bridge CFStringRef)[self serverAddress];
    
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    NSLog(@"Attempting to connect to %@ on port %lu.", [self serverAddress], [self port]);
    
    CFStreamCreatePairWithSocketToHost(NULL, serverAddressRef, [self port], &readStream, &writeStream);
    
    [self setInputStream:(__bridge_transfer NSInputStream *)readStream];
    [self setOutputStream:(__bridge_transfer NSOutputStream *)writeStream];
    [[self inputStream] setDelegate:self];
    [[self outputStream] setDelegate:self];
    [[self inputStream] scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [[self outputStream] scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    //[[self inputStream] open];
    [[self outputStream] open];

    [self setIsConnectedState:YES];
}

//- (void)sendMessage:(NSString *)message {
//    NSString *response = [[NSString stringWithFormat:message] stringByAppendingString:@"\n"];
//    NSData *data = [[NSData alloc] initWithData:[response dataUsingEncoding:NSASCIIStringEncoding]];
//    [[self outputStream] write:[data bytes] maxLength:[data length]];
//}

- (void)sendMessage:(NSString *)message {
    NSLog(@"Sending message: %@", message);
    NSString *stringToSend = [NSString stringWithFormat:@"%@\n", message];
    NSData *dataToSend = [stringToSend dataUsingEncoding:NSUTF8StringEncoding];
    if ([self outputStream]) {
        int remainingToWrite = [dataToSend length];
        void * marker = (void *)[dataToSend bytes];
        while (0 < remainingToWrite) {
            int actuallyWritten = 0;
            actuallyWritten = [[self outputStream] write:marker maxLength:remainingToWrite];
            remainingToWrite -= actuallyWritten;
            marker += actuallyWritten;
        }
    }
}

//- (void)receiveMessage {
//    if(!responseData) {
//        responseData = [NSMutableData data];
//    }
//    NSLog(@"Reading inputStream");
//    uint8_t buf[1024];
//    unsigned int len = 0;
//    while ([[self inputStream] hasBytesAvailable]) {
//        len = [[self inputStream] read:buf maxLength:1024];
//        if(len) {
//            [responseData appendBytes:(const void *)buf length:len];
//            // bytesRead is an instance variable of type NSNumber.
//            [self setBytesRead:([self bytesRead] + len)];
//            [self setHasDataState:YES];
//        } else {
//            NSLog(@"no buffer!");
//        }
//    }
//    NSLog(@"responseData read %d bytes", [responseData length]);
//}

- (void)receiveMessage {
    NSLog(@"Receiving message");
    uint8_t buf[2048];
    int actuallyRead = 0;
    BOOL done = NO;
    if (![self responseData]) {
        responseData = [[NSMutableData alloc] initWithCapacity:2048];
    }
    while (!done) {
        actuallyRead = [[self inputStream] read:buf maxLength:2048];
        [self incrementBytesRead:actuallyRead];
        if (actuallyRead >= 1) {
            [[self responseData] appendBytes:buf length:actuallyRead];
        } else {
            done = YES;
        }
        if (buf[[self bytesRead] - 1] == '\n') {
            // We've got the carriage return at the end of the echo. Let's set the string.
            NSLog(@"Reached the end of a line while reading from input");
        }
    }
    [self setHasDataState:YES];
    NSLog(@"Received data: %@", [[NSString alloc] initWithData:[self responseData] encoding:NSUTF8StringEncoding]);
    
    [self parseToXML];
}

- (void)disconnect {
    if (![self isConnected] || ![self inputStream] || ![self outputStream]) {
        NSLog(@"Warning: disconnect: method called on object that is already disconnected.");
    }
    [[self inputStream] removeFromRunLoop:[NSRunLoop currentRunLoop]
                      forMode:NSDefaultRunLoopMode];
    [[self outputStream] removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [[self inputStream] close];
    [[self outputStream] close];
    [self setIsConnectedState:NO];
}

- (BOOL)hasData {
    //if ([[self inputStream] hasBytesAvailable]) {
    //    NSLog(@"inputStream has bytes available, but did it notify the delegate?");
    //}
    return [self hasDataState];
}

- (void)fetchData {
    NSLog(@"Sending \"GET *ALL\" request.");
    
    NSString *message = [NSString stringWithFormat:
                      @"GET *ALL"];
    /*
    const uint8_t * rawstring = (const uint8_t *)[message UTF8String];
    [[self outputStream] write:rawstring maxLength:[message length]];
    */
    [self sendMessage:message];
    [self setRequestWasSent:YES];
    
    //[[self outputStream] close];
    [[self inputStream] open];
    
    [self receiveMessage];
}

- (void)parseToXML {
    NSString *xpathQueryString;
    NSArray *nodes;
    
    // Point of Information Data ////////////////////////////////////////
    
    // Fill the array (an NSMutableArray) of placemark names
    //
    NSMutableArray * tmp_names = [[NSMutableArray alloc] init];
    xpathQueryString = @"/kml/Document/Placemark/name";
    nodes = PerformXMLXPathQuery([self responseData], xpathQueryString);
    if (DEBUG_XML || [nodes count] < 1) {
        NSLog(@"Nodes found for names: %d", [nodes count]);
    }
    [self populateArray:tmp_names fromNodes:nodes];
    NSLog(@"names = %@", tmp_names);
    self.names = tmp_names;
    
    // Fill the array (an NSMutableArray) of placemark descriptions
    //
    NSMutableArray * tmp_descriptions = [[NSMutableArray alloc] init];
    xpathQueryString = @"/kml/Document/Placemark/description";
    nodes = PerformXMLXPathQuery((NSData *)[self responseData], xpathQueryString);
    if (DEBUG_XML || [nodes count] < 1) {
        NSLog(@"Nodes found for descriptions: %d", [nodes count]);
    }
    [self populateArray:tmp_descriptions fromNodes:nodes];
    NSLog(@"descriptions = %@", tmp_descriptions);
    self.descriptions = tmp_descriptions;
    
    // Fill the array (an NSMutableArray) of point coordinates
    //
    NSMutableArray * tmp_points = [[NSMutableArray alloc] init];
    xpathQueryString = @"/kml/Document/Placemark/Point/coordinates";
    nodes = PerformXMLXPathQuery([self responseData], xpathQueryString);
    if (DEBUG_XML || [nodes count] < 1) {
        NSLog(@"Nodes found for points: %d", [nodes count]);
    }
    [self populateArray:tmp_points fromNodes:nodes];
    NSLog(@"points = %@", tmp_points);
    self.points = tmp_points;
    
    [[self inputStream] close];
    [[self inputStream] removeFromRunLoop:[NSRunLoop currentRunLoop]
                      forMode:NSDefaultRunLoopMode];
    [self setInputStream:nil];
    
    [viewController updateMap];
}

- (void)queryService:(NSString *)pointName {
    assert([self hasData]);
}

-(void)dealloc {
    [self setViewController:nil];
    
    [self setServerAddress:nil];
    [self setInputStream:nil];
    [self setOutputStream:nil];
    
    [self setResponseData:nil];
    
    [self setNames:nil];
    [self setDescriptions:nil];
    [self setPoints:nil];
}

- (void)stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode {
    
    NSLog(@"stream:handleEvent: (Event %d) activated", eventCode);
    if (stream == [self inputStream]) {
        NSLog(@"stream:handleEvent: was called by the input stream");
    } else if (stream == [self outputStream]) {
        NSLog(@"stream:handleEvent: was called by the output stream");
    } else {
        NSLog(@"Unknown stream!");
    }
    
    switch(eventCode) {
        case NSStreamEventOpenCompleted:
        {
            if (stream == [self inputStream])
            {
                NSLog(@"inputStream opened");
            } else {
                // The event happened in the output stream
                assert(stream == [self outputStream]);
                NSLog(@"outputStream opened");
            }

            break;
        }
            
        case NSStreamEventHasBytesAvailable:
        {
            if (stream == [self inputStream])
            {
                NSLog(@"inputStream has bytes available");
                [self receiveMessage];
            } else {
                // The event happened in the output stream
                assert(stream == [self outputStream]);
                NSLog(@"outputStream has bytes available");
            }
            break;
        }
            
        case NSStreamEventErrorOccurred:
        {
            NSLog(@"Can not connect to the host!");
            break;
        }

        case NSStreamEventEndEncountered:
        {
            NSLog(@"Reached the end of a stream");
            
            [self parseToXML];
            
            break;
        }
            
        case NSStreamEventHasSpaceAvailable:
        {
            if (stream == [self inputStream])
            {
                NSLog(@"The input stream reports that it has space available");
            } else {
                assert(stream == [self outputStream]);
                NSLog(@"The output stream reports that it has space available");
                if (![self requestWasSent])
                {
                    //[self fetchData];
                } else {
                    [stream close];
                }
            }
            break;
        }
            
        case NSStreamEventNone:
        {
            if (stream == [self inputStream])
            {
                NSLog(@"The input stream reports no event");
            } else {
                assert(stream == [self outputStream]);
                NSLog(@"The output stream reports no event");
            }
            break;
        }
        
        default:
            NSLog(@"Unknown event");
    }
}

// For nodes that contain more than one value we are interested in,
// this method fills an NSMutableArray with the values it finds.
// For example, the forecast returns four days, so there will be
// an array with four day names, an array with four forecast icons,
// and so forth.
//
- (void) populateArray:(NSMutableArray *)array fromNodes:(NSArray*)nodes {
    if (DEBUG_XML) NSLog(@"populateArray:fromNodes: Populating array with XML data from %d nodes", [nodes count]);
    for ( NSDictionary *node in nodes ) {
        for ( id key in node ) {
            if (DEBUG_XML) NSLog(@"Key in dictionary: %@", key);
            if( [key isEqualToString:@"nodeContent"] ) {
                [array addObject:[node objectForKey:key]];
            }
        }
    }
}

@end


