//
//  CusineTableViewController.m
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/8/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import "CusineTableViewController.h"
#import "CusineItemsViewController.h"
#import "ProceessJSON.h"
#import "HorizontalTableViewCell.h"

@interface CusineTableViewController ()

@end

@implementation CusineTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.CusineTable.delegate=self;
    self.CusineTable.dataSource=self;
    self.CusineTable.backgroundView = nil;
    self.textFont=[UIFont fontWithName:@"Helvetica" size:21.0];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame            = self.view.bounds;
    gradient.colors           = [NSArray arrayWithObjects:
                                 (id)[[UIColor colorWithRed:0.35 green:0.02 blue:0.02 alpha:1.0] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    self.finishedGooglePlacesArray = [[NSArray alloc] init];
    [self makeRestuarantRequests];
    
    // Do any additional setup after loading the view.
    { //Rotate the table view
        CGPoint oldCenter=self.CusineTable.center;
        self.CusineTable.frame=CGRectMake(0.0, 0.0, self.CusineTable.bounds.size.height, self.CusineTable.bounds.size.width);
        self.CusineTable.transform=CGAffineTransformMakeRotation(-M_PI_2);
        self.CusineTable.center=oldCenter;
    }
    self.CusineTable.showsVerticalScrollIndicator = NO;

}
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.CusineTable=nil;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}
-(void)makeRestuarantRequests
{
    self.menuItemArray = [[NSMutableArray alloc] init];
    ProceessJSON *jsonValue = [[ProceessJSON alloc] init];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Mock_Data" ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    self.menuItemArray = [jsonValue returnCuisine: jsonData: @"Cuisine"];
    //NSLog(@"MENU ITEM IS : %@", self.menuItemArray);
    //self.filteredAarray = [[[NSOrderedSet alloc] initWithArray: _menuItemArray] mutableCopy];
    self.filteredArray=[[[NSOrderedSet alloc]initWithArray:_menuItemArray]mutableCopy];
    [self.CusineTable reloadData];
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
    return [self.filteredArray count];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 390.0f;
    NSString *strCellText=[self.filteredArray objectAtIndex:indexPath.row];
    return 110+[strCellText sizeWithAttributes:(NSDictionary *)self.textFont].width;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:  (NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CusineCell";
    HorizontalTableViewCell *cell =(HorizontalTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];;
    if(nil==cell)
    {
        cell=[[HorizontalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    UIImageView *cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(100.0, 100.0, 100.0, 100.0)];
    cellImageView.backgroundColor = [UIColor clearColor];
    
    NSString *imageName = @"italian.jpg";
    if([[self.filteredArray objectAtIndex:indexPath.row] isEqualToString:@"Italian"]) {
        imageName = @"italian.jpg";
    }
    if([[self.filteredArray objectAtIndex:indexPath.row] isEqualToString:@"Indian"]) {
        imageName = @"indian.jpg";
    }
    if([[self.filteredArray objectAtIndex:indexPath.row] isEqualToString:@"American"]) {
        imageName = @"american.jpg";
    }
    if([[self.filteredArray objectAtIndex:indexPath.row] isEqualToString:@"Mexican"]) {
        imageName = @"mexican.jpg";
    }
    
    
    
    cellImageView.image = [UIImage imageNamed: imageName];
    cellImageView.transform = CGAffineTransformMakeRotation(+M_PI_2);
    cellImageView.layer.masksToBounds = YES;
    cellImageView.layer.cornerRadius = 8.0f;
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.frame = CGRectMake(105.0, 155.0, 180.0, 60.0);
    blurEffectView.layer.masksToBounds = YES;
    blurEffectView.layer.cornerRadius = 8.0f;
    
    // blurEffectView.autoresizingMask = 10.0 | 10.0;
    
    [cellImageView addSubview:blurEffectView];
    cell.backgroundView = cellImageView;
    
    // cell.textLabel.textColor = [UIColor colorWithRed:0.35 green:0.05 blue:0.03 alpha:1.0];

    { //Rotate the cell text
        cell.textLabel.frame = CGRectMake(5.0, 5.0, 5.0, 5.0);
        cell.textLabel.transform = CGAffineTransformMakeRotation(+M_PI_2);
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont systemFontOfSize:30];
    cell.textLabel.text = [self.filteredArray objectAtIndex:indexPath.row];
    
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
      NSIndexPath *indexPath = [self.CusineTable indexPathForSelectedRow];
     CusineItemsViewController *detailView = (CusineItemsViewController *)segue.destinationViewController;
     detailView.selectedCusine=[self.filteredArray objectAtIndex:indexPath.row];
     
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 

@end
