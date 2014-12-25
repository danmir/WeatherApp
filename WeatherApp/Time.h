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

@property(copy) NSString* symbol_var;
@property(copy) NSString* name_of_symbol;

@property(copy) NSString* type_of_precipitation;
@property(retain) NSNumber* count_of_precipitation;

@property(copy) NSString* wind_direction_name;
@property(retain) NSNumber* wind_speed_name;

@property(retain) NSNumber* temperature_val_avg;
@property(retain) NSNumber* pressure_value;
@property(retain) NSNumber* humidity_val;

@end
