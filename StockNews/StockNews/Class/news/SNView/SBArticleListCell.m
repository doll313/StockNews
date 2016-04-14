//
//  SBArticleListCell.m
//  IosDemo
//
//  Created by MengWang on 16/3/23.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SBArticleListCell.h"
#import <SBBusiness/SBTimeManager.h>
#import <SBModule/UIImageView+WebCache.h>
#import "SBStarView.h"
#import <SBBusiness/SBJSONNODEV3.h>
#import "SBUserReplyToolView.h"

@interface SBArticleListCell()
@property (nonatomic, strong)UIImageView *avatarImageView;     // 头像
@property (nonatomic, strong)UILabel *userNameLbl;    // 用户名
@property (nonatomic, strong)UILabel *infuLbl;        // 影响力
@property (nonatomic, strong)SBStarView *starView;    // 星级
@property (nonatomic, strong)UILabel *ageLbl;         // 吧龄
@property (nonatomic, strong)UILabel *userAgeLbl;     // 显示吧龄
@property (nonatomic, strong)UILabel *timeLbl;        // 发布时间
@property (nonatomic, strong)UILabel *fromLbl;        // 来自
@property (nonatomic, strong)UILabel *titleLbl;       // 标题
@property (nonatomic, strong)UILabel *contentLbl;     // 内容
@property (nonatomic, strong)SBUserReplyToolView *replyToolView;  // 用户回复
@end

@implementation SBArticleListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _avatarImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_avatarImageView];
        
        _userNameLbl = [[UILabel alloc] init];
        _userNameLbl.textColor = [UIColor blackColor];
        _userNameLbl.font = [UIFont systemFontOfSize:11];
        [self.contentView addSubview:_userNameLbl];
        
        _infuLbl = [[UILabel alloc] init];
        _infuLbl.textColor = [UIColor grayColor];
        _infuLbl.font = [UIFont systemFontOfSize:9];
        [self.contentView addSubview:_infuLbl];
        
        _starView = [[SBStarView alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_starView];
        
        _ageLbl = [[UILabel alloc] init];
        _ageLbl.textColor = [UIColor grayColor];
        _ageLbl.font = [UIFont systemFontOfSize:9];
        [self.contentView addSubview:_ageLbl];
        
        _userAgeLbl = [[UILabel alloc] init];
        _userAgeLbl.textColor = [UIColor orangeColor];
        _userAgeLbl.font = [UIFont systemFontOfSize:9];
        [self.contentView addSubview:_userAgeLbl];
        
        _timeLbl = [[UILabel alloc] init];
        _timeLbl.textColor = [UIColor grayColor];
        _timeLbl.font = [UIFont systemFontOfSize:9];
        [self.contentView addSubview:_timeLbl];
        
        _fromLbl = [[UILabel alloc] init];
        _fromLbl.textColor = [UIColor grayColor];
        _fromLbl.font = [UIFont systemFontOfSize:9];
        [self.contentView addSubview:_fromLbl];
        
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.font = [UIFont boldSystemFontOfSize:14];
        _titleLbl.numberOfLines = 2;
        _titleLbl.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLbl.preferredMaxLayoutWidth = self.width - 2 * APPCONFIG_UI_TABLE_PADDING;
        [self.contentView addSubview:_titleLbl];
        
        _contentLbl = [[UILabel alloc] init];
        _contentLbl.textColor = [UIColor blackColor];
        _contentLbl.font = [UIFont systemFontOfSize:14];
        _contentLbl.numberOfLines = 0;
        _contentLbl.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLbl.preferredMaxLayoutWidth = self.width - 2 * APPCONFIG_UI_TABLE_PADDING;
        [self.contentView addSubview:_contentLbl];
        
        _replyToolView = [[SBUserReplyToolView alloc] init];
        [self.contentView addSubview:_replyToolView];
        
        [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(self.contentView).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.size.mas_equalTo(CGSizeMake(26, 26));
        }];
        
        [self.userNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.right.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
        }];
        
        [self.infuLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userNameLbl.mas_bottom).with.offset(2);
            make.left.equalTo(self.avatarImageView.mas_right).with.offset(APPCONFIG_UI_TABLE_PADDING);
        }];
        
        [self.starView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userNameLbl.mas_bottom).with.offset(2);
            make.left.equalTo(self.infuLbl.mas_right).with.offset(2);
            make.size.mas_equalTo(CGSizeMake(50, 10));
        }];
        
        [self.ageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.infuLbl.mas_top);
            make.left.equalTo(self.starView.mas_right).with.offset(4);
        }];
        
        [self.userAgeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.ageLbl.mas_top);
            make.left.equalTo(self.ageLbl.mas_right).with.offset(2);
        }];
        
        [self.timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.userAgeLbl.mas_bottom).with.offset(2);
            make.left.equalTo(self.userNameLbl);
        }];
        
        [self.fromLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLbl.mas_top);
            make.left.equalTo(self.timeLbl.mas_right).with.offset(4);
        }];
        
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLbl.mas_bottom).with.offset(5);
            make.left.equalTo(self.avatarImageView.mas_left);
            make.right.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
        }];
        
        [self.contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLbl.mas_bottom).with.offset(5);
            make.left.equalTo(self.titleLbl.mas_left);
            make.right.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
        }];
        
        [self.replyToolView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentLbl.mas_bottom);
            make.width.equalTo(self.contentView);
            make.height.equalTo(@36);
            make.bottom.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)dealloc {
    
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.avatarImageView.image = nil;
    self.userNameLbl.text = nil;
    self.userAgeLbl.text = nil;
    self.timeLbl.text = nil;
    self.fromLbl.text = nil;
    self.titleLbl.text = nil;
    self.contentLbl.attributedText = nil;
    
    [self.replyToolView resetBtn];
}

- (void)bindCellData {
    [super bindCellData];
    
    DataItemDetail *detail = [self.cellDetail getDetail:JNV3_POST_USER];
    self.userNameLbl.text = [detail getString:JNV3_USER_NICKNAME];;
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://avator.eastmoney.com/qface/%@/120",[detail getString:JNV3_USER_ID] ]] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
    
    self.infuLbl.text = @"影响力";
    [self.starView setStarCount:[[detail getString:JNV3_USER_INFLU_LEVEL] intValue]];
    self.ageLbl.text = @"注册时长";
    self.userAgeLbl.text = [detail getString:JNV3_USER_BAR_AGE];
    self.timeLbl.text = [SBTimeManager sb_formatStatusTime:[self.cellDetail getString:JNV3_POST_PUBLISH_TIME]];
    self.fromLbl.text = [NSString stringWithFormat:@"来自%@", [self.cellDetail getString:JNV3_POST_FROM]];
    self.titleLbl.text = [self.cellDetail getString:JNV3_POST_TITLE];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[self.cellDetail getString:JNV3_POST_CONTENT]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:5];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedString.string.length)];
    self.contentLbl.attributedText = attributedString;
    
    [self.replyToolView setDetail:self.cellDetail];
}

@end
