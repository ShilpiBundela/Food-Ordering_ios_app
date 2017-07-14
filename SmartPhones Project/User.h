//
//  User.h
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/24/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
{
    NSString *_UserId;
    NSString *_UserName;
    NSString *_Contact;
    NSString *_Address;
    NSString *_Email;
    NSString *_FileName;
     NSString *_Filepath;
    NSMutableArray *_itemName;
    NSMutableArray *_itemCost;
    NSMutableArray *_itemQuantity;
    NSMutableArray *_homecook;
    NSMutableArray *_orderDate;
    BOOL _isSignedIn;
    
}

+ (User *)sharedInstance;

@property(strong, nonatomic, readwrite) NSString *UserId;
@property(strong, nonatomic, readwrite) NSString *UserName;
@property(strong, nonatomic, readwrite) NSString *Contact;
@property(strong, nonatomic, readwrite) NSString *Address;
@property(strong, nonatomic, readwrite) NSString *Email;
@property(strong, nonatomic) NSString *FileName;
@property(strong, nonatomic) NSString *FilePath;
@property(strong, nonatomic, readwrite) NSMutableArray *itemName;
@property(strong, nonatomic, readwrite) NSMutableArray *itemCost;
@property(strong, nonatomic, readwrite) NSMutableArray *itemQuantity;
@property(strong, nonatomic, readwrite) NSMutableArray *homecook;
@property(strong, nonatomic, readwrite) NSMutableArray *orderDate;
@property BOOL isSignedIn;


@end
