//
//  OrderHistoryViewController.m
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/25/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import "OrderHistoryViewController.h"
#import "User.h"
#import "CustomTableViewCell.h"

@interface OrderHistoryViewController ()

@end

@implementation OrderHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame            = self.view.bounds;
    gradient.colors           = [NSArray arrayWithObjects:
                                 (id)[[UIColor colorWithRed:0.35 green:0.02 blue:0.02 alpha:1.0] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    self.OrderItemName=[[NSMutableArray alloc]init];
    self.OrderItemCost=[[NSMutableArray alloc]init];
    self.OrderItemDate=[[NSMutableArray alloc]init];
    self.OrderHistory.delegate=self;
    self.OrderHistory.dataSource=self;
    self.OrderItemHomecook=[[NSMutableArray alloc]init];
    self.user=[User sharedInstance];
    [self makeRequest];
    [self.OrderHistory reloadData];
   
    

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidAppear:(BOOL)animated {
      [self makeRequest];
    [self.OrderHistory reloadData];
    
}
-(void)makeRequest{
    NSData  *userData = [NSData dataWithContentsOfFile:self.user.FilePath];
    NSDictionary *userjson = [NSJSONSerialization JSONObjectWithData:userData options:kNilOptions error:nil];
    NSArray *userDataArray=[userjson objectForKey:@"Userdetail"];
    for(id value in userDataArray){
        self.Userordersarray=[value valueForKey:@"Orders"];
}
    for(id key in self.Userordersarray){
        [self.OrderItemName addObject:[key valueForKey:@"name"]];
        [self.OrderItemHomecook addObject:[key valueForKey:@"homecook"]];
        [self.OrderItemDate addObject:[key valueForKey:@"date"]];
        [self.OrderItemCost addObject:[key valueForKey:@"Cost"]];
        
    }
    NSLog(@"NAME %@",self.OrderItemName);
    NSLog(@"DATE %@",self.OrderItemDate);
    NSLog(@"COST %@",self.OrderItemCost);
    NSLog(@"HOMECOOK %@",self.OrderItemHomecook);
    [self.OrderHistory reloadData];
  
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    //Set the height of the tableview
    // Return the number of rows in the section.
    return [self.Userordersarray count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HistoryCell";
    
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.Subtitle1.textColor = [UIColor whiteColor];
    cell.Subtitle2.textColor = [UIColor whiteColor];
    cell.Subtitle3.textColor = [UIColor whiteColor];
    
    cell.textLabel.text =[self.OrderItemName objectAtIndex:indexPath.row];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[cell Subtitle1] setText: [NSString stringWithFormat:@"Date : %@",[self.OrderItemDate objectAtIndex:indexPath.row]]];
        [[cell Subtitle2] setText: [NSString stringWithFormat:@"Cost : %@",[self.OrderItemCost objectAtIndex:indexPath.row]]];
        [[cell Subtitle3] setText:[NSString stringWithFormat:@"%@",[self.OrderItemHomecook objectAtIndex:indexPath.row]]];
        [cell setNeedsDisplay];
    });
    //  cell.Subtitle1.text = [NSString stringWithFormat:@"Quantity%@",[self.OrderItemQuantity objectAtIndex:indexPath.row]];
    NSLog(@"%@",cell.Subtitle1.text);
    //cell.Subtitle2.text=[self.OrderItemCost objectAtIndex:indexPath.row];
    
    return cell;
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
