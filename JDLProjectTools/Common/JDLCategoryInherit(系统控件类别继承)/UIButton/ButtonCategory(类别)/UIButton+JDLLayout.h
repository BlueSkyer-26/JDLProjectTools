//
//  UIButton+JDLLayout.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/12.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 *  类别  实现button的image和文字的排版
 *示例
     button.titleRect = CGRectMake(10, 10, 120, 20);  正常的frame布局
     button.imageRect = CGRectMake(135, 10, 20, 20);  正常的frame布局
 */

@interface UIButton (JDLLayout)
@property (nonatomic,assign) CGRect titleRect;
@property (nonatomic,assign) CGRect imageRect;
@end
