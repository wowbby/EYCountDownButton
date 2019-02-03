//
//  NSTimer+EYBlockSupport.h
//  EYCountDownButton
//
//  Created by 振兴郑 on 2019/2/3.
//

#import <Foundation/Foundation.h>

@interface NSTimer (EYBlockSupport)
+ (NSTimer *)ey_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;
@end
