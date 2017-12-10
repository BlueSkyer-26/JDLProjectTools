//
//  JDLHeadView.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/10.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLHeadView.h"

@interface JDLHeadView ()

@end

@implementation JDLHeadView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
        self.backgroundColor =KWhiteColor;
//        self.layer.cornerRadius =8.0;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
        
        UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(20, 20, frame.size.width -40, 180)];
        label.backgroundColor =[UIColor orangeColor];
        label.text =@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
        label.numberOfLines =0;
        [self addSubview:label];
        
        UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor =[UIColor cyanColor];
        btn.frame =CGRectMake(40, CGRectGetMaxY(label.frame), KScreenWidth -80, 40);
        [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return  self;
}

-(void)click{
    if ([self.delegate respondsToSelector:@selector(clickView:duration:)]) {
        [self.delegate clickView:self duration:666];
    }
    
    if (self.clickViewBlock) {
        self.clickViewBlock(@"聊咯咯咯了");
    }
}

@end
