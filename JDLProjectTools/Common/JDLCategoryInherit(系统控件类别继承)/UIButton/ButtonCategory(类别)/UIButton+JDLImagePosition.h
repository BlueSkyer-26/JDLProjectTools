//
//  UIButton+JDLImagePosition.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/11.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JDLImagePositionStyle) {
    JDLImagePositionStyleTop, // image在上，label在下
    JDLImagePositionStyleLeft, // image在左，label在右
    JDLImagePositionStyleBottom, // image在下，label在上
    JDLImagePositionStyleRight // image在右，label在左
};

@interface UIButton (JDLImagePosition)

/**
 *  设置图片与文字样式
 *
 *  @param imagePositionStyle     图片位置样式
 *  @param spacing                图片与文字之间的间距
 */
- (void)JDL_imagePositionStyle:(JDLImagePositionStyle)imagePositionStyle spacing:(CGFloat)spacing;


@end
