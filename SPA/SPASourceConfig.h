//
//  KMSourceConfig.h
//  TheMovieDB
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPASourceConfig : NSObject

+ (SPASourceConfig*)config;

@property (nonatomic, copy, readonly) NSString* version;
@property (nonatomic, copy, readonly) NSString* build;
@property (nonatomic, copy, readonly) NSString* theDbHost;
@property (nonatomic, copy, readonly) NSString* apiKey;

@property (nonatomic, copy, readonly) NSString* LoginParam;
@end
