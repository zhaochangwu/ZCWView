//
//  ZCWCounter.m
//  ZCWCustomTools
//
//  Created by zhaochangwu on 16/8/24.
//  Copyright © 2016年 zhaochangwu. All rights reserved.
//

#import "ZCWCounter.h"

@interface ZCWCounter ()

@property (nonatomic, readwrite) NSInteger startNumber;
@property (nonatomic, readwrite) NSInteger endNumber;

@property (nonatomic, readwrite) NSInteger currentNumber;

@property (nonatomic, readwrite, strong) NSTimer *timer;

@end

@implementation ZCWCounter

#pragma mark - life cycle

- (instancetype)initWithStart:(NSInteger)start end:(NSInteger)end {
    self = [super init];
    if (self) {
        self.startNumber = start;
        self.endNumber = end;
        self.currentNumber = start;
        self.unitNumber = 1;
    }
    return self;
}

- (instancetype)initWithRange:(ZCWCounterRange)range {
    return [self initWithStart:range.start end:range.end];
}

+ (instancetype)countDownWithStartNumber:(NSInteger)startNumber {
    ZCWCounterRange range = ZCWMakeCounterRange(startNumber, 0);
    ZCWCounter *counter = [[ZCWCounter alloc] initWithRange:range];
    return counter;
}

#pragma mark - Custom Accessors
- (void)setCurrentNumber:(NSInteger)currentNumber {
    _currentNumber = currentNumber;
    if (self.numberDidChange) {
        self.numberDidChange(currentNumber);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(numberDidChange:)]) {
        [self.delegate numberDidChange:currentNumber];
    }
}

- (ZCWCounterRange)range {
    return ZCWMakeCounterRange(_startNumber, _endNumber);
}

#pragma mark - prvite
- (void)setupTimer {
    if (self.timer) {
        return;
    }
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self
                                                selector:@selector(count)
                                                userInfo:nil
                                                 repeats:YES];
}

- (void)count {
    if (self.range.start > self.range.end) {
        if (self.currentNumber > self.range.end) {
            self.currentNumber -= self.unitNumber;
        } else {
            [self endTimer];
        }
    } else if (self.range.start < self.range.end) {
        if (self.currentNumber < self.range.end) {
            self.currentNumber += self.unitNumber;
        } else {
            [self endTimer];
        }
    } else {
        [self endNumber];
    }
}

- (void)endTimer {
    if (!self.timer) {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
    if (self.didStopCount) {
        self.didStopCount(self.currentNumber);
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(didStopCount:)]) {
        [self.delegate didStopCount:self.currentNumber];
    }
}

#pragma mark - public
- (void)startCount {
    [self setupTimer];
}

- (void)stopCount {
    [self endTimer];
}

- (void)reset {
    self.currentNumber = self.startNumber;
}

@end
