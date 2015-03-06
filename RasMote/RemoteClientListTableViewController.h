//
//  ClientListTableViewController.h
//  RasMote
//
//  Created by Joe Sturzenegger on 2/17/15.
//  Copyright (c) 2015 Joe Sturzenegger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemoteClientDetailViewController.h"

@class RemoteClientListTableViewController;

@protocol RemoteClientListTableViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(RemoteClientListTableViewController *)controller;

@end


@interface RemoteClientListTableViewController : UITableViewController <CredentialsAddDelegate,
    NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) id <RemoteClientListTableViewControllerDelegate> delegate;

@end
