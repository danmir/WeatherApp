//
//  Forecast.h
//  WeatherApp
//
//  Created by Danil Mironov on 15.10.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Time.h"

@interface Forecast : NSObject

@property(retain) NSDate* from;
@property(retain) NSDate* to;

@property(retain) NSDate* sunrise;
@property(retain) NSDate* sunset;

@property(retain) NSMutableArray* data; //Поле вычисляемое по дате

+(Forecast*) createSample1;

@end
