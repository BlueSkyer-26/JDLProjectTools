//
//  JDLPopContentManager.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/10.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <KLCPopup.h>

@interface JDLPopContentManager : NSObject

//视图显示在中间 延时duration 后dismiss
+(KLCPopup *)showPopContentViewCenter:(UIView *)contentView duration:(CGFloat)duration;

//视图显示在下面
+(KLCPopup *)showPopContentViewBottom:(UIView *)contentView;

@end

//示例
//        JDLHeadView *view =[[JDLHeadView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight -200)];
//
//        KLCPopup *popView =[JDLPopContentManager showPopContentViewBottom:view];
//        view.clickViewBlock = ^(NSString *str) {
//
//            [popView dismiss:YES];
//        };
