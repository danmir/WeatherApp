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
@synthesize p_myFile;

-(void)run {
    self.p_sampleWeather = [[Weather alloc] init];
    [self.p_sampleWeather loadFromFile:self.p_myFile target:self selector:@selector(loadProcessed:) ];
}
-(void)loadProcessed:(WeatherFile*)myFile {
    NSLog(@"file: %@ loaded", myFile);
}

@end
