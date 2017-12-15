//
//  JDLAllCommonClass.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/10.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//
//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

#ifndef JDLAllCommonClass_h
#define JDLAllCommonClass_h

#pragma mark ------ BaseConfiguration -------
#import "JDLProjectConfiguration.h"

#pragma mark ------ Manager -------
#import "JDLPopContentManager.h"                //弹出视图管理类

#pragma mark ------ Category -------
#import "UIButton+JDLTouch.h"                   //防止button重复点击
#import "UIButton+JDLLayout.h"                  //button 图片文字位置自定义
#import "UIButton+JDLCountDown.h"               //button 带有倒计时
#import "UIButton+JDLImagePosition.h"           //button 图片文字位置自定义 设置frame的方式

#pragma mark ------ Custom -------
#import "JDLHeadView.h"
#import "JDLAnimationButton.h"                  //带有动画button
#import "JDLNavigationBar.h"                    //导航渐变 颜色 状态栏
#import "JDLCustomNavigationBar.h"
#import "JDLTableViewAnimationKitHeaders.h"     //tableview  展示cell动画

#pragma mark ------ Third -------
#import <YYKit.h>
#import <Masonry.h>
#import <MJRefresh.h>
#import <YBPopupMenu.h>
#import <MJExtension.h>
#import <ReactiveCocoa.h>
#import <IQKeyboardManager.h>

#endif /* JDLAllCommonClass_h */
