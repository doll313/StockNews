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
    sHeader.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *commentCountLbl = [[UILabel alloc] initWithFrame:CGRectZero];
    commentCountLbl.textColor = [UIColor whiteColor];
    commentCountLbl.font = [UIFont systemFontOfSize:14];
    commentCountLbl.backgroundColor = RGB(49,111,201);
    [sHeader addSubview:commentCountLbl];
    
    SBTableData *data = [self.tableView dataOfSection:0];
    commentCountLbl.text = [NSString stringWithFormat:@" %@ 评论 ", @(data.tableDataResult.maxCount)];
    
    [commentCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(sHeader.mas_centerY);
        make.left.equalTo(@10);
    }];
    
    _lookCommentBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [_lookCommentBtn setTitle:[NSString stringWithFormat:@"查看%@评论", (self.sortType == SBV3ReplysSortDES) ? @"最早" : @"最近"] forState:UIControlStateNormal];
    [_lookCommentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_lookCommentBtn addTarget:self action:@selector(lookCommentClick:) forControlEvents:UIControlEventTouchUpInside];
    [sHeader addSubview:_lookCommentBtn];
    [_lookCommentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(sHeader.mas_centerY);
        make.right.equalTo(@-10);
    }];
    
    return sHeader;
}

- (void)lookCommentClick:(id)sender {
    if (self.sortType == SBV3ReplysSortASC) {
        self.sortType = SBV3ReplysSortDES;
        [_lookCommentBtn setTitle:@"查看最早评论" forState:UIControlStateNormal];
    } else {
        self.sortType = SBV3ReplysSortASC;
        [_lookCommentBtn setTitle:@"查看最近评论" forState:UIControlStateNormal];
    }
    [self refreshComments];
}

/** 刷新评论列表 */
- (void)refreshComments {
    [[self.tableView dataOfSection:0] refreshData];
}

@end