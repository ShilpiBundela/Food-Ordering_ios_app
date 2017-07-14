//
//  SignInPageViewController.h
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/24/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface SignInPageViewController : UIViewController<UITextFieldDelegate>
@property User *user;
@property NSString *userID;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *EmailLabel;
@property (weak, nonatomic) IBOutlet UILabel *ContactLabel;
@property (weak, nonatomic) IBOutlet UILabel *AddressLabel;

@property (weak, nonatomic) IBOutlet UITextField *UserIdText;
@property (weak, nonatomic) IBOutlet UIButton *SignIn;
@property (weak, nonatomic) IBOutlet UIButton *ViewOrderHistory;
@property (weak, nonatomic) IBOutlet UITextField *UserEmail;
@property (weak, nonatomic) IBOutlet UITextField *UserContact;
@property NSString *fileName;
@property NSString *userFileName;
@property NSString *userFilepath;
@property NSMutableArray *OrderHistory;
@property (weak, nonatomic) IBOutlet UITextField *UserAddress;
@property (weak, nonatomic) IBOutlet UITextField *UserName;

@end
