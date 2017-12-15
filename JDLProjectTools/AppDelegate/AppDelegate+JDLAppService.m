//
//  AppDelegate+JDLAppService.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/13.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "AppDelegate+JDLAppService.h"

@implementation AppDelegate (JDLAppService)

#pragma mark ------ 统一配置导航栏 状态栏 -------
- (void)setNavBarAppearence
{
    // 设置导航栏默认的背景颜色
    [JDLNavigationBar JDL_setDefaultNavBarBarTintColor:KThemeColor];
    // 设置导航栏所有按钮的默认颜色
    [JDLNavigationBar JDL_setDefaultNavBarTintColor:KWhiteColor];
    // 设置导航栏标题默认颜色
    [JDLNavigationBar JDL_setDefaultNavBarTitleColor:KWhiteColor];
    // 统一设置状态栏样式
    [JDLNavigationBar JDL_setDefaultStatusBarStyle:UIStatusBarStyleLightContent];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [JDLNavigationBar JDL_setDefaultNavBarShadowImageHidden:YES];
}

#pragma mark ------- 适配iOS11 -------
-(void)adaptationNewIOS{
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
}

#pragma mark ------- 网络状态监听 -------
- (void)monitorNetworkStatus
{
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
//    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType networkStatus) {
//
//        switch (networkStatus) {
//                // 未知网络
//            case PPNetworkStatusUnknown:
//                JDLLog(@"网络环境：未知网络");
//                // 无网络
//            case PPNetworkStatusNotReachable:
//                JDLLog(@"网络环境：无网络");
//                [MBProgressHUD showWarnMessage:@"网络已断开，请设置网络"];
//                //                KPostNotification(KNotificationNetWorkStateChange, @NO);
//                break;
//                // 手机网络
//            case PPNetworkStatusReachableViaWWAN:
//                JDLLog(@"网络环境：手机自带网络");
//                [MBProgressHUD showSuccessMessage:@"手机网络"];
//                // 无线网络
//            case PPNetworkStatusReachableViaWiFi:
//                JDLLog(@"网络环境：WiFi");
//                [MBProgressHUD showSuccessMessage:@"wifi网络"];
//                //                KPostNotification(KNotificationNetWorkStateChange, @YES);
//                break;
//        }
//
//    }];
    // 网络状态改变一次, networkStatusWithBlock就会响应一次
    //    [PPNetworkHelper networkStatusWithBlock:^(PPNetworkStatusType networkStatus) {
    //
    //        switch (networkStatus) {
    //                // 未知网络
    //            case PPNetworkStatusUnknown:
    //                // 无网络
    //            case PPNetworkStatusNotReachable:
    //                self.networkData.text = @"没有网络";
    //                [self getData:YES url:dataUrl];
    //                PPLog(@"无网络,加载缓存数据");
    //                break;
    //                // 手机网络
    //            case PPNetworkStatusReachableViaWWAN:
    //                // 无线网络
    //            case PPNetworkStatusReachableViaWiFi:
    //                [self getData:[[NSUserDefaults standardUserDefaults] boolForKey:@"isOn"] url:dataUrl];
    //                PPLog(@"有网络,请求网络数据");
    //                break;
    //        }
    //
    //    }];
    
}

#pragma mark ------ 键盘收回管理 ------
-(void)configureBoardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.keyboardDistanceFromTextField=0;
    manager.enableAutoToolbar = NO;
}

@end
