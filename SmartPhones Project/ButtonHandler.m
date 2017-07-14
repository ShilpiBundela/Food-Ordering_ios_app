//
//  ButtonHandler.m
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/10/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import "ButtonHandler.h"

@implementation ButtonHandler
-(IBAction)handleButton1:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyButtonPressed" object:self];
}
-(IBAction)segmentChanged:(id)sender
{
    self.segmentControl=sender;
    
    switch (self.segmentControl.selectedSegmentIndex) {
        case 0:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyButtonPressed0" object:self];
            break;
        case 1:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"notifyButtonPressed1" object:self];
            break;
            
        default:
            break;
    }
}

@end
