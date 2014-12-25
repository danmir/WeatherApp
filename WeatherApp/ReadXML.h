//
//  ReadXML.h
//  WeatherApp
//
//  Created by Danil Mironov on 29.10.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

@protocol ReadXMLDelegate <NSObject>

-(void)readXMLDidFinish:(Weather*)weather;

@end

@interface ReadXML: NSOperation

-(id)initWithWeatherFromFile:(NSString*)path delegate:(id<ReadXMLDelegate>)theDelegate;
-(id)initWithWeatherFromData:(NSData*)data delegate:(id<ReadXMLDelegate>)theDelegate;

@end
