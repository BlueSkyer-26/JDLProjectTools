//
//  JDLPopContentManager.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/10.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLPopContentManager.h"

@implementation JDLPopContentManager

+(KLCPopup *)showPopContentViewCenter:(UIView *)contentView duration:(CGFloat)duration{
    
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutCenter);
    
    KLCPopup *popup = [KLCPopup popupWithContentView:contentView showType:KLCPopupShowTypeBounceIn dismissType:KLCPopupDismissTypeGrowOut maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout duration:duration];
    
    return popup;
}

+(KLCPopup *)showPopContentViewBottom:(UIView *)contentView{
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutBottom);
    
    KLCPopup *popup = [KLCPopup popupWithContentView:contentView showType:KLCPopupShowTypeSlideInFromBottom dismissType:KLCPopupDismissTypeSlideOutToBottom maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
    
    return popup;
}

+(KLCPopup *)showPopContentViewTop:(UIView *)contentView{
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutCenter, KLCPopupVerticalLayoutTop);
    
    KLCPopup *popup = [KLCPopup popupWithContentView:contentView showType:KLCPopupShowTypeSlideInFromTop dismissType:KLCPopupDismissTypeSlideOutToTop maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
    
    return popup;
}

+(KLCPopup *)showPopContentViewLeft:(UIView *)contentView{
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutLeft, KLCPopupVerticalLayoutCenter);
    
    KLCPopup *popup = [KLCPopup popupWithContentView:contentView showType:KLCPopupShowTypeSlideInFromLeft dismissType:KLCPopupDismissTypeSlideOutToLeft maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
    
    return popup;
}

+(KLCPopup *)showPopContentViewRight:(UIView *)contentView{
    KLCPopupLayout layout = KLCPopupLayoutMake(KLCPopupHorizontalLayoutRight, KLCPopupVerticalLayoutCenter);
    
    KLCPopup *popup = [KLCPopup popupWithContentView:contentView showType:KLCPopupShowTypeSlideInFromRight dismissType:KLCPopupDismissTypeSlideOutToRight maskType:KLCPopupMaskTypeDimmed dismissOnBackgroundTouch:YES dismissOnContentTouch:NO];
    
    [popup showWithLayout:layout];
    
    return popup;
}


@end
