//
//  NSViewCrrl.m
//  FirstApp
//
//  Created by Sabertooth on 03/01/18.
//  Copyright © 2018 Sabertoothasda. All rights reserved.
//

#import "NSViewCrrl.h"

@interface NSViewCrrl ()

@end

@implementation NSViewCrrl
@synthesize main;
@synthesize humidity;
@synthesize pressure;
@synthesize temp;
@synthesize cityname;
@synthesize description;
@synthesize location;
@synthesize imageview;

- (void)viewDidLoad {
    
    [imageview setImageScaling:NSImageScaleProportionallyUpOrDown];
    [imageview setImageFrameStyle:NSImageFramePhoto];
    
    [main setTextColor:[NSColor blackColor]];
    
    stricon = [[NSMutableString alloc] init];
    strmain = [[NSMutableString alloc] init];
    strhumidity = [[NSMutableString alloc] init];
    strpressure = [[NSMutableString alloc] init];
    strtemp = [[NSMutableString alloc] init];
    strdescription = [[NSMutableString alloc] init];
    strlocation = [[NSMutableString alloc] init];
    
    [super viewDidLoad];
    // Do view setup here.
}


-(IBAction)Search:(id)sender {
    
    [main setStringValue:@""];
    [humidity setStringValue:@""];
    [temp setStringValue:@""];
    [description setStringValue:@""];
    [location setStringValue:@""];
    [pressure setStringValue:@""];
    
    NSError *error;
    NSString *Ctyname = [cityname stringValue];
    
    if (!Ctyname) {
        return;
    }
    
    NSString *urlName = [NSMutableString stringWithFormat:@"http://api.openweathermap.org/data/2.5/weather?q=%@,in&appid=1ddfea2bac711c51cad51f0ccf59ad0c", Ctyname];
    
 
    NSURL *url = [NSURL URLWithString:urlName];
    NSString *content = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    
    if (!content || [content isEqualToString:@""]) {
        return;
    }
        
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    if (!data) {
        return;
    }
    
    id Dictdata = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"Error parsing JSON: %@", error);
    }

    if ([Dictdata isKindOfClass:[NSDictionary class]]) {
    
        id str = [Dictdata objectForKey:@"cod"];
        if ([str isEqual:@"404"]) {
            
            [cityname setStringValue:@"City not found"];
            // city not found
            return;
        }
        
        NSDictionary *dictmain = [Dictdata objectForKey:@"main"];
        strhumidity = [dictmain objectForKey:@"humidity"];
        strpressure = [dictmain objectForKey:@"pressure"];
        strtemp = [dictmain objectForKey:@"temp"];
        
        NSDictionary *dictLoc = [Dictdata objectForKey:@"coord"];
        NSString *strLat = [dictLoc objectForKey:@"lat"];
        NSString *strLon = [dictLoc objectForKey:@"lon"];
        strlocation = [NSMutableString stringWithFormat:@"%@,%@",strLat , strLon];

        id arrweather = [Dictdata objectForKey:@"weather"];
        NSDictionary * dictWeather = [arrweather objectAtIndex:0];
        strdescription = [dictWeather objectForKey:@"description"];
        stricon = [dictWeather objectForKey:@"icon"];

        NSString *urlImage = [NSMutableString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", stricon];
        NSImage *imagename = [[NSImage alloc] initWithContentsOfURL:[NSURL URLWithString:urlImage]];
        [imageview setImage:imagename];
        
        strmain = [dictWeather objectForKey:@"main"];
        [main setStringValue:strmain];
        [humidity setStringValue:strhumidity];
        [temp setStringValue:strtemp];
        [description setStringValue:strdescription];
        [location setStringValue:strlocation];
        [pressure setStringValue:strpressure];
    }
}


-(IBAction)Ok:(id)sender {
     [[[NSApplication sharedApplication] mainWindow] close];
}



@end
