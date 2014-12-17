//
//  ForecastViewController.h
//  WeatherApp
//
//  Created by Danil Mironov on 26.11.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Forecast;

@interface ForecastViewController : UITableViewController

@property (nonatomic, retain) Forecast* Forecast;

@end
