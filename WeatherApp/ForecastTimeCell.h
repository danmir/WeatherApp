//
//  ForecastTimeCell.h
//  WeatherApp
//
//  Created by Danil Mironov on 17.12.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForecastTimeCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel* FromLabel;
@property (nonatomic, retain) IBOutlet UILabel* ToLabel;
@property (nonatomic, retain) IBOutlet UIImageView* ImageView;


@end
