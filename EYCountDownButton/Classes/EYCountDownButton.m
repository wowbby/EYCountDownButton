//
//  EYCountDownButton.m
//  EYCountDownButton
//
//  Created by 振兴郑 on 2019/2/3.
//

#import "EYCountDownButton.h"
#import "NSTimer+EYBlockSupport.h"

typedef void(^CountDownUnderwayBlock)(NSInteger restCountDownNum);

@interface EYCountDownButton ()

/** 控制倒计时的timer */
@property (nonatomic, strong) NSTimer *timer;
/** 按钮点击事件的回调 */
@property (nonatomic, copy) dispatch_block_t buttonClickedBlock;
/** 倒计时开始时的回调 */
@property (nonatomic, copy) dispatch_block_t countDownStartBlock;
/** 倒计时进行中的回调（每秒一次） */
@property (nonatomic, copy) CountDownUnderwayBlock countDownUnderwayBlock;
/** 倒计时完成时的回调 */
@property (nonatomic, copy) dispatch_block_t countDownCompletionBlock;

@end

@implementation EYCountDownButton{
    /** 倒计时开始值 */
    NSInteger _startCountDownNum;
    /** 剩余倒计时的值 */
    NSInteger _restCountDownNum;
}
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
             countDownCompletion:(dispatch_block_t)countDownCompletion {
    if (self = [super init]) {
        _startCountDownNum = duration;
        self.buttonClickedBlock       = buttonClicked;
        self.countDownStartBlock      = countDownStart;
        self.countDownUnderwayBlock   = countDownUnderway;
        self.countDownCompletionBlock = countDownCompletion;
        [self addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/** 按钮点击 */
- (void)buttonClicked:(EYCountDownButton *)sender {
    sender.enabled = NO;
    self.buttonClickedBlock();
}

/** 开始倒计时 */
- (void)startCountDown {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    _restCountDownNum = _startCountDownNum;
    !self.countDownStartBlock ?: self.countDownStartBlock(); // 调用倒计时开始的block
    __weak typeof(self) weakSelf = self;
    self.timer = [NSTimer ey_scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer *timer) {
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf refreshButton];
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

/** 刷新按钮内容 */
- (void)refreshButton {
    _restCountDownNum --;
    self.countDownUnderwayBlock(_restCountDownNum); // 调用倒计时进行中的回调
    if (_restCountDownNum == 0) {
        [self.timer invalidate];
        self.timer = nil;
        _restCountDownNum = _startCountDownNum;
        !self.countDownCompletionBlock ?: self.countDownCompletionBlock(); // 调用倒计时完成的回调
        self.enabled = YES;
    }
}
/** 结束倒计时 */
- (void)endCountDown {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    self.enabled = YES;
    !self.countDownCompletionBlock ?: self.countDownCompletionBlock();
}

- (void)dealloc {
    NSLog(@"倒计时按钮已释放");
}
@end
