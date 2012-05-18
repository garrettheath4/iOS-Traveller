//
//  TestTraveller5.m
//  TestTraveller5
//
//  Created by Garrett Koller on 5/17/12.
//  Copyright (c) 2012 Washington and Lee University. All rights reserved.
//

#import "TestTraveller5.h"

@implementation TestTraveller5

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in TestTraveller5");
    [self testGPSquery];
}

- (void)testGPSquery
{
    T5GPSquery *query = [[T5GPSquery alloc] initWithViewController:nil];
    STAssertFalse([query isConnected], @"GPS query should be disconnected.");
    
}

@end
