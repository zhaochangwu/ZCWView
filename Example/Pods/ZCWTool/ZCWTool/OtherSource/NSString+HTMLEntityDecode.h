//
//  NSString+HTMLEntityDecode.h
//  tztMobileApp_HTSC
//
//  Created by Yincheng on 16/5/12.
//
//

#import <Foundation/Foundation.h>

@interface NSString (HTMLEntityDecode)

+ (instancetype)stringByReplacingFromHtmlString:(NSString *)string;

- (NSString *)decodeURLString;

@end
