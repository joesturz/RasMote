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
    _delegate = self;
    _defaultSettings = [NSUserDefaults standardUserDefaults];
    
    _serverIP = [_defaultSettings stringForKey:@"ClientAddress"];
    _clientIP = [_defaultSettings stringForKey:@"ServerAddress"];
    _portNum = [_defaultSettings stringForKey:@"PortNumber"];
	// Do any additional setup after loading the view, typically from a nib.

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
NSMutableData *dataObj;


-(IBAction)buttonTapped:(id)sender
{
    //self.isHeld = NO;
    _serverIP = [_defaultSettings stringForKey:@"ServerAddress"];
    _clientIP = [_defaultSettings stringForKey:@"ClientAddress"];
    _portNum = [_defaultSettings stringForKey:@"PortNumber"];
    if ([_serverIP length] == 0 || [_clientIP length] == 0 || [_portNum length] == 0)
    {
        NSLog(@"The credentials are not set");
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Please add settings"
                              message:@""
                              delegate:nil  // set nil if you don't want the yes button callback
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
    
    UIButton *myButton = (UIButton *)sender;
    
    NSMutableURLRequest *request;
    NSString *URLString;
    NSString *baseURLString = [NSString stringWithFormat:@"http://%@:%@/system/players/%@/", _serverIP, _portNum, _clientIP];
    //http://192.168.1.64:32400/system/players/192.168.1.64/navigation/moveUp
    
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
        NSLog(@"Menu button tapped!");
    }
    
    request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:URLString]
                                      cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                  timeoutInterval:10];
    [request setHTTPMethod: @"GET"];
    [self makeConnectionWithRequest:request];
    
}
-(IBAction)upDownButtonTapped:(NSTimer *)timer
{
    UIButton *myButton = (UIButton *)[timer userInfo];
    [self buttonTapped:myButton];
    self.upDownCounter++;
}

-(IBAction)held:(id)sender
{
    //[self buttonTapped:sender];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(upDownButtonTapped:) userInfo:sender repeats:YES];
}
-(IBAction)released:(id)sender
{
    if (self.timer != nil)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (self.upDownCounter < 1)
    {
        [self buttonTapped:sender];
    }
    self.upDownCounter = 0;
}

-(void)makeConnectionWithRequest:(NSURLRequest *) request
{
    dataObj = [NSMutableData dataWithCapacity:0];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (!conn)
    {
        dataObj = nil;
        NSLog(@"The Connection Failed");
    }

}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //NSLog(@"Recieve Response");
    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *) response;
    
    NSLog(@"Recieve Response, Status Code: %ld", (long)[HTTPResponse statusCode]);
    // This method is called when the server has determined that it
    // has enough information to create the NSURLResponse object.
    
    // It can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    
    // receivedData is an instance variable declared elsewhere.
    [dataObj setLength:0];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Recieve Data");
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [dataObj appendData:data];
}
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError");
    NSLog(@"Connection failed: %@", [error description]);
    
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:[error localizedDescription]
                          message:@""
                          delegate:nil  // set nil if you don't want the yes button callback
                          cancelButtonTitle:@"Cancel"
                          otherButtonTitles:@"OK", nil];
    [alert show];
}
-(void)connectionDidFinishLoading:(NSURLConnection *) connection
{
    NSLog(@"connectionDidFinishLoading");
    NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[dataObj length]);
}
-(IBAction)stepperValueChanged:(id)sender
{
    NSMutableURLRequest *request;
    NSString *URLString;
    
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
    [self makeConnectionWithRequest:request];
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
-(void)receivedData:(NSData*)data
{
    NSString* newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString* newStrNullTerm = [NSString stringWithUTF8String:[data bytes]];
    NSLog(@"Not Null Term: %@",newStr);
    NSLog(@"Null Term: %@",newStrNullTerm);
    
}
-(void)emptyReply
{
    NSLog(@"Empty Reply");
}
-(void)timedOut
{
    NSLog(@"Time Out");
}
-(void)downloadError:(NSError*) error
{
    NSLog(@"Error");
}
@end
