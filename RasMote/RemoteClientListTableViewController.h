//
//  ClientListTableViewController.h
//  RasMote
//
//  Created by Joe Sturzenegger on 2/17/15.
//  Copyright (c) 2015 Joe Sturzenegger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemoteAddClientViewController.h"
#import "Client.h"

@class RemoteClientListTableViewController;

@protocol RemoteClientListTableViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(RemoteClientListTableViewController *)controller;

@end


@interface RemoteClientListTableViewController : UITableViewController <ClientAddDelegate,
    NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) id <RemoteClientListTableViewControllerDelegate> delegate;

@end
