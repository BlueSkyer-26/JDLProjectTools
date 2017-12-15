//
//  JDLAlipayAntForestViewController.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/13.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLAlipayAntForestViewController.h"

#define headImageHeight KScreenWidth *976/750

@interface JDLAlipayAntForestViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIImageView *headImageView;
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation JDLAlipayAntForestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title =@"蚂蚁森林";
    [self JDL_setNavBarBarTintColor:KWhiteColor];
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
    cell.textLabel.text =KNSStringFormat(@"啦啦啦%ld",(long)indexPath.row);
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ------ 关键代码 -------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY =scrollView.contentOffset.y;
    if(offsetY > -headImageHeight){
        CGFloat alpha = (headImageHeight +offsetY)/(KTwoMultiplication(KNavbarHeight));
        [self JDL_setNavBarBackgroundAlpha:alpha];
        if(alpha >0.5){
            [self JDL_setStatusBarStyle:UIStatusBarStyleDefault];
            [self JDL_setNavBarTintColor:KBlackColor];
            [self JDL_setNavBarTitleColor:KBlackColor];
        }else{
            [self JDL_setStatusBarStyle:UIStatusBarStyleLightContent];
            [self JDL_setNavBarTintColor:KWhiteColor];
            [self JDL_setNavBarTitleColor:KWhiteColor];
        }
    }
    else{
        [self JDL_setNavBarBackgroundAlpha:0];
        [self JDL_setNavBarTintColor:[UIColor whiteColor]];
        [self JDL_setNavBarTitleColor:[UIColor whiteColor]];
        [self JDL_setStatusBarStyle:UIStatusBarStyleLightContent];
        
        scrollView.contentOffset =CGPointMake(0, -headImageHeight);
    }
    
}


-(UIImageView *)headImageView{
    if(!_headImageView){
        _headImageView =[[UIImageView alloc] initWithFrame:CGRectMake(0, -headImageHeight, KScreenWidth, headImageHeight)];
        _headImageView.image =KImageName(@"WechatIMG52");
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
