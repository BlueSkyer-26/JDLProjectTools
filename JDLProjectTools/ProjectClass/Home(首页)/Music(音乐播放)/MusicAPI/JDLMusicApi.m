//
//  JDLMusicApi.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/18.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLMusicApi.h"

@implementation JDLMusicApi

+(NSString *)requestDataUrlWithItemString:(NSString *)channelTitle{
    
    uint8_t type;
    
    if ([channelTitle  isEqualToString: @"新歌"]) {
        type = NEW_SONG_LIST;
    }else if ([channelTitle  isEqualToString: @"热歌"]) {
        type = HOT_SONG_LIST;
    }else if ([channelTitle  isEqualToString: @"经典"]) {
        type = OLD_SONG_LIST;
    }else if ([channelTitle  isEqualToString: @"情歌"]) {
        type = LOVE_SONG_LIST;
    }else if ([channelTitle  isEqualToString: @"网络"]) {
        type = INTERNET_SONG_LIST;
    }else if ([channelTitle  isEqualToString: @"影视"]) {
        type = MOVIE_SONG_LIST;
    }else if ([channelTitle  isEqualToString: @"欧美"]) {
        type = EUROPE_SONG_LIST;
    }else if ([channelTitle  isEqualToString: @"Bill"]) {
        type = BILLBOARD_MUSIC_LIST;
    }else if ([channelTitle  isEqualToString: @"摇滚"]) {
        type = ROCK_MUSIC_LIST;
    }else if ([channelTitle  isEqualToString: @"爵士"]) {
        type = JAZZ_MUSIC_LIST;
    }else if ([channelTitle  isEqualToString: @"流行"]) {
        type = POP_MUSIC_LIST;
    }
    
    NSString *partOne = @"http://tingapi.ting.baidu.com/v1/restserver/ting?from=qianqian&version=2.1.0&method=baidu.ting.billboard.billList&format=json&";
    NSString *partTwo = [NSString stringWithFormat:@"type=%d&",type];
    NSString *urlString = [partOne stringByAppendingString:partTwo];
    return urlString;
}

@end
