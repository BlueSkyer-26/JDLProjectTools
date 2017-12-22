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
        
        UIButton *presentBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        presentBtn.tag =24;
        [presentBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:presentBtn];
        [presentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_iconImageView);
        }];
        
        _nextBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_nextBtn setImage:KImageName(@"cm2_fm_btn_next_prs") forState:UIControlStateNormal];
        _nextBtn.tag =25;
        [_nextBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nextBtn];
        [_nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.centerY.equalTo(self).offset(0.0);
            make.width.height.offset(KAdaptY(30));
        }];
        
        _circleView =[[JDLCircleView alloc] init];
        [self addSubview:_circleView];
        [_circleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_nextBtn.mas_left).offset(-8);
            make.centerY.equalTo(self);
            make.width.height.offset(KAdaptY(40));
        }];
        
        _startBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_startBtn setBackgroundImage:KImageName(@"cm2_fm_btn_pause_prs") forState:UIControlStateNormal];
        _startBtn.tag =26;
//        _startBtn.backgroundColor =KPurpleColor;
        [_startBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_startBtn];
        [_startBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_circleView);
            make.width.height.offset(KAdaptY(45));
        }];
        
        _forntBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_forntBtn setBackgroundImage:KImageName(@"cm2_fm_btn_pre_prs") forState:UIControlStateNormal];
        _forntBtn.tag =27;
        [_forntBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_forntBtn];
        [_forntBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_startBtn.mas_left).offset(-8);
            make.centerY.equalTo(self).offset(0.0);
            make.width.height.offset(KAdaptY(30));
        }];
        
        _musicName = [[JDLRollLabel alloc]initWithFrame:CGRectMake(0, 0, 100,KAdaptY(50) *1/2) font:KSYSTEMFONT(14) textColor:KWhiteColor];
        _musicName.text =@"Unknow";
        _musicName.rollSpeed =0.4;
        [self addSubview:_musicName];
        [_musicName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_iconImageView);
            make.left.equalTo(_iconImageView.mas_right).offset(10);
            make.right.equalTo(_forntBtn.mas_left).offset(-10);
            make.height.equalTo(_iconImageView.mas_height).multipliedBy(1/2.0f);
        }];
        
        _authorName = [[JDLRollLabel alloc]initWithFrame:CGRectMake(0, 0, 100,KAdaptY(50) *1/2) font:KSYSTEMFONT(12) textColor:KWhiteColor];
        _authorName.text =@"Unknow";
        _authorName.rollSpeed =0.4;
        [self addSubview:_authorName];
        [_authorName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_musicName.mas_bottom);
            make.left.equalTo(_musicName);
            make.right.equalTo(_forntBtn.mas_left).offset(-10);
            make.height.equalTo(_iconImageView.mas_height).multipliedBy(1/2.0f);
        }];
        
        _timeLabel =[[UILabel alloc] init];
        _timeLabel.textColor =KWhiteColor;
        _timeLabel.font =KSYSTEMFONT(14);
        _timeLabel.backgroundColor =KThemeColor;
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_top).offset(0);
            make.centerX.equalTo(_startBtn);
            make.height.offset(20.0);
        }];
    }
    return self;
}

-(void)buttonClick:(UIButton *)sender{
    if (self.bottomButtonClickBlock) {
        self.bottomButtonClickBlock(sender.tag,sender);
    }
}


@end
