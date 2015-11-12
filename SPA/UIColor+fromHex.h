//
//  UIColor+fromHex.h
//  
//
//  Created by Soumya Mohanty on 11/11/15.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (fromHex)
+ (UIColor *)colorwithHexString:(NSString *)hexStr alpha:(CGFloat)alpha;
@end
