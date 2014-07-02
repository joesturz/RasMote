//
//  RemoteMainViewController.m
//  RasMote
//
//  Created by Joe Sturzenegger on 7/1/14.
//  Copyright (c) 2014 Joe Sturzenegger. All rights reserved.
//

#import "RemoteMainViewController.h"

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

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(RemoteFlipsideViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
    }
}

@end
