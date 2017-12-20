//
//  JDLMusicPlayerManager.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/19.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLMusicPlayerManager.h"

@implementation JDLMusicPlayerManager

static JDLMusicPlayerManager *_shareManager =nil;
+(JDLMusicPlayerManager *)shareManager{
    @synchronized( [JDLMusicPlayerManager class] ){
        if(!_shareManager)
            _shareManager = [[self alloc] init];
        return _shareManager;
    }
    return nil;
}

-(void)playMusicWithUrl:(NSString *)musicUrl{
    NSURL *url =[NSURL URLWithString:musicUrl];
    _avplayItem =[[AVPlayerItem alloc] initWithURL:url];
    _avPlayer =[[AVPlayer alloc] initWithPlayerItem:_avplayItem];
}

-(void) startPlay {
    [_avPlayer play];
}

-(void) stopPlay {
    [_avPlayer pause];
}

@end
