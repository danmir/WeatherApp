//
//  Weather.m
//  WeatherApp
//
//  Created by Danil Mironov on 15.10.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import "Weather.h"
#import "ReadXML.h"

@implementation Weather

@synthesize city;
@synthesize country;
@synthesize lat;
@synthesize lon;
@synthesize forecasts;

-(id) init {
    if (self = [super init]) {
        //
    }
    return self;
}

-(void) dealloc{
    [city release];
    [country release];
    [lat release];
    [lon release];
    [forecasts release];
    
    [super dealloc];
}


@end
