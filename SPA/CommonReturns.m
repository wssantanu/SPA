//
//  CommonReturns.m
//  SPA
//
//  Created by Santanu Das Adhikary on 12/10/15.
//  Copyright (c) 2015 Santanu Das Adhikary. All rights reserved.
//

#import "CommonReturns.h"
#import <QuartzCore/QuartzCore.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <CommonCrypto/CommonHMAC.h>
#import <objc/runtime.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <ifaddrs.h>
#import <AFNetworking/AFNetworkReachabilityManager.h>
#import <UIKit/UIKit.h>

NSString * const ErrorDomain = @"ErrorDomain";
static NSURLRequestCachePolicy const cachePolicy = NSURLRequestReloadRevalidatingCacheData;
static float const streamingTimeoutInterval = 30.0f;
static char const Encode[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

NSString * fhs_url_remove_params(NSURL *url) {
    if (url.absoluteString.length == 0) {
        return nil;
    }
    
    NSArray *parts = [url.absoluteString componentsSeparatedByString:@"?"];
    return (parts.count == 0)?nil:parts[0];
}

id removeNull(id rootObject) {
    if ([rootObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *sanitizedDictionary = [NSMutableDictionary dictionaryWithDictionary:rootObject];
        [rootObject enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            id sanitized = removeNull(obj);
            if (!sanitized) {
                [sanitizedDictionary setObject:@"" forKey:key];
            } else {
                [sanitizedDictionary setObject:sanitized forKey:key];
            }
        }];
        return [NSMutableDictionary dictionaryWithDictionary:sanitizedDictionary];
    }

    if ([rootObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *sanitizedArray = [NSMutableArray arrayWithArray:rootObject];
        [rootObject enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            id sanitized = removeNull(obj);
            if (!sanitized) {
                [sanitizedArray replaceObjectAtIndex:[sanitizedArray indexOfObject:obj] withObject:@""];
            } else {
                [sanitizedArray replaceObjectAtIndex:[sanitizedArray indexOfObject:obj] withObject:sanitized];
            }
        }];
        return [NSMutableArray arrayWithArray:sanitizedArray];
    }
    
    if ([rootObject isKindOfClass:[NSNull class]]) {
        return (id)nil;
    } else {
        return rootObject;
    }
}

@implementation CommonReturns

#pragma mark HTTP Error Codes

+ (BOOL)isConnectedToInternet {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr *)&zeroAddress);
    
    if (reachability) {
        SCNetworkReachabilityFlags flags;
        BOOL worked = SCNetworkReachabilityGetFlags(reachability, &flags);
        CFRelease(reachability);
        
        if (worked) {
            
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0) {
                return NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0) {
                return YES;
            }
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand) != 0) || (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0)) {
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0) {
                    return YES;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN) {
                return YES;
            }
        }
        
    }
    return NO;
}

+ (NSString *)descriptionForHTTPStatus:(NSUInteger)status {
    
    NSString *s = [NSString stringWithFormat:@"HTTP Status %@", @(status)];
    
    NSString *description = nil;
    // http://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml
    if(status == 400) description = @"Bad Request";
    if(status == 401) description = @"Unauthorized";
    if(status == 402) description = @"Payment Required";
    if(status == 403) description = @"Forbidden";
    if(status == 404) description = @"Not Found";
    if(status == 405) description = @"Method Not Allowed";
    if(status == 406) description = @"Not Acceptable";
    if(status == 407) description = @"Proxy Authentication Required";
    if(status == 408) description = @"Request Timeout";
    if(status == 409) description = @"Conflict";
    if(status == 410) description = @"Gone";
    if(status == 411) description = @"Length Required";
    if(status == 412) description = @"Precondition Failed";
    if(status == 413) description = @"Payload Too Large";
    if(status == 414) description = @"URI Too Long";
    if(status == 415) description = @"Unsupported Media Type";
    if(status == 416) description = @"Requested Range Not Satisfiable";
    if(status == 417) description = @"Expectation Failed";
    if(status == 422) description = @"Unprocessable Entity";
    if(status == 423) description = @"Locked";
    if(status == 424) description = @"Failed Dependency";
    if(status == 425) description = @"Unassigned";
    if(status == 426) description = @"Upgrade Required";
    if(status == 427) description = @"Unassigned";
    if(status == 428) description = @"Precondition Required";
    if(status == 429) description = @"Too Many Requests";
    if(status == 430) description = @"Unassigned";
    if(status == 431) description = @"Request Header Fields Too Large";
    if(status == 432) description = @"Unassigned";
    if(status == 500) description = @"Internal Server Error";
    if(status == 501) description = @"Not Implemented";
    if(status == 502) description = @"Bad Gateway";
    if(status == 503) description = @"Service Unavailable";
    if(status == 504) description = @"Gateway Timeout";
    if(status == 505) description = @"HTTP Version Not Supported";
    if(status == 506) description = @"Variant Also Negotiates";
    if(status == 507) description = @"Insufficient Storage";
    if(status == 508) description = @"Loop Detected";
    if(status == 509) description = @"Unassigned";
    if(status == 510) description = @"Not Extended";
    if(status == 511) description = @"Network Authentication Required";
    
    if(description) {
        s = [s stringByAppendingFormat:@": %@", description];
    }
    
    return s;
}

+ (NSDictionary *)userInfoWithErrorDescriptionForHTTPStatus:(NSUInteger)status {
    NSString *s = [self descriptionForHTTPStatus:status];
    if(s == nil) return nil;
    return @{ NSLocalizedDescriptionKey : s };
}

@end

@implementation NSError (FHSTwitterEngine)

+ (NSError *)badRequestError {
    return [NSError errorWithDomain:ErrorDomain code:400 userInfo:@{NSLocalizedDescriptionKey:@"The request has missing or malformed parameters."}];
}

+ (NSError *)noDataError {
    return [NSError errorWithDomain:ErrorDomain code:204 userInfo:@{NSLocalizedDescriptionKey:@"The request did not return any content."}];
}

+ (NSError *)imageTooLargeError {
    return [NSError errorWithDomain:ErrorDomain code:422 userInfo:@{NSLocalizedDescriptionKey:@"The image you are trying to upload is too large."}];
}

@end

@implementation NSString (FHSTwitterEngine)

- (NSString *)fhs_URLEncode {
    CFStringRef url = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, NULL, CFSTR("!*'();:@&=+$,/?%#[]"), kCFStringEncodingUTF8);
    return (__bridge NSString *)url;
}

- (NSString *)fhs_truncatedToLength:(int)length {
    return [self substringToIndex:MIN(length, self.length)];
}

- (NSString *)fhs_trimForTwitter {
    return [self fhs_truncatedToLength:140];
}

- (NSString *)fhs_stringWithRange:(NSRange)range {
    return [[self substringFromIndex:range.location]substringToIndex:range.length];
}

+ (NSString *)fhs_UUID {
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 6.0f) {
        return [[NSUUID UUID]UUIDString];
    } else {
        CFUUIDRef theUUID = CFUUIDCreate(kCFAllocatorDefault);
        CFStringRef string = CFUUIDCreateString(kCFAllocatorDefault, theUUID);
        CFRelease(theUUID);
        NSString *uuid = [NSString stringWithString:(__bridge NSString *)string];
        CFRelease(string);
        return uuid;
    }
}

- (BOOL)fhs_isNumeric {
    const char *raw = (const char *)[self UTF8String];
    
    for (int i = 0; i < strlen(raw); i++) {
        if (raw[i] < '0' || raw[i] > '9') {
            return NO;
        }
    }
    return YES;
}

@end

@implementation NSData (FHSTwitterEngine)

- (NSString *)appropriateFileExtension {
    uint8_t c;
    [self getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
    }
    return nil;
}

- (NSString *)base64Encode {
    int outLength = ((((self.length*4)/3)/4)*4)+(((self.length*4)/3)%4?4:0);
    const char *inputBuffer = self.bytes;
    char *outputBuffer = malloc(outLength+1);
    outputBuffer[outLength] = 0;
    
    int cycle = 0;
    int inpos = 0;
    int outpos = 0;
    char temp;
    
    outputBuffer[outLength-1] = '=';
    outputBuffer[outLength-2] = '=';
    
    while (inpos < self.length) {
        switch (cycle) {
            case 0:
                outputBuffer[outpos++] = Encode[(inputBuffer[inpos]&0xFC)>>2];
                cycle = 1;
                break;
            case 1:
                temp = (inputBuffer[inpos++]&0x03)<<4;
                outputBuffer[outpos] = Encode[temp];
                cycle = 2;
                break;
            case 2:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xF0)>>4];
                temp = (inputBuffer[inpos++]&0x0F)<<2;
                outputBuffer[outpos] = Encode[temp];
                cycle = 3;
                break;
            case 3:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xC0)>>6];
                cycle = 4;
                break;
            case 4:
                outputBuffer[outpos++] = Encode[inputBuffer[inpos++]&0x3f];
                cycle = 0;
                break;
            default:
                cycle = 0;
                break;
        }
    }
    NSString *pictemp = [NSString stringWithUTF8String:outputBuffer];
    free(outputBuffer);
    return pictemp;
}

@end
