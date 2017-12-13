//
//  JDLCustomNavigationBar.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/13.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDLCustomNavigationBar : UIView

@property (nonatomic, copy) void(^onClickLeftButton)(void);
@property (nonatomic, copy) void(^onClickRightButton)(void);

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIColor  *titleLabelColor;
@property (nonatomic, strong) UIFont   *titleLabelFont;
@property (nonatomic, strong) UIColor  *barBackgroundColor;
@property (nonatomic, strong) UIImage  *barBackgroundImage;

+ (instancetype)CustomNavigationBar;

- (void)JDL_setBottomLineHidden:(BOOL)hidden;
- (void)JDL_setBackgroundAlpha:(CGFloat)alpha;
- (void)JDL_setTintColor:(UIColor *)color;

// 默认返回事件
//- (void)JDL_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
//- (void)JDL_setLeftButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)JDL_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)JDL_setLeftButtonWithImage:(UIImage *)image;
- (void)JDL_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

//- (void)JDL_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
//- (void)JDL_setRightButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)JDL_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)JDL_setRightButtonWithImage:(UIImage *)image;
- (void)JDL_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;



@end



