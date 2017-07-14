//
//  CustomTableViewCell.m
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/22/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
@synthesize Subtitle1=_Subtitle1;
@synthesize Subtitle2=_Subtitle2;
@synthesize Subtitle3=_Subtitle3;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _Subtitle1 = [[UILabel alloc] init];
        _Subtitle1 .textColor =[UIColor blackColor];
        [self.contentView addSubview:_Subtitle1];
        
        _Subtitle2 = [[UILabel alloc] init];
       _Subtitle2 .textColor =[UIColor blackColor];
        _Subtitle2.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_Subtitle2];
        
        
        _Subtitle3 = [[UILabel alloc] init];
        _Subtitle3 .textColor =[UIColor blackColor];
        _Subtitle2.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_Subtitle3];
    }
    return self;
}

@end
