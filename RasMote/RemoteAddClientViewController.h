//
//  RemoteAddClientViewController.h
//  RasMote
//
//  Created by Joe Sturzenegger on 2/17/15.
//  Copyright (c) 2015 Joe Sturzenegger. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClientAddDelegate;

@class Client;

@interface RemoteAddClientViewController : UIViewController

@property (nonatomic, strong) Client *client;
@property (nonatomic, unsafe_unretained) id <ClientAddDelegate> delegate;

@end

@protocol ClientAddDelegate <NSObject>

// recipe == nil on cancel
- (void)remoteClientAddViewController:(RemoteAddClientViewController *)remoteClientAddViewController didAddClient:(Client *)client;

@end