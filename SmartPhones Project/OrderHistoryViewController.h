//
//  OrderHistoryViewController.h
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/25/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USer.h"
@interface OrderHistoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *OrderHistory;
@property NSMutableArray *OrderItemName;
@property NSMutableArray *OrderItemCost;
@property NSMutableArray *OrderItemDate;
@property NSMutableArray *OrderItemHomecook;
@property NSMutableArray *Userordersarray;
@property User *user;
@property User *Newuser;
@end
