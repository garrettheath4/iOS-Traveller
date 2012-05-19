//
//  TestTraveller5.m
//  TestTraveller5
//
//  Created by Garrett Koller on 5/17/12.
//  Copyright (c) 2012 Washington and Lee University. All rights reserved.
//

#import "XPathQuery.h"

#import "TestTraveller5.h"

@implementation TestTraveller5

T5GPSquery *query;

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    query = nil;
    [super tearDown];
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in TestTraveller5");
    //[self testGPSquery_init];
    //[self testGPSquery_connect];
    //[self testGPSquery_sendMessage];
}

////////////////////////////////////////////////////////////
// Test T5GPSquery
////////////////////////////////////////////////////////////

- (void)testGPSquery_init
{
    query = [[T5GPSquery alloc] initWithViewController:nil];
    STAssertNotNil(query, @"Not successful in initializing T5GPSquery");
}

//- (void)testGPSquery_connect
//{
//    query = [[T5GPSquery alloc] initWithViewController:nil];
//    [query connect];
//    STAssertTrue([query isConnected], @"GPSquery should be connected after initialization");
//}

- (void)testGPSquery_poll
{
    T5GPSquery *query2 = [[T5GPSquery alloc] initWithViewController:nil];
    [query2 poll];
    STAssertTrue([query2 hasData], @"GPSquery did not fetch any data");
}

- (void)testGPSquery_sendMessage
{
    query = [[T5GPSquery alloc] initWithViewController:nil];
    [query sendMessage:@"GET *ALL"];
}

//- (void)testGPSquery_runThread
//{
//    [NSThread detachNewThreadSelector:@selector(runThread:) toTarget:[T5GPSquery class] withObject:nil];
//    sleep(10);
//}

- (void)testXPathQuery_parseKML
{
    T5GPSquery *query3 = [[T5GPSquery alloc] initWithViewController:nil];
    NSMutableArray *names = [[NSMutableArray alloc] init];
    NSString *xpathQueryString = @"/kml/Document/Placemark/name";
    NSString *dataStr = [NSString stringWithFormat:@"<?xml version=\"1.0\"?><kml><Document><Placemark><name>New York City</name><description>New York City</description><Point><coordinates>-74.006393,40.714172,0</coordinates></Point></Placemark></Document></kml>"];
    NSData *responseData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *nodes = PerformXMLXPathQuery(responseData, xpathQueryString);
    NSLog(@"Nodes found for names TEST: %d", [nodes count]);
    [query3 populateArray:names fromNodes:nodes];
    NSLog(@"names TEST = %@", names);
}

//- (void)testXPathQuery_parseWeatherXML
//{
//    T5GPSquery *query4 = [[T5GPSquery alloc] initWithViewController:nil];
//    NSMutableArray *names = [[NSMutableArray alloc] init];
//    //NSString *xpathQueryString = @"//forecast_conditions/condition/@data";
//    NSString *xpathQueryString = @"/xml_api_reply";
//    NSString *dataStr = [NSString stringWithFormat:@"<?xml version=\"1.0\"?><xml_api_reply version=\"1\"><weather module_id=\"0\" tab_id=\"0\" mobile_row=\"0\" mobile_zipped=\"1\" row=\"0\" section=\"0\" ><forecast_information><city data=\"London,UK\"/><postal_code data=\"London,UK\"/><latitude_e6 data=\"\"/><longitude_e6 data=\"\"/><forecast_date data=\"2012-05-18\"/><current_date_time data=\"1970-01-01 00:00:00 +0000\"/><unit_system data=\"US\"/></forecast_information><current_conditions><condition data=\"Mostly Cloudy\"/><temp_f data=\"57\"/><temp_c data=\"14\"/><humidity data=\"Humidity: 82%\"/><icon data=\"/ig/images/weather/mostly_cloudy.gif\"/><wind_condition data=\"Wind: S at 8 mph\"/></current_conditions><forecast_conditions><day_of_week data=\"Fri\"/><low data=\"52\"/><high data=\"63\"/><icon data=\"/ig/images/weather/chance_of_rain.gif\"/><condition data=\"Chance of Rain\"/></forecast_conditions><forecast_conditions><day_of_week data=\"Sat\"/><low data=\"52\"/><high data=\"63\"/><icon data=\"/ig/images/weather/chance_of_rain.gif\"/><condition data=\"Chance of Rain\"/></forecast_conditions><forecast_conditions><day_of_week data=\"Sun\"/><low data=\"54\"/><high data=\"66\"/><icon data=\"/ig/images/weather/chance_of_rain.gif\"/><condition data=\"Chance of Rain\"/></forecast_conditions><forecast_conditions><day_of_week data=\"Mon\"/><low data=\"52\"/><high data=\"59\"/><icon data=\"/ig/images/weather/mostly_sunny.gif\"/><condition data=\"Mostly Sunny\"/></forecast_conditions></weather></xml_api_reply>"];
//    NSData *responseData = [dataStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSArray *nodes = PerformXMLXPathQuery(responseData, xpathQueryString);
//    NSLog(@"Nodes found for names TEST: %d", [nodes count]);
//    [query4 populateArray:names fromNodes:nodes];
//    NSLog(@"weather TEST = %@", names);
//}




@end










