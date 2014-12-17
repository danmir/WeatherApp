//
//  ForecastTimeViewController.h
//  WeatherApp
//
//  Created by Danil Mironov on 12.11.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Time;

@interface ForecastTimeViewController : UIViewController

@property(nonatomic, retain) Time* Item;

-(void) setTimeItem:(Time*)time;

@end
