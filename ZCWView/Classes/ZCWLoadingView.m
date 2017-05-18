//
//  ZCWLoadingView.m
//  ZCWView
//
//  Created by zhaochangwu on 2017/3/21.
//  Copyright (c) 2017 zhaochangwu. All rights reserved.
//

#import "ZCWLoadingView.h"

#define kZCWLoadingViewDiameter		25.f
#define kZCWLoadingViewRadius			(kZCWLoadingViewDiameter / 2.f)
#define kZCWLoadingViewThickness		2.f
#define kZCWContentLayerWidth			75.f
#define kZCWContentLayerHeight			70.f

#define M_PI_6 (M_PI_2 / 3)

@interface ZCWLoadingView ()

@property (nonatomic, strong) CAShapeLayer *indefiniteAnimatedLayer;//转动的圆弧
@property (nonatomic, strong) CAShapeLayer *circleLayer;
@property (nonatomic, strong) CALayer *contentLayer;
@property (nonatomic, strong) CATextLayer *textLayer;

@end

@implementation ZCWLoadingView

+ (instancetype)view {
	return [[ZCWLoadingView alloc] initWithFrame:ZCWScreenBounds()];
}

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self.layer addSublayer:self.contentLayer];
		[self.contentLayer addSublayer:self.circleLayer];
		[self.contentLayer addSublayer:self.indefiniteAnimatedLayer];
		[self.contentLayer addSublayer:self.textLayer];
	}
	return self;
}

- (CAShapeLayer*)indefiniteAnimatedLayer {
	if(!_indefiniteAnimatedLayer) {
		//设置转动的圆弧
		UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kZCWLoadingViewRadius, kZCWLoadingViewRadius)
															radius:kZCWLoadingViewRadius
														startAngle:0
														  endAngle:-M_PI_6
														 clockwise:NO];
		// 创建一个shapeLayer
		_indefiniteAnimatedLayer = [CAShapeLayer layer];
		_indefiniteAnimatedLayer.frame = CGRectMake(0, 0, kZCWLoadingViewDiameter, kZCWLoadingViewDiameter);
		_indefiniteAnimatedLayer.strokeColor = [UIColor colorWithHexString:@"#0093e6"].CGColor;   // 边缘线的颜色
		_indefiniteAnimatedLayer.path = path.CGPath;                    // 从贝塞尔曲线获取到形状
		_indefiniteAnimatedLayer.lineWidth = kZCWLoadingViewThickness;                           // 线条宽度
		_indefiniteAnimatedLayer.lineCap = kCALineCapRound;
		_indefiniteAnimatedLayer.position = CGPointMake(kZCWContentLayerWidth / 2, kZCWContentLayerHeight / 2 - 10);
		_indefiniteAnimatedLayer.contentsScale = [UIScreen mainScreen].scale;

		CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
		animation.fromValue = (id) 0;
		animation.toValue = @(M_PI*2);
		animation.duration = 1.f;
		animation.removedOnCompletion = NO;
		animation.repeatCount = INFINITY;
		animation.autoreverses = NO;
		[_indefiniteAnimatedLayer addAnimation:animation forKey:@"rotate"];
	}
	return _indefiniteAnimatedLayer;
}

- (CAShapeLayer *)circleLayer {
	if (!_circleLayer) {
		UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(kZCWLoadingViewRadius, kZCWLoadingViewRadius)
															radius:kZCWLoadingViewRadius
														startAngle:0
														  endAngle:(M_PI * 2)
														 clockwise:NO];
		_circleLayer = [CAShapeLayer layer];
		_circleLayer.frame = CGRectMake(0, 0, kZCWLoadingViewDiameter, kZCWLoadingViewDiameter);
		_circleLayer.strokeColor = [UIColor colorWithHexString:@"#b3b3b3"].CGColor;   // 边缘线的颜色
		_circleLayer.fillColor = [UIColor clearColor].CGColor;   // 闭环填充的颜色
		_circleLayer.path = path.CGPath;                    // 从贝塞尔曲线获取到形状
		_circleLayer.lineWidth = kZCWLoadingViewThickness;                           // 线条宽度
		_circleLayer.position = CGPointMake(kZCWContentLayerWidth / 2, kZCWContentLayerHeight / 2 - 10);
		_circleLayer.contentsScale = [UIScreen mainScreen].scale;
	}
	return _circleLayer;
}

- (CALayer *)contentLayer {
	if (!_contentLayer) {
		_contentLayer = [CALayer layer];
		_contentLayer.frame = CGRectMake(0, 0, kZCWContentLayerWidth, kZCWContentLayerHeight);
		_contentLayer.backgroundColor = [[UIColor alloc] initWithWhite:0.0f alpha:.6f].CGColor;
		_contentLayer.position = self.center;
		_contentLayer.cornerRadius = 7.f;
		_contentLayer.contentsScale = [UIScreen mainScreen].scale;
	}
	return _contentLayer;
}

- (CATextLayer *)textLayer {
	if (!_textLayer) {
		_textLayer = [CATextLayer layer];
		CGFloat height = 25.f;
		_textLayer.frame = CGRectMake(0, 0, kZCWContentLayerWidth, height);
		_textLayer.string = @"加载中";
		_textLayer.fontSize = 12.f;
		_textLayer.position	  = CGPointMake(kZCWContentLayerWidth / 2, kZCWContentLayerHeight - height / 2);
		_textLayer.alignmentMode = kCAAlignmentCenter;
		_textLayer.contentsScale = [UIScreen mainScreen].scale;
	}
	return _textLayer;
}

@end
