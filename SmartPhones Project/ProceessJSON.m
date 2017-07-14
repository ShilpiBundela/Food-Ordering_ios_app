//
//  ProceessJSON.m
//  SmartPhones Project
//
//  Created by Shilpi Bundela on 4/12/17.
//  Copyright © 2017 Shilpi Bundela. All rights reserved.
//

#import "ProceessJSON.h"

/**
 
 PRIVATE ATTRIBUTES :
 attributes starting with _ are private
 Do not make any changes to the below attributes/properties
 
 add any properties only used by this class to the below
 ProcessJSON() interface
 
 */
@interface ProceessJSON()

@property NSString *_selectedCusine;
@property (strong, nonatomic) NSArray *_queriedJSON;
@property NSString *selectedHomecook;
@property NSString *selectedDish;
/**
 *
 * _processJSON() : jsonData : jsonObjectName [Private]
 *
 * process the json based on the incoming requests
 * possible values for jsonObjectName
 *
 * - @"MENU_ITEM"
 * - @"Cuisine"
 * - @"homecooks"
 *
 */
- (NSArray *) _processJSON:(NSData *) jsonData : (NSString *) selectedCuisine;

@end

@implementation ProceessJSON

/**
 *
 * _processJSON() : jsonData : jsonObjectName [Private]
 *
 * process the json based on the incoming requests
 * possible values for jsonObjectName
 *
 * - @"MENU_ITEM"
 * - @"Cuisine"
 * - @"homecooks"
 *
 */
- (NSArray *) _processJSON:(NSData *) jsonData : (NSString *) jsonObjectName {
    NSLog(@"SELECTED CUSINE FOR FUNCTION : %@", jsonObjectName);
    
    NSArray *processedJSONArray = [[NSMutableArray alloc] init];
    NSDictionary *menuItemJson;
    
    /**
     * serialize the json data
     */
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
    
    /**
     * Get the objects under homecooks
     */
    self._queriedJSON = [json objectForKey:@"homecooks"];
    
    /**
     * Process requests for Menu Items
     */
    if ([jsonObjectName isEqualToString:@"MENU_ITEM"]) {
        NSArray *cuisinesArray = [[NSMutableArray alloc] init];
        
        for (id value in self._queriedJSON) {
            NSDictionary *tmpDictionary = value;
            //NSLog(@"-----DICTIONARY--------%@",tmpDictionary);
            NSMutableArray *jsonArr = [tmpDictionary mutableArrayValueForKey:@"Menu_Item"];
            
            for (id key in jsonArr) {
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:key options:kNilOptions error:nil];
                menuItemJson = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
                
                if ([[menuItemJson objectForKey:@"Cusine"] isEqualToString:self._selectedCusine]) {
                    cuisinesArray = [cuisinesArray arrayByAddingObject:[menuItemJson valueForKey:@"name"]];
                    processedJSONArray = [[[NSOrderedSet alloc] initWithArray: cuisinesArray] mutableCopy];
                }
            }
        }
    }
    
    /**
     * Process requests for Cuisines
     */
    if ([jsonObjectName isEqualToString:@"Cuisine"]) {
        for (id value in self._queriedJSON) {
            NSDictionary *tmpDictionary = value;
            NSMutableArray *jsonArr = [tmpDictionary mutableArrayValueForKey:@"Menu_Item"];
            
            for (id key in jsonArr) {
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:key options:kNilOptions error:nil];
                menuItemJson = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
                processedJSONArray = [processedJSONArray arrayByAddingObject:[menuItemJson valueForKey:@"Cusine"]];
            }
        }
    }
    if ([jsonObjectName isEqualToString:@"homecooks"]) {
        NSLog(@"%@", self._selectedCusine);
  NSMutableDictionary *homeCooksDetailDictionary = [[NSMutableDictionary alloc] init];
        
        for (id value in self._queriedJSON) {
            NSDictionary *tmpDictionary = value;
            //NSLog(@"%@",tmpDictionary);
            NSMutableArray *jsonArr = [tmpDictionary mutableArrayValueForKey:@"Menu_Item"];
                        for (id key in jsonArr) {
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:key options:kNilOptions error:nil];
                menuItemJson = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
                
                if ([[menuItemJson objectForKey:@"Cusine"] isEqualToString:self._selectedCusine]) {
                    // [dict setObject:[NSNumber numberWithInt:42] forKey:@"A cool number"];
                    [homeCooksDetailDictionary setObject:[tmpDictionary valueForKey:@"name"] forKey:@"Name"];
                    [homeCooksDetailDictionary setObject:[tmpDictionary valueForKey:@"Location"] forKey:@"Location"];
                    [homeCooksDetailDictionary setObject:[tmpDictionary valueForKey:@"Rating"] forKey:@"Rating"];
                    [homeCooksDetailDictionary setObject:[tmpDictionary valueForKey:@"email"] forKey:@"email"];
                    [homeCooksDetailDictionary setObject:[tmpDictionary valueForKey:@"Menu_Item"] forKey:@"Menu_Item"];
                    processedJSONArray = (NSArray *)homeCooksDetailDictionary;
                   // NSLog(@"home cooks processed json : %@", processedJSONArray);
                }
            }
        }

    }
     if ([jsonObjectName isEqualToString:@"AvailablehomecooksDetail"]) {
         NSLog(@"%@", self.selectedDish);
         NSMutableDictionary *homeCooksDetailDictionary = [[NSMutableDictionary alloc] init];
         for (id value in self._queriedJSON) {
             NSDictionary *tmpDictionary = value;
             NSMutableArray *jsonArr = [tmpDictionary mutableArrayValueForKey:@"Menu_Item"];
                 for (id key in jsonArr) {
                     NSData *jsonData = [NSJSONSerialization dataWithJSONObject:key options:kNilOptions error:nil];
                     menuItemJson = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:nil];
                     if ([[menuItemJson objectForKey:@"name"] isEqualToString:self.selectedDish] ) {
                         [homeCooksDetailDictionary setObject:[tmpDictionary valueForKey:@"name"] forKey:@"Name"];
                         [homeCooksDetailDictionary setObject:[tmpDictionary valueForKey:@"Location"] forKey:@"Location"];
                         [homeCooksDetailDictionary setObject:[tmpDictionary valueForKey:@"Rating"] forKey:@"Rating"];
                         [homeCooksDetailDictionary setObject:[tmpDictionary valueForKey:@"email"] forKey:@"email"];
                         [homeCooksDetailDictionary setObject:[tmpDictionary valueForKey:@"Menu_Item"] forKey:@"Menu_Item"];
                         processedJSONArray = (NSArray *)homeCooksDetailDictionary;
                     }

                 }

             
            
        }
     }
    
    

    
     NSLog(@"-----PROCESSED JSON------- %@",processedJSONArray);
    return processedJSONArray;
}

/**
 * Returns Menu Items in the JSON
 */
- (NSArray *) returnMenuItem:(NSData *) jsonData : (NSString *) jsonObjectName : (NSString *) selectedCuisine {
    self._selectedCusine = selectedCuisine;
    return [self _processJSON:jsonData :jsonObjectName];
}

- (NSArray *) returnHomeCookForSelectedDish:(NSData *) jsonData : (NSString *) jsonObjectName : (NSString *) selectedDish {
    self.selectedDish = selectedDish;
    return [self _processJSON:jsonData :jsonObjectName];

    
}
/**
 * Returns Cuisines in the JSON
 */
- (NSArray *) returnCuisine:(NSData *) jsonData : (NSString *) jsonObjectName {
    return [self _processJSON:jsonData :jsonObjectName];
}

/**
 * Returns Home Cooks in the JSON
 */
- (NSArray *) returnHomeCooks: (NSData *) jsonData : (NSString *) jsonObjectName {
    return [self _processJSON:jsonData :jsonObjectName];
}

@end
