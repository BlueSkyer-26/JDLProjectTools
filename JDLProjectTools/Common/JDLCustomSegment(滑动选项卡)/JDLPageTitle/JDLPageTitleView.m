//
//  JDLPageTitleView.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/18.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//


#import "JDLPageTitleView.h"
#import "UIView+JDLFrame.h"
#import "JDLPageTitleViewConfigure.h"

#define JDLPageTitleViewWidth self.frame.size.width
#define JDLPageTitleViewHeight self.frame.size.height

#pragma mark - - - JDLPageTitleButton
@interface JDLPageTitleButton : UIButton
@end
@implementation JDLPageTitleButton
- (void)setHighlighted:(BOOL)highlighted {
    
}
@end

#pragma mark - - - JDLPageTitleView
@interface JDLPageTitleView ()
/// JDLPageTitleViewDelegate
@property (nonatomic, weak) id<JDLPageTitleViewDelegate> delegatePageTitleView;
/// JDLPageTitleViewConfigure
@property (nonatomic, strong) JDLPageTitleViewConfigure *configure;
/// scrollView
@property (nonatomic, strong) UIScrollView *scrollView;
/// 指示器
@property (nonatomic, strong) UIView *indicatorView;
/// 底部分割线
@property (nonatomic, strong) UIView *bottomSeparator;
/// 保存外界传递过来的标题数组
@property (nonatomic, strong) NSArray *titleArr;
/// 存储标题按钮的数组
@property (nonatomic, strong) NSMutableArray *btnMArr;
/// tempBtn
@property (nonatomic, strong) UIButton *tempBtn;
/// 记录所有按钮文字宽度
@property (nonatomic, assign) CGFloat allBtnTextWidth;
/// 记录所有子控件的宽度
@property (nonatomic, assign) CGFloat allBtnWidth;
/// 标记按钮下标
@property (nonatomic, assign) NSInteger signBtnIndex;

/// 开始颜色, 取值范围 0~1
@property (nonatomic, assign) CGFloat startR;
@property (nonatomic, assign) CGFloat startG;
@property (nonatomic, assign) CGFloat startB;
/// 完成颜色, 取值范围 0~1
@property (nonatomic, assign) CGFloat endR;
@property (nonatomic, assign) CGFloat endG;
@property (nonatomic, assign) CGFloat endB;
@end

@implementation JDLPageTitleView

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<JDLPageTitleViewDelegate>)delegate titleNames:(NSArray *)titleNames configure:(JDLPageTitleViewConfigure *)configure {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.77];
        if (delegate == nil) {
            @throw [NSException exceptionWithName:@"JDLPagingView" reason:@"JDLPageTitleView 的代理方法必须设置" userInfo:nil];
        }
        self.delegatePageTitleView = delegate;
        if (titleNames == nil) {
            @throw [NSException exceptionWithName:@"JDLPagingView" reason:@"JDLPageTitleView 的标题数组必须设置" userInfo:nil];
        }
        self.titleArr = titleNames;
        if (configure == nil) {
            @throw [NSException exceptionWithName:@"JDLPagingView" reason:@"JDLPageTitleView 的配置属性必须设置" userInfo:nil];
        }
        self.configure = configure;
        
        [self initialization];
        [self setupSubviews];
    }
    return self;
}
+ (instancetype)pageTitleViewWithFrame:(CGRect)frame delegate:(id<JDLPageTitleViewDelegate>)delegate titleNames:(NSArray *)titleNames configure:(JDLPageTitleViewConfigure *)configure {
    return [[self alloc] initWithFrame:frame delegate:delegate titleNames:titleNames configure:configure];
}

- (void)initialization {
    _isTitleGradientEffect = YES;
    _isOpenTitleTextZoom = NO;
    _isShowIndicator = YES;
    _isNeedBounces = YES;
    _isShowBottomSeparator = YES;
    
    _selectedIndex = 0;
    _titleTextScaling = 0.1;
}

- (void)setupSubviews {
    // 0、处理偏移量
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:tempView];
    // 1、添加 UIScrollView
    [self addSubview:self.scrollView];
    // 2、添加标题按钮
    [self setupTitleButtons];
    // 3、添加底部分割线
    [self addSubview:self.bottomSeparator];
    // 4、添加指示器
    [self.scrollView insertSubview:self.indicatorView atIndex:0];
}

#pragma mark - - - layoutSubviews
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 选中按钮下标初始值
    UIButton *lastBtn = self.btnMArr.lastObject;
    if (lastBtn.tag >= _selectedIndex && _selectedIndex >= 0) {
        [self P_btn_action:self.btnMArr[_selectedIndex]];
    } else {
        return;
    }
}

#pragma mark - - - 懒加载
- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = [NSArray array];
    }
    return _titleArr;
}

- (NSMutableArray *)btnMArr {
    if (!_btnMArr) {
        _btnMArr = [NSMutableArray array];
    }
    return _btnMArr;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.frame = CGRectMake(0, 0, JDLPageTitleViewWidth, JDLPageTitleViewHeight);
    }
    return _scrollView;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        if (self.configure.indicatorStyle == JDLIndicatorStyleCover) {
            CGFloat tempIndicatorViewH = [self JDL_heightWithString:[self.btnMArr[0] currentTitle] font:self.configure.titleFont];
            if (self.configure.indicatorHeight > self.JDL_height) {
                _indicatorView.JDL_y = 0;
                _indicatorView.JDL_height = self.JDL_height;
            } else if (self.configure.indicatorHeight < tempIndicatorViewH) {
                _indicatorView.JDL_y = 0.5 * (self.JDL_height - tempIndicatorViewH);
                _indicatorView.JDL_height = tempIndicatorViewH;
            } else {
                _indicatorView.JDL_y = 0.5 * (self.JDL_height - self.configure.indicatorHeight);
                _indicatorView.JDL_height = self.configure.indicatorHeight;
            }
            
            // 圆角处理
            if (self.configure.indicatorCornerRadius > 0.5 * _indicatorView.JDL_height) {
                _indicatorView.layer.cornerRadius = 0.5 * _indicatorView.JDL_height;
            } else {
                _indicatorView.layer.cornerRadius = self.configure.indicatorCornerRadius;
            }
            
            // 边框宽度及边框颜色
            _indicatorView.layer.borderWidth = self.configure.indicatorBorderWidth;
            _indicatorView.layer.borderColor = self.configure.indicatorBorderColor.CGColor;
            
        } else {
            CGFloat indicatorViewH = self.configure.indicatorHeight;
            _indicatorView.JDL_height = indicatorViewH;
            _indicatorView.JDL_y = self.JDL_height - indicatorViewH;
        }
        _indicatorView.backgroundColor = self.configure.indicatorColor;
    }
    return _indicatorView;
}

- (UIView *)bottomSeparator {
    if (!_bottomSeparator) {
        _bottomSeparator = [[UIView alloc] init];
        CGFloat bottomSeparatorW = self.JDL_width;
        CGFloat bottomSeparatorH = 0.5;
        CGFloat bottomSeparatorX = 0;
        CGFloat bottomSeparatorY = self.JDL_height - bottomSeparatorH;
        _bottomSeparator.frame = CGRectMake(bottomSeparatorX, bottomSeparatorY, bottomSeparatorW, bottomSeparatorH);
        _bottomSeparator.backgroundColor = [UIColor lightGrayColor];
    }
    return _bottomSeparator;
}

#pragma mark - - - 计算字符串宽度
- (CGFloat)JDL_widthWithString:(NSString *)string font:(UIFont *)font {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
}
- (CGFloat)JDL_heightWithString:(NSString *)string font:(UIFont *)font {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [string boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.height;
}

#pragma mark - - - 添加标题按钮
- (void)setupTitleButtons {
    // 计算所有按钮的文字宽度
    [self.titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat tempWidth = [self JDL_widthWithString:obj font:self.configure.titleFont];
        self.allBtnTextWidth += tempWidth;
    }];
    // 所有按钮文字宽度 ＋ 按钮之间的间隔
    self.allBtnWidth = self.configure.spacingBetweenButtons * (self.titleArr.count + 1) + self.allBtnTextWidth;
    self.allBtnWidth = ceilf(self.allBtnWidth);
    
    NSInteger titleCount = self.titleArr.count;
    if (self.allBtnWidth <= self.bounds.size.width) { /// JDLPageTitleView 不可滚动
        CGFloat btnY = 0;
        CGFloat btnW = JDLPageTitleViewWidth / self.titleArr.count;
        CGFloat btnH = 0;
        if (self.configure.indicatorStyle == JDLIndicatorStyleDefault) {
            btnH = JDLPageTitleViewHeight - self.configure.indicatorHeight;
        } else {
            btnH = JDLPageTitleViewHeight;
        }
        for (NSInteger index = 0; index < titleCount; index++) {
            JDLPageTitleButton *btn = [[JDLPageTitleButton alloc] init];
            CGFloat btnX = btnW * index;
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            btn.tag = index;
            btn.titleLabel.font = self.configure.titleFont;
            [btn setTitle:self.titleArr[index] forState:(UIControlStateNormal)];
            [btn setTitleColor:self.configure.titleColor forState:(UIControlStateNormal)];
            [btn setTitleColor:self.configure.titleSelectedColor forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(P_btn_action:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.btnMArr addObject:btn];
            [self.scrollView addSubview:btn];
            
            [self setupStartColor:self.configure.titleColor];
            [self setupEndColor:self.configure.titleSelectedColor];
        }
        self.scrollView.contentSize = CGSizeMake(JDLPageTitleViewWidth, JDLPageTitleViewHeight);
        
    } else { /// JDLPageTitleView 可滚动
        CGFloat btnX = 0;
        CGFloat btnY = 0;
        CGFloat btnH = 0;
        if (self.configure.indicatorStyle == JDLIndicatorStyleDefault) {
            btnH = JDLPageTitleViewHeight - self.configure.indicatorHeight;
        } else {
            btnH = JDLPageTitleViewHeight;
        }
        for (NSInteger index = 0; index < titleCount; index++) {
            JDLPageTitleButton *btn = [[JDLPageTitleButton alloc] init];
            CGFloat btnW = [self JDL_widthWithString:self.titleArr[index] font:self.configure.titleFont] + self.configure.spacingBetweenButtons;
            btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
            btnX = btnX + btnW;
            btn.tag = index;
            btn.titleLabel.font = self.configure.titleFont;
            [btn setTitle:self.titleArr[index] forState:(UIControlStateNormal)];
            [btn setTitleColor:self.configure.titleColor forState:(UIControlStateNormal)];
            [btn setTitleColor:self.configure.titleSelectedColor forState:(UIControlStateSelected)];
            [btn addTarget:self action:@selector(P_btn_action:) forControlEvents:(UIControlEventTouchUpInside)];
            [self.btnMArr addObject:btn];
            [self.scrollView addSubview:btn];
            
            [self setupStartColor:self.configure.titleColor];
            [self setupEndColor:self.configure.titleSelectedColor];
        }
        
        CGFloat scrollViewWidth = CGRectGetMaxX(self.scrollView.subviews.lastObject.frame);
        self.scrollView.contentSize = CGSizeMake(scrollViewWidth, JDLPageTitleViewHeight);
    }
}

#pragma mark - - - 标题按钮的点击事件
- (void)P_btn_action:(UIButton *)button {
    // 1、改变按钮的选择状态
    [self P_changeSelectedButton:button];
    // 2、滚动标题选中按钮居中
    if (self.allBtnWidth > JDLPageTitleViewWidth) {
        [self P_selectedBtnCenter:button];
    }
    // 3、改变指示器的位置以及指示器宽度样式
    [self P_changeIndicatorViewLocationWithButton:button];
    // 4、pageTitleViewDelegate
    if ([self.delegatePageTitleView respondsToSelector:@selector(pageTitleView:selectedIndex:)]) {
        [self.delegatePageTitleView pageTitleView:self selectedIndex:button.tag];
    }
    // 5、标记按钮下标
    self.signBtnIndex = button.tag;
}

#pragma mark - - - 改变按钮的选择状态
- (void)P_changeSelectedButton:(UIButton *)button {
    if (self.tempBtn == nil) {
        button.selected = YES;
        self.tempBtn = button;
    } else if (self.tempBtn != nil && self.tempBtn == button){
        button.selected = YES;
    } else if (self.tempBtn != button && self.tempBtn != nil){
        self.tempBtn.selected = NO;
        button.selected = YES;
        self.tempBtn = button;
    }
    // 标题文字缩放属性
    if (self.isOpenTitleTextZoom) {
        [self.btnMArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = obj;
            btn.transform = CGAffineTransformMakeScale(1, 1);
        }];
        button.transform = CGAffineTransformMakeScale(1 + self.titleTextScaling, 1 + self.titleTextScaling);
    }
}

#pragma mark - - - 滚动标题选中按钮居中
- (void)P_selectedBtnCenter:(UIButton *)centerBtn {
    // 计算偏移量
    CGFloat offsetX = centerBtn.center.x - JDLPageTitleViewWidth * 0.5;
    if (offsetX < 0) offsetX = 0;
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.scrollView.contentSize.width - JDLPageTitleViewWidth;
    if (offsetX > maxOffsetX) offsetX = maxOffsetX;
    // 滚动标题滚动条
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark - - - 改变指示器的位置以及指示器宽度样式
- (void)P_changeIndicatorViewLocationWithButton:(UIButton *)button {
    [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
        if (self.configure.indicatorStyle == JDLIndicatorStyleFixed) {
            self.indicatorView.JDL_width = self.configure.indicatorFixedWidth;
            self.indicatorView.JDL_centerX = button.JDL_centerX;
            
        } else {
            CGFloat tempIndicatorWidth = self.configure.indicatorAdditionalWidth + [self JDL_widthWithString:button.currentTitle font:self.configure.titleFont];
            if (tempIndicatorWidth > button.JDL_width) {
                tempIndicatorWidth = button.JDL_width;
            }
            self.indicatorView.JDL_width = tempIndicatorWidth;
            self.indicatorView.JDL_centerX = button.JDL_centerX;
        }
    }];
}

#pragma mark - - - 给外界提供的方法
- (void)setPageTitleViewWithProgress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    // 1、取出 originalBtn／targetBtn
    UIButton *originalBtn = self.btnMArr[originalIndex];
    UIButton *targetBtn = self.btnMArr[targetIndex];
    self.signBtnIndex = targetBtn.tag;
    // 2、 滚动标题选中居中
    [self P_selectedBtnCenter:targetBtn];
    // 3、处理指示器的逻辑
    if (self.allBtnWidth <= self.bounds.size.width) { /// JDLPageTitleView 不可滚动
        if (self.configure.indicatorScrollStyle == JDLIndicatorScrollStyleDefault) {
            [self P_smallIndicatorScrollStyleDefaultWithProgress:progress originalBtn:originalBtn targetBtn:targetBtn];
        } else {
            [self P_smallIndicatorScrollStyleHalfEndWithProgress:progress originalBtn:originalBtn targetBtn:targetBtn];
        }
        
    } else { /// JDLPageTitleView 可滚动
        if (self.configure.indicatorScrollStyle == JDLIndicatorScrollStyleDefault) {
            [self P_indicatorScrollStyleDefaultWithProgress:progress originalBtn:originalBtn targetBtn:targetBtn];
        } else {
            [self P_indicatorScrollStyleHalfEndWithProgress:progress originalBtn:originalBtn targetBtn:targetBtn];
        }
    }
    // 4、颜色的渐变(复杂)
    if (self.isTitleGradientEffect) {
        [self P_isTitleGradientEffectWithProgress:progress originalBtn:originalBtn targetBtn:targetBtn];
    }
    // 5 、标题文字缩放属性
    if (self.isOpenTitleTextZoom) {
        // 左边缩放
        originalBtn.transform = CGAffineTransformMakeScale((1 - progress) * self.titleTextScaling + 1, (1 - progress) * self.titleTextScaling + 1);
        // 右边缩放
        targetBtn.transform = CGAffineTransformMakeScale(progress * self.titleTextScaling + 1, progress * self.titleTextScaling + 1);
    }
}
/**
 *  根据下标重置标题文字
 *
 *  @param index 标题所对应的下标
 *  @param title 新标题名
 */
- (void)resetTitleWithIndex:(NSInteger)index newTitle:(NSString *)title {
    if (index < self.btnMArr.count) {
        UIButton *button = (UIButton *)self.btnMArr[index];
        [button setTitle:title forState:UIControlStateNormal];
        if (self.signBtnIndex == index) {
            if (self.configure.indicatorStyle == JDLIndicatorStyleDefault || self.configure.indicatorStyle == JDLIndicatorStyleCover) {
                CGFloat tempIndicatorWidth = self.configure.indicatorAdditionalWidth + [self JDL_widthWithString:button.currentTitle font:self.configure.titleFont];
                if (tempIndicatorWidth > button.JDL_width) {
                    tempIndicatorWidth = button.JDL_width;
                }
                self.indicatorView.JDL_width = tempIndicatorWidth;
                self.indicatorView.JDL_centerX = button.JDL_centerX;
            }
        }
    }
}

#pragma mark - - - 内部方法 --> P_
/// JDLPageTitleView 不可滚动 - - - JDLIndicatorScrollStyleDefault
- (void)P_smallIndicatorScrollStyleDefaultWithProgress:(CGFloat)progress originalBtn:(UIButton *)originalBtn targetBtn:(UIButton *)targetBtn {
    // 1、改变按钮的选择状态
    if (progress >= 0.8) { /// 此处取 >= 0.8 而不是 1.0 为的是防止用户滚动过快而按钮的选中状态并没有改变
        [self P_changeSelectedButton:targetBtn];
    }
    
    if (self.configure.indicatorStyle == JDLIndicatorStyleFixed) {
        CGFloat targetBtnX = CGRectGetMaxX(targetBtn.frame) - self.configure.indicatorFixedWidth - 0.5 * (self.JDL_width / self.titleArr.count - self.configure.indicatorFixedWidth);
        CGFloat originalBtnX = CGRectGetMaxX(originalBtn.frame) - self.configure.indicatorFixedWidth - 0.5 * (self.JDL_width / self.titleArr.count - self.configure.indicatorFixedWidth);
        CGFloat totalOffsetX = targetBtnX - originalBtnX;
        CGFloat offsetX = totalOffsetX * progress;
        self.indicatorView.JDL_x = originalBtnX + offsetX;
        
    } else {
        CGFloat targetBtnX = CGRectGetMaxX(targetBtn.frame) - [self JDL_widthWithString:targetBtn.currentTitle font:self.configure.titleFont] - 0.5 * (self.JDL_width / self.titleArr.count - [self JDL_widthWithString:targetBtn.currentTitle font:self.configure.titleFont] + self.configure.indicatorAdditionalWidth);
        CGFloat originalBtnX = CGRectGetMaxX(originalBtn.frame) - [self JDL_widthWithString:originalBtn.currentTitle font:self.configure.titleFont] - 0.5 * (self.JDL_width / self.titleArr.count - [self JDL_widthWithString:originalBtn.currentTitle font:self.configure.titleFont] + self.configure.indicatorAdditionalWidth);
        CGFloat totalOffsetX = targetBtnX - originalBtnX;
        
        /// 计算 targetBtn／originalBtn 宽度的差值
        CGFloat targetBtnDistance = (CGRectGetMaxX(targetBtn.frame) - 0.5 * (self.JDL_width / self.titleArr.count - [self JDL_widthWithString:targetBtn.currentTitle font:self.configure.titleFont]));
        CGFloat originalBtnDistance = (CGRectGetMaxX(originalBtn.frame) - 0.5 * (self.JDL_width / self.titleArr.count - [self JDL_widthWithString:originalBtn.currentTitle font:self.configure.titleFont]));
        CGFloat totalDistance = targetBtnDistance - originalBtnDistance;
        
        /// 计算 indicatorView 滚动时 X 的偏移量
        CGFloat offsetX = totalOffsetX * progress;
        /// 计算 indicatorView 滚动时宽度的偏移量
        CGFloat distance = progress * (totalDistance - totalOffsetX);
        
        /// 计算 indicatorView 新的 frame
        self.indicatorView.JDL_x = originalBtnX + offsetX;
        
        CGFloat tempIndicatorWidth = self.configure.indicatorAdditionalWidth + [self JDL_widthWithString:originalBtn.currentTitle font:self.configure.titleFont] + distance;
        if (tempIndicatorWidth >= targetBtn.JDL_width) {
            CGFloat moveTotalX = targetBtn.JDL_origin.x - originalBtn.JDL_origin.x;
            CGFloat moveX = moveTotalX * progress;
            self.indicatorView.JDL_centerX = originalBtn.JDL_centerX + moveX;
        } else {
            self.indicatorView.JDL_width = tempIndicatorWidth;
        }
    }
}

/// JDLPageTitleView 可滚动 - - - JDLIndicatorScrollStyleDefault
- (void)P_indicatorScrollStyleDefaultWithProgress:(CGFloat)progress originalBtn:(UIButton *)originalBtn targetBtn:(UIButton *)targetBtn {
    /// 改变按钮的选择状态
    if (progress >= 0.8) { /// 此处取 >= 0.8 而不是 1.0 为的是防止用户滚动过快而按钮的选中状态并没有改变
        [self P_changeSelectedButton:targetBtn];
    }
    
    if (self.configure.indicatorStyle == JDLIndicatorStyleFixed) {
        CGFloat targetBtnX = CGRectGetMaxX(targetBtn.frame) - self.configure.indicatorFixedWidth - 0.5 * (targetBtn.JDL_width - self.configure.indicatorFixedWidth);
        CGFloat originalBtnX = CGRectGetMaxX(originalBtn.frame) - self.configure.indicatorFixedWidth - 0.5 * (originalBtn.JDL_width - self.configure.indicatorFixedWidth);
        CGFloat totalOffsetX = targetBtnX - originalBtnX;
        CGFloat offsetX = totalOffsetX * progress;
        self.indicatorView.JDL_x = originalBtnX + offsetX;
        
    } else {
        /// 计算 targetBtn／originalBtn 之间的距离
        CGFloat totalOffsetX = targetBtn.JDL_origin.x - originalBtn.JDL_origin.x;
        /// 计算 targetBtn／originalBtn 宽度的差值
        CGFloat totalDistance = CGRectGetMaxX(targetBtn.frame) - CGRectGetMaxX(originalBtn.frame);
        /// 计算 indicatorView 滚动时 X 的偏移量
        CGFloat offsetX = 0.0;
        /// 计算 indicatorView 滚动时宽度的偏移量
        CGFloat distance = 0.0;
        
        CGFloat tempIndicatorWidth = self.configure.indicatorAdditionalWidth + [self JDL_widthWithString:targetBtn.currentTitle font:self.configure.titleFont];
        if (tempIndicatorWidth >= targetBtn.JDL_width) {
            offsetX = totalOffsetX * progress;
            distance = progress * (totalDistance - totalOffsetX);
            self.indicatorView.JDL_x = originalBtn.JDL_origin.x + offsetX;
            self.indicatorView.JDL_width = originalBtn.JDL_width + distance;
        } else {
            offsetX = totalOffsetX * progress + 0.5 * self.configure.spacingBetweenButtons - 0.5 * self.configure.indicatorAdditionalWidth;
            distance = progress * (totalDistance - totalOffsetX) - self.configure.spacingBetweenButtons;
            /// 计算 indicatorView 新的 frame
            self.indicatorView.JDL_x = originalBtn.JDL_origin.x + offsetX;
            self.indicatorView.JDL_width = originalBtn.JDL_width + distance + self.configure.indicatorAdditionalWidth;
        }
    }
}
/// JDLPageTitleView 不可滚动 - - - JDLIndicatorScrollStyleHalf - JDLIndicatorScrollStyleEnd
- (void)P_smallIndicatorScrollStyleHalfEndWithProgress:(CGFloat)progress originalBtn:(UIButton *)originalBtn targetBtn:(UIButton *)targetBtn {
    if (self.configure.indicatorScrollStyle == JDLIndicatorScrollStyleHalf) {
        if (self.configure.indicatorStyle == JDLIndicatorStyleFixed) {
            if (progress >= 0.5) {
                [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
                    self.indicatorView.JDL_centerX = targetBtn.JDL_centerX;
                    [self P_changeSelectedButton:targetBtn];
                }];
            } else {
                [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
                    self.indicatorView.JDL_centerX = originalBtn.JDL_centerX;
                    [self P_changeSelectedButton:originalBtn];
                }];
            }
            return;
        }
        
        /// 指示器默认样式以及遮盖样式处理
        if (progress >= 0.5) {
            CGFloat tempIndicatorWidth = self.configure.indicatorAdditionalWidth + [self JDL_widthWithString:targetBtn.currentTitle font:self.configure.titleFont];
            [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
                if (tempIndicatorWidth >= targetBtn.JDL_width) {
                    self.indicatorView.JDL_width = targetBtn.JDL_width;
                } else {
                    self.indicatorView.JDL_width = tempIndicatorWidth;
                }
                self.indicatorView.JDL_centerX = targetBtn.JDL_centerX;
                [self P_changeSelectedButton:targetBtn];
            }];
        } else {
            CGFloat tempIndicatorWidth = self.configure.indicatorAdditionalWidth + [self JDL_widthWithString:originalBtn.currentTitle font:self.configure.titleFont];
            [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
                if (tempIndicatorWidth >= targetBtn.JDL_width) {
                    self.indicatorView.JDL_width = originalBtn.JDL_width;
                } else {
                    self.indicatorView.JDL_width = tempIndicatorWidth;
                }
                self.indicatorView.JDL_centerX = originalBtn.JDL_centerX;
                [self P_changeSelectedButton:originalBtn];
            }];
        }
        return;
    }
    
    /// 滚动内容结束指示器处理 ____ 指示器默认样式以及遮盖样式处理
    if (self.configure.indicatorStyle == JDLIndicatorStyleFixed) {
        if (progress == 1.0) {
            [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
                self.indicatorView.JDL_centerX = targetBtn.JDL_centerX;
                [self P_changeSelectedButton:targetBtn];
            }];
        } else {
            [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
                self.indicatorView.JDL_centerX = originalBtn.JDL_centerX;
                [self P_changeSelectedButton:originalBtn];
            }];
        }
        return;
    }
    
    if (progress == 1.0) {
        CGFloat tempIndicatorWidth = self.configure.indicatorAdditionalWidth + [self JDL_widthWithString:targetBtn.currentTitle font:self.configure.titleFont];
        [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
            if (tempIndicatorWidth >= targetBtn.JDL_width) {
                self.indicatorView.JDL_width = targetBtn.JDL_width;
            } else {
                self.indicatorView.JDL_width = tempIndicatorWidth;
            }
            self.indicatorView.JDL_centerX = targetBtn.JDL_centerX;
            [self P_changeSelectedButton:targetBtn];
        }];
    } else {
        CGFloat tempIndicatorWidth = self.configure.indicatorAdditionalWidth + [self JDL_widthWithString:originalBtn.currentTitle font:self.configure.titleFont];
        [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
            if (tempIndicatorWidth >= targetBtn.JDL_width) {
                self.indicatorView.JDL_width = originalBtn.JDL_width;
            } else {
                self.indicatorView.JDL_width = tempIndicatorWidth;
            }
            self.indicatorView.JDL_centerX = originalBtn.JDL_centerX;
            [self P_changeSelectedButton:originalBtn];
        }];
    }
}

/// JDLPageTitleView 可滚动 - - - JDLIndicatorScrollStyleHalf - JDLIndicatorScrollStyleEnd
- (void)P_indicatorScrollStyleHalfEndWithProgress:(CGFloat)progress originalBtn:(UIButton *)originalBtn targetBtn:(UIButton *)targetBtn {
    if (self.configure.indicatorScrollStyle == JDLIndicatorScrollStyleHalf) {
        if (self.configure.indicatorStyle == JDLIndicatorStyleFixed) {
            if (progress >= 0.5) {
                [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
                    self.indicatorView.JDL_centerX = targetBtn.JDL_centerX;
                    [self P_changeSelectedButton:targetBtn];
                }];
            } else {
                [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
                    self.indicatorView.JDL_centerX = originalBtn.JDL_centerX;
                    [self P_changeSelectedButton:originalBtn];
                }];
            }
            return;
        }
        
        /// 指示器默认样式以及遮盖样式处理
        if (progress >= 0.5) {
            CGFloat tempIndicatorWidth = self.configure.indicatorAdditionalWidth + [self JDL_widthWithString:targetBtn.currentTitle font:self.configure.titleFont];
            [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
                if (tempIndicatorWidth >= targetBtn.JDL_width) {
                    self.indicatorView.JDL_width = targetBtn.JDL_width;
                } else {
                    self.indicatorView.JDL_width = tempIndicatorWidth;
                }
                self.indicatorView.JDL_centerX = targetBtn.JDL_centerX;
                [self P_changeSelectedButton:targetBtn];
            }];
        } else {
            CGFloat tempIndicatorWidth = self.configure.indicatorAdditionalWidth + [self JDL_widthWithString:originalBtn.currentTitle font:self.configure.titleFont];
            [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
                if (tempIndicatorWidth >= originalBtn.JDL_width) {
                    self.indicatorView.JDL_width = originalBtn.JDL_width;
                } else {
                    self.indicatorView.JDL_width = tempIndicatorWidth;
                }
                self.indicatorView.JDL_centerX = originalBtn.JDL_centerX;
                [self P_changeSelectedButton:originalBtn];
            }];
        }
        return;
    }
    
    /// 滚动内容结束指示器处理 ____ 指示器默认样式以及遮盖样式处理
    if (self.configure.indicatorStyle == JDLIndicatorStyleFixed) {
        if (progress == 1.0) {
            [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
                self.indicatorView.JDL_centerX = targetBtn.JDL_centerX;
                [self P_changeSelectedButton:targetBtn];
            }];
        } else {
            [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
                self.indicatorView.JDL_centerX = originalBtn.JDL_centerX;
                [self P_changeSelectedButton:originalBtn];
            }];
        }
        return;
    }
    
    if (progress == 1.0) {
        CGFloat tempIndicatorWidth = self.configure.indicatorAdditionalWidth + [self JDL_widthWithString:targetBtn.currentTitle font:self.configure.titleFont];
        [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
            if (tempIndicatorWidth >= targetBtn.JDL_width) {
                self.indicatorView.JDL_width = targetBtn.JDL_width;
            } else {
                self.indicatorView.JDL_width = tempIndicatorWidth;
            }
            self.indicatorView.JDL_centerX = targetBtn.JDL_centerX;
            [self P_changeSelectedButton:targetBtn];
        }];
        
    } else {
        CGFloat tempIndicatorWidth = self.configure.indicatorAdditionalWidth + [self JDL_widthWithString:originalBtn.currentTitle font:self.configure.titleFont];
        [UIView animateWithDuration:self.configure.indicatorAnimationTime animations:^{
            if (tempIndicatorWidth >= originalBtn.JDL_width) {
                self.indicatorView.JDL_width = originalBtn.JDL_width;
            } else {
                self.indicatorView.JDL_width = tempIndicatorWidth;
            }
            self.indicatorView.JDL_centerX = originalBtn.JDL_centerX;
            [self P_changeSelectedButton:originalBtn];
        }];
    }
}

#pragma mark - - - 颜色渐变方法抽取
- (void)P_isTitleGradientEffectWithProgress:(CGFloat)progress originalBtn:(UIButton *)originalBtn targetBtn:(UIButton *)targetBtn {
    // 获取 targetProgress
    CGFloat targetProgress = progress;
    // 获取 originalProgress
    CGFloat originalProgress = 1 - targetProgress;
    
    CGFloat r = self.endR - self.startR;
    CGFloat g = self.endG - self.startG;
    CGFloat b = self.endB - self.startB;
    UIColor *originalColor = [UIColor colorWithRed:self.startR +  r * originalProgress  green:self.startG +  g * originalProgress  blue:self.startB +  b * originalProgress alpha:1];
    UIColor *targetColor = [UIColor colorWithRed:self.startR + r * targetProgress green:self.startG + g * targetProgress blue:self.startB + b * targetProgress alpha:1];
    
    // 设置文字颜色渐变
    originalBtn.titleLabel.textColor = originalColor;
    targetBtn.titleLabel.textColor = targetColor;
}

#pragma mark - - - set
- (void)setIsNeedBounces:(BOOL)isNeedBounces {
    _isNeedBounces = isNeedBounces;
    if (isNeedBounces == NO) {
        self.scrollView.bounces = NO;
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    if (selectedIndex) {
        _selectedIndex = selectedIndex;
    }
}

- (void)setResetSelectedIndex:(NSInteger)resetSelectedIndex {
    _resetSelectedIndex = resetSelectedIndex;
    [self P_btn_action:self.btnMArr[resetSelectedIndex]];
}

- (void)setIsTitleGradientEffect:(BOOL)isTitleGradientEffect {
    _isTitleGradientEffect = isTitleGradientEffect;
}

- (void)setIsOpenTitleTextZoom:(BOOL)isOpenTitleTextZoom {
    _isOpenTitleTextZoom = isOpenTitleTextZoom;
}

- (void)setTitleTextScaling:(CGFloat)titleTextScaling {
    _titleTextScaling = titleTextScaling;
    
    if (titleTextScaling) {
        if (titleTextScaling >= 0.3) {
            _titleTextScaling = 0.3;
        } else {
            _titleTextScaling = 0.1;
        }
    }
}

- (void)setIsShowIndicator:(BOOL)isShowIndicator {
    _isShowIndicator = isShowIndicator;
    if (isShowIndicator == NO) {
        [self.indicatorView removeFromSuperview];
        self.indicatorView = nil;
    }
}

- (void)setIsShowBottomSeparator:(BOOL)isShowBottomSeparator {
    _isShowBottomSeparator = isShowBottomSeparator;
    if (isShowBottomSeparator) {
        
    } else {
        [self.bottomSeparator removeFromSuperview];
        self.bottomSeparator = nil;
    }
}

#pragma mark - - - 颜色设置的计算
/// 开始颜色设置
- (void)setupStartColor:(UIColor *)color {
    CGFloat components[3];
    [self getRGBComponents:components forColor:color];
    self.startR = components[0];
    self.startG = components[1];
    self.startB = components[2];
}
/// 结束颜色设置
- (void)setupEndColor:(UIColor *)color {
    CGFloat components[3];
    [self getRGBComponents:components forColor:color];
    self.endR = components[0];
    self.endG = components[1];
    self.endB = components[2];
}

/**
 *  指定颜色，获取颜色的RGB值
 *
 *  @param components RGB数组
 *  @param color      颜色
 */
- (void)getRGBComponents:(CGFloat [3])components forColor:(UIColor *)color {
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel, 1, 1, 8, 4, rgbColorSpace, 1);
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
}


@end

