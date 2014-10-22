//
//  Weather.m
//  WeatherApp
//
//  Created by Danil Mironov on 15.10.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import "Weather.h"

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
    
    sample_weather.data = [[NSMutableArray alloc] initWithObjects:[Forecast createSample1], [Forecast createSample1], nil];
    
    [sample_weather autorelease];
    
    return sample_weather;
}

-(void) loadFromFile:(WeatherFile*)file target:(id)target selector:(SEL)selector {
    p_target = target;
    p_callback = selector;
    /* do file processing */
    [target performSelector:selector withObject:file];
}

-(void) dealloc{
    [super dealloc];
    // TODO удалить все переменные
}


@end
