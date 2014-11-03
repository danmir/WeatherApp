//
//  ReadXML.h
//  WeatherApp
//
//  Created by Danil Mironov on 29.10.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@interface ReadXML: NSObject

-(Weather*)parseWeatherFromFile:(NSString*)filePath;
-(Weather*)parseWeatherFromData:(NSData*)data;

@end
