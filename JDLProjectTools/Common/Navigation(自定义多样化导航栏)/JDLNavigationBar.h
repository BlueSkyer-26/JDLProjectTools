//
//  JDLNavigationBar.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/13.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDLCustomNavigationBar;

@interface JDLNavigationBar : UIView
+ (BOOL)isIphoneX;
+ (int)navBarBottom;
+ (int)tabBarHeight;
+ (int)screenWidth;
+ (int)screenHeight;
@end

/*
     需在appdelagate中统一配置初始样式
 */
#pragma mark - Default
@interface JDLNavigationBar (JDLDefault)

/** set default barTintColor of UINavigationBar */
+ (void)JDL_setDefaultNavBarBarTintColor:(UIColor *)color;

/** set default barBackgroundImage of UINavigationBar */
/** warning: JDL_setDefaultNavBarBackgroundImage is deprecated! place use JDLCustomNavigationBar */
//+ (void)JDL_setDefaultNavBarBackgroundImage:(UIImage *)image;

/** set default tintColor of UINavigationBar */
+ (void)JDL_setDefaultNavBarTintColor:(UIColor *)color;

/** set default titleColor of UINavigationBar */
+ (void)JDL_setDefaultNavBarTitleColor:(UIColor *)color;

/** set default statusBarStyle of UIStatusBar */
+ (void)JDL_setDefaultStatusBarStyle:(UIStatusBarStyle)style;

/** set default shadowImage isHidden of UINavigationBar */
+ (void)JDL_setDefaultNavBarShadowImageHidden:(BOOL)hidden;

@end



#pragma mark - UINavigationBar
@interface UINavigationBar (JDLAddition) <UINavigationBarDelegate>

/** 设置导航栏所有BarButtonItem的透明度 */
- (void)JDL_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator;

/** 设置导航栏在垂直方向上平移多少距离 */
- (void)JDL_setTranslationY:(CGFloat)translationY;

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)JDL_getTranslationY;

@end




#pragma mark - UIViewController
@interface UIViewController (JDLAddition)

/** record current ViewController navigationBar backgroundImage */
/** warning: JDL_setDefaultNavBarBackgroundImage is deprecated! place use JDLCustomNavigationBar */
//- (void)JDL_setNavBarBackgroundImage:(UIImage *)image;
- (UIImage *)JDL_navBarBackgroundImage;

/** record current ViewController navigationBar barTintColor */
- (void)JDL_setNavBarBarTintColor:(UIColor *)color;
- (UIColor *)JDL_navBarBarTintColor;

/** record current ViewController navigationBar backgroundAlpha */
- (void)JDL_setNavBarBackgroundAlpha:(CGFloat)alpha;
- (CGFloat)JDL_navBarBackgroundAlpha;

/** record current ViewController navigationBar tintColor */
- (void)JDL_setNavBarTintColor:(UIColor *)color;
- (UIColor *)JDL_navBarTintColor;

/** record current ViewController titleColor */
- (void)JDL_setNavBarTitleColor:(UIColor *)color;
- (UIColor *)JDL_navBarTitleColor;

/** record current ViewController statusBarStyle */
- (void)JDL_setStatusBarStyle:(UIStatusBarStyle)style;
- (UIStatusBarStyle)JDL_statusBarStyle;

/** record current ViewController navigationBar shadowImage hidden */
- (void)JDL_setNavBarShadowImageHidden:(BOOL)hidden;
- (BOOL)JDL_navBarShadowImageHidden;

/** record current ViewController custom navigationBar */
/** warning: JDL_setDefaultNavBarBackgroundImage is deprecated! place use JDLCustomNavigationBar */
//- (void)JDL_setCustomNavBar:(JDLCustomNavigationBar *)navBar;

@end

