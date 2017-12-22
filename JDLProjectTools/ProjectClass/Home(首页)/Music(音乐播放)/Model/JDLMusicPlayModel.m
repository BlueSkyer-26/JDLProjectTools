//
//  JDLMusicPlayModel.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/21.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLMusicPlayModel.h"

@implementation JDLMusicPlayModel

static JDLMusicPlayModel *_sharedManager = nil;

+(JDLMusicPlayModel *)shareManager {
    @synchronized( [JDLMusicPlayModel class] ){
        if(!_sharedManager)
            _sharedManager = [[self alloc] init];
        return _sharedManager;
    }
    return nil;
}

-(void)loadMusicWith:(JDLMusicListModel *)model index:(NSInteger )index{
    
    _model =model;
    
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
        self.file_link =url;
        self.selectIndex =index;

    } failed:^(NSError *error){
        if (error.code==NSURLErrorCancelled)return;

    }];
}

@end
