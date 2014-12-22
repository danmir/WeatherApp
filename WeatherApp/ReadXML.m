//
//  ReadXML.m
//  WeatherApp
//
//  Created by Danil Mironov on 29.10.14.
//  Copyright (c) 2014 Danil Mironov. All rights reserved.
//

#import "ReadXML.h"
#import "Forecast.h"
#import "Time.h"

static NSString* const kWeatherdataElement = @"weatherdata";
static NSString* const kWeatherdataLocationElement = @"location";
static NSString* const kWeatherdataLocationNameElement = @"name";
//static NSString* const kWeatherdataLocationTypeElement = @"type";
static NSString* const kWeatherdataLocationCountryElement = @"country";
//static NSString* const kWeatherdataLocationTimezoneElement = @"timezone";
static NSString* const kWeatherdataLocationLocationElement = @"location";

static NSString* const kWeatherdataSunElement = @"sun";

static NSString* const kForecastElement = @"forecast";

static NSString* const kTimeElement = @"time";
static NSString* const kTimeSymbolElement = @"symbol";
static NSString* const kTimePrecipitationElement = @"precipitation";
static NSString* const kTimeWinddirectionElement = @"windDirection";
static NSString* const kTimeWindspeedElement = @"windSpeed";
static NSString* const kTimeTemperatureElement = @"temperature";
static NSString* const kTimePressureElement = @"pressure";
static NSString* const kTimeHumidityElement = @"humidity";
static NSString* const kTimeCloudsElement = @"clouds";

typedef enum IWRssFeedParserParsingSteps
{
    kWeatherParserParsingStepNo = 0,
    
    kWeatherParserParsingStepWeatherdata,
    kWeatherParserParsingStepWeatherdataLocation,
    kWeatherParserParsingStepWeatherdataLocationName,
    kWeatherParserParsingStepWeatherdataLocationCountry,
    kWeatherParserParsingStepWeatherdataLocationLocation,
    kWeatherParserParsingStepWeatherdataSun,
    
    kWeatherParserParsingStepForecast,
    kWeatherParserParsingStepTime,
    kWeatherParserParsingStepTimeSymbol,
    kWeatherParserParsingStepTimePrecipitation,
    kWeatherParserParsingStepTimeWinddirection,
    kWeatherParserParsingStepTimeWindspeed,
    kWeatherParserParsingStepTimeTemperature,
    kWeatherParserParsingStepTimePressure,
    kWeatherParserParsingStepTimeHumidity,
    kWeatherParserParsingStepTimeClouds

} IWeatherParserParsingSteps;

@interface ReadXML ( ) < NSXMLParserDelegate >

@end

@implementation ReadXML
{
    int _currentStep;
    
    NSMutableString* _currentElementString;
    
    NSMutableDictionary* _weatherParsingElements;
    NSMutableDictionary* _timeParsingElements;
    
    NSMutableArray* _parsedForecasts;
    NSMutableArray* _parsedTimes;

}

#pragma mark - initiation and deallocation

-(id) init {
    self = [super init];
    
    if (nil != self) {
        _currentStep = kWeatherParserParsingStepNo;
        
        _currentElementString = nil;
        
        _weatherParsingElements = nil;
        _timeParsingElements = nil;
        
        _parsedForecasts = [[NSMutableArray alloc] init];
        _parsedTimes = nil;
    }
    
    return self;
}

-(void) dealloc
{
    NSLog( @"ReadXML dealloc" );
    
    [ _currentElementString release ];
    
    [ _weatherParsingElements release ];
    [ _timeParsingElements release ];
    
    [ _parsedForecasts release ];
    [ _parsedTimes release ];
    
    [ super dealloc ];
}

#pragma mark - public routines

-(Weather*)parseWeatherFromFile:(NSString*)filePath
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath])
        return [[[Weather alloc] init] autorelease];
    
    NSData* fileData = [NSData dataWithContentsOfFile:filePath];
    if (nil == fileData)
        return [[[Weather alloc] init] autorelease];
    
    return [self parseWeatherFromData:fileData];
}

-(Weather*)parseWeatherFromData:(NSData*)data
{
    NSXMLParser* xmlParser = [[NSXMLParser alloc] initWithData:data];
    [xmlParser setDelegate:self];
    
    if ([xmlParser parse]) {
        [xmlParser release];
        
        Weather* weather = [[[Weather alloc] init] autorelease];
        weather.forecasts = [NSArray arrayWithArray: _parsedForecasts];
        weather.city = [_weatherParsingElements objectForKey:@"location_name"];
        weather.country = [_weatherParsingElements objectForKey:@"location_country"];
        // TODO: переделать строку в число
        weather.lat = [_weatherParsingElements objectForKey:@"lat"];
        weather.lon = [_weatherParsingElements objectForKey:@"lon"];
        
        return weather;
    }
    
    [xmlParser release];
    return [[[Weather alloc] init] autorelease];
}

#pragma mark - NSXMLParserDelegate

-(void)parser:(NSXMLParser*)parser didStartElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qName attributes:(NSDictionary*)attributeDict
{
    switch (_currentStep) {
        case kWeatherParserParsingStepNo:
            if ([elementName isEqualToString:kWeatherdataElement])
            {
                _currentStep = kWeatherParserParsingStepWeatherdata;
                _weatherParsingElements = [[NSMutableDictionary alloc] init];
                _parsedTimes = [[NSMutableArray alloc] init];
            }
            break;
            
        case kWeatherParserParsingStepWeatherdata:
            if ([elementName isEqualToString:kWeatherdataLocationElement] && nil == [_weatherParsingElements objectForKey: @"location"] && attributeDict.count == 0) {
                _currentStep = kWeatherParserParsingStepWeatherdataLocation;
                _currentElementString = [[NSMutableString alloc] init];
            }
            else if ([elementName isEqualToString:kWeatherdataSunElement] && nil == [_weatherParsingElements objectForKey: @"sun"])
            {
                [_weatherParsingElements setObject:[attributeDict objectForKey:@"rise"] forKey:@"rise"];
                [_weatherParsingElements setObject:[attributeDict objectForKey:@"set"] forKey:@"set"];
            }
            else if ([elementName isEqualToString:kForecastElement])
            {
                _currentStep = kWeatherParserParsingStepForecast;
                _timeParsingElements = [[NSMutableDictionary alloc] init];
            }
            break;
            
        case kWeatherParserParsingStepWeatherdataLocation:
            if ([elementName isEqualToString:kWeatherdataLocationNameElement] && nil == [_weatherParsingElements objectForKey: @"name"])
            {
                _currentStep = kWeatherParserParsingStepWeatherdataLocationName;
                _currentElementString = [[NSMutableString alloc] init];
            }
            else if ([elementName isEqualToString:kWeatherdataLocationCountryElement] && nil == [_weatherParsingElements objectForKey: @"country"])
            {
                _currentStep = kWeatherParserParsingStepWeatherdataLocationCountry;
                _currentElementString = [[NSMutableString alloc] init];
            }
            else if ([elementName isEqualToString:kWeatherdataLocationLocationElement] && nil == [_weatherParsingElements objectForKey: @"location"])
            {
                [_weatherParsingElements setObject:[attributeDict objectForKey:@"latitude"] forKey:@"lat"];
                [_weatherParsingElements setObject:[attributeDict objectForKey:@"longitude"] forKey:@"lon"];
            }
            break;
            
        case kWeatherParserParsingStepForecast:
            if ([elementName isEqualToString:kTimeElement])
            {
                _timeParsingElements = [[NSMutableDictionary alloc] init];
                [_timeParsingElements setObject:[attributeDict objectForKey:@"from"] forKey:@"from"];
                [_timeParsingElements setObject:[attributeDict objectForKey:@"to"] forKey:@"to"];
                _currentStep = kWeatherParserParsingStepTime;
                _currentElementString = [[NSMutableString alloc] init];
            }
            break;

        case kWeatherParserParsingStepTime:
            if ([elementName isEqualToString:kTimeSymbolElement])
            {
                [_timeParsingElements setObject:[attributeDict objectForKey:@"number"] forKey:@"symbol_num"];
                [_timeParsingElements setObject:[attributeDict objectForKey:@"name"] forKey:@"symbol_name"];
                [_timeParsingElements setObject:[attributeDict objectForKey:@"var"] forKey:@"symbol_var"];
//                _currentStep = kWeatherParserParsingStepTimeSymbol;
//                _currentElementString = [[NSMutableString alloc] init];
            }
            else if ([elementName isEqualToString:kTimePrecipitationElement])
            {
                if (attributeDict.count != 0) {
                    [_timeParsingElements setObject:[attributeDict objectForKey:@"value"] forKey:@"percipitation_value"];
                    [_timeParsingElements setObject:[attributeDict objectForKey:@"unit"] forKey:@"percipitation_unit"];
                    [_timeParsingElements setObject:[attributeDict objectForKey:@"type"] forKey:@"percipitation_type"];
                }
//                _currentStep = kWeatherParserParsingStepTimePrecipitation;
//                _currentElementString = [[NSMutableString alloc] init];
            }
            else if ([elementName isEqualToString:kTimeWinddirectionElement])
            {
                [_timeParsingElements setObject:[attributeDict objectForKey:@"deg"] forKey:@"wind_deg"];
                [_timeParsingElements setObject:[attributeDict objectForKey:@"code"] forKey:@"wind_code"];
                [_timeParsingElements setObject:[attributeDict objectForKey:@"name"] forKey:@"wind_name"];
//                _currentStep = kWeatherParserParsingStepTimeWinddirection;
//                _currentElementString = [[NSMutableString alloc] init];
            }
            else if ([elementName isEqualToString:kTimeWindspeedElement])
            {
                [_timeParsingElements setObject:[attributeDict objectForKey:@"mps"] forKey:@"wind_speed_mps"];
                [_timeParsingElements setObject:[attributeDict objectForKey:@"name"] forKey:@"wind_speed_name"];
//                _currentStep = kWeatherParserParsingStepTimeWindspeed;
//                _currentElementString = [[NSMutableString alloc] init];
            }
            else if ([elementName isEqualToString:kTimeTemperatureElement])
            {
                [_timeParsingElements setObject:[attributeDict objectForKey:@"unit"] forKey:@"temp_unit"];
                [_timeParsingElements setObject:[attributeDict objectForKey:@"value"] forKey:@"temp_value"];
                [_timeParsingElements setObject:[attributeDict objectForKey:@"min"] forKey:@"temp_min"];
                [_timeParsingElements setObject:[attributeDict objectForKey:@"max"] forKey:@"temp_max"];
//                _currentStep = kWeatherParserParsingStepTimeTemperature;
//                _currentElementString = [[NSMutableString alloc] init];
            }
            else if ([elementName isEqualToString:kTimePressureElement])
            {
                [_timeParsingElements setObject:[attributeDict objectForKey:@"unit"] forKey:@"pressure_unit"];
                [_timeParsingElements setObject:[attributeDict objectForKey:@"value"] forKey:@"pressure_value"];
//                _currentStep = kWeatherParserParsingStepTimePressure;
//                _currentElementString = [[NSMutableString alloc] init];
            }
            else if ([elementName isEqualToString:kTimeHumidityElement])
            {
                [_timeParsingElements setObject:[attributeDict objectForKey:@"unit"] forKey:@"hum_unit"];
                [_timeParsingElements setObject:[attributeDict objectForKey:@"value"] forKey:@"hum_value"];
                //                _currentStep = kWeatherParserParsingStepTimeHumidity;
                //                _currentElementString = [[NSMutableString alloc] init];
            }
            else if ([elementName isEqualToString:kTimeCloudsElement])
            {
                [_timeParsingElements setObject:[attributeDict objectForKey:@"unit"] forKey:@"clouds_unit"];
                [_timeParsingElements setObject:[attributeDict objectForKey:@"value"] forKey:@"clouds_value"];
                [_timeParsingElements setObject:[attributeDict objectForKey:@"all"] forKey:@"clouds_all"];
                //                _currentStep = kWeatherParserParsingStepTimeClouds;
                //                _currentElementString = [[NSMutableString alloc] init];
            }
            break;
    }
}

-(void) parser:(NSXMLParser*)parser didEndElement:(NSString*)elementName namespaceURI:(NSString*)namespaceURI qualifiedName:(NSString*)qName
{
    switch ( _currentStep )
    {
        case kWeatherParserParsingStepTime:
            if ([elementName isEqualToString:kTimeElement])
            {
                NSDateFormatter* fmt = [[[NSDateFormatter alloc] init] autorelease];
//                [fmt setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZZ"];
                [fmt setDateFormat:@"yyyy-MM-ddEHH:mm:ss"];
                //[fmt setLocale:[[[ NSLocale alloc ]initWithLocaleIdentifier:@"en_US"]autorelease]];
                
                Time* time = [[[Time alloc] init] autorelease];
                time.from = [fmt dateFromString:[_timeParsingElements objectForKey:@"from"]];
                time.to = [fmt dateFromString:[_timeParsingElements objectForKey:@"to"]];
                
                time.symbol_var = [_timeParsingElements objectForKey:@"symbol_var"];
                time.name_of_symbol = [_timeParsingElements objectForKey:@"symbol_name"];
                
                NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
                [f setNumberStyle:NSNumberFormatterDecimalStyle];
                //NSNumber * myNumber = [f numberFromString:@"42"];
                time.humidity_val = [f numberFromString:[_timeParsingElements objectForKey:@"hum_value"]];
                [f release];
                // Добавить остальные поля
                
                [_parsedTimes addObject:time];
                
                [_timeParsingElements release];
                _timeParsingElements = nil;

                _currentStep = kWeatherParserParsingStepForecast;
            }
            break;
            
        case kWeatherParserParsingStepWeatherdataLocation:
            if ([elementName isEqualToString:kWeatherdataLocationElement])
            {
                [_currentElementString release];
                _currentElementString = nil;
                _currentStep = kWeatherParserParsingStepWeatherdata;
            }
            break;
            
        case kWeatherParserParsingStepWeatherdataLocationName:
            if ([elementName isEqualToString:kWeatherdataLocationNameElement])
            {
                [_weatherParsingElements setObject:[NSString stringWithString: _currentElementString] forKey:@"location_name"];
                [_currentElementString release];
                _currentElementString = nil;
                _currentStep = kWeatherParserParsingStepWeatherdataLocation;
            }
            break;
            
        case kWeatherParserParsingStepWeatherdataLocationCountry:
            if ([elementName isEqualToString:kWeatherdataLocationCountryElement])
            {
                [_weatherParsingElements setObject:[NSString stringWithString: _currentElementString] forKey:@"location_country"];
                [_currentElementString release];
                _currentElementString = nil;
                _currentStep = kWeatherParserParsingStepWeatherdataLocation;
            }
            break;
            
        case kWeatherParserParsingStepForecast:
            if ([elementName isEqualToString:kForecastElement])
            {
                Forecast* forecast = [[[Forecast alloc] init] autorelease];
                forecast.sunrise = [_weatherParsingElements objectForKey:@"rise"];
                forecast.sunset = [_weatherParsingElements objectForKey:@"set"];
                // TODO: from и to посчитать из всех Times
                forecast.from = [_weatherParsingElements objectForKey:@"rise"];
                forecast.to = [_weatherParsingElements objectForKey:@"rise"];
                
                forecast.times = [NSArray arrayWithArray:_parsedTimes];
                
                [_parsedForecasts addObject:forecast];
                
                [_parsedTimes release];
                _parsedTimes = nil;
                
            }
            break;
            
        case kWeatherParserParsingStepNo:
            break;
    }
}

-(void)parser:(NSXMLParser*)parser foundCharacters:(NSString*)string
{
    if (nil != _currentElementString) {
        [_currentElementString appendString:string];
    }
}


@end