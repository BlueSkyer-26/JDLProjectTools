//
//  JDLCommonNavViewController.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/13.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLCommonNavViewController.h"

@interface JDLCommonNavViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *modelsArray;
@property (nonatomic,strong) NSArray *vcClassArray;

@end

@implementation JDLCommonNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.tableView];
}

#pragma mark ------ tableview  delegate/datasource -------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    
    cell.textLabel.text = self.modelsArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *vc =[[NSClassFromString(self.vcClassArray[indexPath.row]) alloc] init];
    vc.view.backgroundColor =KVCBackgroundColor;
//    vc.title =self.modelsArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark ------ tableview -------
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, KNavbarHeight, KScreenWidth, KScreenHeight -KNavbarHeight -KTabBarHeight) style:UITableViewStylePlain];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
    }
    return _tableView;
}

-(NSMutableArray *)modelsArray{
    if (!_modelsArray) {
        _modelsArray =[NSMutableArray arrayWithObjects:@"蚂蚁森林",@"QQApp",@"QQ个人信息",nil];
        self.vcClassArray =@[@"JDLAlipayAntForestViewController",@"JDLQQAppViewController",@"JDLQQMyMessageViewController"];
    }
    return _modelsArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
