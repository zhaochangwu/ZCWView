//
//  ZCWDefine.h
//  Pods
//
//  Created by zhaochangwu on 2017/4/24.
//
//

#ifndef ZCWDefine_h
#define ZCWDefine_h

//log

#define ZCWLog(level, fmt, ...)	NSLog((level @"\n %s line:%d\n" fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__)

#define ZCWDebugLog(format, ...)	ZCWLog(@"ZCWDebugLog", format, ##__VA_ARGS__)
#define ZCWErrorLog(format, ...)	ZCWLog(@"ZCWErrorLog", format, ##__VA_ARGS__)
#define ZCWReleaseLog(format, ...)  ZCWLog(@"ZCWReleaseLog", format, ##__VA_ARGS__)

#define ZCWNSErrorLog(error)	do {\
										if((error)) {\
											ZCWErrorLog(@"%@", (error));\
										}\
									} while(0)

// weakify & strongify
#ifndef    weakify
#if __has_feature(objc_arc)
#define weakify(object) __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object) __block __typeof__(object) block##_##object = object;
#endif
#endif
#ifndef    strongify
#if __has_feature(objc_arc)
#define strongify(object) __typeof__(object) strong##_##object = weak##_##object;
#else
#define strongify(object) __typeof__(object) strong##_##object = block##_##object;
#endif
#endif

//system version
static inline CGFloat ZCWSystemVersion () {
	return [[UIDevice currentDevice].systemVersion floatValue];
}

static inline BOOL ZCWSystemVersionOrLater(CGFloat version) {
	return ZCWSystemVersion () >= version;
}

//screen
static inline CGRect ZCWScreenBounds () {
	return [UIScreen mainScreen].bounds;
}

static inline CGSize ZCWScreenSize () {
	return [UIScreen mainScreen].bounds.size;
}

static inline CGFloat ZCWScreenWidth () {
	return [UIScreen mainScreen].bounds.size.width;
}

static inline CGFloat ZCWScreenHeight() {
	return [UIScreen mainScreen].bounds.size.height;
}

static inline CGFloat ZCWNavBarHeight () {
	return 64.f;
}

static inline CGFloat ZCWStatusBarHeight () {
	return 20.f;
}


//Valid Type

static inline BOOL ZCWValidNSString (NSString *string) {
	if (!string) {
		return NO;
	}
	if (![string  isKindOfClass:[NSString class]]) {
		return NO;
	}
	return YES;
}


static inline BOOL ZCWValidNSDictionary (NSDictionary *dict) {
	if (!dict) {
		return NO;
	}
	if (![dict  isKindOfClass:[NSDictionary class]]) {
		return NO;
	}
	return YES;
}

static inline BOOL ZCWValidNSNumber (NSNumber *num) {
	if (!num) {
		return NO;
	}
	if (![num  isKindOfClass:[NSNumber class]]) {
		return NO;
	}
	return YES;
}

static inline BOOL ZCWValidNSArray (NSArray *arr) {
	if (!arr) {
		return NO;
	}
	if (![arr  isKindOfClass:[NSArray class]]) {
		return NO;
	}
	return YES;
}

static inline NSString * ZCWDocumentDirectory() {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

#endif /* ZCWDefine_h */
