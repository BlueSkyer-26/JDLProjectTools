//
//  JDLMusicCell.m
//  JDLProjectTools
//
//  Created by 胜炫电子 on 2017/12/19.
//  Copyright © 2017年 BlueSkyer-25. All rights reserved.
//

#import "JDLMusicCell.h"
@interface JDLMusicCell ()

@end

@implementation JDLMusicCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        _headImageView =[[UIImageView alloc] init];
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(KAdaptY(10));
            make.centerY.equalTo(self.contentView);
            make.width.height.offset(KAdaptY(40));
        }];
        
        _jumpView =[[UIView alloc] init];
        [self.contentView addSubview:_jumpView];
        [_jumpView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headImageView.mas_top).offset(KAdaptY(20));
            make.left.bottom.right.equalTo(_headImageView);
        }];
        
        _musicName = [[UILabel alloc]init];
        _musicName.font =KSYSTEMFONT(16);
        _musicName.textColor =KTextColor;
        [self.contentView addSubview:_musicName];
        [_musicName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headImageView);
            make.left.equalTo(_headImageView.mas_right).offset(10);
            make.width.mas_lessThanOrEqualTo(KScreenWidth *0.5);
            make.height.equalTo(_headImageView.mas_height).multipliedBy(1/2.0f);
        }];
        
        _authorName = [[UILabel alloc]init];
        _authorName.font =KSYSTEMFONT(14);
        _authorName.textColor =KTextDetailColor;
        [self.contentView addSubview:_authorName];
        [_authorName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_musicName.mas_bottom);
            make.left.equalTo(_musicName);
            make.height.equalTo(_headImageView.mas_height).multipliedBy(1/2.0f);
        }];
        
        _language = [[UILabel alloc]init];
        _language.font =KSYSTEMFONT(12);
        _language.textColor =KThemeColor;
        _language.layer.borderColor =KThemeColor.CGColor;
        _language.layer.borderWidth =1.0;
        _language.layer.cornerRadius =4.0;
        _language.layer.masksToBounds =YES;
        [self.contentView addSubview:_language];
        [_language mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_musicName);
            make.centerY.equalTo(_musicName);
            make.left.equalTo(_musicName.mas_right).offset(5);
            make.height.equalTo(_headImageView.mas_height).multipliedBy(1/2.6f);
        }];
        
        _country = [[UILabel alloc]init];
        _country.font =KSYSTEMFONT(12);
        _country.textColor =KThemeColor;
        _country.layer.borderColor =KThemeColor.CGColor;
        _country.layer.borderWidth =1.0;
        _country.layer.cornerRadius =4.0;
        _country.layer.masksToBounds =YES;
        [self.contentView addSubview:_country];
        [_country mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_musicName);
            make.centerY.equalTo(_musicName);
            make.left.equalTo(_language.mas_right).offset(5);
            make.height.equalTo(_headImageView.mas_height).multipliedBy(1/2.6f);
        }];
        
        _button =[UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitle:@"···" forState:UIControlStateNormal];
        [_button setTitleColor:KTextDetailColor forState:UIControlStateNormal];
        [self.contentView addSubview:_button];
        [_button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.contentView);
            make.width.height.mas_equalTo(30);
        }];
        
        _jumpNameView =[[UIView alloc] init];
        [self.contentView addSubview:_jumpNameView];
        [_jumpNameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(_authorName);
            make.right.equalTo(_button.mas_left).offset(-6);
            make.height.offset(KAdaptY(16));
            make.width.offset(KAdaptY(20));
        }];
    }
    return self;
}

-(void)setModel:(JDLMusicListModel *)model{
    
    _model =model;
    [_headImageView setImageWithURL:[NSURL URLWithString:model.pic_small] placeholder:KImageName(@"Placeholder")];
    _musicName.text =model.title;
    _authorName.text =model.author;
    
    NSString *languageStr =KStrValid(model.language) ?KNSStringFormat(@" %@ ",model.language):@"";
    _language.text =languageStr;
    _country.text =KNSStringFormat(@" %@ ",model.country);
    
//    [JDLAutherManager popJumpAnimationView:_jumpNameView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
