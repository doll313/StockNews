//
//  SNTopicCell.m
//  StockNews
//
//  Created by MengWang on 16/5/3.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNTopicCell.h"
#import <SBModule/UIImageView+WebCache.h>
#import <SBBusiness/SNJSONNODE.h>
#import <SBModule/NSString+SBMODULE.h>

@interface SNTopicCell()
@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UILabel *titleLbl;         // 标题
@property (nonatomic, strong)UILabel *subTitleLbl;      // 副标题
@property (nonatomic, strong)UILabel *commentNumLbl;    // 评论数
@property (nonatomic, strong)UILabel *simLbl;           // 显示专题
@end

@implementation SNTopicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imgView];
        
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_titleLbl];
        
        _subTitleLbl = [[UILabel alloc] init];
        _subTitleLbl.textColor = [UIColor grayColor];
        _subTitleLbl.font = [UIFont systemFontOfSize:15];
        _subTitleLbl.numberOfLines = 0;
        _subTitleLbl.lineBreakMode = NSLineBreakByTruncatingTail;
        _subTitleLbl.preferredMaxLayoutWidth = self.width - 2 * APPCONFIG_UI_TABLE_PADDING - 70;
        [self.contentView addSubview:_subTitleLbl];
        
        _commentNumLbl = [[UILabel alloc] init];
        _commentNumLbl.textColor = RGB(49,111,201);
        _commentNumLbl.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_commentNumLbl];
        
        _simLbl = [[UILabel alloc] init];
        _simLbl.font = [UIFont systemFontOfSize:11];
        _simLbl.textColor = [UIColor redColor];
        _simLbl.text = @"";
        _simLbl.layer.borderColor = [UIColor redColor].CGColor;
        _simLbl.layer.borderWidth = 0.5;
        _simLbl.layer.cornerRadius = 2;
        [self.contentView addSubview:_simLbl];
        _simLbl.hidden = YES;
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.top.equalTo(self.contentView).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.bottom.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
            make.size.mas_equalTo(CGSizeMake(60, 50));
        }];
        
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.left.equalTo(self.imgView.mas_right).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.right.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
        }];
        
        [self.subTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLbl.mas_bottom).with.offset(4);
            make.left.equalTo(self.titleLbl.mas_left);
            make.right.equalTo(self.titleLbl.mas_right);
            make.bottom.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
        }];
        
        [self.commentNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
            make.bottom.equalTo(self.contentView).with.offset(-5);
        }];
        
        [self.simLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
            make.bottom.equalTo(self.contentView).with.offset(-5);
        }];
    }
    return self;
}

- (void)dealloc {
    
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.simLbl.text = nil;
    self.commentNumLbl.text = nil;
    self.imgView.image = nil;
    self.titleLbl.text = nil;
    self.subTitleLbl.text = nil;
}

- (void)bindCellData {
    [super bindCellData];
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[self.cellDetail getString:SN_TOPIC_LIST_IMAGE]] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
    
    self.titleLbl.text = [self.cellDetail getString:SN_TOPIC_LIST_TITLE];
    // 容错，可能有\n\r
    self.subTitleLbl.text = [[self.cellDetail getString:SN_TOPIC_LIST_SIMTITLE] striptags];
    NSInteger commentCount = [[self.cellDetail getString:SN_TOPIC_LIST_COMMENTSIZE] intValue];
    self.commentNumLbl.text = commentCount > 0 ? [NSString stringWithFormat:@"%@评论", @(commentCount)] : @"";
    
    if ([self.cellDetail getString:SN_TOPIC_LIST_SIMTPYE].length > 0) {
        _simLbl.hidden = NO;
        _simLbl.text = [self.cellDetail getString:SN_TOPIC_LIST_SIMTPYE];
    } else {
        _simLbl.hidden = YES;
    }
}

@end
