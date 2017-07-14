//
//  OrderCartViewController.m
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/21/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import "OrderCartViewController.h"
#import "Order.h"
#import "CustomTableViewCell.h"
#import "User.h"

@interface OrderCartViewController ()

@end

@implementation OrderCartViewController
@synthesize Tip_10percent=_Tip_10percent;
@synthesize Tip_15percent=_Tip_15percent;
@synthesize Tip_20percent=_Tip_20percent;
@synthesize Confirm_Order=_Confirm_Order;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.OrderItemName = [NSMutableArray array];
    self.OrderItemCost = [NSMutableArray array];
    self.OrderItemQuantity = [NSMutableArray array];
    self.OrderItemHomecook = [NSMutableArray array];
    self.OrderItemTable.allowsMultipleSelectionDuringEditing = NO;
    
    self.OrderItemTable.delegate=self;
    self.OrderItemTable.dataSource=self;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame            = self.view.bounds;
    gradient.colors           = [NSArray arrayWithObjects:
                                 (id)[[UIColor colorWithRed:0.35 green:0.02 blue:0.02 alpha:1.0] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    _Confirm_Order.layer.cornerRadius = 3;
    _Confirm_Order.layer.borderWidth = 1;
    _Confirm_Order.layer.borderColor = [UIColor whiteColor].CGColor;
    
    // NSLog(@"-------ORDER CART-------%@",orderitem.itemName);
    // NSLog(@"-------ORDER CART-------%@", orderitem.itemQuantity);
    // NSLog(@"-------ORDER CART-------%@",orderitem.itemCost);
    // NSLog(@"-------ORDER CART-------%@",orderitem.homecook);
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: YES];
    self.orderitem = [Order sharedInstance];
    self.user =[User sharedInstance];
    [self makeRequest];
}
-(void)makeRequest{
    //  for (id itemName in self.orderitem.itemName) {
    //    NSLog(@"this is the item Name : %@", itemName);
    // [self.OrderItemName addObject:itemName];
    //}
    self.OrderItemName = self.orderitem.itemName;
    self.OrderItemQuantity= self.orderitem.itemQuantity;
    self.OrderItemCost = self.orderitem.itemCost;
    self.OrderItemHomecook = self.orderitem.homecook;
    NSLog(@"UPDATE AFER ORDER %@",self.OrderItemName);
    NSLog(@"UPDATE AFER ORDER %@",self.OrderItemHomecook);
    NSLog(@"UPDATE AFER ORDER %@",self.OrderItemQuantity);
    NSLog(@"UPDATE AFER ORDER %@",self.OrderItemCost);

    if(self.OrderItemName.count==0){
        [_Tip_10percent setEnabled:NO];
        [_Tip_15percent setEnabled:NO];
        [_Tip_20percent setEnabled:NO];
        [_Confirm_Order setEnabled:NO];
        self.Total.text =@"YOUR CART IS EMPTY!!";
    }
    
    else{
        [_Tip_10percent setEnabled:YES];
        [_Tip_15percent setEnabled:YES];
        [_Tip_20percent setEnabled:YES];
        [_Confirm_Order setEnabled:YES];
        ///calculate total
        self.sum=0;
        for (NSNumber * n in _OrderItemCost) {
            self.sum += [n doubleValue];
        }
        self.Total.text=[NSString stringWithFormat:@"TOTAL ORDER COST :%f",self.sum];
    }
    
    [self.OrderItemTable reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{    //Set the height of the tableview
    // Return the number of rows in the section.
    return [self.OrderItemName count];
    
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this
        
        [self.orderitem.itemName removeObjectAtIndex:indexPath.row];
        [self.orderitem.itemCost removeObjectAtIndex:indexPath.row];
        [self.orderitem.itemQuantity removeObjectAtIndex:indexPath.row];
        [self.orderitem.homecook removeObjectAtIndex:indexPath.row];
        
        int currentCartQty = [[[super.tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue integerValue];
        currentCartQty -= 1;
        
        [[super.tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = [NSString stringWithFormat:@"%i", currentCartQty];
        [self makeRequest]; // tell table to refresh now
    }
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OrderCell";
    
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
        [[cell Subtitle1] setText: [NSString stringWithFormat:@"Quantity : %@",[self.OrderItemQuantity objectAtIndex:indexPath.row]]];
        [[cell Subtitle2] setText: [NSString stringWithFormat:@"Cost : %@",[self.OrderItemCost objectAtIndex:indexPath.row]]];
        [[cell Subtitle3] setText:[NSString stringWithFormat:@"%@",[self.OrderItemHomecook objectAtIndex:indexPath.row]]];
        [cell setNeedsDisplay];
    });
    //  cell.Subtitle1.text = [NSString stringWithFormat:@"Quantity%@",[self.OrderItemQuantity objectAtIndex:indexPath.row]];
    NSLog(@"%@",cell.Subtitle1.text);
    //cell.Subtitle2.text=[self.OrderItemCost objectAtIndex:indexPath.row];
    
    return cell;
}
//-(void)Delete: (id) sender {
    
//}

- (IBAction)Add10Tip:(id)sender {
    float totaltillNow = (float) self.sum;
    float tip =  (float) 10 / (float) 100 ;
    float total = totaltillNow + ( tip * totaltillNow );
    NSLog(@"SUM%f",tip);
    NSLog(@"TOTAL TILL NOW %f",totaltillNow);
    NSLog(@"TOTAL TILL NOW %f",total);
    
    self.Total.text=[NSString stringWithFormat:@"TOTAL OREDR COST :%f",total];
    [_Tip_15percent setEnabled:NO];
    [_Tip_10percent setEnabled:NO];
    [_Tip_20percent setEnabled:NO];
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"ALERT!!" message:@"10% tip added to your order" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [self presentViewController:alert animated:YES completion:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
}
- (IBAction)Add15Tip:(id)sender {
    float totaltillNow = (float) self.sum;
    float tip =  (float) 15 / (float) 100 ;
    float total = totaltillNow + ( tip * totaltillNow );
    self.Total.text=[NSString stringWithFormat:@"TOTAL OREDR COST :%f",total];
    [_Tip_15percent setEnabled:NO];
    [_Tip_10percent setEnabled:NO];
    [_Tip_20percent setEnabled:NO];
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"ALERT!!" message:@"15% tip added to your order" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [self presentViewController:alert animated:YES completion:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
}
- (IBAction)Add20Tip:(id)sender {
    float totaltillNow = (float) self.sum;
    float tip =  (float) 20 / (float) 100 ;
    float total = totaltillNow + ( tip * totaltillNow );
    self.Total.text=[NSString stringWithFormat:@"TOTAL OREDR COST :%f",total];
    [_Tip_15percent setEnabled:NO];
    [_Tip_10percent setEnabled:NO];
    [_Tip_20percent setEnabled:NO];
    UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"ALERT!!" message:@"20% tip added to your order" preferredStyle:UIAlertControllerStyleActionSheet];
    
    [self presentViewController:alert animated:YES completion:nil];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }]];
    
}

- (IBAction)ConfirmOrder:(id)sender {
    if(self.user.isSignedIn==YES){
        self.UpdatedUserOrdersArray=[[NSMutableArray alloc]init];
        
        NSLog(@"DATA %@", self.user.FileName);
        
        NSLog(@"FILE PATH %@", self.user.FilePath);
        ;
        NSData  *userData = [NSData dataWithContentsOfFile:self.user.FilePath];
        NSLog(@"MY USER DATA %@",userData);
        NSDictionary *userjson = [NSJSONSerialization JSONObjectWithData:userData options:kNilOptions error:nil];
        NSArray *userDataArray=[userjson objectForKey:@"Userdetail"];
        for(id value in userDataArray){
            self.UserOrdersArray=[value valueForKey:@"Orders"];
            [self.UpdatedUserOrdersArray addObjectsFromArray:self.UserOrdersArray];
            
            //NSLog(,@"DATA %@", self.UpdatedUserOrdersArray);
        }
        for(int i=0;i<self.orderitem.itemName.count;i++){
            NSLocale* currentLocale = [NSLocale currentLocale];
            [[NSDate date] descriptionWithLocale:currentLocale];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:4];
            [dict setObject:[NSString stringWithFormat:@"%@",self.orderitem.itemName[i]] forKey:@"name"];
            [dict setObject:[NSString stringWithFormat:@"%@",self.orderitem.itemCost[i]] forKey:@"Cost"];
            [dict setObject:[NSString stringWithFormat:@"%@",self.orderitem.homecook[i]] forKey:@"homecook"];
            [dict setObject:[[NSDate date] descriptionWithLocale:currentLocale]forKey:@"date"];
            self.array = [NSMutableArray arrayWithObject:dict];
            self.postDictionary = dict;
            [self.UpdatedUserOrdersArray addObjectsFromArray:self.array];
            //NSLog(@"UPDated Orders array %@",self.UpdatedUserOrdersArray);
            
        }
        NSMutableDictionary *ordersDictionary =[[NSMutableDictionary alloc]init];
        [ordersDictionary setObject:self.UpdatedUserOrdersArray forKey:@"Orders"];
        NSMutableDictionary *UserDictionary =[[NSMutableDictionary alloc]init];
        [UserDictionary setObject:self.user.UserName forKey:@"name"];
        [UserDictionary setObject:self.user.Address forKey:@"Address"];
        [UserDictionary setObject:self.user.Contact forKey:@"Contact"];
        [UserDictionary setObject:self.user.UserId forKey:@"id"];
        [UserDictionary setObject:self.user.Email forKey:@"Email"];
        [UserDictionary setObject:self.UpdatedUserOrdersArray forKey:@"Orders"];
        NSMutableArray *dictarray =[NSMutableArray arrayWithObject:UserDictionary];
        // NSLog(@"DictArray %@",dictarray);
        NSMutableDictionary *UserDetailsDictionary=[[NSMutableDictionary alloc]init];
        [UserDetailsDictionary setObject:dictarray forKey:@"Userdetail"];
        
        NSMutableArray *finalData=(NSMutableArray*)UserDetailsDictionary;
        //NSMutableDictionary *finalDictionary= [[NSMutableDictionary alloc]init];
        // NSMutableArray *Userarray= [NSMutableArray arrayWithObject:finalDictionary];
        
        //NSLog(@"%@",finalData);
        //NSString *filename=[self.user.FileName stringByAppendingString:@".json"];
        // NSLog(@"FILENAME %@",filename);
        NSError *error = nil;
        NSData *data = [NSJSONSerialization dataWithJSONObject:finalData options:NSJSONWritingPrettyPrinted error:&error];
        //NSLog(@"DATA %@", data);
        
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"STRING %@", jsonString);
        NSLog(@"DATA%@",data);
        [data writeToFile:self.user.FilePath atomically:YES];
        //generate alert
        
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"ALERT!!" message:@"Order Placed Successfully. We hope you enjoy your food." preferredStyle:UIAlertControllerStyleActionSheet];
        [self presentViewController:alert animated:YES completion:nil];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
        //// Empty arrays
        [self.orderitem.itemName removeAllObjects];
        [self.orderitem.itemCost removeAllObjects];
        [self.orderitem.itemQuantity removeAllObjects];
        [self.orderitem.itemName removeAllObjects];
                
        // NSLog(@"UPDATE AFER ORDER %@",self.orderitem.itemName);
        // NSLog(@"UPDATE AFER ORDER %@",self.orderitem.itemCost);
        // NSLog(@"UPDATE AFER ORDER %@",self.orderitem.itemQuantity);
        // NSLog(@"UPDATE AFER ORDER %@",self.orderitem.homecook);
        int currentCartQty = [[[super.tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue integerValue];
        currentCartQty= 0;
        
        [[super.tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = [NSString stringWithFormat:@"%i", currentCartQty];
        //[[super.tabBarController.viewControllers objectAtIndex:1] tabBarItem].badgeValue = @"0";
        [self makeRequest];
}
    else{
        NSLog(@"NOT SIGNED IN!!!");
        UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"ALERT!!" message:@"You are not Signed In. Please Sign In in History Tab" preferredStyle:UIAlertControllerStyleActionSheet];
        [self presentViewController:alert animated:YES completion:nil];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            [self dismissViewControllerAnimated:YES completion:nil];
        }]];
    }
    ////////post request
    // NSData *postreq= [NSJSONSerialization dataWithJSONObject:self.postDictionary options:NSJSONWritingPrettyPrinted error:nil];
    NSString *post = [NSString stringWithFormat:@"homecook=%@&cost=%@&name=%@&date=%@",
                      [self.postDictionary objectForKey:@"homecook"],
                      [self.postDictionary objectForKey:@"Cost"],
                      [self.postDictionary objectForKey:@"name"],
                      [self.postDictionary objectForKey:@"date"]];
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", [postData length]];
    
    // Now that we have what we'd like to post, we can create an NSMutableURLRequest, and include our postData.
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"http://10.110.220.195:3000/"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:postData];
    
    // And finally, we can send our request, and read the reply by creating a new NSURLSession:
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        NSLog(@"requestReply: %@", requestReply);
    }] resume];
    
    
    
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
