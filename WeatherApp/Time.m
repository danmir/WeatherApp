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
@synthesize symbol_var;
@synthesize count_of_precipitation;
@synthesize wind_direction_name;
@synthesize wind_speed_name;
@synthesize temperature_val_avg;
@synthesize pressure_value;
@synthesize humidity_val;

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
    
    sample.symbol_var = @"Showers";
    sample.count_of_precipitation = [[NSNumber alloc] initWithDouble:50];
    sample.wind_direction_name = @"North";
    sample.wind_speed_name = [[NSNumber alloc] initWithDouble:50];
    sample.temperature_val_avg = [[NSNumber alloc] initWithDouble:20];
    sample.pressure_value = [[NSNumber alloc] initWithDouble:50];
    sample.humidity_val = [[NSNumber alloc] initWithDouble:50];
    
    [sample autorelease];
    
    return sample;
}

+(Time*) createSample2 {
    Time* sample = [[Time alloc] init];
    sample.from = [NSDate date];
    sample.to = [NSDate date];
    
    sample.symbol_var = @"Rain";
    sample.count_of_precipitation = [[NSNumber alloc] initWithDouble:50];
    sample.wind_direction_name = @"North";
    sample.wind_speed_name = [[NSNumber alloc] initWithDouble:50];
    sample.temperature_val_avg = [[NSNumber alloc] initWithDouble:20];
    sample.pressure_value = [[NSNumber alloc] initWithDouble:50];
    sample.humidity_val = [[NSNumber alloc] initWithDouble:50];
    
    [sample autorelease];
    
    return sample;
}

+(Time*) createSample3 {
    Time* sample = [[Time alloc] init];
    sample.from = [NSDate date];
    sample.to = [NSDate date];
    
    sample.symbol_var = @"Sunny";
    sample.count_of_precipitation = [[NSNumber alloc] initWithDouble:50];
    sample.wind_direction_name = @"North";
    sample.wind_speed_name = [[NSNumber alloc] initWithDouble:50];
    sample.temperature_val_avg = [[NSNumber alloc] initWithDouble:20];
    sample.pressure_value = [[NSNumber alloc] initWithDouble:50];
    sample.humidity_val = [[NSNumber alloc] initWithDouble:50];
    
    [sample autorelease];
    
    return sample;
}

-(void) dealloc{
    [from release];
    [to release];
    [symbol_var release];
    [count_of_precipitation release];
    [wind_direction_name release];
    [wind_speed_name release];
    [temperature_val_avg release];
    [pressure_value release];
    [humidity_val release];

    [super dealloc];
}

@end
