//
//  UIView+JDLFrame.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/18.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "UIView+JDLFrame.h"

@implementation UIView (JDLFrame)
- (void)setJDL_x:(CGFloat)JDL_x {
    CGRect frame = self.frame;
    frame.origin.x = JDL_x;
    self.frame = frame;
}
- (CGFloat)JDL_x {
    return self.frame.origin.x;
}

- (void)setJDL_y:(CGFloat)JDL_y {
    CGRect frame = self.frame;
    frame.origin.y = JDL_y;
    self.frame = frame;
}
- (CGFloat)JDL_y {
    return self.frame.origin.y;
}

- (void)setJDL_width:(CGFloat)JDL_width {
    CGRect frame = self.frame;
    frame.size.width = JDL_width;
    self.frame = frame;
}
- (CGFloat)JDL_width {
    return self.frame.size.width;
}

- (void)setJDL_height:(CGFloat)JDL_height {
    CGRect frame = self.frame;
    frame.size.height = JDL_height;
    self.frame = frame;
}
- (CGFloat)JDL_height {
    return self.frame.size.height;
}

- (CGFloat)JDL_centerX {
    return self.center.x;
}
- (void)setJDL_centerX:(CGFloat)JDL_centerX {
    CGPoint center = self.center;
    center.x = JDL_centerX;
    self.center = center;
}

- (CGFloat)JDL_centerY {
    return self.center.y;
}
- (void)setJDL_centerY:(CGFloat)JDL_centerY {
    CGPoint center = self.center;
    center.y = JDL_centerY;
    self.center = center;
}

- (void)setJDL_origin:(CGPoint)JDL_origin {
    CGRect frame = self.frame;
    frame.origin = JDL_origin;
    self.frame = frame;
}
- (CGPoint)JDL_origin {
    return self.frame.origin;
}

- (void)setJDL_size:(CGSize)JDL_size {
    CGRect frame = self.frame;
    frame.size = JDL_size;
    self.frame = frame;
}
- (CGSize)JDL_size {
    return self.frame.size;
}

/// 从 XIB 中加载视图
+ (instancetype)JDL_loadViewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}


@end

