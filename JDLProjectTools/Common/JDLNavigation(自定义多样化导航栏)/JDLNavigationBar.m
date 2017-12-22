//
//  JDLNavigationBar.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/13.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//


#import "JDLNavigationBar.h"
#import <objc/runtime.h>

@implementation JDLNavigationBar

+ (BOOL)isIphoneX
{
    if (CGRectEqualToRect([UIScreen mainScreen].bounds,CGRectMake(0, 0, 375, 812))) {
        return YES;
    } else {
        return NO;
    }
}
+ (int)navBarBottom {
    return [self isIphoneX] ? 88 : 64;
}
+ (int)tabBarHeight {
    return [self isIphoneX] ? 83 : 49;
}
+ (int)screenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}
+ (int)screenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

@end


//===============================================================================================
#pragma mark - default navigationBar barTintColor、tintColor and statusBarStyle YOU CAN CHANGE!!!
//===============================================================================================
@implementation JDLNavigationBar (JDLDefault)

static char kJDLDefaultNavBarBarTintColorKey;
static char kJDLDefaultNavBarBackgroundImageKey;
static char kJDLDefaultNavBarTintColorKey;
static char kJDLDefaultNavBarTitleColorKey;
static char kJDLDefaultStatusBarStyleKey;
static char kJDLDefaultNavBarShadowImageHiddenKey;

+ (UIColor *)defaultNavBarBarTintColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kJDLDefaultNavBarBarTintColorKey);
    return (color != nil) ? color : [UIColor whiteColor];
}
+ (void)JDL_setDefaultNavBarBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kJDLDefaultNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIImage *)defaultNavBarBackgroundImage
{
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kJDLDefaultNavBarBackgroundImageKey);
    return image;
}
+ (void)JDL_setDefaultNavBarBackgroundImage:(UIImage *)image {
    objc_setAssociatedObject(self, &kJDLDefaultNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTintColor {
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kJDLDefaultNavBarTintColorKey);
    return (color != nil) ? color : [UIColor colorWithRed:0 green:0.478431 blue:1 alpha:1.0];
}
+ (void)JDL_setDefaultNavBarTintColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kJDLDefaultNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIColor *)defaultNavBarTitleColor
{
    UIColor *color = (UIColor *)objc_getAssociatedObject(self, &kJDLDefaultNavBarTitleColorKey);
    return (color != nil) ? color : [UIColor blackColor];
}
+ (void)JDL_setDefaultNavBarTitleColor:(UIColor *)color {
    objc_setAssociatedObject(self, &kJDLDefaultNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (UIStatusBarStyle)defaultStatusBarStyle
{
    id style = objc_getAssociatedObject(self, &kJDLDefaultStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : UIStatusBarStyleDefault;
}
+ (void)JDL_setDefaultStatusBarStyle:(UIStatusBarStyle)style {
    objc_setAssociatedObject(self, &kJDLDefaultStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (BOOL)defaultNavBarShadowImageHidden {
    id hidden = objc_getAssociatedObject(self, &kJDLDefaultNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : NO;
}
+ (void)JDL_setDefaultNavBarShadowImageHidden:(BOOL)hidden {
    objc_setAssociatedObject(self, &kJDLDefaultNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (CGFloat)defaultNavBarBackgroundAlpha {
    return 1.0;
}

+ (UIColor *)middleColor:(UIColor *)fromColor toColor:(UIColor *)toColor percent:(CGFloat)percent
{
    CGFloat fromRed = 0;
    CGFloat fromGreen = 0;
    CGFloat fromBlue = 0;
    CGFloat fromAlpha = 0;
    [fromColor getRed:&fromRed green:&fromGreen blue:&fromBlue alpha:&fromAlpha];
    
    CGFloat toRed = 0;
    CGFloat toGreen = 0;
    CGFloat toBlue = 0;
    CGFloat toAlpha = 0;
    [toColor getRed:&toRed green:&toGreen blue:&toBlue alpha:&toAlpha];
    
    CGFloat neJDLed = fromRed + (toRed - fromRed) * percent;
    CGFloat newGreen = fromGreen + (toGreen - fromGreen) * percent;
    CGFloat newBlue = fromBlue + (toBlue - fromBlue) * percent;
    CGFloat newAlpha = fromAlpha + (toAlpha - fromAlpha) * percent;
    return [UIColor colorWithRed:neJDLed green:newGreen blue:newBlue alpha:newAlpha];
}
+ (CGFloat)middleAlpha:(CGFloat)fromAlpha toAlpha:(CGFloat)toAlpha percent:(CGFloat)percent {
    return fromAlpha + (toAlpha - fromAlpha) * percent;
}

@end


//==========================================================================
#pragma mark - UINavigationBar
//==========================================================================
@implementation UINavigationBar (JDLAddition)

static char kJDLBackgroundViewKey;
static char kJDLBackgroundImageViewKey;
static char kJDLBackgroundImageKey;

- (UIView *)backgroundView {
    return (UIView *)objc_getAssociatedObject(self, &kJDLBackgroundViewKey);
}
- (void)setBackgroundView:(UIView *)backgroundView {
    objc_setAssociatedObject(self, &kJDLBackgroundViewKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)backgroundImageView {
    return (UIImageView *)objc_getAssociatedObject(self, &kJDLBackgroundImageViewKey);
}
- (void)setBackgroundImageView:(UIImageView *)bgImageView {
    objc_setAssociatedObject(self, &kJDLBackgroundImageViewKey, bgImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIImage *)backgroundImage {
    return (UIImage *)objc_getAssociatedObject(self, &kJDLBackgroundImageKey);
}
- (void)setBackgroundImage:(UIImage *)image {
    objc_setAssociatedObject(self, &kJDLBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// set navigationBar backgroundImage
- (void)JDL_setBackgroundImage:(UIImage *)image
{
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    if (self.backgroundImageView == nil)
    {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        if (self.subviews.count > 0)
        {
            self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), [JDLNavigationBar navBarBottom])];
            self.backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
            
            // _UIBarBackground is first subView for navigationBar
            [self.subviews.firstObject insertSubview:self.backgroundImageView atIndex:0];
        }
    }
    self.backgroundImage = image;
    self.backgroundImageView.image = image;
}

// set navigationBar barTintColor
- (void)JDL_setBackgroundColor:(UIColor *)color
{
    [self.backgroundImageView removeFromSuperview];
    self.backgroundImageView = nil;
    self.backgroundImage = nil;
    if (self.backgroundView == nil)
    {
        // add a image(nil color) to _UIBarBackground make it clear
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), [JDLNavigationBar navBarBottom])];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        // _UIBarBackground is first subView for navigationBar
        [self.subviews.firstObject insertSubview:self.backgroundView atIndex:0];
    }
    self.backgroundView.backgroundColor = color;
}

// set _UIBarBackground alpha (_UIBarBackground subviews alpha <= _UIBarBackground alpha)
- (void)JDL_setBackgroundAlpha:(CGFloat)alpha
{
    UIView *barBackgroundView = self.subviews.firstObject;
    if (@available(iOS 11.0, *))
    {   // sometimes we can't change _UIBarBackground alpha
        for (UIView *view in barBackgroundView.subviews) {
            view.alpha = alpha;
        }
    } else {
        barBackgroundView.alpha = alpha;
    }
}

- (void)JDL_setBarButtonItemsAlpha:(CGFloat)alpha hasSystemBackIndicator:(BOOL)hasSystemBackIndicator
{
    for (UIView *view in self.subviews)
    {
        if (hasSystemBackIndicator == YES)
        {
            // _UIBarBackground/_UINavigationBarBackground对应的view是系统导航栏，不需要改变其透明度
            Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
            if (_UIBarBackgroundClass != nil)
            {
                if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                    view.alpha = alpha;
                }
            }
            
            Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
            if (_UINavigationBarBackground != nil)
            {
                if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                    view.alpha = alpha;
                }
            }
        }
        else
        {
            // 这里如果不做判断的话，会显示 backIndicatorImage
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")] == NO)
            {
                Class _UIBarBackgroundClass = NSClassFromString(@"_UIBarBackground");
                if (_UIBarBackgroundClass != nil)
                {
                    if ([view isKindOfClass:_UIBarBackgroundClass] == NO) {
                        view.alpha = alpha;
                    }
                }
                
                Class _UINavigationBarBackground = NSClassFromString(@"_UINavigationBarBackground");
                if (_UINavigationBarBackground != nil)
                {
                    if ([view isKindOfClass:_UINavigationBarBackground] == NO) {
                        view.alpha = alpha;
                    }
                }
            }
        }
    }
}

// 设置导航栏在垂直方向上平移多少距离
- (void)JDL_setTranslationY:(CGFloat)translationY {
    // CGAffineTransformMakeTranslation  平移
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

/** 获取当前导航栏在垂直方向上偏移了多少 */
- (CGFloat)JDL_getTranslationY {
    return self.transform.ty;
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      SEL needSwizzleSelectors[1] = {
                          @selector(setTitleTextAttributes:)
                      };
                      
                      for (int i = 0; i < 1;  i++) {
                          SEL selector = needSwizzleSelectors[i];
                          NSString *newSelectorStr = [NSString stringWithFormat:@"JDL_%@", NSStringFromSelector(selector)];
                          Method originMethod = class_getInstanceMethod(self, selector);
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (void)JDL_setTitleTextAttributes:(NSDictionary<NSString *,id> *)titleTextAttributes
{
    NSMutableDictionary<NSString *,id> *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    if (newTitleTextAttributes == nil) {
        return;
    }
    
    NSDictionary<NSString *,id> *originTitleTextAttributes = self.titleTextAttributes;
    if (originTitleTextAttributes == nil) {
        [self JDL_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    __block UIColor *titleColor;
    [originTitleTextAttributes enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([key isEqual:NSForegroundColorAttributeName]) {
            titleColor = (UIColor *)obj;
            *stop = YES;
        }
    }];
    
    if (titleColor == nil) {
        [self JDL_setTitleTextAttributes:newTitleTextAttributes];
        return;
    }
    
    if (newTitleTextAttributes[NSForegroundColorAttributeName] == nil) {
        newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    }
    [self JDL_setTitleTextAttributes:newTitleTextAttributes];
}

@end

@interface UIViewController (Addition)
- (void)setPushToCurrentVCFinished:(BOOL)isFinished;
@end

//==========================================================================
#pragma mark - UINavigationController
//==========================================================================
@implementation UINavigationController (JDLAddition)

static CGFloat JDLPopDuration = 0.12;
static int JDLPopDisplayCount = 0;
- (CGFloat)JDLPopProgress
{
    CGFloat all = 60 * JDLPopDuration;
    int current = MIN(all, JDLPopDisplayCount);
    return current / all;
}

static CGFloat JDLPushDuration = 0.10;
static int JDLPushDisplayCount = 0;
- (CGFloat)JDLPushProgress
{
    CGFloat all = 60 * JDLPushDuration;
    int current = MIN(all, JDLPushDisplayCount);
    return current / all;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return [self.topViewController JDL_statusBarStyle];
}

- (void)setNeedsNavigationBarUpdateForBarBackgroundImage:(UIImage *)backgroundImage {
    [self.navigationBar JDL_setBackgroundImage:backgroundImage];
}
- (void)setNeedsNavigationBarUpdateForBarTintColor:(UIColor *)barTintColor {
    [self.navigationBar JDL_setBackgroundColor:barTintColor];
}
- (void)setNeedsNavigationBarUpdateForBarBackgroundAlpha:(CGFloat)barBackgroundAlpha {
    [self.navigationBar JDL_setBackgroundAlpha:barBackgroundAlpha];
}
- (void)setNeedsNavigationBarUpdateForTintColor:(UIColor *)tintColor {
    self.navigationBar.tintColor = tintColor;
}
- (void)setNeedsNavigationBarUpdateForShadowImageHidden:(BOOL)hidden {
    self.navigationBar.shadowImage = (hidden == YES) ? [UIImage new] : nil;
}
- (void)setNeedsNavigationBarUpdateForTitleColor:(UIColor *)titleColor
{
    NSDictionary *titleTextAttributes = [self.navigationBar titleTextAttributes];
    if (titleTextAttributes == nil) {
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:titleColor};
        return;
    }
    NSMutableDictionary *newTitleTextAttributes = [titleTextAttributes mutableCopy];
    newTitleTextAttributes[NSForegroundColorAttributeName] = titleColor;
    self.navigationBar.titleTextAttributes = newTitleTextAttributes;
}

- (void)updateNavigationBarWithFromVC:(UIViewController *)fromVC toVC:(UIViewController *)toVC progress:(CGFloat)progress
{
    // change navBarBarTintColor
    UIColor *fromBarTintColor = [fromVC JDL_navBarBarTintColor];
    UIColor *toBarTintColor = [toVC JDL_navBarBarTintColor];
    UIColor *newBarTintColor = [JDLNavigationBar middleColor:fromBarTintColor toColor:toBarTintColor percent:progress];
    [self setNeedsNavigationBarUpdateForBarTintColor:newBarTintColor];
    
    // change navBarTintColor
    UIColor *fromTintColor = [fromVC JDL_navBarTintColor];
    UIColor *toTintColor = [toVC JDL_navBarTintColor];
    UIColor *newTintColor = [JDLNavigationBar middleColor:fromTintColor toColor:toTintColor percent:progress];
    [self setNeedsNavigationBarUpdateForTintColor:newTintColor];
    
    // change navBarTitleColor（在JDL_popToViewController:animated:方法中直接改变标题颜色）
    //    UIColor *fromTitleColor = [fromVC JDL_navBarTitleColor];
    //    UIColor *toTitleColor = [toVC JDL_navBarTitleColor];
    //    UIColor *newTitleColor = [JDLNavigationBar middleColor:fromTitleColor toColor:toTitleColor percent:progress];
    //    [self setNeedsNavigationBarUpdateForTitleColor:newTitleColor];
    
    // change navBar _UIBarBackground alpha
    CGFloat fromBarBackgroundAlpha = [fromVC JDL_navBarBackgroundAlpha];
    CGFloat toBarBackgroundAlpha = [toVC JDL_navBarBackgroundAlpha];
    CGFloat newBarBackgroundAlpha = [JDLNavigationBar middleAlpha:fromBarBackgroundAlpha toAlpha:toBarBackgroundAlpha percent:progress];
    [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:newBarBackgroundAlpha];
}

#pragma mark - call swizzling methods active 主动调用交换方法
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      SEL needSwizzleSelectors[4] = {
                          NSSelectorFromString(@"_updateInteractiveTransition:"),
                          @selector(popToViewController:animated:),
                          @selector(popToRootViewControllerAnimated:),
                          @selector(pushViewController:animated:)
                      };
                      
                      for (int i = 0; i < 4;  i++) {
                          SEL selector = needSwizzleSelectors[i];
                          NSString *newSelectorStr = [[NSString stringWithFormat:@"JDL_%@", NSStringFromSelector(selector)] stringByReplacingOccurrencesOfString:@"__" withString:@"_"];
                          Method originMethod = class_getInstanceMethod(self, selector);
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (NSArray<UIViewController *> *)JDL_popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{   // pop 的时候导航栏标题颜色直接改变
    [self setNeedsNavigationBarUpdateForTitleColor:[viewController JDL_navBarTitleColor]];
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        JDLPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:JDLPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self JDL_popToViewController:viewController animated:animated];
    [CATransaction commit];
    return vcs;
}

- (NSArray<UIViewController *> *)JDL_popToRootViewControllerAnimated:(BOOL)animated
{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(popNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        JDLPopDisplayCount = 0;
    }];
    [CATransaction setAnimationDuration:JDLPopDuration];
    [CATransaction begin];
    NSArray<UIViewController *> *vcs = [self JDL_popToRootViewControllerAnimated:animated];
    [CATransaction commit];
    return vcs;
}

// change navigationBar barTintColor smooth before pop to current VC finished
- (void)popNeedDisplay
{
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil)
    {
        JDLPopDisplayCount += 1;
        CGFloat popProgress = [self JDLPopProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:popProgress];
    }
}

- (void)JDL_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    __block CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(pushNeedDisplay)];
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [CATransaction setCompletionBlock:^{
        [displayLink invalidate];
        displayLink = nil;
        JDLPushDisplayCount = 0;
        [viewController setPushToCurrentVCFinished:YES];
    }];
    [CATransaction setAnimationDuration:JDLPushDuration];
    [CATransaction begin];
    [self JDL_pushViewController:viewController animated:animated];
    [CATransaction commit];
}

// change navigationBar barTintColor smooth before push to current VC finished or before pop to current VC finished
- (void)pushNeedDisplay
{
    if (self.topViewController != nil && self.topViewController.transitionCoordinator != nil)
    {
        JDLPushDisplayCount += 1;
        CGFloat pushProgress = [self JDLPushProgress];
        UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
        UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
        [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:pushProgress];
    }
}

#pragma mark - deal the gesture of return
- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
    __weak typeof (self) weakSelf = self;
    id<UIViewControllerTransitionCoordinator> coor = [self.topViewController transitionCoordinator];
    if ([coor initiallyInteractive] == YES)
    {
        NSString *sysVersion = [[UIDevice currentDevice] systemVersion];
        if ([sysVersion floatValue] >= 10)
        {
            [coor notifyWhenInteractionChangesUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        else
        {
            [coor notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
                __strong typeof (self) pThis = weakSelf;
                [pThis dealInteractionChanges:context];
            }];
        }
        return YES;
    }
    
    NSUInteger itemCount = self.navigationBar.items.count;
    NSUInteger n = self.viewControllers.count >= itemCount ? 2 : 1;
    UIViewController *popToVC = self.viewControllers[self.viewControllers.count - n];
    [self popToViewController:popToVC animated:YES];
    return YES;
}

// deal the gesture of return break off
- (void)dealInteractionChanges:(id<UIViewControllerTransitionCoordinatorContext>)context
{
    void (^animations) (UITransitionContextViewControllerKey) = ^(UITransitionContextViewControllerKey key){
        UIColor *curColor = [[context viewControllerForKey:key] JDL_navBarBarTintColor];
        CGFloat curAlpha = [[context viewControllerForKey:key] JDL_navBarBackgroundAlpha];
        [self setNeedsNavigationBarUpdateForBarTintColor:curColor];
        [self setNeedsNavigationBarUpdateForBarBackgroundAlpha:curAlpha];
    };
    
    // after that, cancel the gesture of return
    if ([context isCancelled] == YES)
    {
        double cancelDuration = [context transitionDuration] * [context percentComplete];
        [UIView animateWithDuration:cancelDuration animations:^{
            animations(UITransitionContextFromViewControllerKey);
        }];
    }
    else
    {
        // after that, finish the gesture of return
        double finishDuration = [context transitionDuration] * (1 - [context percentComplete]);
        [UIView animateWithDuration:finishDuration animations:^{
            animations(UITransitionContextToViewControllerKey);
        }];
    }
}

- (void)JDL_updateInteractiveTransition:(CGFloat)percentComplete
{
    UIViewController *fromVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [self.topViewController.transitionCoordinator viewControllerForKey:UITransitionContextToViewControllerKey];
    [self updateNavigationBarWithFromVC:fromVC toVC:toVC progress:percentComplete];
    
    [self JDL_updateInteractiveTransition:percentComplete];
}

@end


//==========================================================================
#pragma mark - UIViewController
//==========================================================================
@implementation UIViewController (JDLAddition)

static char kJDLPushToCurrentVCFinishedKey;
static char kJDLPushToNextVCFinishedKey;
static char kJDLNavBarBackgroundImageKey;
static char kJDLNavBarBarTintColorKey;
static char kJDLNavBarBackgroundAlphaKey;
static char kJDLNavBarTintColorKey;
static char kJDLNavBarTitleColorKey;
static char kJDLStatusBarStyleKey;
static char kJDLNavBarShadowImageHiddenKey;
static char kJDLCustomNavBarKey;

// navigationBar barTintColor can not change by currentVC before fromVC push to currentVC finished
- (BOOL)pushToCurrentVCFinished
{
    id isFinished = objc_getAssociatedObject(self, &kJDLPushToCurrentVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToCurrentVCFinished:(BOOL)isFinished {
    objc_setAssociatedObject(self, &kJDLPushToCurrentVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar barTintColor can not change by currentVC when currentVC push to nextVC finished
- (BOOL)pushToNextVCFinished
{
    id isFinished = objc_getAssociatedObject(self, &kJDLPushToNextVCFinishedKey);
    return (isFinished != nil) ? [isFinished boolValue] : NO;
}
- (void)setPushToNextVCFinished:(BOOL)isFinished
{
    objc_setAssociatedObject(self, &kJDLPushToNextVCFinishedKey, @(isFinished), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// navigationBar backgroundImage
- (UIImage *)JDL_navBarBackgroundImage
{
    UIImage *image = (UIImage *)objc_getAssociatedObject(self, &kJDLNavBarBackgroundImageKey);
    image = (image == nil) ? [JDLNavigationBar defaultNavBarBackgroundImage] : image;
    return image;
}
- (void)JDL_setNavBarBackgroundImage:(UIImage *)image
{
    if ([[self JDL_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        //        UINavigationBar *navBar = (UINavigationBar *)[self JDL_customNavBar];
        //        [navBar JDL_setBackgroundImage:image];
    }
    else {
        objc_setAssociatedObject(self, &kJDLNavBarBackgroundImageKey, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

// navigationBar barTintColor
- (UIColor *)JDL_navBarBarTintColor
{
    UIColor *barTintColor = (UIColor *)objc_getAssociatedObject(self, &kJDLNavBarBarTintColorKey);
    return (barTintColor != nil) ? barTintColor : [JDLNavigationBar defaultNavBarBarTintColor];
}
- (void)JDL_setNavBarBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kJDLNavBarBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self JDL_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        //        UINavigationBar *navBar = (UINavigationBar *)[self JDL_customNavBar];
        //        [navBar JDL_setBackgroundColor:color];
    }
    else
    {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:color];
        }
    }
}

// navigationBar _UIBarBackground alpha
- (CGFloat)JDL_navBarBackgroundAlpha
{
    id barBackgroundAlpha = objc_getAssociatedObject(self, &kJDLNavBarBackgroundAlphaKey);
    return (barBackgroundAlpha != nil) ? [barBackgroundAlpha floatValue] : [JDLNavigationBar defaultNavBarBackgroundAlpha];
    
}
- (void)JDL_setNavBarBackgroundAlpha:(CGFloat)alpha
{
    objc_setAssociatedObject(self, &kJDLNavBarBackgroundAlphaKey, @(alpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self JDL_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        //        UINavigationBar *navBar = (UINavigationBar *)[self JDL_customNavBar];
        //        [navBar JDL_setBackgroundAlpha:alpha];
    }
    else
    {
        BOOL isRootViewController = (self.navigationController.viewControllers.firstObject == self);
        if (([self pushToCurrentVCFinished] == YES || isRootViewController == YES) && [self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:alpha];
        }
    }
}

// navigationBar tintColor
- (UIColor *)JDL_navBarTintColor
{
    UIColor *tintColor = (UIColor *)objc_getAssociatedObject(self, &kJDLNavBarTintColorKey);
    return (tintColor != nil) ? tintColor : [JDLNavigationBar defaultNavBarTintColor];
}
- (void)JDL_setNavBarTintColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kJDLNavBarTintColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self JDL_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        //        UINavigationBar *navBar = (UINavigationBar *)[self JDL_customNavBar];
        //        navBar.tintColor = color;
    }
    else
    {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTintColor:color];
        }
    }
}

// navigationBartitleColor
- (UIColor *)JDL_navBarTitleColor
{
    UIColor *titleColor = (UIColor *)objc_getAssociatedObject(self, &kJDLNavBarTitleColorKey);
    return (titleColor != nil) ? titleColor : [JDLNavigationBar defaultNavBarTitleColor];
}
- (void)JDL_setNavBarTitleColor:(UIColor *)color
{
    objc_setAssociatedObject(self, &kJDLNavBarTitleColorKey, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([[self JDL_customNavBar] isKindOfClass:[UINavigationBar class]])
    {
        //        UINavigationBar *navBar = (UINavigationBar *)[self JDL_customNavBar];
        //        navBar.titleTextAttributes = @{NSForegroundColorAttributeName:color};
    }
    else
    {
        if ([self pushToNextVCFinished] == NO) {
            [self.navigationController setNeedsNavigationBarUpdateForTitleColor:color];
        }
    }
}

// statusBarStyle
- (UIStatusBarStyle)JDL_statusBarStyle
{
    id style = objc_getAssociatedObject(self, &kJDLStatusBarStyleKey);
    return (style != nil) ? [style integerValue] : [JDLNavigationBar defaultStatusBarStyle];
}
- (void)JDL_setStatusBarStyle:(UIStatusBarStyle)style
{
    objc_setAssociatedObject(self, &kJDLStatusBarStyleKey, @(style), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setNeedsStatusBarAppearanceUpdate];
}

// shadowImage
- (void)JDL_setNavBarShadowImageHidden:(BOOL)hidden
{
    objc_setAssociatedObject(self, &kJDLNavBarShadowImageHiddenKey, @(hidden), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:hidden];
    
}
- (BOOL)JDL_navBarShadowImageHidden
{
    id hidden = objc_getAssociatedObject(self, &kJDLNavBarShadowImageHiddenKey);
    return (hidden != nil) ? [hidden boolValue] : [JDLNavigationBar defaultNavBarShadowImageHidden];
}

// custom navigationBar
- (UIView *)JDL_customNavBar
{
    UIView *navBar = objc_getAssociatedObject(self, &kJDLCustomNavBarKey);
    return (navBar != nil) ? navBar : [UIView new];
}
- (void)JDL_setCustomNavBar:(UINavigationBar *)navBar
{
    objc_setAssociatedObject(self, &kJDLCustomNavBarKey, navBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                  {
                      SEL needSwizzleSelectors[3] = {
                          @selector(viewWillAppear:),
                          @selector(viewWillDisappear:),
                          @selector(viewDidAppear:)
                      };
                      
                      for (int i = 0; i < 3;  i++) {
                          SEL selector = needSwizzleSelectors[i];
                          NSString *newSelectorStr = [NSString stringWithFormat:@"JDL_%@", NSStringFromSelector(selector)];
                          Method originMethod = class_getInstanceMethod(self, selector);
                          Method swizzledMethod = class_getInstanceMethod(self, NSSelectorFromString(newSelectorStr));
                          method_exchangeImplementations(originMethod, swizzledMethod);
                      }
                  });
}

- (void)JDL_viewWillAppear:(BOOL)animated
{
    if ([self canUpdateNavigationBar] == YES)
    {
        [self setPushToNextVCFinished:NO];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self JDL_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self JDL_navBarTitleColor]];
    }
    [self JDL_viewWillAppear:animated];
}

- (void)JDL_viewWillDisappear:(BOOL)animated
{
    if ([self canUpdateNavigationBar] == YES) {
        [self setPushToNextVCFinished:YES];
    }
    [self JDL_viewWillDisappear:animated];
}

- (void)JDL_viewDidAppear:(BOOL)animated
{
    if ([self canUpdateNavigationBar] == YES)
    {
        UIImage *barBgImage = [self JDL_navBarBackgroundImage];
        if (barBgImage != nil) {
            [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundImage:barBgImage];
        } else {
            [self.navigationController setNeedsNavigationBarUpdateForBarTintColor:[self JDL_navBarBarTintColor]];
        }
        [self.navigationController setNeedsNavigationBarUpdateForBarBackgroundAlpha:[self JDL_navBarBackgroundAlpha]];
        [self.navigationController setNeedsNavigationBarUpdateForTintColor:[self JDL_navBarTintColor]];
        [self.navigationController setNeedsNavigationBarUpdateForTitleColor:[self JDL_navBarTitleColor]];
        [self.navigationController setNeedsNavigationBarUpdateForShadowImageHidden:[self JDL_navBarShadowImageHidden]];
    }
    [self JDL_viewDidAppear:animated];
}

- (BOOL)canUpdateNavigationBar
{
    CGRect viewFrame = self.view.frame;
    CGRect maxFrame = [UIScreen mainScreen].bounds;
    CGRect middleFrame = CGRectMake(0, JDLNavigationBar.navBarBottom, JDLNavigationBar.screenWidth, JDLNavigationBar.screenHeight-JDLNavigationBar.navBarBottom);
    CGRect minFrame = CGRectMake(0, JDLNavigationBar.navBarBottom, JDLNavigationBar.screenWidth, JDLNavigationBar.screenHeight-JDLNavigationBar.navBarBottom-JDLNavigationBar.tabBarHeight);
    // 蝙蝠🦇 （灵机一动：视频通话问题？）
    BOOL isBat = CGRectEqualToRect(viewFrame, maxFrame) || CGRectEqualToRect(viewFrame, middleFrame) || CGRectEqualToRect(viewFrame, minFrame);
    if (self.navigationController && isBat) {
        return YES;
    } else {
        return NO;
    }
}

@end
