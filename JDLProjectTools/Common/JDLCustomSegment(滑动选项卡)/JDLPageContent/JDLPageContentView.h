//
//  JDLPageContentView.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/18.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDLPageContentView;

@protocol JDLPageContentViewDelegate <NSObject>
@optional
/**
 *  联动 JDLPageTitleView 的方法
 *
 *  @param pageContentView      JDLPageContentView
 *  @param progress             JDLPageContentView 内部视图滚动时的偏移量
 *  @param originalIndex        原始视图所在下标
 *  @param targetIndex          目标视图所在下标
 */
- (void)pageContentView:(JDLPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex;
/**
 *  给 JDLPageContentView 所在控制器提供的方法（根据偏移量来处理返回手势的问题）
 *
 *  @param pageContentView     JDLPageContentView
 *  @param offsetX             JDLPageContentView 内部视图的偏移量
 */
- (void)pageContentView:(JDLPageContentView *)pageContentView offsetX:(CGFloat)offsetX;
@end

@interface JDLPageContentView : UIView
/**
 *  对象方法创建 JDLPageContentView
 *
 *  @param frame        frame
 *  @param parentVC     当前控制器
 *  @param childVCs     子控制器个数
 */
- (instancetype)initWithFrame:(CGRect)frame parentVC:(UIViewController *)parentVC childVCs:(NSArray *)childVCs;
/**
 *  类方法创建 JDLPageContentView
 *
 *  @param frame        frame
 *  @param parentVC     当前控制器
 *  @param childVCs     子控制器个数
 */
+ (instancetype)pageContentViewWithFrame:(CGRect)frame parentVC:(UIViewController *)parentVC childVCs:(NSArray *)childVCs;

/** JDLPageContentViewDelegate */
@property (nonatomic, weak) id<JDLPageContentViewDelegate> delegatePageContentView;
/** 是否需要滚动 JDLPageContentView 默认为 YES；设为 NO 时，不必设置 JDLPageContentView 的代理及代理方法 */
@property (nonatomic, assign) BOOL isScrollEnabled;

/** 给外界提供的方法，获取 JDLPageTitleView 选中按钮的下标 */
- (void)setPageCententViewCurrentIndex:(NSInteger)currentIndex;

@end

