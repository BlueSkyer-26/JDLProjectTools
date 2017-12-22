//
//  JDLAutherManager.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/21.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDLAutherManager : NSObject

#pragma mark - int转NSString   秒-->分：秒
+(NSString *)secondsToString: (int)needTransformInteger;

#pragma mark - NSString转int   分：秒-->秒
+(int)stringToSeconds: (NSString *)timeString;

#pragma mark - 跳动效果
+ (void)popJumpAnimationView:(UIView *)sender;
@end
