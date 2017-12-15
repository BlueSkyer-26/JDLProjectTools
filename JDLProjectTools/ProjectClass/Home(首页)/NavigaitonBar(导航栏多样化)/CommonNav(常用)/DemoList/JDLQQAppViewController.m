//
//  JDLQQAppViewController.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/14.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLQQAppViewController.h"

#define headImageHeight KScreenWidth *0.6

@interface JDLQQAppViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UITableView *tableView;

@end

@implementation JDLQQAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title =@"QQApp";
    [self JDL_setNavBarBarTintColor:KOrangeColor];
    [self JDL_setNavBarBackgroundAlpha:0];
    
    [self.tableView addSubview:self.headImageView];
    [self.view addSubview:self.tableView];
    
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
    cell.textLabel.text =KNSStringFormat(@"QQApp%ld",(long)indexPath.row);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY =scrollView.contentOffset.y;
    if((headImageHeight +offsetY) >headImageHeight){
        [UIView animateWithDuration:0.5 animations:^{
            [self JDL_setNavBarBackgroundAlpha:1];
            [self JDL_setStatusBarStyle:UIStatusBarStyleDefault];
            [self JDL_setNavBarTintColor:KBlackColor];
            [self JDL_setNavBarTitleColor:KBlackColor];
        }];
    }
    else{
        [UIView animateWithDuration:0.5 animations:^{
            [self JDL_setNavBarBackgroundAlpha:0];
            [self JDL_setStatusBarStyle:UIStatusBarStyleLightContent];
            [self JDL_setNavBarTintColor:KWhiteColor];
            [self JDL_setNavBarTitleColor:KWhiteColor];
        }];
    }
    if(offsetY < -headImageHeight){
        scrollView.contentOffset =CGPointMake(0, -headImageHeight);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImageView *)headImageView{
    if(!_headImageView){
        _headImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, -headImageHeight, KScreenWidth, headImageHeight)];
        _headImageView.image =KImageName(@"Icon-40");
    }
    return _headImageView;
}

-(UITableView *)tableView{
    if(!_tableView){
        _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight) style:UITableViewStylePlain];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tableView.contentInset =UIEdgeInsetsMake(headImageHeight, 0, 0, 0);
        _tableView.showsVerticalScrollIndicator =NO;
        _tableView.backgroundColor =KClearColor;
        _tableView.rowHeight =60;
        _tableView.delegate =self;
        _tableView.dataSource =self;
    }
    return _tableView;
}

@end
