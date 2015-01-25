//
//  UITableViewCell+CategoryViewCell.m
//  LikedOrNope
//
//  Created by Utkarsh Garg on 1/25/15.
//  Copyright (c) 2015 modocache. All rights reserved.
//

#import "TrendCell.h"

@implementation TrendCell

@synthesize descriptionLabel = _descriptionLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // configure control(s)
        self.descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 300, 30)];
        self.descriptionLabel.textColor = [UIColor blackColor];
        self.descriptionLabel.font = [UIFont fontWithName:@"Arial" size:12.0f];
        
        [self addSubview:self.descriptionLabel];
    }
    return self;
}


@end
