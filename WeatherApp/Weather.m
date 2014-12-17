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

-(id) init {
    if (self = [super init]) {
        //
    }
    return self;
}

+(Weather*) createSample {
    Weather* sample_weather = [[Weather alloc] init];
    
    sample_weather.city = @"Yekaterinburg";
    sample_weather.country = @"Russia";
    
    sample_weather.lat = [[NSNumber alloc] initWithDouble:55];
    sample_weather.lon = [[NSNumber alloc] initWithDouble:60];
    
    sample_weather.forecasts = [[NSMutableArray alloc] initWithObjects:[Forecast createSample1], [Forecast createSample1], nil];
    
    [sample_weather autorelease];
    
    return sample_weather;
}

-(void) loadFromFile:(NSString*)file {
    /* do file processing */
    ReadXML* parser = [[[ReadXML alloc] init] autorelease];
    Weather* weather = [parser parseWeatherFromFile:file];
    
    if (nil != weather)
        [delegate didWeatherLoadSucceeded: weather];
    else
        [delegate didWeatherLoadFailed:[[NSError alloc] init]];
}

-(void)loadRssFromURL:(NSURL *)url {
    
}

-(void) setDelegate:(id)newDelegate{
    delegate = newDelegate;
}

-(void) dealloc{
    [super dealloc];
    // TODO: удалить все переменные
}


@end
