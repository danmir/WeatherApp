//
//  AppDelegate.m
//  WeatherApp
//
//  Created by Danil Mironov on 15.10.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import "AppDelegate.h"

#import "Time.h"
#import "Forecast.h"
#import "Weather.h"
#import "ReadXML.h"

#import "ForecastTimeViewController.h"
#import "ForecastViewController.h"

@interface AppDelegate () <WeatherDelegate>

-(void) weatherLoaded:(Weather*)weather;

@end

@implementation AppDelegate
{
    UIWindow* _window;
    ForecastViewController* _ctrl;
}

-(void) dealloc {
    [_ctrl release];
    [_window release];
    
    [super dealloc];
}

-(void) weatherLoaded:(Weather *)weather{
   // NSLog(@"Weather loaded: %@", [weather description]);
    NSLog(@"weatherLoaded called");
}

#pragma mark - Implements delegated functions
-(void)didWeatherLoadSucceeded:(Weather*)weather {
    NSLog(@"Все успешно загрузилось in App delegate");
    NSLog(@"%@", weather);
    Forecast* forecast = [weather.forecasts objectAtIndex:0];
    //Time* time = [forecast.times objectAtIndex:0];
    //[_itemCtrl setTimeItem:time];
    [_ctrl setForecast:forecast];
}

-(void)didWeatherLoadFailed:(NSError *)error {
    NSLog(@"Что-то пошло не так in App delegate");
}
#pragma mark - View loading

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    
    _ctrl = [ [ ForecastViewController alloc ] initWithNibName: @"ForecastViewController" bundle: [ NSBundle mainBundle ] ];
    
    //_itemCtrl = [[ForecastTimeViewController alloc ] initWithNibName: @"ForecastTimeViewController" bundle:[NSBundle mainBundle]];
    UINavigationController* navctrl = [ [ [ UINavigationController alloc ] initWithRootViewController: _ctrl ] autorelease ];
    navctrl.navigationBar.barStyle = UIBarStyleBlackOpaque;
    _window.rootViewController = navctrl;
    [_window makeKeyAndVisible];
    
    // Обработка callback
    Weather* p_sampleWeather = [[Weather alloc] init];
    [p_sampleWeather setDelegate:self]; // Set that we are delegate
    [p_sampleWeather loadFromFile:@"/Users/danmir/Downloads/forecast.xml"];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
