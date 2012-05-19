//
//  TestTraveller5_Threads.m
//  Traveller5
//
//  Created by Garrett Koller on 5/18/12.
//  Copyright (c) 2012 Washington and Lee University. All rights reserved.
//

#import "XPathQuery.h"

#import "TestTraveller5_Threads.h"

@implementation TestTraveller5_Threads

- (void)testGPSquery_runThread
{
    [NSThread detachNewThreadSelector:@selector(runThread:) toTarget:[T5GPSquery class] withObject:nil];
    while(TRUE)
        sleep(15);
}

@end
