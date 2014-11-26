//
//  ForecastTimeViewController.m
//  WeatherApp
//
//  Created by Danil Mironov on 12.11.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import "ForecastTimeViewController.h"

#import "Time.h"

@interface ForecastTimeViewController ()

@property (nonatomic, retain) IBOutlet UIImageView* SymbolView;
@property (nonatomic, retain) IBOutlet UILabel* FromView;
@property (nonatomic, retain) IBOutlet UILabel* ToView;
@property (nonatomic, retain) IBOutlet UILabel* DescriptionView;

@end

@implementation ForecastTimeViewController
{
    UIImageView* _symbolView;
    UILabel* _fromView;
    UILabel* _toView;
    UILabel* _descriptionView;
}

@synthesize SymbolView = _symbolView;
@synthesize FromView = _fromView;
@synthesize ToView = _toView;
@synthesize DescriptionView = _descriptionView;

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (nil != self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"ForecastTimeViewController загрузился");
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - public routines

-(void)setTimeItem:(Time *)time
{
    // Prepare data
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setTimeStyle:NSDateFormatterShortStyle];
    [format setDateStyle:NSDateFormatterMediumStyle];
    _fromView.text = [format stringFromDate:time.from];
    _toView.text = [format stringFromDate:time.to];
    
    _descriptionView.text = time.type_of_precipitation;
    
    NSURL* url = [[NSURL alloc] initWithString:@"http://openweathermap.org/img/w/10d.png"];
    NSData* data = [NSData dataWithContentsOfURL: url];
    UIImage* img = [UIImage imageWithData: data];
    _symbolView.image = img;
}

-(void) dealloc {
    [_symbolView release];
    [_fromView release];
    [_toView release];
    [_descriptionView release];
    
    [super dealloc];
}

@end
