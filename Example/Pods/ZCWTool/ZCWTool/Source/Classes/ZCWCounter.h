//
//  ZCWCounter.h
//  ZCWCustomTools
//
//  Created by zhaochangwu on 16/8/24.
//  Copyright © 2016年 zhaochangwu. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct _ZCWCounterRange {
    NSInteger start;
    NSInteger end;
} ZCWCounterRange;

NS_INLINE ZCWCounterRange ZCWMakeCounterRange(NSInteger start, NSInteger end) {
    ZCWCounterRange r;
    r.start = start;
    r.end = end;
    return r;
}
NS_ASSUME_NONNULL_END

typedef void(^ZCWCounterBlock)(NSInteger currentNumber);

@protocol ZCWCounterDelegate <NSObject>

/**
 *  会在数值改变之后调用, 会在block之后执行
 *
 *  @param currentNumber <#currentNumber description#>
 */
- (void)numberDidChange:(NSInteger)currentNumber;

/**
 *  结束计数的时候会调用
 *
 *  @param currentNumber <#currentNumber description#>
 */
- (void)didStopCount:(NSInteger)currentNumber;

@end

/**
 *  实现类似于倒计时的功能, 从开始的数一直数到结束的数
 */

@interface ZCWCounter : NSObject

/**
 *  开始的数字
 */
@property (nonatomic, readonly) NSInteger startNumber;

/**
 *  结束的数字
 */
@property (nonatomic, readonly) NSInteger endNumber;

@property (nonatomic, readonly) ZCWCounterRange range;

/**
 *  每次变化的单位值, 默认是1.0
 */
@property (nonatomic, readwrite) NSInteger unitNumber;

/**
 *  当前的值, 类初始化的时候会和startNumber一致
 */
@property (nonatomic, readonly) NSInteger currentNumber;


@property (nonatomic, readwrite, nullable, weak) id <ZCWCounterDelegate> delegate;

/**
 *  会在数值改变之后调用, 会先于代理执行
 */
@property (nonatomic, readwrite, nullable, copy) ZCWCounterBlock numberDidChange;

/**
 *  会在计数结束的时候调用, 会先于代理执行
 */
@property (nonatomic, readwrite, nullable, copy) ZCWCounterBlock didStopCount;

- (_Nonnull instancetype)initWithRange:(ZCWCounterRange)range;
- (_Nonnull instancetype)initWithStart:(NSInteger)start end:(NSInteger)end;

/**
 *  从输入的数开始倒数到0
 *
 *  @param startNumber 开始倒数的数
 *
 *  @return 一个倒计到0的对象
 */
+ (_Nonnull instancetype)countDownWithStartNumber:(NSInteger)startNumber;

/**
 *  开始计数
 */
- (void)startCount;

/**
 *  停止计数
 */
- (void)stopCount;

/**
 *  当前计数重置为开始计数
 */
- (void)reset;

@end

