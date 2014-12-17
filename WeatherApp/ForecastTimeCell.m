//
//  ForecastTimeCell.m
//  WeatherApp
//
//  Created by Danil Mironov on 17.12.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import "ForecastTimeCell.h"

@interface ForecastTimeCell ()

@end

@implementation ForecastTimeCell
{
    UIImageView* _imageView;
    UILabel* _fromLabel;
    UILabel* _toLabel;
}

-(id)initWithStyle: (UITableViewCellStyle)style reuseIdentifier: (NSString*)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier: reuseIdentifier];
    if (self) {
    }
    
    return self;
}

-(void)dealloc {
    [_imageView release];
    [_fromLabel release];
    [_toLabel release];
    
    [super dealloc];
}

-(void)awakeFromNib {
}

-(void)setSelected: (BOOL)selected animated: (BOOL)animated {
    [super setSelected: selected animated: animated];
}

@end
