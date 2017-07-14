//
//  User.m
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/24/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import "User.h"

@implementation User


@synthesize UserName = _UserName;
@synthesize UserId = _UserId;
@synthesize Address = _Address;
@synthesize Email = _Email;
@synthesize Contact=_Contact;
@synthesize isSignedIn=_isSignedIn;
@synthesize itemName = _itemName;
@synthesize itemCost = _itemCost;
@synthesize itemQuantity = _itemQuantity;
@synthesize homecook = _homecook;
@synthesize orderDate=_orderDate;

+ (User *)sharedInstance {
    static dispatch_once_t onceToken;
    static User *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[User alloc] init];
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
        _orderDate=[[NSMutableArray alloc]init];
        
       
        
    }
    return self;
}



@end
