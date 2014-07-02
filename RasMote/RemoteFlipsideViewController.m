//
//  RemoteFlipsideViewController.m
//  RasMote
//
//  Created by Joe Sturzenegger on 7/1/14.
//  Copyright (c) 2014 Joe Sturzenegger. All rights reserved.
//

#import "RemoteFlipsideViewController.h"

@interface RemoteFlipsideViewController ()

@end

@implementation RemoteFlipsideViewController

//NSMutableURLRequest *request;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
NSString *address;
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)applyClicked:(UIButton *)sender
{
    NSString *log = [NSString stringWithFormat:@"Got Address: %@", [_addressField text]];
    if ([log isEqual:nil] || [log length] != 0)
    {
        [self setAddress:[_addressField text]];
        NSLog(log);
    }
    //request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@""]];
}
-(void)setAddress:(NSString *)add
{
    address = add;
    [_addressField setText:add];
}
-(NSString*)address
{
    if ([address isEqual:nil] || [address length] == 0)
    {
        return @"Unset Address";
    }
    return address;
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
