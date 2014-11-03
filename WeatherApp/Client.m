//
//  Client.m
//  WeatherApp
//
//  Created by Danil Mironov on 22.10.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import "Client.h"

@implementation Client

@synthesize p_sampleWeather;
//@synthesize p_myFile;

-(void)run {
    p_sampleWeather = [[Weather alloc] init];
    [p_sampleWeather setDelegate:self]; // Set that we are delegate
    [p_sampleWeather loadFromFile:@"/Users/danmir/Downloads/forecast.xml"];
    //[p_sampleWeather loadFromFile:p_myFile]; // Start loading
}

#pragma mark - Implements delegated functions
-(void)didWeatherLoadSucceeded:(Weather*)weather {
    NSLog(@"Все успешно загрузилось");
    NSLog(@"%@", weather);
}

-(void)didWeatherLoadFailed:(NSError *)error {
    NSLog(@"Что-то пошло не так");
}

@end
