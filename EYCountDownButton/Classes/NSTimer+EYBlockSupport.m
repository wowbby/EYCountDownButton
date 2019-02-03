//
//  NSTimer+EYBlockSupport.m
//  EYCountDownButton
//
//  Created by 振兴郑 on 2019/2/3.
//

#import "NSTimer+EYBlockSupport.h"

@implementation NSTimer (EYBlockSupport)
+ (NSTimer *)ey_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block {
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(ey_callBlock:) userInfo:[block copy] repeats:repeats];
}

+ (void)ey_callBlock:(NSTimer *)timer {
    void (^block)(NSTimer *timer) = timer.userInfo;
    !block ?: block(timer);
}
@end
