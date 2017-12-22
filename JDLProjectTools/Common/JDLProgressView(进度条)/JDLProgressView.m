//
//  JDLProgressView.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/21.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLProgressView.h"

#define KProgressBorderWidth 2.0f
#define KProgressPadding 1.0f
#define KProgressColor [UIColor colorWithRed:0/255.0 green:191/255.0 blue:255/255.0 alpha:1]

@interface JDLProgressView ()
@property (nonatomic, weak) UIView *tView;
@end

@implementation JDLProgressView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        JDLLog(@"萨瓦迪卡===%f",frame.size.width);
        //边框
        UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 2)];
        borderView.centerY =self.centerY;
//        borderView.layer.cornerRadius = self.bounds.size.height * 0.5;
//        borderView.layer.masksToBounds = YES;
        borderView.backgroundColor = [UIColor whiteColor];
//        borderView.layer.borderColor = [KProgressColor CGColor];
//        borderView.layer.borderWidth = KProgressBorderWidth;
        [self addSubview:borderView];
        
        //进度
        UIView *tView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, frame.size.height *0.5)];
        tView.top =borderView.centerY -frame.size.height *0.25;
        tView.backgroundColor = KWhiteColor;
        tView.layer.cornerRadius = self.bounds.size.height * 0.5;
        tView.layer.masksToBounds = YES;
        [self addSubview:tView];
        self.tView = tView;
    }
    
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    CGFloat margin = KProgressBorderWidth + KProgressPadding;
    CGFloat maxWidth = self.bounds.size.width;
    CGFloat heigth = self.bounds.size.height *0.5;
    
    _tView.width =maxWidth *progress;
//    _tView.frame = CGRectMake(margin, margin, maxWidth * progress, heigth);
//    _tView.frame = CGRectMake(0, 0, maxWidth * progress, heigth);
//    _tView.centerY =self.centerY;
}

@end
