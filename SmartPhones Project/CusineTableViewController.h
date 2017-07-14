//
//  CusineTableViewController.h
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/8/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CusineTableViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *CusineTable;
@property (nonatomic, strong) NSMutableData *buffer;
@property (nonatomic, strong) NSURLConnection *connection;
@property (strong, nonatomic) NSArray *googlePlacesArrayFromAFNetworking;
@property (strong, nonatomic) NSArray *finishedGooglePlacesArray;
@property (strong, nonatomic) NSArray *menuItemArray;
@property (strong,nonatomic) NSMutableArray *filteredArray;
@property UIFont *textFont;
@end
