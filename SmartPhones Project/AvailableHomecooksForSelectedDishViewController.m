//
//  AvailableHomecooksForSelectedDishViewController.m
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/16/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import "AvailableHomecooksForSelectedDishViewController.h"
#import "ProceessJSON.h"
#import "HomeCookMenuforSelectedCusineViewController.h"
#import "CustomTableViewCell.h"
@interface AvailableHomecooksForSelectedDishViewController ()

@end

@implementation AvailableHomecooksForSelectedDishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", self.selectedDish);
    self.HomecooksTable.dataSource = self;
    self.HomecooksTable.delegate = self;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame            = self.view.bounds;
    gradient.colors           = [NSArray arrayWithObjects:
                                 (id)[[UIColor colorWithRed:0.35 green:0.02 blue:0.02 alpha:1.0] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    [self MakeRequest];

    // Do any additional setup after loading the view.
}
-(void)MakeRequest{
    // Keys to find names and locations for the home cook
    NSArray *nameKey = [[NSArray alloc] initWithObjects: @"Name", nil];
    NSArray *locationKey = [[NSArray alloc] initWithObjects: @"Location", nil];
    NSArray *ratingKey= [[NSArray alloc]initWithObjects:@"Rating", nil];
    NSArray *emailKey =[[NSArray alloc]initWithObjects:@"email", nil];
    NSArray *menuKey =[[NSArray alloc]initWithObjects:@"Menu_Item", nil];
    //NSArray *menuKey = [[NSArray alloc]initWithObjects:@"Menu_Item", nil];
    // init homecooks and processJson class
    self.homecooksName = [[NSArray alloc]init];
    ProceessJSON *jsonValue = [[ProceessJSON alloc] init];
    
    // Get the data to pass to process json
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Mock_Data" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    /**
     * get the parsed data for processJSON
     * @return {array} [Name:..., Location:..., Rating:...., Email...]
     */
   // self.homecooksName = [jsonValue returnMenuItem:jsonData : @"AvailablehomecooksDetail" : self.selectedDish];
    self.homecooksName = [jsonValue returnHomeCookForSelectedDish:jsonData :@"AvailablehomecooksDetail" :self.selectedDish];
    

    // typecast the array into mutable dictionary
    self.homeCooksDetails = (NSMutableDictionary *)self.homecooksName;
    
    // filter the dictionary based on name and location into their respective arrays
    self.homecooksName = [self.homeCooksDetails objectsForKeys:nameKey notFoundMarker:[NSNull null]];
    self.homecooksLocation = [self.homeCooksDetails objectsForKeys:locationKey notFoundMarker:[NSNull null]];
    self.homecooksRating= [self.homeCooksDetails objectsForKeys:ratingKey notFoundMarker:[NSNull null]];
    self.homecooksContact= [self.homeCooksDetails objectsForKeys:emailKey notFoundMarker:[NSNull null]];
    self.Menu= [self.homeCooksDetails objectsForKeys:menuKey notFoundMarker:[NSNull null]];
    [self.HomecooksTable reloadData];
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
    return [self.homecooksName count];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HomecooksCellSelectedDish";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString * name = [self.homecooksName objectAtIndex:indexPath.row];
    NSString * location = [self.homecooksLocation objectAtIndex:indexPath.row];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text =name;
    cell.detailTextLabel.text =location;
    
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.HomecooksTable indexPathForSelectedRow];
    HomeCookMenuforSelectedCusineViewController *detailView = (HomeCookMenuforSelectedCusineViewController *)segue.destinationViewController;
    detailView.HomeCook=[self.homecooksName objectAtIndex:indexPath.row];
    detailView.Location=[self.homecooksLocation objectAtIndex:indexPath.row];
    detailView.Rating =[self.homecooksRating objectAtIndex:indexPath.row];
    detailView.Contact=[self.homecooksContact objectAtIndex:indexPath.row];
    detailView.Menu =[self.Menu objectAtIndex:indexPath.row];
}


@end
