//
//  JDLAnimationButton.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/11.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBlock)(void);

@interface JDLAnimationButton : UIButton

@property (nonatomic, copy) ClickBlock clickBlock;
@property (nonatomic, assign) CGFloat buttonScale;//缩小的比率，小于=1.0,大于0.0

/*
 *  继承  实现button的image和文字的排版
 *示例
 button.titleRect = CGRectMake(10, 10, 120, 20);  正常的frame布局
 button.imageRect = CGRectMake(135, 10, 20, 20);  正常的frame布局
 */
@property (nonatomic,assign) CGRect titleRect;
@property (nonatomic,assign) CGRect imageRect;

//常规方法
+ (JDLAnimationButton *)buttonWithType:(UIButtonType)type
                                  frame:(CGRect)frame
                                  title:(NSString *)title
                             titleColor:(UIColor *)color
                        backgroundColor:(UIColor *)backgroundColor
                              imageName:(NSString *)image
                               andBlock:(ClickBlock)tempBlock;

@end
