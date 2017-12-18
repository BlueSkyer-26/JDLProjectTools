//
//  JDLPageTitleView.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/18.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JDLPageTitleViewConfigure, JDLPageTitleView;

@protocol JDLPageTitleViewDelegate <NSObject>
/**
 *  联动 pageContent 的方法
 *
 *  @param pageTitleView      JDLPageTitleView
 *  @param selectedIndex      选中按钮的下标
 */
- (void)pageTitleView:(JDLPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex;
@end

@interface JDLPageTitleView : UIView
/**
 *  对象方法创建 JDLPageTitleView
 *
 *  @param frame     frame
 *  @param delegate     delegate
 *  @param titleNames     标题数组
 *  @param configure        JDLPageTitleView 信息配置
 */
- (instancetype)initWithFrame:(CGRect)frame delegate:(id<JDLPageTitleViewDelegate>)delegate titleNames:(NSArray *)titleNames configure:(JDLPageTitleViewConfigure *)configure;
/**
 *  类方法创建 JDLPageTitleView
 *
 *  @param frame     frame
 *  @param delegate     delegate
 *  @param titleNames     标题数组
 *  @param configure        JDLPageTitleView 信息配置
 */
+ (instancetype)pageTitleViewWithFrame:(CGRect)frame delegate:(id<JDLPageTitleViewDelegate>)delegate titleNames:(NSArray *)titleNames configure:(JDLPageTitleViewConfigure *)configure;

/** JDLPageTitleView 是否需要弹性效果，默认为 YES */
@property (nonatomic, assign) BOOL isNeedBounces;
/** 选中标题按钮下标，默认为 0 */
@property (nonatomic, assign) NSInteger selectedIndex;
/** 重置选中标题按钮下标（用于子控制器内的点击事件改变标题的选中下标）*/
@property (nonatomic, assign) NSInteger resetSelectedIndex;
/** 是否让标题按钮文字有渐变效果，默认为 YES */
@property (nonatomic, assign) BOOL isTitleGradientEffect;
/** 是否开启标题按钮文字缩放效果，默认为 NO */
@property (nonatomic, assign) BOOL isOpenTitleTextZoom;
/** 标题文字缩放比，默认为 0.1f，取值范围 0 ～ 0.3f */
@property (nonatomic, assign) CGFloat titleTextScaling;
/** 是否显示指示器，默认为 YES */
@property (nonatomic, assign) BOOL isShowIndicator;
/** 是否显示底部分割线，默认为 YES */
@property (nonatomic, assign) BOOL isShowBottomSeparator;

/** 给外界提供的方法，获取 JDLPageContentView 的 progress／originalIndex／targetIndex, 必须实现 */
- (void)setPageTitleViewWithProgress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex;

/** 根据下标重置标题文字（index 标题所对应的下标值、title 新的标题名）*/
- (void)resetTitleWithIndex:(NSInteger)index newTitle:(NSString *)title;

@end
