//
//  CommonReturns.h
//  SPA
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import <Foundation/Foundation.h>

id removeNull(id rootObject);

// Image sizes
typedef enum {
    ImageSizeMini, // 24px by 24px
    ImageSizeNormal, // 48x48
    ImageSizeBigger, // 73x73
    ImageSizeOriginal // original size of image
} ImageSize;

@interface CommonReturns : NSObject

+ (BOOL)isConnectedToInternet;

@end

@interface NSData (FHSTwitterEngine)
- (NSString *)appropriateFileExtension;
- (NSString *)base64Encode;
@end

@interface NSString (FHSTwitterEngine)
- (NSString *)fhs_URLEncode;
- (NSString *)fhs_truncatedToLength:(int)length;
- (NSString *)fhs_trimForTwitter;
- (NSString *)fhs_stringWithRange:(NSRange)range;
+ (NSString *)fhs_UUID;
- (BOOL)fhs_isNumeric;
@end

@interface NSError (FHSTwitterEngine)

+ (NSError *)badRequestError;
+ (NSError *)noDataError;
+ (NSError *)imageTooLargeError;

@end
