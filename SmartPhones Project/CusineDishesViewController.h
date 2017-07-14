//
//  CusineDishesViewController.h
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/11/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CusineDishesViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *CusineDishesTable;
@property NSArray *DishesName;
@property NSString *selecedCusine;

@property (weak, nonatomic) IBOutlet UISearchBar *SearchBar;
@property NSMutableArray *filteredString;
@property BOOL isFilltered;
@end
