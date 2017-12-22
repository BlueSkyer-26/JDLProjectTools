//
//  UITableView+JDLAnimationKit.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/13.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDLTableViewAnimationKitConfig.h"

@interface UITableView (JDLAnimationKit)

/*
 *  显示tableview 展示cell动画
 */
-(void)JDL_showTableviewAnimationWithType:(JDLTableViewAnimationType )animationType;

@end
