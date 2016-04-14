//
//  SNLiveCell.m
//  IosDemo
//
//  Created by MengWang on 16/3/21.
//  Copyright © 2016年 YukiWang. All rights reserved.
//  

#import "SNLiveCell.h"
#import <SBBusiness/SNJSONNODE.h>
#import <SBBusiness/SBTimeManager.h>

@interface SNLiveCell()
@property (nonatomic, strong)UILabel *timeLbl;          // 时间
@property (nonatomic, strong)UILabel *titleLbl;         // 标题
@end

@implementation SNLiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _timeLbl = [[UILabel alloc] init];
        _timeLbl.textColor = RGB(49,111,201);
        _timeLbl.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_timeLbl];
        
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = [UIColor blackColor];
        _titleLbl.font = [UIFont systemFontOfSize:15];
        _titleLbl.numberOfLines = 4;
        _titleLbl.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLbl.preferredMaxLayoutWidth = self.width - 5 * APPCONFIG_UI_TABLE_PADDING;
        [self.contentView addSubview:_titleLbl];
        
        [self.timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.left.equalTo(self.contentView).with.offset(4 * APPCONFIG_UI_TABLE_PADDING);
        }];
        
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLbl.mas_bottom).with.offset(APPCONFIG_UI_TABLE_PADDING);
            make.left.equalTo(self.timeLbl.mas_left);
            make.right.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
            make.bottom.equalTo(self.contentView).with.offset(-APPCONFIG_UI_TABLE_PADDING);
        }];

    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // uilable多行，autolayout一定要设置这个属性
    self.titleLbl.preferredMaxLayoutWidth = self.width - 5 * APPCONFIG_UI_TABLE_PADDING;
}

- (void)dealloc {
    
}

- (void)bindCellData {
    [super bindCellData];

    self.timeLbl.text = [SBTimeManager sb_formatStr:[self.cellDetail getString:SN_OTHER_LIST_TIME] preFormat:@"yyyy-MM-dd HH:mm:ss" newFormat:@"HH:mm"];
    NSString *title = [self.cellDetail getString:SN_SHARETITLE_LIVE];
    
    NSString *cellStyle = [self.tableData.tableDataResult.resultInfo getString:@"cell-style"];
    if ([cellStyle isEqualToString:@"digestStyle"]) {
        self.titleLbl.text = [self.cellDetail getString:SN_SHARETITLE_LIVE];
    } else {
        self.titleLbl.text = title.length > 0 ? title : [self.cellDetail getString:SN_OTHER_LIST_TITLE];
    }
    
    NSInteger titleStyle = [[self.cellDetail getString:SN_OTHER_LIST_TITLESTYLE] intValue];
    if (titleStyle >= 2 ) {
        _titleLbl.textColor = [UIColor redColor];
    } else {
        _titleLbl.textColor = [UIColor blackColor];
    }
}

@end
