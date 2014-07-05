//
//  RemoteFlipsideViewController.m
//  RasMote
//
//  Created by Joe Sturzenegger on 7/1/14.
//  Copyright (c) 2014 Joe Sturzenegger. All rights reserved.
//

#import "RemoteFlipsideViewController.h"

@interface RemoteFlipsideViewController ()

@end

@implementation RemoteFlipsideViewController
{
    NSString *clientAddress;
    NSString *port;
    NSString *serverAddress;
}

//NSMutableURLRequest *request;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.clientAddressField.delegate = self;
    self.serverAddressField.delegate = self;
    self.portField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setClientAddress:(NSString *)add
{
    clientAddress = add;
    [_clientAddressField setText:add];
}
-(void)setPort:(NSString *)add
{
    port = add;
    [_portField setText:add];
}

-(NSString*)clientAddress
{
    if ([clientAddress isEqual:nil] || [clientAddress length] == 0)
    {
        return @"Unset Client Address";
    }
    return clientAddress;
}
-(NSString*)port
{
    if ([port isEqual:nil] || [port length] == 0)
    {
        return @"Unset Port";
    }
    return port;
}
-(void)setServerAddress:(NSString*) add
{
    serverAddress = add;
    [_serverAddressField setText:add];

}
-(NSString*)serverAddress
{
    if ([serverAddress isEqual:nil] || [serverAddress length] == 0)
    {
        return @"Unset Server Address";
    }
    return serverAddress;

}

//-(id)initWithPreferedSettings
//{
//    self = [super init];
//    if (self)
//    {
//        [self prefersStatusBarHidden];
//    }
//    return self;
//}
//-(id)init
//{
//    return [self initWithPreferedSettings];
//}

-(BOOL)prefersStatusBarHidden
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    NSString *addressString = [_clientAddressField text];
    NSString *serverString = [_serverAddressField text];
    NSString *portString =[_portField text];
    
    if (([addressString isEqual:nil] || [addressString length] != 0)
        && ([portString isEqual:nil] || [portString length] != 0)
        && ([serverString isEqual:nil] || [serverString length] != 0))
    {
        [self setClientAddress:addressString];
        [self setPort:portString];
        [self setServerAddress:serverString];
        NSLog(@"Got Server Address: %@, Client Address: %@ and Port: %@", serverString, addressString, portString);
    }
    else
    {
        NSLog(@"Client, Server or Port were not set!");
    }
    return YES;
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
