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
@synthesize coords=_coords;

@synthesize pointNameToCoords=_pointNameToCoords;

const UInt32 BUF_SIZE = 10240;

const BOOL DEBUG_SOCKETS = NO;
const BOOL DEBUG_XML = NO;

#pragma mark - Instance Methods

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
        [self setCoords:[NSMutableData data]];
        
        [self setPointNameToCoords:[[NSMutableDictionary alloc] init]];
    } else {
        assert(NO);
    }
    return self;
}

+ (void)runThread:(id)controller {
    T5GPSquery *query = [[T5GPSquery alloc] initWithViewController:(T5ViewController *)controller];
    while (TRUE) {
        [query poll];
        sleep(1);
    }
}

- (void)poll {
    //if (![self isConnected] || ![self outputStream] || ![self inputStream]) {
        [self connect];
    //}
    [self fetchData];
    [self parseToXML];
    [self fillPointDictionary];
    [[self viewController] updateMap];
    [self disconnect];
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
    
    [self setInputStream:(__bridge NSInputStream *)readStream];
    [self setOutputStream:(__bridge NSOutputStream *)writeStream];
    [[self inputStream] setDelegate:self];
    [[self outputStream] setDelegate:self];
    [[self inputStream] scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [[self outputStream] scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [[self inputStream] open];
    [[self outputStream] open];
    
    [self setIsConnectedState:YES];
}

- (BOOL)hasData {
    //if ([[self inputStream] hasBytesAvailable]) {
    //    NSLog(@"inputStream has bytes available, but did it notify the delegate?");
    //}
    return [self hasDataState];
}

- (void)sendMessage:(NSString *)message {
    NSLog(@"Sending message: %@", message);
    NSString *stringToSend = [NSString stringWithFormat:@"%@\n", message];
    NSData *dataToSend = [stringToSend dataUsingEncoding:NSUTF8StringEncoding];
    if ([self outputStream]) {
        while(![[self outputStream] hasSpaceAvailable]) {
            NSLog(@"Waiting for outputStream to have space available to write message");
            sleep(1);
        }
        int remainingToWrite = [dataToSend length];
        void * marker = (void *)[dataToSend bytes];
        while (0 < remainingToWrite) {
            int actuallyWritten = 0;
            actuallyWritten = [[self outputStream] write:marker maxLength:remainingToWrite];
            remainingToWrite -= actuallyWritten;
            marker += actuallyWritten;
        }
        NSLog(@"Message sent");
    } else {
        NSLog(@"outputStream is not initialized");
    }
}

- (void)fetchData {
    if ([self requestWasSent]) {
        NSLog(@"Warning: re-fetching data after request was already sent");
    }
    NSLog(@"Sending \"GET *ALL\" request.");
    
    NSString *message = [NSString stringWithFormat:@"GET *ALL"];
    [self sendMessage:message];
    [self setRequestWasSent:YES];
    
    [self receiveMessage];
}

- (void)receiveMessage {
    NSLog(@"Receiving message");
    unsigned char *buf = malloc(BUF_SIZE);
    [self setBytesRead:0];
    int actuallyRead = 0;
    BOOL done = NO;
    if (![self responseData]) {
//        [self setResponseData:[[NSMutableData alloc] initWithCapacity:BUF_SIZE]];
        [self setResponseData:[NSMutableData data]];
    }
    while (![[self inputStream] hasBytesAvailable]) {
        NSLog(@"Waiting for inputStream to have bytes available to read");
        sleep(1);
    }
    while (!done) {
        actuallyRead = [[self inputStream] read:buf maxLength:BUF_SIZE];
        [self incrementBytesRead:actuallyRead];
        [self printBufferData:buf length:actuallyRead+1];
        if (actuallyRead >= 1) {
            NSLog(@"Appending %d bytes to responseData", actuallyRead);
            if (DEBUG_SOCKETS) {
                NSString *receivedStr = [[NSString alloc] initWithData:[self responseData] encoding:NSUTF8StringEncoding];
                NSLog(@"responseData before append (length %d): %@", [receivedStr length], receivedStr);
            }
            [[self responseData] appendBytes:buf length:actuallyRead];
            if (DEBUG_SOCKETS) {
                NSString *receivedStr = [[NSString alloc] initWithData:[self responseData] encoding:NSUTF8StringEncoding];
                NSLog(@"responseData after append (length %d): %@", [receivedStr length], receivedStr);
            }
        } else {
            if ([self bytesRead] > 0) {
                done = YES;
            }
        }
        if ([self bytesRead] > 0 && buf[[self bytesRead] - 1] == '\n') {
            // We've got the carriage return at the end of the echo. Let's set the string.
            NSLog(@"Reached the end of a line while reading from input");
        }
    }
    NSString *receivedStr = [[NSString alloc] initWithData:[self responseData] encoding:NSUTF8StringEncoding];
    NSLog(@"Received data (length %d): %@", [receivedStr length], receivedStr);
}

- (void)printBufferData:(uint8_t *)buf length:(int)size {
//    uint8_t buf[BUF_SIZE];
    NSMutableString *bytesStr = [[NSMutableString alloc] initWithCapacity:size*4+1];
    NSMutableString *charsStr = [[NSMutableString alloc] initWithCapacity:size+1];
    for (int i=0; i<size; i++) {
        [bytesStr appendFormat:@"%d ", buf[i]];
        [charsStr appendFormat:@"%@", [[NSString alloc] initWithBytes:&buf[i] length:1 encoding:NSUTF8StringEncoding]];
    }
    NSLog(@"Buffer Data: %@", bytesStr);
    NSLog(@"Buffer String: %@", charsStr);
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
    [self setNames:tmp_names];
    
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
    [self setDescriptions:tmp_descriptions];
    
    // Fill the array (an NSMutableArray) of point coordinates
    //
    NSMutableArray * tmp_coords = [[NSMutableArray alloc] init];
    xpathQueryString = @"/kml/Document/Placemark/Point/coordinates";
    nodes = PerformXMLXPathQuery([self responseData], xpathQueryString);
    if (DEBUG_XML || [nodes count] < 1) {
        NSLog(@"Nodes found for coords: %d", [nodes count]);
    }
    [self populateArray:tmp_coords fromNodes:nodes];
    NSLog(@"coords = %@", tmp_coords);
    [self setCoords:tmp_coords];
    
//    [[self inputStream] close];
//    [[self inputStream] removeFromRunLoop:[NSRunLoop currentRunLoop]
//                                  forMode:NSDefaultRunLoopMode];
//    [self setInputStream:nil];
    
    [self setResponseData:nil];
}

- (void)disconnect {
    if (![self isConnected] || ![self inputStream] || ![self outputStream]) {
        NSLog(@"Warning: disconnect: method called on object that is already disconnected.");
    }
    [[self inputStream] removeFromRunLoop:[NSRunLoop currentRunLoop]
                                  forMode:NSDefaultRunLoopMode];
    [[self outputStream] removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    //[[self inputStream] close];
    [[self outputStream] close];
    [self setIsConnectedState:NO];
    [self setRequestWasSent:NO];
}

-(void)dealloc {
    [self setViewController:nil];
    
    [self setServerAddress:nil];
    [self setInputStream:nil];
    [self setOutputStream:nil];
    
    [self setResponseData:nil];
    
    [self setNames:nil];
    [self setDescriptions:nil];
    [self setCoords:nil];
    
    [self setPointNameToCoords:nil];
}

-(void)incrementBytesRead:(NSInteger)increment {
    [self setBytesRead:([self bytesRead] + increment)];
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
                //[self setOutputStream:(NSOutputStream *)stream];
                //[self fetchData];
            }
            
            break;
        }
            
        case NSStreamEventHasBytesAvailable:
        {
            if (stream == [self inputStream])
            {
                NSLog(@"inputStream has bytes available");
                //[self receiveMessage];
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
            
            //[self parseToXML];
            
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
                    //[stream close];
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

- (void)fillPointDictionary {
    for (int i=0; i<[[self names] count]; i++) {
        NSArray *coordParts = [[[self coords] objectAtIndex:i] componentsSeparatedByString:@","];
        CLLocationDegrees longitude = [[coordParts objectAtIndex:1] doubleValue];
        CLLocationDegrees latitude = [[coordParts objectAtIndex:0] doubleValue];
        [[self pointNameToCoords] setValue:[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] forKey:[[self names] objectAtIndex:i]];
    }
    [self setHasDataState:YES];
}

- (CLLocation *)queryService:(NSString *)pointName {
    assert([self hasData]);
    return [[self pointNameToCoords] objectForKey:pointName];
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


