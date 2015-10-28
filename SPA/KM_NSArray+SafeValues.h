//
//  KM_NSArray+SafeValues.h
//  TheMovieDB
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSArray (KM_NSArray_SafeValues)

- (NSString*)km_safeStringAtIndex:(NSUInteger)index;
- (NSNumber*)km_safeNumberAtIndex:(NSUInteger)index;
- (NSDictionary*)km_safeDictionaryAtIndex:(NSUInteger)index;

@end
