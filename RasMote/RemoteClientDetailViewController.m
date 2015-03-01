//
//  RemoteFlipsideViewController.m
//  RasMote
//
//  Created by Joe Sturzenegger on 7/1/14.
//  Copyright (c) 2014 Joe Sturzenegger. All rights reserved.
//

#import "RemoteClientDetailViewController.h"
#import "EditingTableViewCell.h"

@interface RemoteClientDetailViewController ()

@end

@implementation RemoteClientDetailViewController
{
    NSString *clientAddress;
    NSString *port;
    NSString *serverAddress;
}

-(IBAction)clickBackgound
{
    [self.view endEditing:YES];
}

//NSMutableURLRequest *request;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.clientAddressField.delegate = self;
    self.serverAddressField.delegate = self;
    self.portField.delegate = self;
// Do any additional setup after loading the view, typically from a nib.
    
    
    _defaultSettings = [NSUserDefaults standardUserDefaults];
    [self setClientAddress:[_defaultSettings stringForKey:@"ClientAddress"]];
    [self setServerAddress:[_defaultSettings stringForKey:@"ServerAddress"]];
    [self setPort:[_defaultSettings stringForKey:@"PortNumber"]];
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
    [_defaultSettings setObject:add forKey:@"ClientAddress"];
}
-(void)setPort:(NSString *)add
{
    port = add;
    [_portField setText:add];
    [_defaultSettings setObject:add forKey:@"PortNumber"];
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
    [_defaultSettings setObject:add forKey:@"ServerAddress"];

}
-(NSString*)serverAddress
{
    if ([serverAddress isEqual:nil] || [serverAddress length] == 0)
    {
        return @"Unset Server Address";
    }
    return serverAddress;

}
-(void) setUpFlipSideServer:(NSString *) serverAdd Client:(NSString *)clientAdd Port:(NSString *) portNum
{
    self.portField.text = portNum;
    self.clientAddressField.text = clientAdd;
    self.serverAddressField.text = serverAdd;
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
        [self setClientAddress:addressString];
        [self setPort:portString];
        [self setServerAddress:serverString];
    }
    return YES;
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}
- (IBAction)save:(id)sender {
    
    NSManagedObjectContext *context = [self.client managedObjectContext];
    
    // if there isn't an ingredient object, create and configure one
    if (!self.credentials) {
        self.credentials = [NSEntityDescription insertNewObjectForEntityForName:@"Credentials"
                                                        inManagedObjectContext:context];
        //[self.client addCredentialsObject:self.credentials];
    }
    
    // update the ingredient from the values in the text fields
    

    self.credentials.serverAddress = self.serverAddressField.text;
    self.credentials.clientAddress = self.clientAddressField.text;
    self.credentials.port = self.portField.text;
    
    [self.client addCredentialsObject:self.credentials];
    
    // save the managed object context
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate.
         You should not use this function in a shipping application, although it may be
         useful during development. If it is not possible to recover from the error, display
         an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}




@end
