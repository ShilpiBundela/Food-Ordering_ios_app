//
//  HomeCookMenuforSelectedCusineViewController.m
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/16/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import "HomeCookMenuforSelectedCusineViewController.h"
#import "Order.h"
@interface HomeCookMenuforSelectedCusineViewController ()

@property id actionSender;

@end

@implementation HomeCookMenuforSelectedCusineViewController

- (void)viewDidLoad {
    self.orderitem = [Order sharedInstance];
    [super viewDidLoad];
    self.MenuTable.delegate=self;
    self.MenuTable.dataSource=self;
   
    self.orderCount = [[[super.tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue integerValue];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame            = self.view.bounds;
    gradient.colors           = [NSArray arrayWithObjects:
                                 (id)[[UIColor colorWithRed:0.35 green:0.02 blue:0.02 alpha:1.0] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    self.navigationItem.title=self.HomeCook;
    self.LocationLabel.text=self.Location;
    self.RatingLabel.text=self.Rating;
    self.ContactLabel.text=self.Contact;
    self.Itemname=[[NSArray alloc]init];
    self.ItemCost=[[NSArray alloc]init];
    self.alert = [[UIAlertView alloc] initWithTitle:@"ENTER Quantity"
                                            message:@"Please enter the quantity of Item you want to order"
                                           delegate:self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:@"OK", nil];
    
    self.alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    self.alertTextField = [self.alert textFieldAtIndex:0];
    self.alertTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.alertTextField.placeholder = @"Enter Quantity";
    self.alertTextField.delegate=self;
    [self.alertTextField setClearsOnBeginEditing:YES];
    NSLog(@"%@",self.Menu);
    [self MakeRequest];
    // Do any additional setup after loading the view.
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
    // Dispose of any resources that can be recreated.
}
-(void)MakeRequest{
    // Keys to find names and locations for the home cook
    //NSArray *menuKey = [[NSArray alloc]initWithObjects:@"Menu_Item", nil];
    // init homecooks and processJson class
    
    // typecast the array into mutable dictionary
    self.MenuDictionary = (NSMutableDictionary *)self.Menu;
    
    // filter the dictionary based on name and location into their respective arrays
    self.Itemname = [self.MenuDictionary valueForKey:@"name"];
    self.ItemCost = [self.MenuDictionary valueForKey:@"Cost"];
    NSLog(@"%@",self.Itemname);
    NSLog(@"%@",self.ItemCost);
    [self.MenuTable reloadData];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString* detailString = self.alertTextField.text;
    NSLog(@"String is: %@", detailString); //Put it on the debugger
    if ([self.alertTextField.text length] <= 0 || buttonIndex == 0){
        return; //If cancel or 0 length string the string doesn't matter
    }
    
    if (buttonIndex == 0) {
        NSLog(@"\n\n\n\ntext field : %@", [self.alertTextField text]);
        [self.orderitem.itemQuantity addObject:[self.alertTextField text]];
    }
    if (buttonIndex == 1) {
        CGPoint buttonPosition = [self.actionSender convertPoint:CGPointZero toView:self.MenuTable];
        NSIndexPath *indexPath = [self.MenuTable indexPathForRowAtPoint:buttonPosition];
        NSString *OrderitemName =[self.Itemname objectAtIndex:indexPath.row];
        int OrderitemQuantity=[[self.alertTextField text]intValue];
        int OrderitemCostperUnit=[[self.ItemCost objectAtIndex:indexPath.row]intValue];
        int TotalCost= OrderitemQuantity * OrderitemCostperUnit;
        
        [self.orderitem.itemQuantity addObject:[NSNumber numberWithInt:OrderitemQuantity]];
        [self.orderitem.itemName addObject:OrderitemName];
        [self.orderitem.itemCost addObject:[NSNumber numberWithInteger:TotalCost ]];
        [self.orderitem.homecook addObject:self.HomeCook];
        
        self.orderCount += 1;
        [[super.tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = [NSString stringWithFormat:@"%lu", self.orderitem.itemName.count];
        
        // NSLog(@"------CART NAME------%@",self.orderitem.itemName);
        // NSLog(@"------CART COST------%@",self.orderitem.itemCost);
        // NSLog(@"------CART QTY------%@",self.orderitem.itemQuantity);
        // NSLog(@"------CART HOMECOOK------%@",self.orderitem.homecook);
        //NSLog(@"COUNT----%lu",self.orderitem.itemName.count);
    }
}

-(NSString *)returnQuantity :(id)sender:(NSString *)string {
    return string;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.Itemname count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HomecookMenu";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *name = [self.Itemname objectAtIndex:indexPath.row];
    NSString *cost = [self.ItemCost objectAtIndex:indexPath.row];
    CGRect buttonRect = CGRectMake(260, 15, 80, 40);
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = buttonRect;
    button.layer.cornerRadius = 3;
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor whiteColor].CGColor;
    [button setTitle:@"ORDER" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(myAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    cell.textLabel.text =name;
    cell.detailTextLabel.text =cost;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:button];
    
    return cell;
}
-(void)myAction: (id) sender {
    self.actionSender = sender;
    [self.alert show];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
