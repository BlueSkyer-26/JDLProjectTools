//
//  JDLTableViewAnimationKit.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/13.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JDLTableViewAnimationKitConfig.h"

@interface JDLTableViewAnimationKit : NSObject<UICollisionBehaviorDelegate>
/**
     显示动画
 
 @param animationType :动画类型
 @param tableView :    要显示动画的tableview
 */
+ (void)showWithAnimationType:(JDLTableViewAnimationType)animationType tableView:(UITableView *)tableView;

+ (void)moveAnimationWithTableView:(UITableView *)tableView;
+ (void)alphaAnimationWithTableView:(UITableView *)tableView;
+ (void)fallAnimationWithTableView:(UITableView *)tableView;
+ (void)shakeAnimationWithTableView:(UITableView *)tableView;
+ (void)overTurnAnimationWithTableView:(UITableView *)tableView;
+ (void)toTopAnimationWithTableView:(UITableView *)tableView;
+ (void)springListAnimationWithTableView:(UITableView *)tableView;
+ (void)shrinkToTopAnimationWithTableView:(UITableView *)tableView;
+ (void)layDownAnimationWithTableView:(UITableView *)tableView;
+ (void)roteAnimationWithTableView:(UITableView *)tableView;
@end
