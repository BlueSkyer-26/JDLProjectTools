//
//  UIButton+JDLCountDown.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/11.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^countdownCompletionBlock)(void);

@interface UIButton (JDLCountDown)
/** 倒计时,秒字倒计,无回调*/
- (void)JDL_countdownWithSecond:(NSInteger)second;
/** 倒计时,秒字倒计,带有回调 */
- (void)JDL_countdownWithSecond:(NSInteger)second completion:(countdownCompletionBlock)block;

@end

