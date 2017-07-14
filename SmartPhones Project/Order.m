//
//  Order.m
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/21/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import "Order.h"

@implementation Order
@synthesize itemName = _itemName;
@synthesize itemCost = _itemCost;
@synthesize itemQuantity = _itemQuantity;
@synthesize homecook = _homecook;

+ (Order *)sharedInstance {
    static dispatch_once_t onceToken;
    static Order *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[Order alloc] init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if (self) {
        _itemName = [[NSMutableArray alloc] init];
        _itemCost = [[NSMutableArray alloc] init];
        _itemQuantity = [[NSMutableArray alloc] init];
        _homecook=[[NSMutableArray alloc]init];

        // Note these aren't allocated as [[NSString alloc] init] doesn't provide a useful object
        
    }
    return self;
}


@end
