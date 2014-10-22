//
//  Time.m
//  WeatherApp
//
//  Created by Danil Mironov on 15.10.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import "Time.h"

@implementation Time

@synthesize from;
@synthesize to;
@synthesize type_of_precipitation;
@synthesize count_of_precipitation;
@synthesize wind_direction;
@synthesize wind_speed;
@synthesize temperature;
@synthesize pressure;
@synthesize humidity;

-(id) init {
    if (self = [super init]) {
        //
    }
    return self;
}

+(Time*) createSample1 {
    Time* sample = [[Time alloc] init];
    sample.from = [NSDate date];
    sample.to = [NSDate date];
    
    sample.type_of_precipitation = @"Showers";
    sample.count_of_precipitation = [[NSNumber alloc] initWithDouble:50];
    sample.wind_direction = @"North";
    sample.wind_speed = [[NSNumber alloc] initWithDouble:50];
    sample.temperature = [[NSNumber alloc] initWithDouble:20];
    sample.pressure = [[NSNumber alloc] initWithDouble:50];
    sample.humidity = [[NSNumber alloc] initWithDouble:50];
    
    [sample autorelease];
    
    return sample;
}

+(Time*) createSample2 {
    Time* sample = [[Time alloc] init];
    sample.from = [NSDate date];
    sample.to = [NSDate date];
    
    sample.type_of_precipitation = @"Rain";
    sample.count_of_precipitation = [[NSNumber alloc] initWithDouble:50];
    sample.wind_direction = @"North";
    sample.wind_speed = [[NSNumber alloc] initWithDouble:50];
    sample.temperature = [[NSNumber alloc] initWithDouble:20];
    sample.pressure = [[NSNumber alloc] initWithDouble:50];
    sample.humidity = [[NSNumber alloc] initWithDouble:50];
    
    [sample autorelease];
    
    return sample;
}

+(Time*) createSample3 {
    Time* sample = [[Time alloc] init];
    sample.from = [NSDate date];
    sample.to = [NSDate date];
    
    sample.type_of_precipitation = @"Sunny";
    sample.count_of_precipitation = [[NSNumber alloc] initWithDouble:50];
    sample.wind_direction = @"North";
    sample.wind_speed = [[NSNumber alloc] initWithDouble:50];
    sample.temperature = [[NSNumber alloc] initWithDouble:20];
    sample.pressure = [[NSNumber alloc] initWithDouble:50];
    sample.humidity = [[NSNumber alloc] initWithDouble:50];
    
    [sample autorelease];
    
    return sample;
}

-(void) dealloc{
    [from release];
    [to release];
    [type_of_precipitation release];
    [count_of_precipitation release];
    [wind_direction release];
    [wind_speed release];
    [temperature release];
    [pressure release];
    [humidity release];

    [super dealloc];
}

@end
