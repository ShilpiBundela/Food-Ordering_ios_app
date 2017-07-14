//
//  AppDelegate.h
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/8/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "CusineTableViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic) UIImageView *splashView;
@property (weak, nonatomic)  UIActivityIndicatorView *Spinner;

- (void)saveContext;


@end

