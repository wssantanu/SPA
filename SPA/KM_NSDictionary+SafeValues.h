//
//  KM_NSDictionary+SafeValues.h
//  TheMovieDB
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (KM_NSDictionary_SafeValues)

- (NSString*)km_safeStringForKey:(id)key;
- (NSNumber*)km_safeNumberForKey:(id)key;
- (NSArray*)km_safeArrayForKey:(id)key;
- (NSDictionary*)km_safeDictionaryForKey:(id)key;
- (UIImage*)km_safeImageForKey:(id)key;

@end
