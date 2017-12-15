//
//  JDLNavigationBarViewController.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/13.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLNavigationTabBarController.h"

@implementation JDLNavigationTabBarController

#pragma mark ------ 统一设置所有的 UITabBarItem 文字属性 -------
+(void)initialize{
    NSMutableDictionary *attrs =[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] =KSYSTEMFONT(12);
    attrs[NSForegroundColorAttributeName] =KGrayColor;
    
    NSMutableDictionary *selectAttrs =[NSMutableDictionary dictionary];
    selectAttrs[NSFontAttributeName] =KSYSTEMFONT(12);
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

        [self addChildViewControllers];
    }
    return self;
}

#pragma mark ------ 添加所有子控制器 -------
-(void)addChildViewControllers{
    [self addChildViewControllerClassName:@"JDLCommonNavViewController" title:@"常用" imageName:@"tabbar_home" selectimageName:@"tabbar_home_highlighted"];
    [self addChildViewControllerClassName:@"JDLCustomNavViewController" title:@"自定义导航栏" imageName:@"tabbar_home" selectimageName:@"tabbar_home_highlighted"];
    [self addChildViewControllerClassName:@"JDLMoveNavViewController" title:@"移动导航栏" imageName:@"tabbar_home" selectimageName:@"tabbar_home_highlighted"];
}

#pragma mark ------ 设置所有子控制器 -------
-(void)addChildViewControllerClassName:(NSString *)className title:(NSString *)title imageName:(NSString *)imageName selectimageName:(NSString *)selectimageName{
    UIViewController *controller =[[NSClassFromString(className) alloc] init];
    controller.tabBarItem.title =title;
    controller.view.backgroundColor =KVCBackgroundColor;
    controller.tabBarItem.image =KImageName(imageName);
    controller.tabBarItem.selectedImage =KImageName(selectimageName);
    
    [self addChildViewController:controller];
}
@end
