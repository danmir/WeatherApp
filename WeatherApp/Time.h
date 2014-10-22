//
//  Time.h
//  WeatherApp
//
//  Created by Danil Mironov on 15.10.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Time : NSObject

@property(retain) NSDate* from;
@property(retain) NSDate* to;
@property(copy) NSString* type_of_precipitation;
@property(retain) NSNumber* count_of_precipitation;
@property(copy) NSString* wind_direction;
@property(retain) NSNumber* wind_speed;
@property(retain) NSNumber* temperature;
@property(retain) NSNumber* pressure;
@property(retain) NSNumber* humidity;

+(Time*) createSample1;
+(Time*) createSample2;
+(Time*) createSample3;

@end
