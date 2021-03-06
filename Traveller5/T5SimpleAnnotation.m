//
//  T5SimpleAnnotation.m
//  Traveller5
//
//  Created by Alex Baca on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "T5SimpleAnnotation.h"

@implementation T5SimpleAnnotation

@synthesize coordinate=_cooordinare;
@synthesize title=_title; 
@synthesize subtitle=_subtitle;
@synthesize route=_route;

+ (id)annotationWithCoordinate:(CLLocationCoordinate2D)coord {
    return [[[self class] alloc] initWithCoordinate:coord]; 
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coord {
    if ( self = [super init] ) {
        self.coordinate = coord;
    }
    return self; 
}

@end
