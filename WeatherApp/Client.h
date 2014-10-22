//
//  Client.h
//  WeatherApp
//
//  Created by Danil Mironov on 22.10.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@interface Client : NSObject

@property(retain) WeatherFile* p_myFile;
@property(retain) Weather* p_sampleWeather;

-(void)run;
-(void)loadProcessed:(WeatherFile*)myFile;

@end
