//
//  JDLTabBarController.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/11.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLTabBarController.h"
#import "JDLNavigationController.h"

@interface JDLTabBarController ()
//@property (nonatomic, weak) JDLAnimationButton *centerButton;
@property (nonatomic, weak) UIButton *centerButton;
@property (nonatomic,assign) NSInteger indexFlag;
@end

@implementation JDLTabBarController

#pragma mark ------ 统一设置所有的 UITabBarItem 文字属性 -------
+(void)initialize{
    NSMutableDictionary *attrs =[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] =KSYSTEMFONT(11);
    attrs[NSForegroundColorAttributeName] =KGrayColor;
    
    NSMutableDictionary *selectAttrs =[NSMutableDictionary dictionary];
    selectAttrs[NSFontAttributeName] =KSYSTEMFONT(11);
    selectAttrs[NSForegroundColorAttributeName] =KThemeColor;
    
    UITabBarItem *items =[UITabBarItem appearance];
    [items setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [items setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];   // 设置背景图片
//    [[UITabBar appearance] setBackgroundImage:KImageName(@"Icon-40")];   // 设置背景图片
    [[UITabBar appearance] setBackgroundColor:KWhiteAlphaColor(1.0)];    // 设置tabbar背景颜色
//    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
    //去除 TabBar 自带的顶部阴影  去掉顶部黑线
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
}

#pragma mark ------ 初始化 -------
-(instancetype)init{
    if (self =[super init]) {
        self.indexFlag =0;
        [self addChildViewControllers];
        [self addCenterButton];
    }
    return self;
}

#pragma mark ------ 添加所有子控制器 -------
-(void)addChildViewControllers{
    [self addChildViewControllerClassName:@"JDLHomeViewController" title:@"首页" imageName:@"tabbar_home" selectimageName:@"tabbar_home_highlighted"];
    [self addChildViewControllerClassName:@"JDLFoundViewController" title:@"发现" imageName:@"tabbar_discover" selectimageName:@"tabbar_discover_highlighted"];
    [self addChildViewControllerClassName:@"JDLCenterViewController" title:nil imageName:nil selectimageName:nil];
    [self addChildViewControllerClassName:@"JDLMessageViewController" title:@"消息" imageName:@"tabbar_message_center" selectimageName:@"tabbar_message_center_highlighted"];
    [self addChildViewControllerClassName:@"JDLMineViewController" title:@"我的" imageName:@"tabbar_profile" selectimageName:@"tabbar_profile_highlighted"];
}

#pragma mark ------ 设置所有子控制器 -------
-(void)addChildViewControllerClassName:(NSString *)className title:(NSString *)title imageName:(NSString *)imageName selectimageName:(NSString *)selectimageName{
    UIViewController *controller =[[NSClassFromString(className) alloc] init];
//    controller.title =title;
    controller.tabBarItem.title =title;
    controller.view.backgroundColor =KVCBackgroundColor;
    controller.tabBarItem.image =KImageName(imageName);
    controller.tabBarItem.selectedImage =KImageName(selectimageName);
    
    JDLNavigationController *nvc =[[JDLNavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nvc];
}

#pragma mark ------ 添加中间突出按钮 -------
-(void)addCenterButton{
    
    //下面两者任选其一
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"tabBar_publish_icon_highlighted"] forState:UIControlStateSelected];
    [button setTitle:@"" forState:UIControlStateNormal];
    button.backgroundColor =KClearColor;
    [button addTarget:self action:@selector(composeButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.centerButton = button;
    [self.tabBar addSubview:button];
    [self.tabBar bringSubviewToFront:button];
    CGFloat width = self.tabBar.bounds.size.width / self.childViewControllers.count;
    self.tabBar.tintColor = [UIColor colorWithRed:68/255.0 green:173/255.0 blue:159/255.0 alpha:1];
    button.frame = CGRectInset(self.tabBar.bounds, 2 *width, 0);
    button.titleRect = CGRectMake(0, button.frame.size.height *0.5, width, button.frame.size.height *0.5);
    button.imageRect = CGRectMake(width *0.2, (button.frame.size.height -width *0.6) *0.5, width *0.6, width *0.6);
    button.titleLabel.textAlignment =NSTextAlignmentCenter;
    
    
//    JDLAnimationButton *centerButton =[JDLAnimationButton buttonWithType:UIButtonTypeCustom frame:CGRectZero title:@"" titleColor:KThemeColor backgroundColor:KClearColor imageName:@"tabBar_publish_icon" andBlock:^{
//
//        JDLHeadView *view =[[JDLHeadView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight -200)];
//
//        KLCPopup *popView =[JDLPopContentManager showPopContentViewBottom:view];
//        view.clickViewBlock = ^(NSString *str) {
//
//            [popView dismiss:YES];
//        };
//    }];
//    [centerButton setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
//    [centerButton setImage:[UIImage imageNamed:@"tabBar_publish_icon_highlighted"] forState:UIControlStateSelected];
//    centerButton.buttonScale =0.9;
//    centerButton.titleLabel.textAlignment =NSTextAlignmentCenter;
//
//    CGFloat width = self.tabBar.width / self.childViewControllers.count;
//    CGRect frame = CGRectInset(self.tabBar.bounds, 2 *width, 0);
//    centerButton.frame =frame;
//    centerButton.titleRect = CGRectMake(0, centerButton.height *0.5, width, centerButton.height *0.5);
//    centerButton.imageRect = CGRectMake(width *0.17, (centerButton.height -width *0.66) *0.5, width *0.66, width *0.66);
//    centerButton.titleLabel.textAlignment =NSTextAlignmentCenter;
//    [self.tabBar addSubview:centerButton];
//    [self.tabBar bringSubviewToFront:centerButton];
//    self.centerButton =centerButton;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //关键代码 注释掉正常跳转对应的视图   不注释则是执行按钮点击方法
    [self.tabBar bringSubviewToFront:self.centerButton];
}

#pragma mark ------ 点击中间按钮 ------
- (void)composeButtonClick:(UIButton *)button {
    NSLog(@"点击了按钮");
    JDLHeadView *view =[[JDLHeadView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight *0.2)];
    
    KLCPopup *popView =[JDLPopContentManager showPopContentViewBottom:view];
    view.clickViewBlock = ^(NSString *str) {
        
        [popView dismiss:YES];
    };
//    UIViewController  *vc =[[UIViewController alloc] init];
//    vc.view.backgroundColor =[UIColor yellowColor];
//    [self presentViewController:vc animated:YES completion:nil];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    NSInteger index = [self.tabBar.items indexOfObject:item];
    if (self.indexFlag != index) {
        [self animationWithIndex:index];
    }
}

// 动画
- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    UIView *animationView = tabbarbuttonArray[index];
    UIImageView *imageView;
    for (UIView *sub in animationView.subviews) {
        if ([sub isKindOfClass:[UIImageView class]]) {
            imageView = (UIImageView *)sub;
        }
    }
    //缩放
//    [self scaleAnimationWithImageView:imageView];
    //抖动
    [self shakeImageWithImageView:imageView];
    self.indexFlag = index;
}
//抖动
- (void)shakeImageWithImageView:(UIImageView *)imageView {
    //创建动画对象,绕Z轴旋转
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //设置属性，周期时长
    [animation setDuration:0.1];
    //抖动角度
    animation.fromValue = @(-M_1_PI/2);
    animation.toValue = @(M_1_PI/2);
    //重复次数，1次
    animation.repeatCount = 2;
    //恢复原样
    animation.autoreverses = YES;
    //锚点设置为图片中心，绕中心抖动
    imageView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    [imageView.layer addAnimation:animation forKey:@"rotation"];
}
//缩放
- (void)scaleAnimationWithImageView:(UIImageView *)imageView{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@1.5 ,@0.8, @1.0,@1.2,@1.0];
    animation.duration = 0.5;
    animation.calculationMode = kCAAnimationCubic;
    [imageView.layer addAnimation:animation forKey:@"transform.scale"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
