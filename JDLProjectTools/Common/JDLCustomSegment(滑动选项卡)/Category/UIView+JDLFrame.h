//
//  UIView+JDLFrame.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/18.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JDLFrame)
@property (nonatomic, assign) CGFloat JDL_x;
@property (nonatomic, assign) CGFloat JDL_y;
@property (nonatomic, assign) CGFloat JDL_width;
@property (nonatomic, assign) CGFloat JDL_height;
@property (nonatomic, assign) CGFloat JDL_centerX;
@property (nonatomic, assign) CGFloat JDL_centerY;
@property (nonatomic, assign) CGPoint JDL_origin;
@property (nonatomic, assign) CGSize JDL_size;

/// 从 XIB 中加载视图
+ (instancetype)JDL_loadViewFromXib;

@end
