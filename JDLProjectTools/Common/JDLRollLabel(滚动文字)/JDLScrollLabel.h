//
//  JDLScrollLabel.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/21.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>
#define Num_Lable 2

enum AutoScrollDirection {
    
    AutoScroll_Scroll_Right,
    AutoScroll_Scroll_Left,
};

@interface JDLScrollLabel : UIScrollView<UIScrollViewDelegate>{
    
    UILabel *label[Num_Lable];
    enum AutoScrollDirection scrollDirection;
    float scrollSpeed;
    NSTimeInterval pauseInterval;
    int bufferSpaceBetweenLabels;
    bool isScrolling;
    
}
@property(nonatomic,retain) UIColor *textColor;

@property(nonatomic, retain) UIFont *font;

- (void)readjustLabels;
- (void) setText:(NSString *)text;
- (NSString *)text;
- (void)scroll;

@end
