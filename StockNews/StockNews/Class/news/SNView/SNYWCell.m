//
//  SNYWCell.m
//  IosDemo
//
//  Created by MengWang on 16/3/18.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNYWCell.h"
#import <SBModule/UIImageView+WebCache.h>
#import <SBBusiness/SNJSONNODE.h>

@interface SNYWCell()
@property (nonatomic, strong)UIImageView *imgView;
@property (nonatomic, strong)UILabel *titleLbl;         // 标题
@property (nonatomic, strong)UILabel *commentNumLbl;    // 评论数
@property (nonatomic, strong)UILabel *simLbl;           // 显示专题
@end

@implementation SNYWCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imgView];
        
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.font = [UIFont systemFontOfSize:15];
        _titleLbl.numberOfLines = 2;
        _titleLbl.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:_titleLbl];
        
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
        
        [self.simLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLbl.mas_bottom);
            make.left.equalTo(self.titleLbl);
        }];
        
        [self.commentNumLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLbl.mas_bottom).with.offset(2);
            make.right.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
            make.bottom.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // uilable多行，autolayout一定要设置这个属性
    self.titleLbl.preferredMaxLayoutWidth = self.width - 3 * APPCONFIG_UI_TABLE_PADDING - self.imgView.right;
}

- (void)dealloc {
    
}

- (void)bindCellData {
    [super bindCellData];
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[self.cellDetail getString:SN_SUMMARY_LIST_IMAGE]] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
    self.titleLbl.text = [self.cellDetail getString:SN_SUMMARY_LIST_BASICTITLE];
    self.commentNumLbl.text = [NSString stringWithFormat:@"%@评论", [self.cellDetail getString:SN_SUMMARY_LIST_COMMENTSIZE]];
    
    if ([[self.cellDetail getString:SN_TOPIC_LIST_SIMTPYE] isEqualToString:@"2"] && [self.cellDetail getString:SN_SUMMARY_LIST_SIMTPYE].length > 0) {
        _simLbl.hidden = NO;
        _simLbl.text = [self.cellDetail getString:SN_SUMMARY_LIST_SIMTPYE];
    } else {
        _simLbl.hidden = YES;
    }
}

@end
