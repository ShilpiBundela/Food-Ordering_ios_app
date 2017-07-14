//
//  HomeCookMenuforSelectedCusineViewController.h
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/16/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
@interface HomeCookMenuforSelectedCusineViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,UITextFieldDelegate>
@property NSString *HomeCook;
@property NSString *Rating;
@property NSString *Location;
@property NSString *Contact;
@property NSArray *Menu;
@property NSArray *Itemname;
@property NSArray *ItemCost;
@property NSDictionary *MenuDictionary;
@property (weak, nonatomic) IBOutlet UITableView *MenuTable;
@property (weak, nonatomic) IBOutlet UILabel *LocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *RatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *ContactLabel;
@property Order *orderitem;
@property NSDictionary *Order;
@property UIAlertView *alert;
@property UITextField * alertTextField;
@property int orderCount;
@end
