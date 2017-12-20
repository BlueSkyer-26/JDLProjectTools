//
//  JDLMusicApi.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/18.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <Foundation/Foundation.h>

// Music const
#define NEW_SONG_LIST           1
#define HOT_SONG_LIST           2
#define OLD_SONG_LIST           22
#define LOVE_SONG_LIST          23
#define INTERNET_SONG_LIST      25
#define MOVIE_SONG_LIST         24
#define EUROPE_SONG_LIST        21
#define BILLBOARD_MUSIC_LIST    8
#define ROCK_MUSIC_LIST         11
#define JAZZ_MUSIC_LIST         12
#define POP_MUSIC_LIST          16

@interface JDLMusicApi : NSObject

+(NSString *)requestDataUrlWithItemString:(NSString *)title;

@end
