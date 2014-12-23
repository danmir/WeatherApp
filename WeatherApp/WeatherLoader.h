//
//  WeatherLoader.h
//  WeatherApp
//
//  Created by Danil Mironov on 17.12.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadXML.h"

@interface WeatherLoader : NSObject <ReadXMLDelegate>

-(id)initWithURL:(NSURL*)url thenCallTarget:(id)target withSelector:(SEL)selector;

@end
