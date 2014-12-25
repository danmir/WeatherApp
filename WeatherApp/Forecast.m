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

-(void) dealloc{
    [from release];
    [to release];
    [sunrise release];
    [sunset release];
    [super dealloc];
}

@end
