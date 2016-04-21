//
//  SBCommentView.m
//  IosDemo
//
//  Created by MengWang on 16/1/21.
//  Copyright © 2016年 YukiWang. All rights reserved.
//

#import "SBCommentView.h"
#import <SBBusiness/SBV3Process.h>
#import "SBCommentCell.h"
#import "SBCommentView+Private.h"

@interface SBCommentView()
@property (nonatomic, strong)UIButton *lookCommentBtn;
@property (nonatomic, assign)SBV3ReplysSort sortType;
@end

@implementation SBCommentView

- (instancetype)initWithPostId:(NSString *)postid type:(NSInteger)type {
    self = [super init];
    if (self) {
        _model = [[SBEmojiModel alloc] init];
        _sortType = SBV3ReplysSortDES;
        
        _tableView = [[SBTableView alloc] initWithStyle:NO];
        _tableView.ctrl = self.ctrl;
        _tableView.estimatedRowHeight = 80;
        [self addSubview:_tableView];
        
        SBWS(__self);
        
        // request相关
        _tableView.requestData = ^(SBTableData *tableViewData) {
            return [SBV3Process sbget_mainpost_replys:postid type:type p:tableViewData.pageAt sort:__self.sortType delegate:tableViewData];
        };
        
        _tableView.receiveData = ^(SBTableView *tableView, SBTableData *tableViewData, DataItemResult *result) {
            if (result.hasError) {
                return;
            }
            [__self calculateHeight:result];
            [tableViewData.tableDataResult appendItems:result];          //添加数据
        };
        
        _tableView.headerForSection = ^UIView *(SBTableView *tableView, NSInteger section) {
            return [__self commentsHeaderView];
        };
        
        _tableView.didSelectRow = ^(SBTableView *tableView, NSIndexPath *indexPath) {
            
        };
        
        SBTableData *sectionData = [[SBTableData alloc] init];
        sectionData.hasHeaderView = YES;
        sectionData.mDataCellClass = [SBCommentCell class];
        sectionData.hasFinishCell = YES;
        [_tableView addSectionWithData:sectionData];
        
        [sectionData loadData];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

-(void)dealloc {
    
}

- (UIView *)commentsHeaderView {
    UIView *sHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 44)];
    sHeader.backgroundColor = [UIColor whiteColor];
    
    UILabel *commentCountLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    commentCountLbl.textColor = [UIColor blackColor];
    commentCountLbl.font = [UIFont systemFontOfSize:13];
    commentCountLbl.backgroundColor = [UIColor clearColor];
    [sHeader addSubview:commentCountLbl];
    
    SBTableData *data = [self.tableView dataOfSection:0];
    commentCountLbl.text = [NSString stringWithFormat:@"评论 %@", @(data.tableDataResult.maxCount)];
    
    [commentCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(sHeader.mas_centerY);
        make.left.equalTo(@10);
    }];
    
    _lookCommentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _lookCommentBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_lookCommentBtn setTitle:[NSString stringWithFormat:@"%@评论", (self.sortType == SBV3ReplysSortDES) ? @"最早" : @"最近"] forState:UIControlStateNormal];
    [_lookCommentBtn setTitleColor:RGB(49,111,201) forState:UIControlStateNormal];
    [_lookCommentBtn addTarget:self action:@selector(lookCommentClick:) forControlEvents:UIControlEventTouchUpInside];
    [sHeader addSubview:_lookCommentBtn];
    [_lookCommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(sHeader.mas_centerY);
        make.right.equalTo(@-20);
    }];
    
    UIImageView *bottomLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"t1_cell_seperate_line"]];
    bottomLine.frame = CGRectMake(0, sHeader.height - 1, sHeader.width, 1);
    [sHeader addSubview:bottomLine];
    
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(sHeader.width - 20, sHeader.height / 2 - 5, 10, 10)];
    arrow.image = [UIImage imageNamed:@"t1_stock_tips_list_into"];
    [sHeader addSubview:arrow];
    
    return sHeader;
}

- (void)lookCommentClick:(id)sender {
    if (self.sortType == SBV3ReplysSortASC) {
        self.sortType = SBV3ReplysSortDES;
        [_lookCommentBtn setTitle:@"最早评论" forState:UIControlStateNormal];
    } else {
        self.sortType = SBV3ReplysSortASC;
        [_lookCommentBtn setTitle:@"最近评论" forState:UIControlStateNormal];
    }
    [self refreshComments];
}

/** 刷新评论列表 */
- (void)refreshComments {
    [[self.tableView dataOfSection:0] refreshData];
}

@end