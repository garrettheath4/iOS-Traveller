//
//  TestTraveller5.m
//  TestTraveller5
//
//  Created by Garrett Koller on 5/17/12.
//  Copyright (c) 2012 Washington and Lee University. All rights reserved.
//

#import "TestTraveller5.h"

@implementation TestTraveller5

T5GPSquery *query;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    query = [[T5GPSquery alloc] initWithViewController:nil];
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
    [self testGPSquery_connect];
}

////////////////////////////////////////////////////////////
// Test T5GPSquery
////////////////////////////////////////////////////////////

- (void)testGPSquery_init
{
    STAssertNotNil(query, @"Not successful in initializing T5GPSquery");
}

- (void)testGPSquery_connect
{
    STAssertTrue([query isConnected], @"GPSquery should be connected after initialization");
}

- (void)testGPSquery_fetchData
{
    T5GPSquery *query2 = [[T5GPSquery alloc] initWithViewController:nil];
    [query2 fetchData];
    STAssertTrue([query2 hasData], @"GPSquery did not fetch any data");
}

@end










