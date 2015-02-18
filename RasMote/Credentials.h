//
//  Credentials.h
//  RasMote
//
//  Created by Joe Sturzenegger on 2/17/15.
//  Copyright (c) 2015 Joe Sturzenegger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Client;

@interface Credentials : NSManagedObject

@property (nonatomic, retain) NSString * clientAddress;
@property (nonatomic, retain) NSString * port;
@property (nonatomic, retain) NSString * serverAddress;
@property (nonatomic, retain) Client *client;

@end
