//
//  JDLBottomMenuView.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/19.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLBottomMenuView.h"

@interface JDLBottomMenuView ()

@end

@implementation JDLBottomMenuView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self =[super initWithFrame:frame]) {
        
        self.backgroundColor =KThemeColor;
        _iconImageView =[[JDLMusicRotationImageView alloc] init];
        _iconImageView.backgroundColor =KPurpleColor;
        _iconImageView.image =KImageName(@"Icon-40");
        [_iconImageView JDL_setCornerRadiusFlout:KAdaptY(25)];
        [self addSubview:_iconImageView];
        [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self);
            make.width.height.offset(KAdaptY(50));
        }];
        
        _progressLine = [[UILabel alloc]init];
        _progressLine.font =KSYSTEMFONT(14);
        _progressLine.textColor =KWhiteColor;
        _progressLine.backgroundColor =KRedColor;
        [self addSubview:_progressLine];
        [_progressLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_iconImageView);
            make.left.equalTo(_iconImageView.mas_right).offset(10);
            make.right.equalTo(self).offset(-60);
            make.height.equalTo(_iconImageView.mas_height).multipliedBy(1/3.0f);
        }];
        
        _musicName = [[UILabel alloc]init];
        _musicName.font =KSYSTEMFONT(14);
        _musicName.text =@"Unknow";
        _musicName.textColor =KWhiteColor;
        [self addSubview:_musicName];
        [_musicName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_progressLine.mas_bottom);
            make.left.equalTo(_progressLine);
            make.height.equalTo(_iconImageView.mas_height).multipliedBy(1/3.0f);
        }];
        
        _authorName = [[UILabel alloc]init];
        _authorName.font =KSYSTEMFONT(12);
        _authorName.text =@"Unknow";
        _authorName.textColor =KWhiteColor;
        [self addSubview:_authorName];
        [_authorName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_musicName.mas_bottom);
            make.left.equalTo(_musicName);
            make.height.equalTo(_iconImageView.mas_height).multipliedBy(1/3.0f);
        }];
    }
    return self;
}

@end
