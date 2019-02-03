//
//  EYCountDownButton.h
//  EYCountDownButton
//
//  Created by 振兴郑 on 2019/2/3.
//

#import <UIKit/UIKit.h>

@interface EYCountDownButton : UIButton
/**
 构造方法
 
 @param duration 倒计时时间
 @param buttonClicked 按钮点击事件的回调
 @param countDownStart 倒计时开始时的回调
 @param countDownUnderway 倒计时进行中的回调（每秒一次）
 @param countDownCompletion 倒计时完成时的回调
 @return 倒计时button
 */
- (instancetype)initWithDuration:(NSInteger)duration
                   buttonClicked:(dispatch_block_t)buttonClicked
                  countDownStart:(dispatch_block_t)countDownStart
               countDownUnderway:(void(^)(NSInteger restCountDownNum))countDownUnderway
             countDownCompletion:(dispatch_block_t)countDownCompletion;

/** 开始倒计时 */
- (void)startCountDown;

/** 结束倒计时 */
- (void)endCountDown;
@end
