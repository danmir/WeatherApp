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
@property (nonatomic, retain) IBOutlet UILabel* NameOfSymbol;
@property (nonatomic, retain) IBOutlet UILabel* HumidityVal;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *ActivityIndicator;

@end

@implementation ForecastTimeViewController
{
    UIImageView* _symbolView;
    UILabel* _fromView;
    UILabel* _toView;
    UILabel* _descriptionView;
    UILabel* _humidityVal;
    
    Time* _item;
}

@synthesize SymbolView = _symbolView;
@synthesize FromView = _fromView;
@synthesize ToView = _toView;
@synthesize DescriptionView = _descriptionView;
@synthesize NameOfSymbol = _nameOfSymbol;
@synthesize HumidityVal = _humidityVal;

@synthesize ActivityIndicator = _activityIndictor;

@synthesize Item = _item;

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

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self setTimeItem:_item];
    [_activityIndictor stopAnimating];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_activityIndictor startAnimating];
    
    //self.navigationItem.title = _item.Title;
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
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
    
    _descriptionView.text = time.symbol_var;
    
    NSString* url_string = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", time.symbol_var];
    NSURL* url = [[NSURL alloc] initWithString:url_string];
    NSData* data = [NSData dataWithContentsOfURL: url];
    UIImage* img = [UIImage imageWithData: data];
    _symbolView.image = img;
    
    _nameOfSymbol.text = time.name_of_symbol;
    
    _humidityVal.text = [NSString stringWithFormat:@"Humidity: %@ percent", time.humidity_val];
}

-(void) dealloc {
    [_symbolView release];
    [_fromView release];
    [_toView release];
    [_descriptionView release];
    [_nameOfSymbol release];
    [_humidityVal release];
    
    [_item release];
    
    [_activityIndictor release];
    [super dealloc];
}

@end
