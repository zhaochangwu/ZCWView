//
//  ZCWToastView.h
//  ZCWView
//
//  Created by zhaochangwu on 2017/3/23.
//
//

#import <UIKit/UIKit.h>

/*
 为了h5样式统一
 仿照蚂蚁金服前端组件`Toast`样式和接口
 https://mobile.ant.design/components/toast/
 */

@interface ZCWToastView : UIView

@property (nonatomic, copy) void (^closeCompletion)(ZCWToastView *toast);
@property (nonatomic, readonly) NSTimeInterval duration; //消失时间, =0则不消失
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) UIImage *image;

//hasMask=YES时, isTouchHide的设置才生效
@property (nonatomic) BOOL isTouchHide; //default is 'yes;
@property (nonatomic) BOOL hasMask;	//defult is 'yes'

+ (instancetype)infoToastWithMessage:(NSString *)msg; //只有文字没有图片

+ (instancetype)successToast;
+ (instancetype)successToastWithMessage:(NSString *)msg;
+ (instancetype)successToastWithMessage:(NSString *)msg duration:(NSTimeInterval)duration;

+ (instancetype)failToast;
+ (instancetype)failToastWithMessage:(NSString *)msg;
+ (instancetype)failToastWithMessage:(NSString *)msg duration:(NSTimeInterval)duration;

+ (instancetype)offlineToast;
+ (instancetype)offlineToastWithMessage:(NSString *)msg;
+ (instancetype)offlineToastWithMessage:(NSString *)msg duration:(NSTimeInterval)duration;

- (void)hide;

@end
