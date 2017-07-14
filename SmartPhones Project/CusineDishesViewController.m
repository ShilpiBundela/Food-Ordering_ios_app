//
//  CusineDishesViewController.m
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/11/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import "CusineDishesViewController.h"
#import "CusineItemsViewController.h"
#import "ProceessJSON.h"
#import "AvailableHomecooksForSelectedDishViewController.h"
@interface CusineDishesViewController ()

@end

@implementation CusineDishesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self MakeRequest];
    self.CusineDishesTable.dataSource=self;
    self.CusineDishesTable.delegate=self;
    
    
    // NSLog(@"%@",self.selecedCusine);
    
    // Do any additional setup after loading the view.
}

-(void)MakeRequest{
     self.DishesName = [[NSArray alloc]init];
    ProceessJSON *jsonValue = [[ProceessJSON alloc] init];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Mock_Data" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    self.DishesName = [jsonValue returnMenuItem:jsonData : @"MENU_ITEM" : self.selecedCusine];
     //NSLog(@"--------MENU ITEM FOR NEW VIEW IS : %@----------", self.DishesName);
    [self.CusineDishesTable reloadData];
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
{
    // Return the number of rows in the section.
    return [self.DishesName count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DishesCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //NSLog(@"json data : %@", self.filteredArray);
    cell.textLabel.text = [self.DishesName objectAtIndex:indexPath.row];
    
    //NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:[tempDictionary objectForKey:@"icon"]]];
    // NSString *imageUrl = [tempDictionary objectForKey:@"image"];
    //cell.imageView.image=[UIImage imageWithData: imageData];
    //if([tempDictionary objectForKey:@"rating"] != NULL)
    //{
    // cell.detailTextLabel.text = [NSString stringWithFormat:@"Rating: %@ of 5",[tempDictionary   objectForKey:@"rating"]];
    // }
    // else
    // {
    //cell.detailTextLabel.text = [NSString stringWithFormat:@"Not Rated"];
    //}
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.CusineDishesTable indexPathForSelectedRow];
    AvailableHomecooksForSelectedDishViewController *detailView = (AvailableHomecooksForSelectedDishViewController *)segue.destinationViewController;
    detailView.selectedDish=[self.DishesName objectAtIndex:indexPath.row];

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
