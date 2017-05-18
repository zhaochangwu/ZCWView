//
//  ZCWToastView.m
//  ZCWView
//
//  Created by zhaochangwu on 2017/3/23.
//  Copyright (c) 2017 zhaochangwu. All rights reserved.
//

#import "ZCWToastView.h"
#import "UIImage+LoadImages.h"

#define kZCWToastViewTextFont			[UIFont systemFontOfSize:14.f]
#define kZCWToastViewDefultDuration	2.f
#define kZCWToastViewGap				15.f
#define kZCWToastViewMinimumWidth		70.f

@interface ZCWToastView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic) NSTimeInterval duration;

@end

@implementation ZCWToastView

#pragma mark - public

//infotoast

+ (instancetype)infoToastWithMessage:(NSString *)msg {
	return [self infoToastWithMessage:msg duration:kZCWToastViewDefultDuration];
}

+ (instancetype)infoToastWithMessage:(NSString *)msg duration:(NSTimeInterval)duration {
	return [[self alloc] initWithMessage:msg image:nil duration:duration];
}

//successToast

+ (instancetype)successToast {
	return [self successToastWithMessage:nil];
}

+ (instancetype)successToastWithMessage:(NSString *)msg {
	return [self successToastWithMessage:msg duration:2.f];
}

+ (instancetype)successToastWithMessage:(NSString *)msg duration:(NSTimeInterval)duration {
	return [[self alloc] initWithMessage:msg ? : @"请求成功" image:[UIImage bundleImageNamed:@"success"] duration:duration];
}

//failToast

+ (instancetype)failToast {
	return [self failToastWithMessage:nil];
}

+ (instancetype)failToastWithMessage:(NSString *)msg {
	return [self failToastWithMessage:msg duration:kZCWToastViewDefultDuration];
}

+ (instancetype)failToastWithMessage:(NSString *)msg duration:(NSTimeInterval)duration {
	return [[self alloc] initWithMessage:msg ? : @"请求失败" image:[UIImage bundleImageNamed:@"fail"] duration:duration];
}

//offlineToast
+ (instancetype)offlineToast {
	return [self offlineToastWithMessage:nil];
}

+ (instancetype)offlineToastWithMessage:(NSString *)msg {
	return [self offlineToastWithMessage:msg duration:kZCWToastViewDefultDuration];
}

+ (instancetype)offlineToastWithMessage:(NSString *)msg duration:(NSTimeInterval)duration {
	return [[self alloc] initWithMessage:msg ? : @"网络连接失败" image:[UIImage bundleImageNamed:@"offline"] duration:duration];
}

- (void)hide {
	weakify(self);
	if (self.closeCompletion) {
		self.closeCompletion(weak_self);
	}
	[self removeFromSuperview];
}

#pragma mark - life cycle

- (instancetype)initWithMessage:(NSString *)msg image:(UIImage *)image duration:(NSTimeInterval)duration {
	self = [self init];
	if (self) {

		self.message = msg;

		if (image) {
			[self.contentView addSubview:self.imageView];
			self.image = image;
		}

		[self layoutSubviews];
		self.duration = duration;
		[self setupConstraints];

		//此处容易引起内存泄露
		if (self.duration) {
			[self performSelector:@selector(hide) withObject:nil afterDelay:self.duration];
		}
	}
	return self;
}

- (instancetype)init {
	self = [super init];
	if (self) {
		self.frame = ZCWScreenBounds();
		[self addSubview:self.contentView];
		[self.contentView addSubview:self.textLabel];
		self.isTouchHide = YES;
		UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchHide)];
		[self addGestureRecognizer:tap];
		self.hasMask = YES;
	}
	return self;
}

- (void)removeFromSuperview {
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(hide) object:nil];
	[super removeFromSuperview];
}

- (void)updateConstraints {
	[self setupConstraints];
	[super updateConstraints];
}

- (void)setupConstraints {
	weakify(self);
	CGSize textLabelSize = self.textLabel.size;
	if (self.image) {
		//图片和文字均存在时的布局
		[self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.top.mas_equalTo(kZCWToastViewGap);
			make.size.mas_equalTo(CGSizeMake(32.f, 32.f));
			make.centerX.mas_equalTo(0);
		}];
		[self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(0);
			make.edges.mas_equalTo(UIEdgeInsetsMake(0, kZCWToastViewGap, kZCWToastViewGap, kZCWToastViewGap)).priority(750);
			make.size.mas_equalTo(textLabelSize);
			make.top.mas_equalTo(weak_self.imageView.mas_bottom).offset(8);
		}];
		[self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.center.mas_equalTo(CGPointZero);
			make.width.mas_greaterThanOrEqualTo(kZCWToastViewMinimumWidth);
		}];
	} else {
		//只有文字时候的布局
		[self.textLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.centerX.mas_equalTo(0);
			make.edges.mas_equalTo(UIEdgeInsetsMake(kZCWToastViewGap, kZCWToastViewGap, kZCWToastViewGap, kZCWToastViewGap)).priority(750);
			make.size.mas_equalTo(textLabelSize);
		}];
		[self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
			make.center.mas_equalTo(CGPointZero);
			make.width.mas_greaterThanOrEqualTo(kZCWToastViewMinimumWidth);
		}];
	}
}

#pragma mark - setter

- (void)setMessage:(NSString *)message {
	NSAssert(ZCWValidNSString(message), @"Invalid argument 'message'");
	_message = message;
	self.textLabel.text = message;
	[self.textLabel sizeToFit];
}

- (void)setImage:(UIImage *)image {
	NSAssert([image isKindOfClass:[UIImage class]], @"Invalid argument 'image'");
	_image = image;
	if (image && _imageView) {
		_imageView.image = image;
	} else if (image && !_imageView) {
		[self addSubview:self.imageView];
		[self layoutSubviews];
	} else if (!image && _imageView) {
		[_imageView removeFromSuperview];
		[self layoutSubviews];
	}
}

- (void)setHasMask:(BOOL)hasMask {
	_hasMask = hasMask;
	self.userInteractionEnabled = hasMask;
}

#pragma mark - handker

- (void)touchHide {
	if (self.isTouchHide) {
		[self hide];
	}
}

#pragma mark - 懒加载//getter
- (UIView *)contentView {
	if (!_contentView) {
		_contentView = [[UIView alloc] init];
		_contentView.backgroundColor = [[UIColor alloc] initWithWhite:0.0f alpha:.6f];
		_contentView.clipsToBounds = YES;
		_contentView.layer.cornerRadius = 5.f;
	}
	return _contentView;
}

- (UIImageView *)imageView {
	if (!_imageView) {
		_imageView = [[UIImageView alloc] init];
	}
	return _imageView;
}

- (UILabel *)textLabel {
	if (!_textLabel) {
		_textLabel = [[UILabel alloc] init];
		_textLabel.font = kZCWToastViewTextFont;
		_textLabel.numberOfLines = 0;
		_textLabel.textAlignment = NSTextAlignmentCenter;
		_textLabel.textColor = [UIColor whiteColor];
		_textLabel.font = [UIFont systemFontOfSize:14.f];
		_textLabel.frame = CGRectMake(0, 0, ZCWScreenWidth() - 100, 0);
	}
	return _textLabel;
}

@end
