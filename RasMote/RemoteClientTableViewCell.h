//
//  RemoteClientTableViewCell.h
//  RasMote
//
//  Created by Joe Sturzenegger on 2/19/15.
//  Copyright (c) 2015 Joe Sturzenegger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Credentials.h"

@interface RemoteClientTableViewCell : UITableViewCell

@property (nonatomic, strong) Credentials *credentials;

@end
