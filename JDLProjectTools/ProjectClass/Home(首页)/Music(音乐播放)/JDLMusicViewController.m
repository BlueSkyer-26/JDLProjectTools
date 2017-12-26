//
//  JDLMusicViewController.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/18.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLMusicViewController.h"

#import "JDLMusicPlayModel.h"

#import "JDLBottomMenuView.h"

#import "JDLMusicPlayerManager.h"

#import "JDLDetailMusicViewController.h"
#import "JDLMusicLrcDetailViewController.h"

JDLMusicPlayerManager *playerManager;

@interface JDLMusicViewController ()<JDLPageTitleViewDelegate,JDLPageContentViewDelegate>
{
    JDLMusicPlayModel *playMusicModel;
    JDLDetailMusicViewController *detailMusicViewController;
}
@property (nonatomic,strong) JDLPageTitleView     *pageTitleView;
@property (nonatomic,strong) JDLPageContentView   *pageContentView;
@property (nonatomic,strong) JDLBottomMenuView    *bottomMenuView;

@property (nonatomic,strong) NSMutableArray       *currentChannelsArray;

@property (nonatomic, strong) id playerTimeObserver;  //播放时间
@end

@implementation JDLMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    playerManager =[JDLMusicPlayerManager shareManager];
    playMusicModel =[JDLMusicPlayModel shareManager];
    
    [self createView];
    
}

-(void)createView{
    [self.view addSubview:self.pageTitleView];
    [self.view addSubview:self.pageContentView];
    [self.view addSubview:self.bottomMenuView];

    // 设置KVO
    [playMusicModel addObserver:self forKeyPath:@"selectIndex" options:NSKeyValueObservingOptionOld
     |NSKeyValueObservingOptionNew context:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollViewMoveNofication) name:KScrollViewMoveNofication object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(scrollViewMoveEndNofication) name:KScrollViewMoveEndNofication object:nil];
}

#pragma mark - KVO
-(void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqual: @"selectIndex"]) {
        [self playSongSetting];
    }
}

#pragma mark ------ 通知 -------
-(void)scrollViewMoveNofication{
    [UIView animateWithDuration:0.6 animations:^{
        _bottomMenuView.timeLabel.alpha =0;
    }];
}
-(void)scrollViewMoveEndNofication{
    [UIView animateWithDuration:0.6 animations:^{
        _bottomMenuView.timeLabel.alpha =1;
    }];
}

-(void)playSongSetting{

    if (_playerTimeObserver != nil) {

        [playerManager.avPlayer removeTimeObserver:_playerTimeObserver];
        _playerTimeObserver = nil;

        [playerManager.avPlayer.currentItem cancelPendingSeeks];
        [playerManager.avPlayer.currentItem.asset cancelLoading];
    }

    [playerManager playMusicWithUrl:playMusicModel.file_link];
    [playerManager startPlay];
    [_bottomMenuView.iconImageView startRotating];
    _bottomMenuView.musicName.text =playMusicModel.model.title;
    _bottomMenuView.authorName.text =playMusicModel.model.author;
    [_bottomMenuView.iconImageView setImageWithURL:[NSURL URLWithString:playMusicModel.model.pic_small] placeholder:KImageName(@"Icon-40")];
    [_bottomMenuView.startBtn setBackgroundImage:KImageName(@"cm2_fm_btn_play_prs") forState:UIControlStateNormal];

    [KNotificationCenter addObserver:self selector:@selector(nextMusicClick) name:AVPlayerItemDidPlayToEndTimeNotification object:playerManager.avPlayer.currentItem];
    
    _playerTimeObserver =[playerManager.avPlayer addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {

        CGFloat currentTime =CMTimeGetSeconds(time);


        CMTime total =playerManager.avPlayer.currentItem.duration;
        CGFloat totalTime =CMTimeGetSeconds(total);

        _bottomMenuView.circleView.progress = currentTime/totalTime;
        _bottomMenuView.timeLabel.text =KNSStringFormat(@"%@/%@",[JDLAutherManager secondsToString:currentTime],[JDLAutherManager secondsToString:totalTime]);
        
//        [JDLAutherManager popJumpAnimationView:_bottomMenuView.timeLabel];
        
    }];
}

#pragma mark ------ 下一曲 -------
-(void)nextMusicClick{

    if (playMusicModel.selectIndex <playMusicModel.allMusicArray.count -1) {

        [playMusicModel loadMusicWith:playMusicModel.allMusicArray[playMusicModel.selectIndex +1] index:playMusicModel.selectIndex +1];
    }else{
        //如果是最后一首，则从第一首播放
        [playMusicModel loadMusicWith:playMusicModel.allMusicArray[0] index:0];
    }
   
}

#pragma mark ------ 上一曲 -------
-(void)previousMusicClick{

    if (playMusicModel.selectIndex <=playMusicModel.allMusicArray.count -1) {
        
        //如果是第一首，则从最后一首播放
        if(playMusicModel.selectIndex ==0){
            NSInteger allSongCount =playMusicModel.allMusicArray.count;
            [playMusicModel loadMusicWith:playMusicModel.allMusicArray[allSongCount -1] index:allSongCount -1];
        }else{
            [playMusicModel loadMusicWith:playMusicModel.allMusicArray[playMusicModel.selectIndex -1] index:playMusicModel.selectIndex -1];
        }
    }
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
            detailMusicViewController =[[JDLDetailMusicViewController alloc] init];
            detailMusicViewController.channelTitle =self.currentChannelsArray[i];
            /* 不能在这里设置颜色 否则全部加载*/
//            vc.view.backgroundColor =KRANDOM_COLOR;
            [vcClassArray addObject:detailMusicViewController];
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
        WEAKSELF;
        _bottomMenuView =[[JDLBottomMenuView alloc] initWithFrame:CGRectMake(0, KScreenHeight -KAdaptY(60) -KSafeHeight, KScreenWidth, KAdaptY(60))];
        _bottomMenuView.bottomButtonClickBlock = ^(NSInteger index,UIButton *btn) {
            //24弹出歌词视图   25下一首   26开始暂停    27上一首
            switch (index) {
                case 24:{
                    JDLMusicLrcDetailViewController *detailVC =[[JDLMusicLrcDetailViewController alloc] init];
                    detailVC.view.backgroundColor =KOrangeColor;
                    [weakSelf presentViewController:detailVC animated:YES completion:nil];
                }
                    
                    break;
                case 25:{
                    [weakSelf nextMusicClick];
                }
                    
                    break;
                case 26:{
                    
                    if (playerManager.avPlayer.rate == 0) {
                        
                        [btn setBackgroundImage:KImageName(@"cm2_fm_btn_play_prs") forState:UIControlStateNormal];
                        [weakSelf.bottomMenuView.iconImageView resumeRotating];
                        [playerManager startPlay];
                        
                    } else {
                        
                        [btn setBackgroundImage:KImageName(@"cm2_fm_btn_pause_prs") forState:UIControlStateNormal];
                        [weakSelf.bottomMenuView.iconImageView stopRotating];
                        [playerManager stopPlay];
                    }
                }
                    
                    break;
                case 27:{
                    [weakSelf previousMusicClick];
                }
                    
                    break;
                    
                default:
                    break;
            }
            
        };
    }
    return _bottomMenuView;
}
#pragma mark - removeObserver
- (void)dealloc{
    [self removeObserver];
}

- (void)removeObserver{
    
    [playerManager.avPlayer removeTimeObserver:_playerTimeObserver];
    _playerTimeObserver = nil;
    
    [playerManager.avPlayer.currentItem cancelPendingSeeks];
    [playerManager.avPlayer.currentItem.asset cancelLoading];
    
//    MPRemoteCommandCenter *commandCenter = [MPRemoteCommandCenter sharedCommandCenter];
//    [commandCenter.likeCommand removeTarget:self];
//    [commandCenter.dislikeCommand removeTarget:self];
//    [commandCenter.bookmarkCommand removeTarget:self];
//    [commandCenter.nextTrackCommand removeTarget:self];
//    [commandCenter.skipForwardCommand removeTarget:self];
//    [commandCenter.changePlaybackPositionCommand removeTarget:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
