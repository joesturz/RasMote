//
//  RemoteClientTableViewCell.m
//  RasMote
//
//  Created by Joe Sturzenegger on 2/19/15.
//  Copyright (c) 2015 Joe Sturzenegger. All rights reserved.
//

#import "RemoteClientTableViewCell.h"

@interface RemoteClientTableViewCell ()

@property (nonatomic, strong) UILabel *clientNameLabel;

@end

@implementation RemoteClientTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
