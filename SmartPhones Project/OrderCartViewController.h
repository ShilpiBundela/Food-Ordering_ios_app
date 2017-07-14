//
//  OrderCartViewController.h
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/21/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"
#import "User.h"
#import "CustomTableViewCell.h"
@interface OrderCartViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate>

@property NSMutableArray *_objects;
@property (weak, nonatomic) IBOutlet UITableView *OrderItemTable;
@property NSMutableArray *OrderItemName;
@property NSMutableArray *OrderItemCost;
@property NSMutableArray *OrderItemQuantity;
@property NSMutableArray *OrderItemHomecook;
@property (weak, nonatomic) IBOutlet UILabel *Total;
@property Order *orderitem;
@property (weak, nonatomic) IBOutlet UIButton *Tip_15percent;
@property (weak, nonatomic) IBOutlet UIButton *Confirm_Order;
@property  double sum ;
@property (weak, nonatomic) IBOutlet UIButton *Tip_10percent;
@property (weak, nonatomic) IBOutlet UIButton *Tip_20percent;
@property User *user;
@property NSMutableArray *UserOrdersArray;
@property NSMutableArray *UpdatedUserOrdersArray;
@property NSMutableArray *UserDetails;
@property NSMutableArray *array;
@property NSDictionary *postDictionary;
@property  UIAlertView *alert;
@property  UITextField * alertTextField;
@end
