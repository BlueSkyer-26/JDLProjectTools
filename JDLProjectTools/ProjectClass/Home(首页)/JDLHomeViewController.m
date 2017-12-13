//
//  JDLHomeViewController.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/11.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLHomeViewController.h"

@interface JDLHomeViewController ()
{
    JDLAnimationButton *button;
}
@property (nonatomic,strong) UIButton *btn;
@end

@implementation JDLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(40, 120, KScreenWidth -80, 80);
    [btn setImage:KImageName(@"Icon-40") forState:UIControlStateNormal];
    [btn setTitle:@"快快快快快快" forState:UIControlStateNormal];
    [btn JDL_imagePositionStyle:JDLImagePositionStyleTop spacing:10.0];
    btn.JDL_eventTimeInterval =5;
    btn.backgroundColor =[UIColor cyanColor];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    button =[JDLAnimationButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(40, 220, 80, 60) title:@"凤飞飞" titleColor:KThemeColor backgroundColor:KWhiteColor imageName:@"Icon-40" andBlock:^{
        
        UIViewController *vc =[[UIViewController alloc] init];
        vc.view.backgroundColor =KThemeColor;
        [self.navigationController pushViewController:vc animated:YES];
//        [button JDL_countdownWithSecond:2];
//        [button JDL_countdownWithSecond:10 completion:^{
//            JDLLog(@"萨瓦迪卡");
//        }];
//        JDLHeadView *view =[[JDLHeadView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight -200)];
//
//        KLCPopup *popView =[JDLPopContentManager showPopContentViewBottom:view];
//        view.clickViewBlock = ^(NSString *str) {
//
//            [popView dismiss:YES];
//        };
    }];
    button.buttonScale =0.5;
//    button.imageRect =CGRectMake(button.frame.size.width *0.5 -20, 0, 40, 40);
//    button.titleRect =CGRectMake(button.frame.size.width *0.5 -40, 50, 80, 20);
//    button.titleLabel.textAlignment =NSTextAlignmentCenter;
    [button JDL_imagePositionStyle:JDLImagePositionStyleTop spacing:5.0];
    [self.view addSubview:button];
}
-(void)click:(UIButton *)sender{
    
    [sender JDL_countdownWithSecond:5];
    JDLLog(@"萨瓦迪卡dianji ");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
