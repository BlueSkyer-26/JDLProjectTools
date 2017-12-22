//
//  JDLMusicCell.h
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/19.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDLMusicListModel.h"
@interface JDLMusicCell : UITableViewCell

@property (nonatomic,strong) UIImageView    *headImageView;
@property (nonatomic,strong) UILabel        *musicName;
@property (nonatomic,strong) UILabel        *authorName;
@property (nonatomic,strong) UILabel        *language;
@property (nonatomic,strong) UILabel        *country;
@property (nonatomic,strong) UIButton       *button;

@property (nonatomic,strong) UIView         *jumpView;
@property (nonatomic,strong) UIView         *jumpNameView;

@property (nonatomic,strong) JDLMusicListModel *model;

@end
