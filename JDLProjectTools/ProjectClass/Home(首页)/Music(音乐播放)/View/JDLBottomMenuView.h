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
@property (nonatomic,strong) UILabel *progressLine;
@property (nonatomic,strong) UILabel *musicName;
@property (nonatomic,strong) UILabel *authorName;
@property (nonatomic,strong) UIButton *startBtn;
@end
