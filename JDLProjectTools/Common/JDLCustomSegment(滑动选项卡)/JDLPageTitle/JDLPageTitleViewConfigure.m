//
//  JDLPageTitleViewConfigure.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/18.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLPageTitleViewConfigure.h"

@implementation JDLPageTitleViewConfigure

+ (instancetype)pageTitleViewConfigure {
    return [[self alloc] init];
}

- (CGFloat)spacingBetweenButtons {
    if (_spacingBetweenButtons <= 0) {
        _spacingBetweenButtons = 20;
    }
    return _spacingBetweenButtons;
}

- (UIFont *)titleFont {
    if (!_titleFont) {
        _titleFont = [UIFont systemFontOfSize:15];
    }
    return _titleFont;
}

- (UIColor *)titleColor {
    if (!_titleColor) {
        _titleColor = [UIColor blackColor];
    }
    return _titleColor;
}

- (UIColor *)titleSelectedColor {
    if (!_titleSelectedColor) {
        _titleSelectedColor = [UIColor redColor];
    }
    return _titleSelectedColor;
}

- (CGFloat)indicatorHeight {
    if (_indicatorHeight <= 0) {
        _indicatorHeight = 2.0f;
    }
    return _indicatorHeight;
}

- (UIColor *)indicatorColor {
    if (!_indicatorColor) {
        _indicatorColor = [UIColor redColor];
    }
    return _indicatorColor;
}

- (CGFloat)indicatorAdditionalWidth {
    if (_indicatorAdditionalWidth <= 0) {
        _indicatorAdditionalWidth = 0;
    }
    return _indicatorAdditionalWidth;
}

- (CGFloat)indicatorAnimationTime {
    if (_indicatorAnimationTime <= 0) {
        _indicatorAnimationTime = 0.1;
    } else if (_indicatorAnimationTime > 0.3) {
        _indicatorAnimationTime = 0.3;
    }
    return _indicatorAnimationTime;
}

- (CGFloat)indicatorCornerRadius {
    if (_indicatorCornerRadius <= 0) {
        _indicatorCornerRadius = 0;
    }
    return _indicatorCornerRadius;
}

- (CGFloat)indicatorBorderWidth {
    if (_indicatorBorderWidth <= 0) {
        _indicatorBorderWidth = 0;
    }
    return _indicatorBorderWidth;
}

- (UIColor *)indicatorBorderColor {
    if (!_indicatorBorderColor) {
        _indicatorBorderColor = [UIColor clearColor];
    }
    return _indicatorBorderColor;
}

- (CGFloat)indicatorFixedWidth {
    if (_indicatorFixedWidth <= 0) {
        _indicatorFixedWidth = 20;
    }
    return _indicatorFixedWidth;
}

@end
