//
//  NSString+HTMLEntityDecode.m
//  tztMobileApp_HTSC
//
//  Created by Yincheng on 16/5/12.
//
//

#import "NSString+HTMLEntityDecode.h"

@implementation NSString (HTMLEntityDecode)

+ (instancetype)stringByReplacingFromHtmlString:(NSString *)string {
    if (string.length > 0) {
        string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
        string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
        string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
        string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
        string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
        string = [string stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    }

    return string;
}

- (NSString *)decodeURLString
{
    NSMutableString *outputStr = [NSMutableString stringWithString:self];
    // 有一些非标准的 url 使用 “+” 来代替了 “%20”
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@" "
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


@end
