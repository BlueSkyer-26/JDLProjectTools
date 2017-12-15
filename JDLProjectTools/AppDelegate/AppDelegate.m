//
//  AppDelegate.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/8.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+JDLAppService.h"
#import "JDLTabBarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.layer.cornerRadius = 6;
    self.window.layer.masksToBounds = YES;
    self.window.rootViewController = [[JDLTabBarController alloc] init];

    [self setNavBarAppearence];     //统一配置导航栏 状态栏
    [self adaptationNewIOS];        //适配iOS11以上版本
    [self configureBoardManager];   //键盘弹起收回统一处理
    
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {

}


@end
