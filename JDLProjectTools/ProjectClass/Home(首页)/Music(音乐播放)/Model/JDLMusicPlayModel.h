//
//  JDLMusicPlayModel.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/21.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JDLMusicListModel.h"
@interface JDLMusicPlayModel : NSObject

+(JDLMusicPlayModel *)shareManager;

@property (nonatomic,strong) JDLMusicListModel *model;

@property (nonatomic,strong) NSString *file_link;
@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic,strong) NSMutableArray *allMusicArray;

-(void)loadMusicWith:(JDLMusicListModel *)model index:(NSInteger )index;

@end
