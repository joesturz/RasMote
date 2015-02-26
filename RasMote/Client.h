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

@property (nonatomic, strong) NSString * clientName;
@property (nonatomic, strong) Credentials *credentials;

@end

@interface Client (CoreDataGeneratedAccessors)

-(void)addCredentialsObject:(NSManagedObject *)value;
-(void)removeCredentialsObject:(NSManagedObject *)value;

@end
