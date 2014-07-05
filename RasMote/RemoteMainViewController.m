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
-(void)sendClientURL:(NSString*) cURL fromServerURL:(NSString*) sURL overPort:(NSString*) portNumber
{
    
}

-(IBAction)buttonTapped:(UIButton *)sender
{
    UIButton *myButton = sender;
    NSLog(@"Server IP: %@",[_flipController serverAddress]);
    NSLog(@"Client IP: %@",[_flipController clientAddress]);
    NSLog(@"Port: %@",[_flipController port]);
    
    
    //NSString *currentAddress = [_flipController address];
    
    if ([myButton.currentTitle  isEqualToString: @"↑"])
    {
        NSLog(@"Up button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"↓"])
    {
        NSLog(@"Down button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"←"])
    {
        NSLog(@"Left button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"→"])
    {
        NSLog(@"Right button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"◉"])
    {
        NSLog(@"Select button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"↩︎"])
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
        NSString *test = [_flipController serverAddress];
        [flipC setClientAddress:test];
        
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
