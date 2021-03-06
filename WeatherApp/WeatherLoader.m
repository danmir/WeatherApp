//
//  WeatherLoader.m
//  WeatherApp
//
//  Created by Danil Mironov on 17.12.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import "WeatherLoader.h"

@interface WeatherLoader ( ) <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@end

@implementation WeatherLoader {
    NSMutableData* _data;
    NSURLConnection* _connection;
    
    id _target;
    SEL _selector;
}

#pragma mark - NSURLConnectionDataDelegate

-(id)initWithURL:(NSURL*)url thenCallTarget:(id)target withSelector:(SEL)selector; {
    self = [ super init ];
    if ( nil != self )
    {
        _data = [ [ NSMutableData alloc ] init ];
        _target = target;
        _selector = selector;
        
        NSMutableURLRequest* req = [ [ [ NSMutableURLRequest alloc ] initWithURL: url ] autorelease ];
        [ req setHTTPMethod: @"GET" ];
        [ req setCachePolicy: NSURLRequestReloadIgnoringLocalAndRemoteCacheData ];
        
        _connection = [ [ NSURLConnection connectionWithRequest: req delegate: self ] retain ];
    }
    
    return self;
}

-(void) dealloc {
    // TODO: разобраться в чем тут дело с памятью и почему это приводит к ошибкам
    //[ _data release ];
    //[ _connection release ];
    
    [ super dealloc ];
}

-( void ) connection: ( NSURLConnection* )connection didReceiveResponse: ( NSURLResponse* )response
{
    [ _data setLength: 0 ];
}

-( void ) connection: ( NSURLConnection* )connection didReceiveData: ( NSData* )data
{
    [ _data appendData: data ];
}

-( void ) connectionDidFinishLoading: ( NSURLConnection* )connection
{
    ReadXML* parser = [[ReadXML alloc] initWithWeatherFromData:_data delegate:self];
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    [queue addOperation:parser];
    [parser setCompletionBlock: ^{
        NSLog(@"Finished ReadXML in queue");
    }];
    [parser release];
    
    //ReadXML* parser = [ [ [ ReadXML alloc ] init ] autorelease ];
    //Weather* weather = [parser parseWeatherFromData: _data];
    
    //[ _target performSelector: _selector withObject: weather ];
    //[ self autorelease ];
}

#pragma mark - ReadXMLDelegate

-(void)readXMLDidFinish:(Weather *)weather{
    // Парсер отработал и прислал нам weather
    if (weather)
        NSLog(@"Парсер закончил работу");
    // Отправляем дальше
    [ _target performSelector: _selector withObject: weather ];
    //[ self autorelease ];
}

#pragma mark - NSURLConnectionDelegate

-( void ) connection: ( NSURLConnection* )connection didFailWithError: ( NSError* )error
{
    [ _target performSelector: _selector withObject: error ];
    //[ self autorelease ];
}

@end
