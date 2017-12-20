//
//  JDLMusicListModel.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/19.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JDLMusicListModel : NSObject
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *country;
@property (nonatomic,strong) NSString *lrclink;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *pic_small;
@property (nonatomic,strong) NSString *song_id;
@property (nonatomic,strong) NSString *language;
@property (nonatomic,strong) NSString *file_duration;
@end
