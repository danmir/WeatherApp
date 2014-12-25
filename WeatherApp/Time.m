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
