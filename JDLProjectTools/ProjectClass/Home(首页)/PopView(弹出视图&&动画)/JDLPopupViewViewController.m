//
//  JDLPopupViewViewController.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/13.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLPopupViewViewController.h"

@interface JDLPopupViewViewController ()

@end

@implementation JDLPopupViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    JDLAnimationButton *buttonCenter =[JDLAnimationButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(KLeftPadding, KNavbarHeight +KLeftPadding, KScreenWidth -KTwoMultiplication(KLeftPadding), 60) title:@"PopupViewCenter" titleColor:KWhiteColor backgroundColor:KThemeColor imageName:@"Icon-tabbar" andBlock:^{
       
        JDLHeadView *headView =[[JDLHeadView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth -80, 400)];
        KLCPopup *popView =[JDLPopContentManager showPopContentViewCenter:headView duration:0];
        headView.clickViewBlock = ^(NSString *str) {
            [popView dismiss:YES];
        };
        
    }];
    [buttonCenter JDL_imagePositionStyle:JDLImagePositionStyleTop spacing:2];
    [buttonCenter JDL_setCornerRadiusFlout:KTwoHalfMultiplication(buttonCenter.height)];
    [self.view addSubview:buttonCenter];
    
    JDLAnimationButton *buttonBottom =[JDLAnimationButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(KLeftPadding, buttonCenter.bottom +KLeftPadding, KScreenWidth -KTwoMultiplication(KLeftPadding), 60) title:@"PopupViewBottom" titleColor:KWhiteColor backgroundColor:KThemeColor imageName:@"Icon-tabbar" andBlock:^{
        
        UIView *bgView =[[UIView alloc] initWithFrame:CGRectMake(KLeftPadding, 0, KScreenWidth -KTwoMultiplication(KLeftPadding), 200)];
        bgView.backgroundColor =KClearColor;
        
        JDLHeadView *headView =[[JDLHeadView alloc] initWithFrame:CGRectMake(0, 0, bgView.width, bgView.height)];
        [bgView addSubview:headView];
        
        KLCPopup *popView =[JDLPopContentManager showPopContentViewBottom:bgView];
        headView.clickViewBlock = ^(NSString *str) {
            [popView dismiss:YES];
        };
        
    }];
    [buttonBottom JDL_imagePositionStyle:JDLImagePositionStyleTop spacing:2];
    [buttonBottom JDL_setCornerRadiusFlout:KTwoHalfMultiplication(buttonBottom.height)];
    [self.view addSubview:buttonBottom];
    
    JDLAnimationButton *buttonTop =[JDLAnimationButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(KLeftPadding, buttonBottom.bottom +KLeftPadding, KScreenWidth -KTwoMultiplication(KLeftPadding), 60) title:@"PopupViewTop" titleColor:KWhiteColor backgroundColor:KThemeColor imageName:@"Icon-tabbar" andBlock:^{
        
        JDLHeadView *headView =[[JDLHeadView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 200)];
        KLCPopup *popView =[JDLPopContentManager showPopContentViewTop:headView];
        headView.clickViewBlock = ^(NSString *str) {
            [popView dismiss:YES];
        };
        
    }];
    [buttonTop JDL_imagePositionStyle:JDLImagePositionStyleTop spacing:2];
    [buttonTop JDL_setCornerRadiusFlout:KTwoHalfMultiplication(buttonTop.height)];
    [self.view addSubview:buttonTop];
    
    JDLAnimationButton *buttonLeft =[JDLAnimationButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(KLeftPadding, buttonTop.bottom +KLeftPadding, KScreenWidth -KTwoMultiplication(KLeftPadding), 60) title:@"PopupViewLeft" titleColor:KWhiteColor backgroundColor:KThemeColor imageName:@"Icon-tabbar" andBlock:^{
        
        JDLHeadView *headView =[[JDLHeadView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth *0.6, KScreenHeight)];
        KLCPopup *popView =[JDLPopContentManager showPopContentViewLeft:headView];
        headView.clickViewBlock = ^(NSString *str) {
            [popView dismiss:YES];
        };
        
    }];
    [buttonLeft JDL_imagePositionStyle:JDLImagePositionStyleBottom spacing:2];
    [buttonLeft JDL_setCornerRadiusFlout:KTwoHalfMultiplication(buttonLeft.height)];
    [self.view addSubview:buttonLeft];
    
    JDLAnimationButton *buttonRight =[JDLAnimationButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(KLeftPadding, buttonLeft.bottom +KLeftPadding, KScreenWidth -KTwoMultiplication(KLeftPadding), 60) title:@"PopupViewRight" titleColor:KWhiteColor backgroundColor:KThemeColor imageName:@"Icon-tabbar" andBlock:^{
        
        JDLHeadView *headView =[[JDLHeadView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth *0.6, KScreenHeight)];
        KLCPopup *popView =[JDLPopContentManager showPopContentViewRight:headView];
        headView.clickViewBlock = ^(NSString *str) {
            [popView dismiss:YES];
        };
        
    }];
    [buttonRight JDL_imagePositionStyle:JDLImagePositionStyleTop spacing:2];
    [buttonRight JDL_setCornerRadiusFlout:KTwoHalfMultiplication(buttonRight.height)];
    [self.view addSubview:buttonRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
