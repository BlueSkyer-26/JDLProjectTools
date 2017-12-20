//
//  JDLMusicPlayerManager.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/19.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface JDLMusicPlayerManager : NSObject

@property (nonatomic,strong) AVPlayer *avPlayer;
@property (nonatomic,strong) AVPlayerItem *avplayItem;

+(JDLMusicPlayerManager *)shareManager;

-(void)playMusicWithUrl:(NSString *)url;
-(void) startPlay;
-(void) stopPlay;
@end
