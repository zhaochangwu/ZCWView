//
//  NSDate+ZCWString.h
//  Pods
//
//  Created by zhaochangwu on 2017/5/17.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (ZCWString)

+ (NSString *)currentDateStringWithFormatter:(NSString *)format;
- (NSString *)dateStringWithFormatter:(NSString *)format;

@end
