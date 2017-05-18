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
	NSString *path = @"Frameworks/ZCWView.framework/ZCWView.bundle/Images.bundle";
	NSString *imagesBundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:path];
	NSString *imagePath = [imagesBundlePath stringByAppendingPathComponent:name];
	UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
	return image;
}

@end
