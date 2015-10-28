//
//  NSString+UrlEncoding.m
//  TheMovieDB
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//


#import "KM_NSString+UrlEncoding.h"

@implementation NSString (KM_NSString_UrlEncoding)

-(NSString*)urlEncodedString{
    NSString* unEncodedString = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString* encodedString = [unEncodedString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return encodedString;
}

- (NSString *)st_stringByAppendingGETParameters:(NSDictionary *)parameters doApplyURLEncoding:(BOOL)doApplyURLEncoding {
    
    NSMutableString *ms = [self mutableCopy];
    
    __block BOOL questionMarkFound = NO;
    
    NSArray *sortedParameters = [self dictionariesSortedByKey:parameters];
    
    [sortedParameters enumerateObjectsUsingBlock:^(NSDictionary *d, NSUInteger idx, BOOL *stop) {
        
        NSString *key = [[d allKeys] lastObject];
        NSString *value = [[[d allValues] lastObject] description];
        
        if(questionMarkFound == NO) {
            questionMarkFound = [ms rangeOfString:@"?"].location != NSNotFound;
        }
        
        [ms appendString: (questionMarkFound ? @"&" : @"?") ];
        
        if(doApplyURLEncoding) {
            key = [key st_stringByAddingRFC3986PercentEscapesUsingEncoding:NSUTF8StringEncoding];
            value = [value st_stringByAddingRFC3986PercentEscapesUsingEncoding:NSUTF8StringEncoding];
        }
        
        [ms appendFormat:@"%@=%@", key, value];
    }];
    
    return ms;
}

- (NSString *)st_stringByAddingRFC3986PercentEscapesUsingEncoding:(NSStringEncoding)encoding {
    
    NSString *s = (__bridge_transfer NSString *)(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                         (CFStringRef)self,
                                                                                         NULL,
                                                                                         CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                                         kCFStringEncodingUTF8));
    return s;
}

- (NSArray *)dictionariesSortedByKey:(NSDictionary *)dictionary {
    
    NSArray *keys = [dictionary allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    
    NSMutableArray *sortedDictionaries = [NSMutableArray arrayWithCapacity:[dictionary count]];
    
    for(NSString *key in sortedKeys) {
        NSDictionary *d = @{ key : dictionary[key] };
        [sortedDictionaries addObject:d];
    }
    return sortedDictionaries;
}

@end
