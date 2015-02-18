//
//  Client.h
//  RasMote
//
//  Created by Joe Sturzenegger on 2/17/15.
//  Copyright (c) 2015 Joe Sturzenegger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Credentials;

@interface Client : NSManagedObject

@property (nonatomic, retain) NSString * clientName;
@property (nonatomic, retain) Credentials *credentials;

@end
