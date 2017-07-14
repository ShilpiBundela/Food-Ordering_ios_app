//
//  CusineItemsViewController.h
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/10/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CusineItemsViewController : UIViewController
@property(nonatomic,weak)UIViewController *contents;
@property NSString* selectedCusine;
@property (strong, nonatomic) NSArray *menuItemsArray;
@property (strong,nonatomic) NSMutableArray *filteredArray;
@end
