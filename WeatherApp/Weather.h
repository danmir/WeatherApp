//
//  Weather.h
//  WeatherApp
//
//  Created by Danil Mironov on 15.10.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Forecast.h"
#import "WeatherFile.h"

@interface Weather : NSObject {
    id p_target;
    SEL p_callback;
}

@property(copy) NSString* city;
@property(copy) NSString* country;

@property(retain) NSNumber* lat;
@property(retain) NSNumber* lon;

@property(retain) NSMutableArray* data;

+(Weather*)createSample;

-(void)loadFromFile:(WeatherFile*)file target:(id)target selector:(SEL)selector;


@end
