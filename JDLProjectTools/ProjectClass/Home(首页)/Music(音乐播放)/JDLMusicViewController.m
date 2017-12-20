//
//  JDLMusicViewController.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/18.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLMusicViewController.h"

#import "JDLMusicListModel.h"

#import "JDLBottomMenuView.h"

#import "JDLMusicPlayerManager.h"

#import "JDLDetailMusicViewController.h"

@interface JDLMusicViewController ()<JDLPageTitleViewDelegate,JDLPageContentViewDelegate>
{
    JDLMusicPlayerManager *playerManager;
}
@property (nonatomic,strong) JDLPageTitleView     *pageTitleView;
@property (nonatomic,strong) JDLPageContentView   *pageContentView;
@property (nonatomic,strong) JDLBottomMenuView    *bottomMenuView;

@property (nonatomic,strong) NSMutableArray       *currentChannelsArray;
@end

@implementation JDLMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    playerManager =[JDLMusicPlayerManager shareManager];
    
    [self createView];

}

-(void)createView{
    [self.view addSubview:self.pageTitleView];
    [self.view addSubview:self.pageContentView];
    [self.view addSubview:self.bottomMenuView];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playMusicNofication:) name:KPlayMusicNofication object:nil];
}

-(void)playMusicNofication:(NSNotification *)notification{
    
    JDLLog(@"萨瓦迪卡===%@",notification.userInfo[@"model"]);
    JDLMusicListModel *model =notification.userInfo[@"model"];
    
    NSString *path = [@"http://tingapi.ting.baidu.com/v1/restserver/ting?from=qianqian&version=2.1.0&method=baidu.ting.song.play&songid="  stringByAppendingString:model.song_id];
    [ZBRequestManager requestWithConfig:^(ZBURLRequest *request){
        request.urlString =path;
        request.methodType=ZBMethodTypeGET;//默认为GET
        request.apiType=ZBRequestTypeCache;//默认为ZBRequestTypeRefresh
        request.timeoutInterval=10;
    }  success:^(id responseObject,apiType type){
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
      
        NSDictionary *array = [dict objectForKey:@"bitrate"];

        NSString *url = [array objectForKey:@"file_link"];
        [self playMusicWith:url model:model];
        JDLLog(@"萨瓦迪卡快快快快快快===%@",url);
        
    } failed:^(NSError *error){
        if (error.code==NSURLErrorCancelled)return;

    }];
    
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
//    NSString *path = [@"http://tingapi.ting.baidu.com/v1/restserver/ting?from=qianqian&version=2.1.0&method=baidu.ting.song.play&songid="  stringByAppendingString:notification.userInfo[@"song_id"]];
//
//    [manager GET:path parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if ([responseObject isKindOfClass:[NSDictionary class]])
//        {
//            NSDictionary *array = [responseObject objectForKey:@"bitrate"];
//
//            NSString *url = [array objectForKey:@"file_link"];
//            [self playMusicWith:url];
//            JDLLog(@"萨瓦迪卡快快快快快快===%@",url);
//        }
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error--%@",error);
//    }];
}

-(void)playMusicWith:(NSString *)url model:(JDLMusicListModel *)model{
    [playerManager playMusicWithUrl:url];
    [playerManager startPlay];
    [_bottomMenuView.iconImageView startRotating];
    _bottomMenuView.musicName.text =model.title;
    _bottomMenuView.authorName.text =model.author;
}


#pragma mark ------ pageView deleagate -------
- (void)pageTitleView:(JDLPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
    [self.pageContentView setPageCententViewCurrentIndex:selectedIndex];
}

- (void)pageContentView:(JDLPageContentView *)pageContentView progress:(CGFloat)progress originalIndex:(NSInteger)originalIndex targetIndex:(NSInteger)targetIndex {
    [self.pageTitleView setPageTitleViewWithProgress:progress originalIndex:originalIndex targetIndex:targetIndex];
}

-(JDLPageTitleView *)pageTitleView{
    if (_pageTitleView ==nil) {
        
        JDLPageTitleViewConfigure *configure = [JDLPageTitleViewConfigure pageTitleViewConfigure];
        configure.indicatorScrollStyle = JDLIndicatorScrollStyleDefault;
        configure.indicatorAdditionalWidth =6;
        configure.titleSelectedColor =KThemeColor;
        configure.indicatorColor =KThemeColor;
        configure.titleFont = KSYSTEMFONT(15);
        
        _pageTitleView = [JDLPageTitleView pageTitleViewWithFrame:CGRectMake(0, KNavbarHeight, KScreenWidth, KSegmentHeight) delegate:self titleNames:self.currentChannelsArray configure:configure];
        _pageTitleView.isTitleGradientEffect = NO;
        _pageTitleView.selectedIndex = 0;
        _pageTitleView.isNeedBounces = NO;
    }
    return _pageTitleView;
}

-(JDLPageContentView *)pageContentView{
    if (_pageContentView ==nil) {
        
        NSMutableArray *vcClassArray =[NSMutableArray array];
        for (int i=0; i < self.currentChannelsArray.count; i ++) {
            JDLDetailMusicViewController *vc =[[JDLDetailMusicViewController alloc] init];
            vc.channelTitle =self.currentChannelsArray[i];
            /* 不能在这里设置颜色 否则全部加载*/
//            vc.view.backgroundColor =KRANDOM_COLOR;
            [vcClassArray addObject:vc];
        }

        _pageContentView = [[JDLPageContentView alloc] initWithFrame:CGRectMake(0, _pageTitleView.bottom, KScreenWidth, KScreenHeight -_pageTitleView.bottom -KSafeHeight) parentVC:self childVCs:vcClassArray];
        _pageContentView.delegatePageContentView = self;
    }
    return _pageContentView;
}

#pragma mark - 顶部标题数组设置
-(NSMutableArray *)currentChannelsArray {
    if (!_currentChannelsArray) {
        _currentChannelsArray = [NSMutableArray arrayWithObjects:@"新歌", @"热歌", @"经典", @"情歌", @"网络", @"影视", @"欧美",@"Bill", @"摇滚", @"爵士", @"流行", nil];
    }
    return _currentChannelsArray;
}

-(JDLBottomMenuView *)bottomMenuView{
    if (!_bottomMenuView) {
        _bottomMenuView =[[JDLBottomMenuView alloc] initWithFrame:CGRectMake(0, KScreenHeight -KAdaptY(60) -KSafeHeight, KScreenWidth, KAdaptY(60))];
    }
    return _bottomMenuView;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
