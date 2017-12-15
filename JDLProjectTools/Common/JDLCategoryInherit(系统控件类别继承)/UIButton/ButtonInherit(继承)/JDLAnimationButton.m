//
//  JDLAnimationButton.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/11.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLAnimationButton.h"
#define animateDelay 0.15   //默认动画执行时间
#define defaultScale 0.9    //默认缩小的比率
@implementation JDLAnimationButton

+ (JDLAnimationButton *)buttonWithType:(UIButtonType)type
                              frame:(CGRect)frame
                              title:(NSString *)title
                         titleColor:(UIColor *)color
                    backgroundColor:(UIColor *)backgroundColor
                              imageName:(NSString *)imageName
                           andBlock:(ClickBlock)tempBlock
{
    JDLAnimationButton * pushBtn = [JDLAnimationButton buttonWithType:type];
    pushBtn.frame = frame;
    [pushBtn setTitle:title forState:UIControlStateNormal];
    [pushBtn setTitleColor:color forState:UIControlStateNormal];
    [pushBtn setBackgroundColor:backgroundColor];
    [pushBtn addTarget:pushBtn action:@selector(pressedEvent:) forControlEvents:UIControlEventTouchDown];
    [pushBtn addTarget:pushBtn action:@selector(unpressedEvent:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
    [pushBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    //给按钮的block赋值
    pushBtn.clickBlock = tempBlock;
    
    return pushBtn;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (!CGRectIsEmpty(self.titleRect) && !CGRectEqualToRect(self.titleRect, CGRectZero)) {
        return self.titleRect;
    }
    return [super titleRectForContentRect:contentRect];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    if (!CGRectIsEmpty(self.imageRect) && !CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return self.imageRect;
    }
    return [super imageRectForContentRect:contentRect];
}

//按钮的压下事件 按钮缩小
- (void)pressedEvent:(JDLAnimationButton *)btn
{
    //缩放比例必须大于0，且小于等于1
    CGFloat scale = (_buttonScale && _buttonScale <=1.0) ? _buttonScale : defaultScale;
    
    [UIView animateWithDuration:animateDelay animations:^{
        btn.transform = CGAffineTransformMakeScale(scale, scale);
    }];
}
//点击手势拖出按钮frame区域松开，响应取消
- (void)cancelEvent:(JDLAnimationButton *)btn
{
    [UIView animateWithDuration:animateDelay animations:^{
        btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
}
//按钮的松开事件 按钮复原 执行响应
- (void)unpressedEvent:(JDLAnimationButton *)btn
{
    [UIView animateWithDuration:animateDelay animations:^{
        btn.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        //执行动作响应
        if (self.clickBlock) {
            self.clickBlock();
        }
    }];
}


@end
