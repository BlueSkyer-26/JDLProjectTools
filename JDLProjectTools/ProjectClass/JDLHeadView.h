//
//  JDLHeadView.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/10.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JDLHeadView;

@protocol JDLHeadViewDelegate <NSObject>
-(void)clickView:(JDLHeadView *)view duration:(CGFloat )duration;
@end

@interface JDLHeadView : UIView

@property (nonatomic,assign) id<JDLHeadViewDelegate>delegate;

@property (nonatomic,copy) void(^clickViewBlock)(NSString *str);

@end
