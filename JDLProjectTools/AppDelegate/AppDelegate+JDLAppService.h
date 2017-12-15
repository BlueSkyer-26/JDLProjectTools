//
//  AppDelegate+JDLAppService.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/13.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (JDLAppService)
/**
 包含第三方 和 应用内业务的实现，减轻入口代码压力
 */

//统一配置导航栏 状态栏
-(void)setNavBarAppearence;

//适配iOS11
-(void)adaptationNewIOS;

//监听网络状态
-(void)monitorNetworkStatus;

//键盘弹起收回统一处理
-(void)configureBoardManager;
@end
