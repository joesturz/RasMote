//
//  RemoteFlipsideViewController.h
//  RasMote
//
//  Created by Joe Sturzenegger on 7/1/14.
//  Copyright (c) 2014 Joe Sturzenegger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Credentials.h"

@class RemoteClientDetailViewController;

@protocol RemoteClientDetailViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(RemoteClientDetailViewController *)controller;

@end

@protocol CredentialsAddDelegate;

@interface RemoteClientDetailViewController : UIViewController <UITextFieldDelegate>

-(BOOL) textFieldShouldReturn:(UITextField *)textField;
-(IBAction) clickBackgound;

@property(nonatomic, strong) Credentials *credentials;

@property (unsafe_unretained, nonatomic) id <CredentialsAddDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *clientAddressField;
@property (weak, nonatomic) IBOutlet UITextField *serverAddressField;
@property (weak, nonatomic) IBOutlet UITextField *portField;
@property (weak, nonatomic) IBOutlet UITextField *clientNameField;

@property(nonatomic) NSString *clientAddress;
@property(nonatomic) NSString *serverAddress;
@property(nonatomic) NSString *port;

@property(nonatomic) NSUserDefaults *defaultSettings;

-(void) setUpFlipSideServer:(NSString *) serverAdd Client:(NSString *)clientAdd Port:(NSString *) portNum;



@end

@protocol CredentialsAddDelegate <NSObject>

// credentials == nil on cancel
- (void)remoteClientDetailsViewController:(RemoteClientDetailViewController *)remoteClientDetailsViewController didAddCredentials:(Credentials *)credentials;

@end
