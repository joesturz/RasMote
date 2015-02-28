//
//  RemoteFlipsideViewController.h
//  RasMote
//
//  Created by Joe Sturzenegger on 7/1/14.
//  Copyright (c) 2014 Joe Sturzenegger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Client.h"
#import "Credentials.h"

@class RemoteClientDetailViewController;

@protocol RemoteClientDetailViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(RemoteClientDetailViewController *)controller;

@end

@interface RemoteClientDetailViewController : UIViewController <UITextFieldDelegate>

-(BOOL) textFieldShouldReturn:(UITextField *)textField;
-(IBAction) clickBackgound;

@property Client *client;
@property Credentials *credentials;

@property (weak, nonatomic) id <RemoteClientDetailViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *clientAddressField;
@property (weak, nonatomic) IBOutlet UITextField *serverAddressField;
@property (weak, nonatomic) IBOutlet UITextField *portField;

@property(nonatomic) NSString *clientAddress;
@property(nonatomic) NSString *serverAddress;
@property(nonatomic) NSString *port;

@property(nonatomic) NSUserDefaults *defaultSettings;

-(void) setUpFlipSideServer:(NSString *) serverAdd Client:(NSString *)clientAdd Port:(NSString *) portNum;
- (IBAction)done:(id)sender;

@end