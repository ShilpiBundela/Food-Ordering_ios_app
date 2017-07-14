//
//  AvailableHomecooksForSelectedDishViewController.h
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/16/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AvailableHomecooksForSelectedDishViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *HomecooksTable;
@property NSString *selectedDish;
@property (strong, nonatomic) NSArray *homecooksName;
@property (strong, nonatomic) NSArray *homecooksLocation;
@property (strong, nonatomic) NSArray *homecooksContact;
@property (strong, nonatomic) NSArray *homecooksRating;
@property (strong,nonatomic) NSArray *Menu;
@property NSMutableDictionary *homeCooksDetails;
@end
