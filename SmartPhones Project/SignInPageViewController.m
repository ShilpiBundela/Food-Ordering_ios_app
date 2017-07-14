//
//  SignInPageViewController.m
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/24/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import "SignInPageViewController.h"
#import "User.h"
@interface SignInPageViewController ()

@end

@implementation SignInPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   [self.UserIdText setDelegate:self];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame            = self.view.bounds;
    gradient.colors           = [NSArray arrayWithObjects:
                                 (id)[[UIColor colorWithRed:0.35 green:0.02 blue:0.02 alpha:1.0] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 (id)[[UIColor blackColor] CGColor],
                                 nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
    self.SignIn.layer.cornerRadius = 3;
    self.SignIn.layer.borderWidth = 1;
    self.SignIn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.ViewOrderHistory.layer.cornerRadius = 3;
    self.ViewOrderHistory.layer.borderWidth = 1;
    self.ViewOrderHistory.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.OrderHistory=[[NSMutableArray alloc]init];
    
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
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: YES];
    self.user = [User sharedInstance];
    [self makeRequest];
}

-(void)makeRequest{
    // [self.user setIsSignedIn:YES];
    if(self.user.isSignedIn==YES){
        self. UserIdText.hidden=YES;
        self.SignIn.hidden=YES;
        self.UserName.hidden=NO;
        self.UserEmail.hidden=NO;
        self.UserContact.hidden=NO;
        self.UserAddress.hidden=NO;
        self.NameLabel.hidden=NO;
        self.EmailLabel.hidden=NO;
        self.ContactLabel.hidden=NO;
        self.AddressLabel.hidden=NO;
        [self.ViewOrderHistory setEnabled:YES];

        // CGRect someRect = CGRectMake(100, 300, 200.0, 30.0);
        //UITextField* text = [[UITextField alloc] initWithFrame:someRect];
        //text.borderStyle=UITextBorderStyleLine;
        //text.backgroundColor=[UIColor whiteColor];
        // text.placeholder=@"User ID";
           }
    else{
        self.NameLabel.hidden=YES;
        self.EmailLabel.hidden=YES;
        self.ContactLabel.hidden=YES;
        self.AddressLabel.hidden=YES;
        self.UserName.hidden=YES;
        self.UserEmail.hidden=YES;
        self.UserContact.hidden=YES;
        self.UserAddress.hidden=YES;
        self.SignIn.hidden=NO;
        [self.ViewOrderHistory setEnabled:NO];
    }
    
    
    
}
- (IBAction)SignIn:(id)sender {
    
    self.userID=self.UserIdText.text;
    [self textFieldShouldReturn:self.UserIdText];
    //[self textFieldShouldClear:self.UserIdText];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"user_directory" ofType:@"json"];
    NSLog(@"FILE PATH %@",filePath);
    
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    // NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSDictionary *jsonDictionary =[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSArray *userIDArray= [jsonDictionary objectForKey:@"user"];

    
    for(id key in userIDArray){
        NSString *userKey=[key valueForKey:@"id"];
        if([self.userID isEqualToString:userKey
            ]){
            NSLog(@"FOUND KEY !!");
            self.userID=[key valueForKey:@"id"];
            ////setting default
            ///[[NSUserDefaults standardUserDefaults] setObject:self.UserIdText.text forKey:self.userID];
            
           
            self.user.UserId=self.userID;
            self.userFileName=[key valueForKey:@"file"];
            //self.userFilepath=[key valueForKey:@"file_path"];
            self.user.FileName=self.userFileName;
            //self.user.FilePath=self.userFilepath;
            ///////////////////////////////
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSError *error;
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsDirectory = [paths objectAtIndex:0];
            NSString *filename=[self.user.FileName stringByAppendingString:@".json"];
            NSString *txtPath2=  [NSHomeDirectory() stringByAppendingPathComponent:filename];
            self.userFilepath=txtPath2;
            self.user.FilePath=self.userFilepath;
            NSLog(@"TEXT PATH %@",txtPath2);
            NSString *resourcePath = [[NSBundle mainBundle] pathForResource:self.userFileName ofType:@"json"];
            if ([fileManager fileExistsAtPath:txtPath2] == NO) {
                
                [fileManager copyItemAtPath:resourcePath toPath:txtPath2 error:&error];
                }
            NSLog(@"TEXT PATH %@",resourcePath);
            
            ///////////////
            
            
            
            
            
            
            NSString *newfilePath = [[NSBundle mainBundle] pathForResource:self.userFileName ofType:@"json"];
            NSData  *userData = [NSData dataWithContentsOfFile:newfilePath];
            NSDictionary *userjson = [NSJSONSerialization JSONObjectWithData:userData options:kNilOptions error:nil];
            NSArray *userDataArray=[userjson objectForKey:@"Userdetail"];
             NSLog(@"USER DATA %@",userjson);
            [self.user setIsSignedIn:YES];
            [self makeRequest];
            for(id value in userDataArray){
                self.user.UserName=[value valueForKey:@"name"];
                 NSLog(@"USER DATA %@", self.user.UserName);
                self.user.Address= [value valueForKey:@"Address"];
                self.user.Email=[value valueForKey:@"Email"];
                self.user.Contact=[value valueForKey:@"Contact"];
                self.UserName.text= self.user.UserName;
                self.UserEmail.text= self.user.Email;
                self.UserAddress.text=self.user.Address;
                self.UserContact.text=self.user.Contact;
                 NSLog(@"USER DATA %@", self.UserName.text);
                 NSLog(@"USER DATA %@", self.UserEmail.text);
                 NSLog(@"USER DATA %@", self.UserContact.text);
                 NSLog(@"USER DATA %@", self.UserAddress.text);
                self.OrderHistory=[value valueForKey:@"Orders"];
                NSLog(@"Order History%@",self.OrderHistory);
            }
        }
       
        else{
            
            UIAlertController *alert  = [UIAlertController alertControllerWithTitle:@"ALERT!!" message:@"SignIn" preferredStyle:UIAlertControllerStyleActionSheet];
            [self presentViewController:alert animated:YES completion:nil];
            [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                [self dismissViewControllerAnimated:YES completion:nil];
            }]];

        }
    
    }
    

}
- (IBAction)ViewOrderHistory:(id)sender {
   


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
