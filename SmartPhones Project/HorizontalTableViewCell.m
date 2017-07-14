//
//  HorizontalTableViewCell.m
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/16/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import "HorizontalTableViewCell.h"

@implementation HorizontalTableViewCell

static CGSize onLoadSize;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.transform = CGAffineTransformMakeRotation(M_PI_2);
        self.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if(CGSizeZero.width==onLoadSize.width && CGSizeZero.height==onLoadSize.height)
    {
        onLoadSize=self.contentView.bounds.size;
    }
    self.textLabel.frame = CGRectMake(0, 0, onLoadSize.width, onLoadSize.height);
    self.selectedBackgroundView.frame=self.textLabel.frame;
}
@end
