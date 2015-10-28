//
//  NSBundle+Loader.h
//  TheMovieDB
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSBundle (Loader)

- (id)dataFromResource:(NSString *)resource;
- (id)jsonFromResource:(NSString *)resource;

@end
