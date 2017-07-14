//
//  CusineItemsViewController.m
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/10/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import "CusineItemsViewController.h"
#import "CusineHomecooksViewController.h"
#import "CusineDishesViewController.h"
#import "ProceessJSON.h"

@interface CusineItemsViewController ()


@end

@implementation CusineItemsViewController
@synthesize contents =_contents;
- (void)viewDidLoad {
    [super viewDidLoad];
    //NSLog(@"%@",self.selectedCusine);
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame            = self.view.bounds;
    gradient.colors           = [NSArray arrayWithObjects:
                                 (id)[[UIColor colorWithRed:0.35 green:0.02 blue:0.02 alpha:1.0] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeView1:) name:@"notifyButtonPressed0" object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeView2:) name:@"notifyButtonPressed1" object:nil];
   [self changeView1:self];
}
-(void)setContent:(UIViewController *)content
{
    //CHECK FOR EXISTING CONTENT
    if(_contents)
    {
        //IF CONTENT EXISTS, REMOVE IT
        [_contents.view removeFromSuperview];
        [_contents removeFromParentViewController];
    }
    
    //NOW ADD THE NEW CONTENT AND DISPLAY
    _contents = content;
    [self addChildViewController:_contents];
    [_contents didMoveToParentViewController:self];
    [self.view addSubview:_contents.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)changeView1: (id) sender
{
    //create access to the next view
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    CusineDishesViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"View1"];
    vc.selecedCusine=self.selectedCusine;
       //set the _content of the declared UIViewController to be the assigned view
    self.content = vc;
    
    //THIS SETS THE SIZE AND POSITION OF THE NEW CONTENT
    self.contents.view.frame = CGRectMake(10, 65, 300, 300);
       
    //[vc.CusineDishesTable reloadData];
}
-(void)changeView2: (id) sender
{
    //create access to the next view
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    CusineHomecooksViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"View2"];
    vc.selectedCusine = self.selectedCusine;
    
    NSLog(@"-------------SELECTED CUSINE FOR VIEW 2 METHOD---------%@",self.selectedCusine);
    //set the _content of the declared UIViewController to be the assigned view
    self.content = vc;
    
    //THIS SETS THE SIZE AND POSITION OF THE NEW CONTENT
    self.contents.view.frame = CGRectMake(10, 65, 300, 300);
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
