//
//  JDLAutherManager.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/21.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLAutherManager.h"

@implementation JDLAutherManager

#pragma mark - int转NSString   秒-->分：秒
+(NSString *)secondsToString: (int)needTransformInteger {
    
    //实现00：00这种格式播放时间
    int wholeTime = needTransformInteger;
    
    int min  = wholeTime / 60;
    
    int sec = wholeTime % 60;
    
    NSString *str = [NSString stringWithFormat:@"%02d:%02d", min , sec];
    
    return str;
}

#pragma mark - NSString转int   分：秒-->秒
+(int)stringToSeconds: (NSString *)timeString {
    
    NSArray *strTemp = [timeString componentsSeparatedByString:@":"];
    
    int time = [strTemp.firstObject intValue] * 60 + [strTemp.lastObject intValue];
    
    return time;
}

//跳动效果的实现
+ (void)popJumpAnimationView:(UIView *)sender
{
    CALayer *layer =sender.layer;
    
    NSArray *durations = @[@1.26f, @0.43f, @1.01f, @0.73f];
    NSArray *beginTimes = @[@0.77f, @0.29f, @0.28f, @0.74f];
    CAMediaTimingFunction *timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    CGFloat lineSize = sender.width / 7;
    CGFloat x = (layer.bounds.size.width - sender.width) / 2;
    CGFloat y = (layer.bounds.size.height - sender.height) / 2;
    
    // Animation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.keyTimes = @[@0.0f, @0.5f, @1.0f];
    animation.values = @[@1.0f, @0.5f, @1.0f];
    animation.timingFunctions = @[timingFunction, timingFunction];
    animation.repeatCount = HUGE_VALF;
    animation.removedOnCompletion = NO;
    
    for (int i = 0; i < 4; i++) {
        CAShapeLayer *line = [CAShapeLayer layer];
        UIBezierPath *linePath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, lineSize, sender.height) cornerRadius:lineSize / 2];
        
        animation.duration = [durations[i] floatValue];
        animation.beginTime = [beginTimes[i] floatValue];
        line.fillColor = KThemeColor.CGColor;
        line.path = linePath.CGPath;
        [line addAnimation:animation forKey:@"animation"];
        line.frame = CGRectMake(x + lineSize * 2 * i, y, lineSize, sender.height);
        [layer addSublayer:line];
    }
    
    //复制层
//    CAReplicatorLayer * repL = [CAReplicatorLayer layer];
//    repL.frame = sender.bounds;
//    //复制6份
//    repL.instanceCount = 6;
//    //形变，每一个形变都是相对于上一个复制出来的子层开始的
//    repL.instanceTransform = CATransform3DMakeTranslation(45, 0, 0);
//    //动画延时执行
//    repL.instanceDelay = 0.5;
//    ///要设置复制层的颜色 原始层的颜色要设为白色.
//    repL.instanceColor = [UIColor redColor].CGColor;
//    [sender.layer addSublayer:repL];
//
//    CALayer * layer = [CALayer layer];
//    layer.frame = CGRectMake(0, sender.bounds.size.height-10, 10, 50);
//    layer.backgroundColor = [UIColor whiteColor].CGColor;
//
//    layer.position = CGPointMake(0, sender.bounds.size.height);
//    layer.anchorPoint = CGPointMake(0, 1);
//
//    [repL addSublayer:layer];
//
//    //添加动画 对y方向缩放
//    CABasicAnimation * anim = [CABasicAnimation animation];
//    //设置属性
//    anim.keyPath = @"transform.scale.y";
//    anim.toValue = @0;
//    anim.repeatCount = MAXFLOAT;
//    anim.autoreverses = YES;
//    anim.duration = 0.5;
//    [sender.layer addAnimation:anim forKey:nil];
    
//    CGFloat duration = 1.f;
//    CGFloat height = 7.f;
//
//    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
//    CGFloat currentTy = sender.transform.ty;
//    animation.duration = duration;
//    animation.values = @[@(currentTy), @(currentTy - height/4), @(currentTy-height/4*2), @(currentTy-height/4*3), @(currentTy - height), @(currentTy-height/4*3), @(currentTy -height/4*2), @(currentTy - height/4), @(currentTy)];
//    animation.keyTimes = @[ @(0), @(0.025), @(0.085), @(0.2), @(0.5), @(0.8), @(0.915), @(0.975), @(1) ];
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    animation.repeatCount = HUGE_VALF;
//    [sender.layer addAnimation:animation forKey:@"kViewShakerAnimationKey"];
    
}

@end
