//
//  JDLRollLabel.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/20.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDLRollLabel : UIScrollView
@property (nonatomic, strong) NSString *text; // 设置文字
@property(nonatomic,assign) float rollSpeed; // 滚动速度，默认0.5

/**
 *  初始化方法
 *  @param font  设置字体
 *  @param color 字体颜色
 */
-(instancetype)initWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)color;
@end
