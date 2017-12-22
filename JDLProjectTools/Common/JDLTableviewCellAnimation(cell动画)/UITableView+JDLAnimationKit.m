//
//  UITableView+JDLAnimationKit.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/13.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "UITableView+JDLAnimationKit.h"
#import "JDLTableViewAnimationKit.h"

@implementation UITableView (JDLAnimationKit)


- (void)JDL_showTableviewAnimationWithType:(JDLTableViewAnimationType)animationType{
    
    [JDLTableViewAnimationKit showWithAnimationType:animationType tableView:self];
}

@end
