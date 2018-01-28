//
//  NSViewCrrl.h
//  FirstApp
//
//  Created by Sabertooth on 03/01/18.
//  Copyright © 2018 Sabertoothasda. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NSViewCrrl : NSViewController
{
    NSTextField *cityname;
    NSTextField *main;
    NSTextField *humidity;
    NSTextField *pressure;
    NSTextField *temp;
    NSTextField *description;
    NSTextField *location;
    NSImageView *imageview;
    
    NSMutableString *stricon;
    NSMutableString *strmain;
    NSMutableString *strhumidity;
    NSMutableString *strpressure;
    NSMutableString *strtemp;
    NSMutableString *strdescription;
    NSMutableString *strlocation;
    
}
@property(retain) IBOutlet NSImageView *imageview;
@property(retain) IBOutlet NSTextField *cityname;
@property(retain) IBOutlet NSTextField *main;
@property(retain) IBOutlet NSTextField *humidity;
@property(retain) IBOutlet NSTextField *pressure;
@property(retain) IBOutlet NSTextField *temp;
@property(retain) IBOutlet NSTextField *description;
@property(retain) IBOutlet NSTextField *location;
-(IBAction)Ok:(id)sender;
-(IBAction)Search:(id)sender;
@end
