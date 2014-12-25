//
//  ForecastViewController.m
//  WeatherApp
//
//  Created by Danil Mironov on 26.11.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import "ForecastViewController.h"
#import "ForecastTimeViewController.h"

#import "Weather.h"
#import "Time.h"

#import "ForecastTimeCell.h"

#import "WeatherLoader.h"

@interface ForecastViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView* TableView;
@property (nonatomic, retain) IBOutlet ForecastTimeCell* ForecastTimeCell;

-(void)weatherLoaded:(id)object;

@end

@implementation ForecastViewController
{
    UITableView* _tableView;
    Forecast* _forecast;
    
    NSMutableDictionary* _index;
    NSArray* _keys;
    
    ForecastTimeCell* _forecastTimeCell;
}

@synthesize TableView = _tableView;
@synthesize Forecast = _forecast;

@synthesize ForecastTimeCell = _forecastTimeCell;

- (id) initWithNibName:(NSString*)nibNameOrNil bundle: (NSBundle*)nibBundleOrNil {
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    
    if (nil !=  self) {
        _index = [[NSMutableDictionary alloc] init];
        _keys = [[NSArray alloc] init];
    }
    
    return self;
}

- (void) dealloc {
    [_tableView release];
    [_forecast release];
    
    [_index release];
    [_keys release];
    
    [_forecastTimeCell release];
    
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];

    // Как только начнем щагрузку
    self.navigationItem.title = @"Weather";
    [[WeatherLoader alloc] initWithURL:[NSURL URLWithString: @"http://api.openweathermap.org/data/2.5/forecast?q=Yekaterinburg&mode=xml"] thenCallTarget: self withSelector:@selector(weatherLoaded:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)weatherLoaded: ( id )object {
    if ( [ object isKindOfClass: [ Weather class ] ] )
    {
        Forecast* tmp = [ [ ( Weather* )object forecasts ] objectAtIndex: 0 ];
        [self setForecast:tmp];
        [ _tableView reloadData ];
    }
    else if ( [ object isKindOfClass: [ NSError class ] ] )
    {
        UIAlertView* alert = [ [ [ UIAlertView alloc ] initWithTitle: @"Error" message: @"Не удалось загрузить погоду" delegate: nil cancelButtonTitle: @"OK" otherButtonTitles: nil ] autorelease ];
        [ alert show ];
    }
}

- (void)setForecast:(Forecast *)forecast {
    [_forecast release];
    _forecast = [forecast retain];
    
    [_index removeAllObjects];
    [_keys release];
    
    NSDateFormatter* fmt = [[[NSDateFormatter alloc] init] autorelease];
    //[fmt setTimeStyle:NSDateFormatterShortStyle];
    //[fmt setDateStyle:NSDateFormatterMediumStyle];
    [fmt setDateFormat: @"yyyy-MM-dd"];
    
    NSMutableArray* keys = [ NSMutableArray array ];
    
    for (Time* time in forecast.times) {
        NSString* from = [fmt stringFromDate: time.from];
        NSString* to = [fmt stringFromDate: time.to];
        
        NSMutableArray* indexitems = [ _index objectForKey: from ];
        if ( nil == indexitems ) {
            indexitems = [[[NSMutableArray alloc] init] autorelease];
            [_index setObject: indexitems forKey: from];
            
            [keys addObject: from];
        }
        
        if ( nil != indexitems ) {
            [indexitems addObject: time];
        }
    }
    // TODO: Неправильно работает сортировка !
    _keys = [ [ keys sortedArrayUsingComparator: ^NSComparisonResult( NSString* key1, NSString* key2 )
               {
                   return [ key2 compare: key1 ];
               } ] retain ];
    // Pubdate - много новостей на одну дату
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1 + [ [ _index allKeys ] count ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if ( section == 0 )
        return 1;
    NSMutableArray* indexitems = [ _index objectForKey: [ _keys objectAtIndex: section - 1 ] ];
    return [ indexitems count ];
}

-(NSString*) tableView: (UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0)
        return nil;

    return [_keys objectAtIndex: section - 1];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellStyle1 = @"CellStyle1";
    static NSString* cellStyleItem = @"myCell";
    
    if (0 == indexPath.section) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: cellStyle1];
        if (nil == cell) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStyle1] autorelease];
        }
        
        cell.textLabel.text = [NSString stringWithFormat: @"Count - %d", [_forecast.times count]];
        cell.detailTextLabel.text = @"";
        cell.imageView.image = nil;
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        return cell;
    } else {
        ForecastTimeCell* cell = (ForecastTimeCell*)[tableView dequeueReusableCellWithIdentifier:cellStyleItem];
        if (nil == cell) {
            [[NSBundle mainBundle] loadNibNamed: @"ForecastTimeCell" owner:self options:nil];
            cell = _forecastTimeCell;
            _forecastTimeCell = nil;
        }
        NSMutableArray* indexitems = [_index objectForKey:[_keys objectAtIndex:indexPath.section - 1]];
        Time* time = [indexitems objectAtIndex: indexPath.row];
        
        NSDateFormatter* fmt = [[[NSDateFormatter alloc] init] autorelease];
        [fmt setDateFormat: @"HH:mm:ss"];
        NSString* from = [fmt stringFromDate: time.from];
        NSString* to = [fmt stringFromDate: time.to];
        
        //cell.textLabel.text = from;
        cell.FromLabel.text = from;
        cell.ToLabel.text = to;
        
        NSString* url_string = [NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", time.symbol_var];
        NSURL* url = [[NSURL alloc] initWithString:url_string];
        NSData* data = [NSData dataWithContentsOfURL: url];
        UIImage* img = [UIImage imageWithData: data];
        cell.ImageView.image = img;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate

-(CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 50.0f;
}

-(void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    [ tableView deselectRowAtIndexPath: indexPath animated: YES ];
    
    ForecastTimeViewController* ctrl = [ [ [ ForecastTimeViewController alloc ] initWithNibName: @"ForecastTimeViewController" bundle: [ NSBundle mainBundle ] ] autorelease ];
    
    NSMutableArray* indexitems = [ _index objectForKey: [ [ _index allKeys ] objectAtIndex: indexPath.section - 1 ] ];
    
    ctrl.Item = [indexitems objectAtIndex: indexPath.row];
    // ????
    //[ctrl setTimeItem:_forecast.times[0]];
    
    [self.navigationController pushViewController:ctrl animated:YES];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
