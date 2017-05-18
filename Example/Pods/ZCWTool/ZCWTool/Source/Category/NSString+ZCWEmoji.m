//
//  NSString+ZCWEmoji.m
//  Pods
//
//  Created by zhaochangwu on 2017/5/11.
//
//

#import "NSString+ZCWEmoji.h"

@implementation NSString (ZCWEmoji)

- (BOOL)isContainEmoji {

	__block BOOL isEomji = NO;
	[self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
	 ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
		 const unichar hs = [substring characterAtIndex:0];
		 if (0xd800 <= hs && hs <= 0xdbff) {
			 if (substring.length > 1) {
				 const unichar ls = [substring characterAtIndex:1];
				 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
				 if (0x1d000 <= uc && uc <= 0x1f77f) {
					 NSLog(@"YES %@", substring);
					 isEomji = YES;
				 }
				 if (0x1f910 <= uc && uc <= 0x1f918) {
					 NSLog(@"YES %@", substring);
					 isEomji = YES;
				 }
				 if (0x1f980 <= uc && uc <= 0x1f984) {
					 NSLog(@"YES %@", substring);
					 isEomji = YES;
				 }
				 if (uc == 0x1f9c0) {
					 isEomji = YES;
				 }
			 }
		 } else if (substring.length > 1) {
			 const unichar ls = [substring characterAtIndex:1];
			 if (ls == 0x20e3|| ls ==0xfe0f || ls == 0xd83c) {
				 isEomji = YES;
			 }
		 } else {
			 if (0x2100 <= hs && hs <= 0x27ff && hs != 0x263b) {
				 isEomji = YES;
			 } else if (0x2B05 <= hs && hs <= 0x2b07) {
				 isEomji = YES;
			 } else if (0x2934 <= hs && hs <= 0x2935) {
				 isEomji = YES;
			 } else if (0x3297 <= hs && hs <= 0x3299) {
				 NSLog(@"YES %@", substring);
			 } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50|| hs == 0x231a ) {
				 isEomji = YES;
			 }
		 }

		 //九宫格输入的时候是这些特殊字符
		 NSArray *tenKeyKeyboardStrings =  @[@"\u19eb1dea0", @"\u19eb1df00", @"\u19eb1dfa0", @"\u19eb1e000",
											 @"\u19eb1e060", @"\u19eb1e0c0", @"\u19eb1e120", @"\u19eb1e180"];
		 [tenKeyKeyboardStrings enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
			 if ([substring isEqualToString:obj]) {
				 isEomji = NO;
				 *stop = YES;
			 }
		 }];
	 }];
	return isEomji;
}

@end
