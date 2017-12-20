//
//  UIScrollView+JDLRefresh.m
//  Withdrawals
//
//  Created by 胜炫电子 on 2017/10/26.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "UIScrollView+JDLRefresh.h"

@implementation UIScrollView (JDLRefresh)


- (void)setRefreshWithHeaderBlock:(void (^)(void))headerBlock footerBlock:(void (^)(void))footerBlock{
    
    
    if (headerBlock) {
        
//        MJRefreshGifHeader *header =[MJRefreshGifHeader headerWithRefreshingBlock:^{
//            if (headerBlock) {
//                headerBlock();
//            }
//        }];
        
        MJRefreshNormalHeader *header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            if (headerBlock) {
                headerBlock();
            }
        }];
        
        //设置动画
//        NSMutableArray *headerImages = [NSMutableArray array];
//        for (int i = 1; i <= 14; i++) {
//            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"header_%d",i]];
//            [headerImages addObject:image];
//        }
//        [header setImages:@[[UIImage imageNamed:@"header_1"]] forState:MJRefreshStatePulling];
//        [header setImages:@[[UIImage imageNamed:@"header_14"]] forState:MJRefreshStateIdle];
//        [header setImages:headerImages forState:MJRefreshStateRefreshing];
        
        header.lastUpdatedTimeLabel.hidden = YES;
        header.stateLabel.hidden = YES;
        self.mj_header = header;
    }
    if (footerBlock) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            footerBlock();
        }];
        [footer setTitle:@"暂无更多数据" forState:MJRefreshStateNoMoreData];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        footer.refreshingTitleHidden = YES;
        self.mj_footer = footer;
    }
    
}

- (void)headerBeginRefreshing
{
    [self.mj_header beginRefreshing];
}

- (void)headerEndRefreshing
{
    [self.mj_header endRefreshing];
}

- (void)footerEndRefreshing
{
    [self.mj_footer endRefreshing];
}

- (void)footerNoMoreData
{
    [self.mj_footer setState:MJRefreshStateNoMoreData];
}

- (void)hideFooterRefresh{
    self.mj_footer.hidden = YES;
}


- (void)hideHeaderRefresh{
    self.mj_header.hidden = YES;
}



@end
