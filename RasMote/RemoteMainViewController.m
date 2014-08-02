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
    _defaultSettings = [NSUserDefaults standardUserDefaults];
    if (_flipController == nil)
    {
        _serverIP = [_defaultSettings stringForKey:@"ClientAddress"];
        _clientIP = [_defaultSettings stringForKey:@"ServerAddress"];
        _portNum = [_defaultSettings stringForKey:@"PortNumber"];
    }
    else
    {
        _serverIP = [_flipController serverAddress];
        _clientIP = [_flipController clientAddress];
        _portNum = [_flipController port];
    }
	// Do any additional setup after loading the view, typically from a nib.
//    self.flipController = [[RemoteFlipsideViewController alloc] initWithNibName:@"RemoteFlipSideViewController" bundle:Nil];
//    self.flipController.delegate = self;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sendClientURL:(NSString*) cURL fromServerURL:(NSString*) sURL overPort:(NSString*) portNumber
{
    
}
bool isPlaying = NO;
-(IBAction)buttonTapped:(id)sender
{
    UIButton *myButton = (UIButton *)sender;
    
    NSMutableURLRequest *request;
    NSError *requestError;
    NSURLResponse *response = nil;
    NSString *URLString;
    NSString *baseURLString = [NSString stringWithFormat:@"http://%@:%@/system/players/%@/", _serverIP, _portNum, _clientIP];

    NSLog(@"Server IP: %@",_serverIP);
    NSLog(@"Client IP: %@",_clientIP);
    NSLog(@"Port: %@", _portNum);
    
    //NSString *currentAddress = [_flipController address];
    
    if ([myButton.currentTitle  isEqualToString: @"↑"])
    {
        URLString = [NSString stringWithFormat:@"%@%@", baseURLString, @"navigation/moveUp"];
        NSLog(@"Up button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"↓"])
    {
        URLString = [NSString stringWithFormat:@"%@%@", baseURLString, @"navigation/moveDown"];
        NSLog(@"Down button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"←"])
    {
        URLString = [NSString stringWithFormat:@"%@%@", baseURLString, @"navigation/moveLeft"];
        NSLog(@"Left button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"→"])
    {
        URLString = [NSString stringWithFormat:@"%@%@", baseURLString, @"navigation/moveRight"];
        NSLog(@"Right button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"◉"])
    {
        URLString = [NSString stringWithFormat:@"%@%@", baseURLString, @"navigation/select"];
        NSLog(@"Select button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"↩︎"])
    {
        URLString = [NSString stringWithFormat:@"%@%@", baseURLString, @"navigation/back"];
        NSLog(@"Back button tapped!");
    }
    else if ([myButton.currentTitle isEqualToString:@"Menu"])
    {
        URLString = [NSString stringWithFormat:@"%@%@", baseURLString, @"navigation/toggleOSD"];
        NSLog(@"Back button tapped!");
    }
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                  timeoutInterval:10];
    [request setHTTPMethod: @"GET"];
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&requestError];
}
-(IBAction)stepperValueChanged:(id)sender
{
    NSMutableURLRequest *request;
    NSString *URLString;
    NSOperationQueue *queue;
    
    NSString *baseURLString = [NSString stringWithFormat:@"http://%@:%@/system/players/%@/application/setVolume?level=", _serverIP, _portNum, _clientIP];

    UIStepper *stepper = (UIStepper *)sender;
    stepper.maximumValue = 10;
    stepper.minimumValue = 0;
    int value = [stepper value] * 10;
    URLString = [NSString stringWithFormat:@"%@%d", baseURLString, value];
    NSLog(@"%d", value);
    self.volumeLevel.text = [NSString stringWithFormat:@"%d", value];
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                  timeoutInterval:10];
    [request setHTTPMethod: @"GET"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
    {
//                if ([data length] > 0 && requestError == nil)
//                    [delegate receivedData:data];
//                else if ([data length] == 0 && requestError == nil)
//                    [delegate emptyReply];
//                else if (requestError != nil && requestError.code == ERROR_CODE_TIMEOUT)
//                    [delegate timedOut];
//                else if (requestError != nil)
//                    [delegate downloadError:requestError];
    }];

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
        [flipC setDelegate:self];

    }
}



@end
