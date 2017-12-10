//
//  ViewController.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/8.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "ViewController.h"
#import "JDLHeadView.h"
@interface ViewController ()<JDLHeadViewDelegate>
{
    KLCPopup *popView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(20, 50, KScreenWidth -40, 180)];
    label.backgroundColor =[UIColor orangeColor];
    label.text =@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈";
    label.numberOfLines =0;
    [self.view addSubview:label];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    JDLHeadView *view =[[JDLHeadView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight -200)];
    view.clickViewBlock = ^(NSString *str) {
     
        [popView dismiss:YES];
    };
    view.delegate =self;
    
//    popView = [JDLPopContentManager showPopContentViewCenter:view duration:0.0];
    popView =[JDLPopContentManager showPopContentViewBottom:view];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)clickView:(JDLHeadView *)view duration:(CGFloat)duration {
    JDLLog(@"萨瓦迪卡=%@==%f",view,duration);
//    [popView dismiss:YES];
}

@end
