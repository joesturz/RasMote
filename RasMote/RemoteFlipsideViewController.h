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

@interface RemoteFlipsideViewController : UIViewController

@property (weak, nonatomic) id <RemoteFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
