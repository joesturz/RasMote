//
//  ClientListTableViewController.m
//  RasMote
//
//  Created by Joe Sturzenegger on 2/17/15.
//  Copyright (c) 2015 Joe Sturzenegger. All rights reserved.
//

#import "RemoteClientListTableViewController.h"
#import "RemoteClientDetailViewController.h"
#import "RemoteAppDelegate.h"
#import "RemoteClientTableViewCell.h"


@interface RemoteClientListTableViewController ()

@end

// segue ID when "+" button is tapped
static NSString *kShowClientSegueID = @"showCredentials";
static NSString *kAddClientSegueID = @"addCredentials";
static NSString *kShowTableView = @"showTableView";

@implementation RemoteClientListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // add the table's edit button to the left side of the nav bar
    // self.navigationItem.leftBarButtonItem = self.editButtonItem;
    // Set the table view's row height
    self.tableView.rowHeight = 44.0;
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Client support

-(void) remoteClientDetailsViewController:(RemoteClientDetailViewController *)remoteClientDetailsViewController didAddCredentials:(Credentials *)credentials
{
    if (credentials)
    {
        [self performSegueWithIdentifier:kShowTableView sender:credentials];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger count = [self.fetchedResultsController sections].count;
    
    if (count == 0) {
        count = 1;
    }
    
    return count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = 0;
    
    if ([self.fetchedResultsController sections].count > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        numberOfRows = [sectionInfo numberOfObjects];
    }
    
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // dequeue a RecipeTableViewCell, then set its recipe to the recipe for the current row
    RemoteClientTableViewCell *clientCell =
    (RemoteClientTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"credentialsCellID" forIndexPath:indexPath];
    [self configureCell:clientCell atIndexPath:indexPath];
    
    return clientCell;
}

- (void)configureCell:(RemoteClientTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Credentials *credentials = (Credentials *)[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.credentials = credentials;
}
#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController {
    
    // Set up the fetched results controller if needed.
    if (_fetchedResultsController == nil) {
        // Create the fetch request for the entity.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        // Edit the entity name as appropriate.
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Credentials" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"clientName" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
        aFetchedResultsController.delegate = self;
        self.fetchedResultsController = aFetchedResultsController;
    }
    
    return _fetchedResultsController;
}

/**
 Delegate methods of NSFetchedResultsController to respond to additions, removals and so on.
 */
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(RemoteClientTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

- (IBAction)done:(id)sender {
    
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    
    // The fetch controller has sent all current change notifications,
    // so tell the table view to process all updates.
    [self.tableView endUpdates];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
 */


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        // Save the context.
        NSError *error;
        if (![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:kShowClientSegueID]) {
        // show a recipe
        //
        RemoteClientDetailViewController *detailController = (RemoteClientDetailViewController *)segue.destinationViewController;
        
        Credentials *credentials = nil;
        if ([sender isKindOfClass:[Credentials class]]) {
            // the sender is the actual recipe send from "didAddRecipe" delegate (user created a new recipe)
            credentials = (Credentials *)sender;
        }
        else {
            // the sender is ourselves (user tapped an existing recipe)
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            credentials = (Credentials *)[self.fetchedResultsController objectAtIndexPath:indexPath];
        }
        detailController.credentials = credentials;
    }
    if ([[segue identifier] isEqualToString:kAddClientSegueID]) {
        // add a recipe
        //
        Credentials *credentials = [NSEntityDescription insertNewObjectForEntityForName:@"Credentials"
                                                          inManagedObjectContext:self.managedObjectContext];
        
        UINavigationController *navController = segue.destinationViewController;
        RemoteClientDetailViewController *detailsController = (RemoteClientDetailViewController *)navController.topViewController;
        detailsController.delegate = self;  // do didAddClient delegate method is called when cancel or save are tapped
        detailsController.credentials = credentials;
    }
}


@end
