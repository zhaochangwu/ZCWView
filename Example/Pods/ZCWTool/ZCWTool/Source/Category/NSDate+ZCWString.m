//
//  NSDate+ZCWString.m
//  Pods
//
//  Created by zhaochangwu on 2017/5/17.
//
//

#import "NSDate+ZCWString.h"

@implementation NSDate (ZCWString)

+ (NSString *)currentDateStringWithFormatter:(NSString *)format {
	return [[NSDate date] dateStringWithFormatter:format];
}

- (NSString *)dateStringWithFormatter:(NSString *)format {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = format;;
	return [formatter stringFromDate:self];
}

@end
