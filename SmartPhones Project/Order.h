//
//  Order.h
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/21/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Order : NSObject
{
    NSMutableArray *_itemName;
    NSMutableArray *_itemCost;
    NSMutableArray *_itemQuantity;
    NSMutableArray *_homecook;
}

+ (Order *)sharedInstance;

@property(strong, nonatomic, readwrite) NSMutableArray *itemName;
@property(strong, nonatomic, readwrite) NSMutableArray *itemCost;
@property(strong, nonatomic, readwrite) NSMutableArray *itemQuantity;
@property(strong, nonatomic, readwrite) NSMutableArray *homecook;

@end
