//
//  SPAColorConfig.h
//  SPA
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPAColorConfig : NSObject

/*
 Color White
 */
@property (nonatomic,retain) NSString *SPAWhite;
/*
 Color Black
 */
@property (nonatomic,retain) NSString *SPABlack;
/*
 Color Yellow
 */
@property (nonatomic,retain) NSString *SPAYellow;
/*
 Color Green
 */
@property (nonatomic,retain) NSString *SPAGreen;

+ (SPAColorConfig *)config;
@end
