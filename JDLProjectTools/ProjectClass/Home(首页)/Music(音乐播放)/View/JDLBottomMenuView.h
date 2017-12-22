//
//  JDLBottomMenuView.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/19.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "JDLMusicRotationImageView.h"

@interface JDLBottomMenuView : UIView

@property (nonatomic,strong) JDLMusicRotationImageView *iconImageView;
@property (nonatomic,strong) JDLCircleView *circleView;
@property (nonatomic,strong) JDLRollLabel *musicName;
@property (nonatomic,strong) JDLRollLabel *authorName;
@property (nonatomic,strong) UIButton *startBtn;
@property (nonatomic,strong) UIButton *forntBtn;
@property (nonatomic,strong) UIButton *nextBtn;
@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic,strong) void(^bottomButtonClickBlock)(NSInteger index,UIButton *btn);

@end
