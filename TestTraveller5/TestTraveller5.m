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
    [self testGPSquery_init];
}

////////////////////////////////////////////////////////////
// Test T5GPSquery
////////////////////////////////////////////////////////////

- (void)testGPSquery_init
{
    STAssertNotNil([[T5GPSquery alloc] initWithViewController:nil], @"Not successful in initializing T5GPSquery");
}

- (void)testGPSquery_connect
{
    T5GPSquery *query = [[T5GPSquery alloc] initWithViewController:nil];
    STAssertTrue([query isConnected], @"GPSquery should be connected after initialization");
}

@end










