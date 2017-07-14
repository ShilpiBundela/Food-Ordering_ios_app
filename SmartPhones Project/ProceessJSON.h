//
//  ProceessJSON.h
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/12/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProceessJSON : NSObject

/**
 * Returns Menu Items in the JSON
 * {use} :
 * [Object].returnMenuItem:jsonData :@"MENU_ITEM": @"Indian"
 */
- (NSArray *) returnMenuItem:(NSData *) jsonData : (NSString *) jsonObjectName : (NSString *) selectedCuisine;

/**
 * Returns Cuisines in the JSON
 * {use} :
 * [Object].returnMenuItem:jsonData :@"Cuisine"
 */
- (NSArray *) returnCuisine:(NSData *) jsonData : (NSString *) jsonObjectName;

/**
 * Returns Home Cooks in the JSON
 * {use} :
 * [Object].returnMenuItem:jsonData :@"homecooks"
 */
- (NSArray *) returnHomeCooks:(NSData *) jsonData : (NSString *) jsonObjectName;

- (NSArray *) returnHomeCookForSelectedDish:(NSData *) jsonData : (NSString *) jsonObjectName : (NSString *) selectedDish;
@end
