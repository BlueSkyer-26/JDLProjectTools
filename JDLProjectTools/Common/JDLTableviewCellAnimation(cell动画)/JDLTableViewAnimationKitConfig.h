//
//  JDLTableViewAnimationKitConfig.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/13.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#ifndef JDLTableViewAnimationKitConfig_h
#define JDLTableViewAnimationKitConfig_h

typedef NS_ENUM(NSInteger,JDLTableViewAnimationType){
    JDLTableViewAnimationTypeMove = 0,    //
    JDLTableViewAnimationTypeAlpha,       //从上往下依次加载
    JDLTableViewAnimationTypeFall,        //从下往上依次叠加加载
    JDLTableViewAnimationTypeShake,
    JDLTableViewAnimationTypeOverTurn,
    JDLTableViewAnimationTypeToTop,
    JDLTableViewAnimationTypeSpringList,
    JDLTableViewAnimationTypeShrinkToTop,
    JDLTableViewAnimationTypeLayDown,
    JDLTableViewAnimationTypeRote,
};

#endif /* JDLTableViewAnimationKitConfig_h */
