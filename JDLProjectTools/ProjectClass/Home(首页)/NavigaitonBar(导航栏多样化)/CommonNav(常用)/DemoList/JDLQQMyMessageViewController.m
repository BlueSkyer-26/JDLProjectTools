//
//  JDLQQMyMessageViewController.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/14.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLQQMyMessageViewController.h"

#define headImageHeight KScreenWidth *0.5

@interface JDLQQMyMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    JDLAnimationButton *button;
}
@property (nonatomic,strong) UIImageView *bottomImageView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIView *headMessageView;

@property (nonatomic,strong) UIView *navMessageView;
@end

@implementation JDLQQMyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人信息";
    [self JDL_setNavBarBackgroundAlpha:0];
    [self JDL_setNavBarBarTintColor:KPurpleColor];
    
    [self setupNavItems];
    [self.view addSubview:self.bottomImageView];
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView =self.headMessageView;
}

- (void)setupNavItems
{
//    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navLeft"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickLeft)];
//    self.navigationItem.leftBarButtonItem = leftButtonItem;
//
//    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navRight"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickRight)];
//    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    self.navigationItem.titleView = self.navMessageView;
}


#pragma mark ------ tableview delegate/datesource -------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 30;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier =@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault      reuseIdentifier:identifier];
    }
    cell.backgroundColor =KBlackAlphaColor(0.4);
    cell.textLabel.textColor =KWhiteColor;
    cell.textLabel.text =KNSStringFormat(@"啦啦啦哈哈哈%ld",(long)indexPath.row);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY =scrollView.contentOffset.y;
    if(offsetY >0){
        CGFloat alpha =offsetY/(2*KNavbarHeight);
        self.title = @"";
        [self JDL_setNavBarBackgroundAlpha:alpha];
        button.alpha =alpha;
        if(alpha >0.5){
            [self JDL_setStatusBarStyle:UIStatusBarStyleLightContent];
            [self JDL_setNavBarTintColor:KWhiteColor];
            [self JDL_setNavBarTitleColor:KWhiteColor];
        }else{
            [self JDL_setStatusBarStyle:UIStatusBarStyleLightContent];
            [self JDL_setNavBarTintColor:KWhiteColor];
            [self JDL_setNavBarTitleColor:KWhiteColor];
        }
    }else{
        self.title = @"个人信息";
        [self JDL_setNavBarBackgroundAlpha:0];
        button.alpha =0;
        
        self.bottomImageView.center =self.view.center;
        self.bottomImageView.bounds =CGRectMake(0, 0, KScreenWidth -offsetY, KScreenHeight -offsetY);
//        CABasicAnimation *animation =[CABasicAnimation animationWithKeyPath:@"transform.scale"];
//        animation.fromValue =@1;
//        animation.toValue =@(offsetY);
//        animation.removedOnCompletion = NO;
//        animation.fillMode = kCAFillModeForwards;
//        [self.bottomImageView.layer addAnimation:animation forKey:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImageView *)bottomImageView{
    if(!_bottomImageView){
        _bottomImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight)];
        _bottomImageView.image =KImageName(@"JDLProject-lufei");
    }
    return _bottomImageView;
}
-(UIView *)headMessageView{
    if(!_headMessageView){
        _headMessageView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, headImageHeight)];
        _headMessageView.backgroundColor =KClearColor;
        
        UIImageView *headImage =[[UIImageView alloc] init];
        headImage.centerX =self.view.centerX;
        headImage.centerY =_headMessageView.centerY;
        headImage.bounds =CGRectMake(0, 0, KAdaptX(66), KAdaptX(66));
        headImage.image =KImageName(@"Icon-40");
        headImage.layer.cornerRadius =KAdaptX(33);
        headImage.layer.masksToBounds =YES;
        [_headMessageView addSubview:headImage];
        
        UILabel *nameLabel =[[UILabel alloc] initWithFrame:CGRectMake(0, headImage.bottom, KScreenWidth, _headMessageView.height -headImage.bottom)];
        nameLabel.text =@"BlueSkyer-25";
        nameLabel.textColor =KWhiteColor;
        nameLabel.textAlignment =NSTextAlignmentCenter;
        [_headMessageView addSubview:nameLabel];
    }
    return _headMessageView;
}
-(UIView *)navMessageView{
    if(!_navMessageView){
        _navMessageView =[[UIView alloc] initWithFrame:CGRectMake(100, 0, KScreenWidth -200, KNavbarHeight)];
        _navMessageView.backgroundColor =KClearColor;
        
        button =[JDLAnimationButton buttonWithType:UIButtonTypeCustom frame:CGRectMake(20, 0, _navMessageView.width -40, _navMessageView.height) title:@"BlueSkyer-25" titleColor:KWhiteColor backgroundColor:KClearColor imageName:@"Icon-40" andBlock:^{
            
          
        }];
        button.buttonScale =0.5;
        button.imageRect =CGRectMake(button.width *0.5 -15, 0, 30, 30);
        button.titleRect =CGRectMake(0, 30, button.width, 14);
        button.titleLabel.textAlignment =NSTextAlignmentCenter;
        button.titleLabel.font =KSYSTEMFONT(12);
        button.imageView.layer.cornerRadius =15;
        button.layer.masksToBounds =YES;
        
        button.alpha =0;
//        [button JDL_imagePositionStyle:JDLImagePositionStyleTop spacing:5.0];
        [_navMessageView addSubview:button];
    }
    return _navMessageView;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tableView.contentInset =UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.showsVerticalScrollIndicator =NO;
        _tableView.backgroundColor =KClearColor;
        _tableView.rowHeight =60;
        _tableView.delegate =self;
        _tableView.dataSource =self;
    }
    return _tableView;
}

@end
