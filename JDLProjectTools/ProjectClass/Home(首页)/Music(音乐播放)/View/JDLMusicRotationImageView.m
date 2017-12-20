//
//  JDLMusicRotationImageView.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/19.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLMusicRotationImageView.h"

@implementation JDLMusicRotationImageView

-(void)JDL_setCornerRadiusFlout:(CGFloat )flout{
    self.layer.cornerRadius =flout;
    self.layer.masksToBounds =YES;
}

-(void)startRotating{
    
    CABasicAnimation *rotateAnimation =[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotateAnimation.fromValue =[NSNumber numberWithFloat:0.0];
    rotateAnimation.toValue =[NSNumber numberWithFloat:M_PI *2];
    rotateAnimation.duration =20;
    rotateAnimation.repeatCount =MAXFLOAT;
    [self.layer addAnimation:rotateAnimation forKey:nil];
}

-(void)stopRotating{
    CFTimeInterval pausedTime = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.layer.speed = 0.0;                                          // 停止旋转
    self.layer.timeOffset = pausedTime;                              // 保存时间，恢复旋转需要用到
}

-(void)resumeRotating{
    
    if (self.layer.timeOffset == 0) {
        [self startRotating];
        return;
    }
    
    CFTimeInterval pausedTime = self.layer.timeOffset;
    self.layer.speed = 1.0;                                         // 开始旋转
    self.layer.timeOffset = 0.0;
    self.layer.beginTime = 0.0;
    CFTimeInterval timeSincePause = [self.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;                                             // 恢复时间
    self.layer.beginTime = timeSincePause;                          // 从暂停的时间点开始旋转
}

@end
