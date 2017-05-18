//
//  NSObject+Archiver.m
//  Pods
//
//  Created by zhaochangwu on 2017/5/11.
//
//

#import "NSObject+ZCWArchiver.h"
#import "ZCWDefine.h"

static NSString *const kFormat = @"/%@.data";

@implementation NSObject (ZCWArchiver)

- (BOOL)archiverWithFileName:(NSString *)fileName {
	NSString *path = [ZCWDocumentDirectory() stringByAppendingFormat:kFormat, fileName];
	ZCWDebugLog(@"archiver file: %@ to path: \n%@", fileName, path);
	//1:准备存储数据的对象
	NSMutableData *data = [NSMutableData data];
	//2:创建归档对象
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
	//3:开始归档
	[archiver encodeObject:self forKey:fileName];
	//4:完成归档
	[archiver finishEncoding];
	//5:写入文件当中
	return [data writeToFile:path atomically:YES];
}

+ (instancetype)unarchiverWithFileName:(NSString *)fileName {
	NSString *path = [ZCWDocumentDirectory() stringByAppendingFormat:kFormat,fileName];
	//1:读取文件,生成NSData类型
	NSData *unarchiverData = [NSData dataWithContentsOfFile:path];
	//2:创建反归档对象
	NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchiverData];
	//3:反归档.根据可以访问
	return [unarchiver decodeObjectForKey:fileName];
}

- (void)removeCacheWithFileName:(NSString *)fileName {
	//利用GCD
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		//要删除的文件路径
		NSString * deletePath = [ZCWDocumentDirectory() stringByAppendingFormat:kFormat, fileName];
		if ([[NSFileManager defaultManager] fileExistsAtPath:deletePath]) {
			//删除
			NSError * error = nil;
			[[NSFileManager defaultManager] removeItemAtPath:deletePath error:&error];
		}
	});
}

@end
