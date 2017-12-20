//
//  JDLMusicRotationImageView.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/19.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDLMusicRotationImageView : UIImageView

-(void)JDL_setCornerRadiusFlout:(CGFloat )flout;

-(void)startRotating;
-(void)stopRotating;
-(void)resumeRotating;

@end
