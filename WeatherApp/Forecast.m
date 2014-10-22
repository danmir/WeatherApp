//
//  Forecast.m
//  WeatherApp
//
//  Created by Danil Mironov on 15.10.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import "Forecast.h"

@implementation Forecast

@synthesize from;
@synthesize to;

@synthesize sunrise;
@synthesize sunset;

-(id) init {
    if (self = [super init]) {
        //
    }
    return self;
}

+(Forecast*) createSample1 {
    Forecast* sample_forecast = [[Forecast alloc] init];
    sample_forecast.from = [NSDate date];
    sample_forecast.to = [NSDate date];
    
    sample_forecast.sunrise = [NSDate date];
    sample_forecast.sunset = [NSDate date];
    
    sample_forecast.data = [[NSMutableArray alloc] initWithObjects:[Time createSample1], [Time createSample2], [Time createSample3], nil];
    
    [sample_forecast autorelease];
    
    return sample_forecast;
}

-(void) dealloc{
    [super dealloc];
}

@end
