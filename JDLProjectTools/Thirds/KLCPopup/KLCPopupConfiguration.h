//
//  KLCPopupConfiguration.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/18.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#ifndef KLCPopupConfiguration_h
#define KLCPopupConfiguration_h

// 判断是否是iPhone X
#define KLCiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度
#define KLCStatusHeight (KIS_IPHONE_X ? 44.f : 20.f)
// 导航栏高度
#define KLCNavbarHeight (KIS_IPHONE_X ? 88.f : 64.f)
// tabBar高度
#define KLCTabBarHeight (KIS_IPHONE_X ? (49.f+34.f) : 49.f)
// bottom 安全高度
#define KLCSafeHeight  (KIS_IPHONE_X ? 34.f: 0)

#endif /* KLCPopupConfiguration_h */
