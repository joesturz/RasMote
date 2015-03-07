//
//  RemoteClientTableViewCell.m
//  RasMote
//
//  Created by Joe Sturzenegger on 2/19/15.
//  Copyright (c) 2015 Joe Sturzenegger. All rights reserved.
//

#import "RemoteClientTableViewCell.h"

@interface RemoteClientTableViewCell ()

@property (nonatomic, strong) UILabel *credentialsNameLabel;

- (CGRect) _nameLabelFrame;

@end

@implementation RemoteClientTableViewCell

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        
        _credentialsNameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.credentialsNameLabel setFont:[UIFont boldSystemFontOfSize:14.0]];
        [self.credentialsNameLabel setTextColor:[UIColor blackColor]];
        [self.credentialsNameLabel setHighlightedTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.credentialsNameLabel];
    }
    
    return self;
}

// to save space, the prep time label disappears during editing
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.credentialsNameLabel setFrame:[self _nameLabelFrame]];
}


#define IMAGE_SIZE          42.0
#define EDITING_INSET       10.0
#define TEXT_LEFT_MARGIN    8.0
#define TEXT_RIGHT_MARGIN   5.0
#define PREP_TIME_WIDTH     80.0

// returns the frame of the various subviews -- these are dependent on the editing state of the cell

- (CGRect)_nameLabelFrame {
    
    if (self.editing) {
        return CGRectMake(IMAGE_SIZE + EDITING_INSET + TEXT_LEFT_MARGIN, 4.0, self.contentView.bounds.size.width - IMAGE_SIZE - EDITING_INSET - TEXT_LEFT_MARGIN, 16.0);
    }
    else {
        return CGRectMake(IMAGE_SIZE + TEXT_LEFT_MARGIN, 4.0, self.contentView.bounds.size.width - IMAGE_SIZE - TEXT_RIGHT_MARGIN * 2 - PREP_TIME_WIDTH, 16.0);
    }
}

#pragma mark - Recipe set accessor

- (void)setRecipe:(Credentials *)newCredentials {
    
    if (newCredentials != _credentials) {
        _credentials = newCredentials;
    }
    self.credentialsNameLabel.text = (_credentials.clientName.length > 0) ? _credentials.clientName : @"-";
}

@end
