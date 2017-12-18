//
//  JDLBaseCustomNavViewController.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/18.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLBaseCustomNavViewController.h"

@interface JDLBaseCustomNavViewController ()

@end

@implementation JDLBaseCustomNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationController.navigationBar.hidden = YES;
    [self setupNavBar];
}

- (void)setupNavBar
{
    [self.view addSubview:self.customNavBar];
    
    // 设置自定义导航栏背景图片
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"millcolorGrad"];
    
    // 设置自定义导航栏标题颜色
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    
    if (self.navigationController.childViewControllers.count != 1) {
        //        [self.customNavBar wr_setLeftButtonWithTitle:@"<<" titleColor:[UIColor whiteColor]];
        //        [UIImage imageNamed:@"back"]];
        [self.customNavBar JDL_setLeftButtonWithImage:[UIImage imageNamed:@"new_back_white"]];
    }
}

- (JDLCustomNavigationBar *)customNavBar
{
    if (_customNavBar == nil) {
        _customNavBar = [JDLCustomNavigationBar CustomNavigationBar];
    }
    return _customNavBar;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
