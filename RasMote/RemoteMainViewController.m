//
//  RemoteMainViewController.m
//  RasMote
//
//  Created by Joe Sturzenegger on 7/1/14.
//  Copyright (c) 2014 Joe Sturzenegger. All rights reserved.
//

#import "RemoteMainViewController.h"
#import "RemoteFlipsideViewController.h"

@interface RemoteMainViewController ()

@end

@implementation RemoteMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)buttonTapped:(UIButton *)sender
{
    UIButton *myButton = sender;
    NSLog([_flipController address]);
    NSString *currentAddress = [_flipController address];
    
    if ([myButton.currentTitle  isEqualToString: @"Up"])
    {
        NSLog(@"Up button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"Down"])
    {
        NSLog(@"Down button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"Left"])
    {
        NSLog(@"Left button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"Right"])
    {
        NSLog(@"Right button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"Select"])
    {
        NSLog(@"Select button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"Menu"])
    {
        NSLog(@"Menu button tapped!");
    }
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(RemoteFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    _flipController = controller;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        
        RemoteFlipsideViewController *flipC = (RemoteFlipsideViewController *)[segue destinationViewController];
        NSString *test = [_flipController address];
        [flipC setAddress:test];
        
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
