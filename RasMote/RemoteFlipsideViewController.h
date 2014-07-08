//
//  RemoteFlipsideViewController.h
//  RasMote
//
//  Created by Joe Sturzenegger on 7/1/14.
//  Copyright (c) 2014 Joe Sturzenegger. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RemoteFlipsideViewController;

@protocol RemoteFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(RemoteFlipsideViewController *)controller;

@end

@interface RemoteFlipsideViewController : UIViewController <UITextFieldDelegate>
{
}

@property (weak, nonatomic) id <RemoteFlipsideViewControllerDelegate> delegate;
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
