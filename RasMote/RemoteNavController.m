//
//  RemoteNavController.m
//  RasMote
//
//  Created by Joe Sturzenegger on 6/13/15.
//  Copyright (c) 2015 Joe Sturzenegger. All rights reserved.
//

#import "RemoteNavController.h"

@implementation RemoteNavController

-(void) viewDidLoad
{
    //[self.navigationBar setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0]];
    float greyValue = 85.0f;
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:greyValue/255.0f green:greyValue/255.0f blue:greyValue/255.0f alpha:1.0]];
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIColor colorWithRed:255.0/255.0 green:161.0/255.0 blue:0.0/255.0 alpha:1.0], NSForegroundColorAttributeName, nil]];
    [self.navigationBar setAlpha:0.0];
    //255	161	0
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end
