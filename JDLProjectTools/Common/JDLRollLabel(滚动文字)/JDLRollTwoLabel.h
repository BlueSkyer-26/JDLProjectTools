//
//  JDLRollTwoLabel.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/20.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDLRollTwoLabel : UIView
- (nonnull instancetype)initWithFrame:(CGRect)frame andRaceTitle:(nonnull NSString*)racetitle;

- (void)changeRaceTitle:(nonnull NSString*)raceTitle;
@end
