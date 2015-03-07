//
//  RemoteMainViewController.h
//  RasMote
//
//  Created by Joe Sturzenegger on 7/1/14.
//  Copyright (c) 2014 Joe Sturzenegger. All rights reserved.
//

#import "RemoteClientListTableViewController.h"

@interface RemoteMainViewController : UIViewController <RemoteClientListTableViewControllerDelegate>

@property(strong, nonatomic) RemoteClientListTableViewController *flipController;
@property(weak, nonatomic) RemoteMainViewController *delegate;

@property(weak, nonatomic) IBOutlet UILabel *volumeLevel;
@property (weak, nonatomic) IBOutlet UILabel *clientNameLabel;

@property(weak, nonatomic) NSUserDefaults *defaultSettings;

@property(weak, nonatomic) NSString *serverIP;
@property(weak, nonatomic) NSString *clientIP;
@property(weak, nonatomic) NSString *clientName;
@property(weak, nonatomic) NSString *portNum;

@property(nonatomic, retain) NSTimer *timer;

@property (nonatomic) NSInteger upDownCounter;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

-(IBAction)buttonTapped:(id)sender;
-(IBAction)stepperValueChanged:(id)sender;
-(IBAction)held:(id)sender;
-(IBAction)released:(id)sender;


@end
