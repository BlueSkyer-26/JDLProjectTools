//
//  JDLDetailMusicViewController.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/18.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLDetailMusicViewController.h"

#import "JDLMusicApi.h"

#import "JDLMusicCell.h"

#import "JDLMusicListModel.h"
#import "JDLMusicPlayModel.h"

#define TITLES @[@"修改", @"删除", @"扫一扫",@"付款"]
#define ICONS  @[@"motify",@"delete",@"saoyisao",@"pay"]

static NSString *CellId = @"Cell";
@interface JDLDetailMusicViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    JDLMusicPlayModel *playMusicManager;
    NSInteger selectIndex;
}
@property (nonatomic,strong) UITableView        *tableView;
@property (nonatomic,strong) NSMutableArray     *musicListArray;

@end

@implementation JDLDetailMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createView];          //创建视图
    
    playMusicManager =[JDLMusicPlayModel shareManager];
    
    [self requestData];         //请求数据
}

#pragma mark ------ 创建视图 -------
-(void)createView{
    [self.view addSubview:self.tableView];
}

#pragma mark ------ 请求数据 -------
-(void)requestData{
    
    /**
     *  ZBRequestTypeCache 为 有缓存使用缓存 无缓存就重新请求
     *  默认缓存路径/Library/Caches/ZBKit/AppCache
     */
    [self getDataWithApiType:ZBRequestTypeCache type:1];
    
    WEAKSELF;
    [self.tableView setRefreshWithHeaderBlock:^{
     
        [weakSelf getDataWithApiType:ZBRequestTypeRefresh type:1];
    } footerBlock:^{
     
        [weakSelf getDataWithApiType:ZBRequestTypeRefreshMore type:2];
    }];
    
    [self.tableView setupEmptyDataText:@"点击查看更多" tapBlock:^{
     
        [weakSelf getDataWithApiType:ZBRequestTypeRefresh type:1];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.musicListArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    JDLMusicListModel *model =self.musicListArray[indexPath.row];
    
    JDLMusicCell *cell=[tableView dequeueReusableCellWithIdentifier:CellId];
    
    cell.model =model;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KAdaptY(60);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JDLMusicListModel *model =self.musicListArray[indexPath.row];
  
    [playMusicManager loadMusicWith:model index:indexPath.row];
    

//    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
//    CGRect rectInSuperview = [tableView convertRect:rectInTableView toView:[tableView superview]];
//    CGPoint point =CGPointMake(rectInSuperview.origin.x, rectInSuperview.origin.y);
//    //推荐用这种写法
//    [YBPopupMenu showAtPoint:point titles:TITLES icons:nil menuWidth:110 otherSettings:^(YBPopupMenu *popupMenu) {
//        popupMenu.dismissOnSelected = NO;
//        popupMenu.isShowShadow = YES;
//        popupMenu.delegate = self;
//        popupMenu.offset = 10;
//        popupMenu.type = YBPopupMenuTypeDark;
//        popupMenu.rectCorner = UIRectCornerBottomLeft | UIRectCornerBottomRight;
//    }];
   
    JDLLog(@"你选择了《%@》这首歌==%@",model.title,model.lrclink);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    self.scrollviewMoveStr =KNSStringFormat(@"%f",scrollView.contentOffset.y);
    KPostNotification(KScrollViewMoveNofication, nil, nil);
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.scrollviewEndStr =KNSStringFormat(@"%f",scrollView.contentOffset.y);
    KPostNotification(KScrollViewMoveEndNofication, nil, nil);
}


#pragma mark - AFNetworking
- (void)getDataWithApiType:(apiType)requestType type:(NSInteger )requestTypeNum{

    NSNumber *typeNumCoumt;
    if (requestTypeNum==1) {
        typeNumCoumt =@0;
    }else if (requestTypeNum==2){
        typeNumCoumt =@(self.musicListArray.count);
    }
    NSString *partTwo = [NSString stringWithFormat:@"offset=%@&size=%d",typeNumCoumt, 20];
    NSString *urlString = [[JDLMusicApi requestDataUrlWithItemString:self.channelTitle] stringByAppendingString:partTwo];
    
    [ZBRequestManager requestWithConfig:^(ZBURLRequest *request){
        request.urlString =urlString;
        request.methodType=ZBMethodTypeGET;//默认为GET
        request.apiType=requestType;//默认为ZBRequestTypeRefresh
        request.timeoutInterval=10;
    }  success:^(id responseObject,apiType type){
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableArray *array=[dict objectForKey:@"song_list"];
        NSMutableArray *loadSongArray =[JDLMusicListModel mj_objectArrayWithKeyValuesArray:array];
      
        if (requestTypeNum ==1) {
            //            [self.musicListArray removeAllObjects];
            self.musicListArray =loadSongArray;
        }else{
            [self.musicListArray addObjectsFromArray:loadSongArray];
        }

        playMusicManager.allMusicArray =self.musicListArray;
        
        [self.tableView headerEndRefreshing];    //结束刷新
        [self.tableView footerEndRefreshing];    //结束刷新
        [self.tableView reloadData];
    
//        self.tableView.mj_footer.hidden =array.count <20 ?YES:NO;
        requestTypeNum ==1?[JDLTableViewAnimationKit showWithAnimationType:0 tableView:self.tableView]: nil;
        
    } failed:^(NSError *error){
        if (error.code==NSURLErrorCancelled)return;
        [self.tableView headerEndRefreshing];
    }];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight -KNavbarHeight -KSegmentHeight -KAdaptY(60)) style:UITableViewStylePlain];
        [_tableView registerClass:[JDLMusicCell class] forCellReuseIdentifier:CellId];
        _tableView.separatorStyle =UITableViewCellSeparatorStyleNone;
        _tableView.delegate =self;
        _tableView.dataSource =self;
    }
    return _tableView;
}

-(NSMutableArray *)musicListArray{
    
    if (!_musicListArray) {
        _musicListArray =[NSMutableArray array];
    }
    return _musicListArray;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
