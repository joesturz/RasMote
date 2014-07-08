//
//  RemoteMainViewController.h
//  RasMote
//
//  Created by Joe Sturzenegger on 7/1/14.
//  Copyright (c) 2014 Joe Sturzenegger. All rights reserved.
//

#import "RemoteFlipsideViewController.h"

@interface RemoteMainViewController : UIViewController <RemoteFlipsideViewControllerDelegate>

@property(strong, nonatomic) RemoteFlipsideViewController *flipController;
@property(weak, nonatomic) IBOutlet UILabel *volumeLevel;
@property(weak, nonatomic) RemoteMainViewController *delegate;

-(IBAction)buttonTapped:(id)sender;
-(IBAction)stepperValueChanged:(id)sender;


@end
