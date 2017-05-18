//
//  UIImage+LoadImages.m
//  Pods
//
//  Created by zhaochangwu on 2017/5/18.
//
//

#import "UIImage+LoadImages.h"

@implementation UIImage (LoadImages)

+ (UIImage *)bundleImageNamed:(NSString *)name {
	NSString *frameworksPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Frameworks"];
	NSString *bundlePath = [frameworksPath stringByAppendingPathComponent:@"ZCWView.framework"];
	NSString *imagesBundlePath = [bundlePath stringByAppendingPathComponent:@"Images.bundle"];
	NSString *imagePath = [imagesBundlePath stringByAppendingPathComponent:name];
	UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
	return image;
}

@end
