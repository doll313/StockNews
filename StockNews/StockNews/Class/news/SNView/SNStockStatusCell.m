//
//  SNStockStatusCell.m
//  IosDemo
//
//  Created by MengWang on 16/3/22.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SNStockStatusCell.h"
#import <SBBusiness/SNJSONNODE.h>
#import <SBBusiness/SBTimeManager.h>

@interface SNStockStatusCell()
@property (nonatomic, strong)UILabel *timeLbl;          // 时间
@property (nonatomic, strong)UILabel *titleLbl;         // 标题
@end

@implementation SNStockStatusCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.font = [UIFont systemFontOfSize:15];
        _titleLbl.numberOfLines = 2;
        _titleLbl.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLbl.preferredMaxLayoutWidth = self.width - 2 * APPCONFIG_UI_TABLE_PADDING;
        [self.contentView addSubview:_titleLbl];
        
        _timeLbl = [[UILabel alloc] init];
        _timeLbl.textColor = [UIColor blueColor];
        _timeLbl.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_timeLbl];
        
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(5);
            make.left.equalTo(self.contentView).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.right.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
        }];
        
        [self.timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLbl.mas_bottom).with.offset(5);
            make.right.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
            make.bottom.equalTo(self.contentView).with.offset(-5);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // uilable多行，autolayout一定要设置这个属性
    self.titleLbl.preferredMaxLayoutWidth = self.width - 2 * APPCONFIG_UI_TABLE_PADDING;
}

- (void)dealloc {
    
}

- (void)bindCellData {
    [super bindCellData];
    
    self.titleLbl.text = [self.cellDetail getString:SN_OTHER_LIST_TITLE];
    self.timeLbl.text = [SBTimeManager sb_formatStatusTime:[self.cellDetail getString:SN_OTHER_LIST_TIME]];
}

@end
