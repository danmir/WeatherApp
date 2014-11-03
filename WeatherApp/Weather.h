//
//  Weather.h
//  WeatherApp
//
//  Created by Danil Mironov on 15.10.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Forecast.h"

@class Weather;

@protocol WeatherDelegate <NSObject>

-(void) didWeatherLoadSucceeded:(Weather*)weather;
-(void) didWeatherLoadFailed:(NSError*)error;

@end

@interface Weather : NSObject {
    id delegate;
}

@property(copy) NSString* city;
@property(copy) NSString* country;

@property(retain) NSNumber* lat;
@property(retain) NSNumber* lon;

@property(retain) NSArray* forecasts;

+(Weather*)createSample;

-(void)loadFromFile:(NSString*)file;
-(void)setDelegate:(id)newDelegate;


@end
