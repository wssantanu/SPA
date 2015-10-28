//
//  KM_NSString+UrlEncoding.h
//  TheMovieDB
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (KM_NSString_UrlEncoding)

-(NSString*)urlEncodedString;
-(NSArray *)dictionariesSortedByKey:(NSDictionary *)dictionary;
@end
